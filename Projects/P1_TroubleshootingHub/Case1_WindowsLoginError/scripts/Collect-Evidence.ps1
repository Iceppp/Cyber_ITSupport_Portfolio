<#
.SYNOPSIS
  Collects diagnostic evidence (Before/After) for the "User Profile Cannot Be Loaded" case.

.DESCRIPTION
  Gathers system, registry, and event log data related to user profile load issues.
  Can be used before or after fixing the profile to document troubleshooting evidence.

.PARAMETER UserName
  The target local user account (e.g., TestUser).

.PARAMETER OutputRoot
  Root folder where evidence will be saved. Default: C:\ITSupportLabs\Case1_WindowsLoginError

.EXAMPLE
  .\Collect-Evidence.ps1 -UserName TestUser
#>

param(
  [Parameter(Mandatory=$true)][string]$UserName,
  [string]$OutputRoot = "C:\ITSupportLabs\Case1_WindowsLoginError"
)

$ErrorActionPreference = "Stop"

# Prepare folders
$logDir  = Join-Path $OutputRoot "logs"
$snapDir = Join-Path $OutputRoot "screenshots"  # for screenshots you take manually
New-Item -ItemType Directory -Force -Path $logDir  | Out-Null
New-Item -ItemType Directory -Force -Path $snapDir | Out-Null

Write-Host "== Collecting environment & account info =="

# 1) List all local users
net user | Out-File (Join-Path $logDir "net_user.txt")

# 2) List folders under C:\Users
Get-ChildItem C:\Users | Out-File (Join-Path $logDir "users_folder.txt")

# 3) Dump ProfileList registry key (text view)
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /s `
  | Out-File (Join-Path $logDir "profilelist_reg.txt")

# 3.1 Export ProfileList branch for backup (.reg)
$regExport = Join-Path $logDir "ProfileList_Export.reg"
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" "$regExport" /y | Out-Null

# 4) Collect relevant User Profile Service event logs
$ids = 1500,1501,1502,1505,1508,1511,1515,1530
$upsTxt = Join-Path $logDir "ups_events.txt"

try {
  Get-WinEvent -FilterHashtable @{ LogName='Application'; Id=$ids } -MaxEvents 400 |
    Where-Object { $_.ProviderName -in 'User Profile Service','Microsoft-Windows-User Profiles Service' } |
    Format-List TimeCreated, Id, ProviderName, LevelDisplayName, Message |
    Out-File $upsTxt -Encoding UTF8
} catch {
  # Fallback: search "profile" if filtering fails
  Get-WinEvent -LogName Application -MaxEvents 400 |
    Where-Object { $_.Message -match 'profile|User Profile' } |
    Format-List TimeCreated, Id, ProviderName, LevelDisplayName, Message |
    Out-File $upsTxt -Encoding UTF8
}

# 5) Backup entire Application log as .evtx
wevtutil epl Application (Join-Path $logDir "Application_Snapshot.evtx") | Out-Null

# 6) Context info
$expectedProfile = "C:\Users\$UserName"
@"
ExpectedProfilePath: $expectedProfile
Timestamp          : $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
"@ | Out-File (Join-Path $logDir "context.txt")

Write-Host "`n== Evidence collection complete =="
Write-Host "Logs saved in: $logDir"
