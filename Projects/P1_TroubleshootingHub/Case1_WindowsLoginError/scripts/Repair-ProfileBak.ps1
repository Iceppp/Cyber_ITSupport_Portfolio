<#
.SYNOPSIS
  Repairs "User Profile Cannot Be Loaded" errors by fixing registry (.bak key) and resetting State/RefCount.

.DESCRIPTION
  Automatically renames or corrects the ProfileList registry keys,
  resets State and RefCount to 0, restores NTUSER.DAT if renamed,
  and fixes folder ownership/permissions for the target user.

.PARAMETER UserName
  Target user to repair (e.g., TestUser).

.PARAMETER OutputRoot
  Root folder for repair logs. Default: C:\ITSupportLabs\Case1_WindowsLoginError

.PARAMETER WhatIf
  Runs in dry-run mode showing what would be changed without applying it.

.EXAMPLE
  .\Repair-ProfileBak.ps1 -UserName TestUser
#>

[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [Parameter(Mandatory=$true)][string]$UserName,
  [string]$OutputRoot = "C:\ITSupportLabs\Case1_WindowsLoginError"
)

$ErrorActionPreference = "Stop"
$logDir = Join-Path $OutputRoot "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$repairLog = Join-Path $logDir "repair_actions.log"

function Log($msg) {
  $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | $msg"
  $line | Tee-Object -FilePath $repairLog -Append
}

Log "==== Starting repair for user '$UserName' ===="

# Step 0: Restore NTUSER.DAT if previously renamed
$profilePath = "C:\Users\$UserName"
$broken = Join-Path $profilePath "NTUSER.DAT.broken"
if (Test-Path $broken) {
  if ($PSCmdlet.ShouldProcess($broken, "Rename to NTUSER.DAT")) {
    Rename-Item $broken "NTUSER.DAT" -Force
    Log "Restored NTUSER.DAT from NTUSER.DAT.broken"
  }
}

# Step 1: Locate the user profile key in the registry
$profileList = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'
$keys = Get-ChildItem $profileList

$keyExact = $keys | Where-Object {
  (Get-ItemProperty $_.PsPath).ProfileImagePath -eq $profilePath
}

$keyBak = $keys | Where-Object {
  $_.PSChildName -like "*.bak" -and
  ((Get-ItemProperty $_.PsPath).ProfileImagePath -like "$profilePath*")
}

# Rename .bak to main if needed
if ($keyBak -and -not $keyExact) {
  $targetName = $keyBak.PSChildName -replace '\.bak$',''
  $targetPath = Join-Path $profileList $targetName
  if (Test-Path $targetPath) {
    if ($PSCmdlet.ShouldProcess($targetPath, "Rename to .bad")) {
      Rename-Item $targetPath ($targetName + ".bad") -Force
      Log "Renamed existing main key to .bad: $targetName.bad"
    }
  }
  if ($PSCmdlet.ShouldProcess($keyBak.PSPath, "Remove .bak suffix")) {
    Rename-Item $keyBak.PSPath $targetName
    Log "Renamed .bak key to main: $targetName"
  }
  $keys = Get-ChildItem $profileList
  $keyExact = Get-Item (Join-Path $profileList $targetName)
}

if (-not $keyExact) {
  $keyExact = $keys | Where-Object {
    (Get-ItemProperty $_.PsPath).ProfileImagePath -like "$profilePath*"
  } | Select-Object -First 1
}

if (-not $keyExact) {
  Log "ERROR: Cannot find ProfileList key for $profilePath"
  throw "ProfileList key not found"
}

# Step 2: Reset State and RefCount to 0
$path = $keyExact.PSPath
if ($PSCmdlet.ShouldProcess($path, "Reset State/RefCount/Path")) {
  New-ItemProperty -Path $path -Name "State" -PropertyType DWord -Value 0 -Force | Out-Null
  New-ItemProperty -Path $path -Name "RefCount" -PropertyType DWord -Value 0 -Force | Out-Null
  Set-ItemProperty -Path $path -Name "ProfileImagePath" -Value $profilePath
  Log "Set State=0, RefCount=0, ProfileImagePath=$profilePath"
}

# Step 3: Fix folder ownership and permissions
if (Test-Path $profilePath) {
  if ($PSCmdlet.ShouldProcess($profilePath, "Set owner/permissions")) {
    icacls "$profilePath" /setowner $UserName /T /C /L | Out-Null
    icacls "$profilePath" /inheritance:e | Out-Null
    icacls "$profilePath" /grant "$UserName:(OI)(CI)F" /T /C /L | Out-Null
    Log "Permissions fixed for $profilePath"
  }
} else {
  Log "WARNING: Profile folder not found: $profilePath"
}

# Step 4: Save registry snapshot (after repair)
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /s `
  | Out-File (Join-Path $logDir "profilelist_reg_after.txt")

Log "==== Repair Completed (Reboot recommended) ===="
Write-Host "`nRepair finished. Please restart the machine and try signing in as '$UserName'.`n"
