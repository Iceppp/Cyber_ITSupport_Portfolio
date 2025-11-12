<#
.SYNOPSIS
  Simulate Outlook/OWA connection failure by poisoning hosts file.

.DESCRIPTION
  Appends loopback entries for common Outlook/Microsoft endpoints, flushes DNS,
  and saves a timestamped backup of the original hosts file first.

.OUTPUTS
  - Backup:   C:\ITSupportLabs\Case3_OutlookCannotConnect\Backup\hosts_YYYYMMDD_HHMM.bak
  - Console:  Summary of endpoints added
#>

param(
  [string]$Root = "C:\ITSupportLabs\Case3_OutlookCannotConnect"
)

$ErrorActionPreference = "Stop"
$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"
$backupDir = Join-Path $Root "Backup"
New-Item -ItemType Directory -Force -Path $backupDir | Out-Null

# Backup hosts
$stamp = Get-Date -Format "yyyyMMdd_HHmm"
$backup = Join-Path $backupDir "hosts_$stamp.bak"
Copy-Item $hosts $backup -Force

$endpoints = @(
  "outlook.office.com",
  "outlook.office365.com",
  "outlook.live.com",
  "login.microsoftonline.com",
  "graph.microsoft.com",
  "login.live.com"
)

# Build unique hosts content (avoid duplicates)
$current = Get-Content $hosts -ErrorAction SilentlyContinue
$poison = $endpoints | ForEach-Object { "127.0.0.1 $_" }
$new = @()
$new += $current
foreach ($line in $poison) {
  if ($current -notcontains $line) { $new += $line }
}

Set-Content -Path $hosts -Value $new -Encoding ASCII
ipconfig /flushdns | Out-Null

Write-Host "DNS simulation applied. Endpoints forced to 127.0.0.1:" -ForegroundColor Yellow
$endpoints | ForEach-Object { Write-Host " - $_" }
Write-Host "Backup saved to: $backup"