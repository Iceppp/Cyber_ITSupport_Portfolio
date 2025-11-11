<#
.SYNOPSIS
  Collect BEFORE/AFTER evidence for Print Spooler issues.

.PARAMETER OutputRoot
  Root folder to store logs (default: C:\ITSupportLabs\Case2_PrinterNotWorking)

.EXAMPLE
  .\Collect-SpoolerEvidence.ps1
#>

param([string]$OutputRoot = "C:\ITSupportLabs\Case2_PrinterNotWorking")

$ErrorActionPreference = "Stop"
$log = Join-Path $OutputRoot "logs"
New-Item -ItemType Directory -Force -Path $log | Out-Null

# 1) Print-related services
Get-Service | Where-Object {$_.DisplayName -like "*Print*"} | Out-File (Join-Path $log "print_services_status.txt")

# 2) Spooler registry snapshot
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /s `
  | Out-File (Join-Path $log "spooler_reg_before.txt")

# 3) Event logs: Service Control Manager (spooler crash/stop)
wevtutil qe System /q:"*[System[(EventID=7031 or EventID=7034) and Provider[@Name='Service Control Manager']]]" /f:text /c:100 `
  | Out-File (Join-Path $log "spooler_events_before.txt")

# 4) Full System log snapshot (optional)
wevtutil epl System (Join-Path $log "System_Snapshot.evtx") | Out-Null

"Evidence collected to: $log"