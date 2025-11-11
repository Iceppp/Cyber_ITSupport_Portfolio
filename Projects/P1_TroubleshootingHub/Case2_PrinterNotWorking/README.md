# 🧩 Case 2 – Printer Not Working (Spooler Service Fix)

**Goal:** Resolve "Printer Offline / Queue Stuck" by fixing the Print Spooler.  
**Env:** Windows 10 VM (Oracle VirtualBox)

## Symptoms (Before)
- Printers show **Not connected/Offline**
- Printing fails, queue stuck
- Services: **Print Spooler = Stopped**
- System log: **Event ID 7031/7034** (Service Control Manager)

## Evidence (Before)
- `screenshots/01_printer_error.png`
- `logs/print_services_status.txt`
- `logs/spooler_reg_before.txt`
- `logs/spooler_events_before.txt`

## Fix
1. Stop Spooler → clear `C:\Windows\System32\spool\PRINTERS\*`
2. Start Spooler
3. Reinstall virtual printer (Microsoft XPS Document Writer) if missing
4. Confirm service is **Running**

Commands:
```powershell
net stop spooler
Remove-Item "C:\Windows\System32\spool\PRINTERS\*" -Force -ErrorAction SilentlyContinue
net start spooler
Remove-Printer -Name "Microsoft XPS Document Writer" -ErrorAction SilentlyContinue
Add-Printer -Name "Microsoft XPS Document Writer" -DriverName "Microsoft XPS Document Writer v4" -PortName "PORTPROMPT:"

## ✅ Verification (After)

- **Spooler = Running** → `screenshots/02_spooler_running.png`  
- **Printer status = Ready** → `screenshots/03_printer_ready.png`  
- **Logs:**  
  - `logs/spooler_status_after.txt`  
  - `logs/spooler_events_after.txt` *(no new 7031/7034 errors)*

---

## 🧰 Scripts

| Script | Description |
|---------|--------------|
| `scripts/Collect-SpoolerEvidence.ps1` | Collects logs and event data before fixing. |
| `scripts/Repair-SpoolerService.ps1` | Restarts the spooler, clears print queue, and reinstalls the virtual printer. |

### Example usage
```powershell
cd C:\ITSupportLabs\Case2_PrinterNotWorking\scripts
.\Collect-SpoolerEvidence.ps1
.\Repair-SpoolerService.ps1

Logs will be stored automatically in: C:\ITSupportLabs\Case2_PrinterNotWorking\logs
