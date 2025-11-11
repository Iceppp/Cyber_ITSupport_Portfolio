<#
.SYNOPSIS
  Repair typical "Printer Offline / Queue Stuck" by restarting Spooler and clearing PRINTERS folder.
  Reinstalls Microsoft XPS Document Writer if missing.

.PARAMETER OutputRoot
  Where to save after-fix logs. Default: C:\ITSupportLabs\Case2_PrinterNotWorking

.EXAMPLE
  .\Repair-SpoolerService.ps1
#>

param([string]$OutputRoot = "C:\ITSupportLabs\Case2_PrinterNotWorking")

$ErrorActionPreference = "Stop"
$log = Join-Path $OutputRoot "logs"
New-Item -ItemType Directory -Force -Path $log | Out-Null

# Stop -> clear -> Start
net stop spooler | Out-Null
Remove-Item "C:\Windows\System32\spool\PRINTERS\*" -Force -ErrorAction SilentlyContinue
net start spooler | Out-Null

# Ensure virtual printer exists
if (-not (Get-Printer -Name "Microsoft XPS Document Writer" -ErrorAction SilentlyContinue)) {
  Add-Printer -Name "Microsoft XPS Document Writer" -DriverName "Microsoft XPS Document Writer v4" -PortName "PORTPROMPT:"
}

# After-fix logs
Get-Service Spooler | Out-File (Join-Path $log "spooler_status_after.txt")
wevtutil qe System /q:"*[System[(EventID=7031 or EventID=7034) and Provider[@Name='Service Control Manager']]]" /f:text /c:20 `
  | Out-File (Join-Path $log "spooler_events_after.txt")

"Repair completed. Spooler should be RUNNING. Verify by printing a Test Page."