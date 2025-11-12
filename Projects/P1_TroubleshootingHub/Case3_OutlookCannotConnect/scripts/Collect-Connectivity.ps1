<#
.SYNOPSIS
  Collect DNS and TCP connectivity evidence (before/after).

.PARAMETER Phase
  'before' or 'after' to name the output files accordingly.

.PARAMETER Root
  Base folder for Case 3.

.NOTES
  Run in elevated PowerShell.
#>

param(
  [ValidateSet('before','after')]
  [string]$Phase = 'before',
  [string]$Root = "C:\ITSupportLabs\Case3_OutlookCannotConnect"
)

$ErrorActionPreference = "Stop"
$log = Join-Path $Root "logs"
New-Item -ItemType Directory -Force -Path $log | Out-Null

# Primary host to verify
$hostName = "outlook.office365.com"

Resolve-DnsName $hostName | Out-File (Join-Path $log "dns_status_$Phase.txt")
Test-NetConnection $hostName -Port 443 | Out-File (Join-Path $log "network_test_$Phase.txt")

Write-Host "Evidence saved to: $log (Phase: $Phase)" -ForegroundColor Green