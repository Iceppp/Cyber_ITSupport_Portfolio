<#
.SYNOPSIS
  Restore hosts file (using latest backup if exists) and flush DNS.

.DESCRIPTION
  If a backup exists in Backup/hosts_*.bak, restore the newest one.
  Otherwise, clear custom entries by writing an empty file (keeps default comments away).

.NOTES
  Run as Administrator.
#>

param(
  [string]$Root = "C:\ITSupportLabs\Case3_OutlookCannotConnect"
)

$ErrorActionPreference = "Stop"
$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"
$backupDir = Join-Path $Root "Backup"

$latest = Get-ChildItem -Path $backupDir -Filter "hosts_*.bak" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($latest) {
  Copy-Item $latest.FullName $hosts -Force
  Write-Host "Hosts restored from backup: $($latest.Name)"
} else {
  # Minimal safe fallback: blank file
  Set-Content -Path $hosts -Value "" -Encoding ASCII
  Write-Host "No backup found. Hosts file cleared."
}

ipconfig /flushdns | Out-Null
Write-Host "DNS cache flushed."
