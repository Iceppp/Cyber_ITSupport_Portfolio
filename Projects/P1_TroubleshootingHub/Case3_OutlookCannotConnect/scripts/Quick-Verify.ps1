<#
.SYNOPSIS
  Open Outlook Web and print quick status to console after DNS change.

.DESCRIPTION
  Launches the default browser to https://outlook.office365.com and prints the
  current Resolve-DnsName + Test-NetConnection summary to help with screenshots.
#>

param(
  [string]$Root = "C:\ITSupportLabs\Case3_OutlookCannotConnect"
)

$log = Join-Path $Root "logs"
New-Item -ItemType Directory -Force -Path $log | Out-Null

Start-Process "https://outlook.office365.com"

"=== DNS ===" | Tee-Object -FilePath (Join-Path $log "quick_verify.txt")
Resolve-DnsName outlook.office365.com | Tee-Object -FilePath (Join-Path $log "quick_verify.txt") -Append
"`n=== TCP 443 ===" | Tee-Object -FilePath (Join-Path $log "quick_verify.txt") -Append
Test-NetConnection outlook.office365.com -Port 443 | Tee-Object -FilePath (Join-Path $log "quick_verify.txt") -Append

Write-Host "Quick verification written to logs\quick_verify.txt"

