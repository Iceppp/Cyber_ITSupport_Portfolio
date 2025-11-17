# 🧩 Case 2 — Printer Not Working (Print Spooler Service Fix)
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** Print Spooler Failure / Printer Offline / Queue Stuck

---

## 🎯 Scenario  
User reports:

> “Printer shows offline and printing does not work.”

This issue occurs when the Windows Print Spooler service (spoolsv.exe) crashes, stops, or becomes stuck due to corrupt print jobs or registry problems. This case simulates a real-world helpdesk situation.

---

## 🧪 Step 1 — Baseline (Normal Printer State)

Before reproducing the issue, a virtual printer (Microsoft XPS Document Writer) was verified to be working:

✔ Print Spooler service = **Running**  
✔ Printer = **Ready**  
✔ No stuck print jobs  
✔ No Event Viewer errors (7031/7034)

### 📁 Baseline Evidence
- `screenshots/baseline_printer_ready.png`
- `logs/baseline_spooler_status.txt`
- `logs/baseline_spooler_events.txt`

---

## 🧨 Step 2 — Simulation (Reproduce the Printer Issue)

To intentionally break the printing system:

### ✔ Actions performed
1. Stopped Spooler service:
   ```
   net stop spooler
   ```
2. Added corrupt files to:
   ```
   C:\Windows\System32\spool\PRINTERS
   ```
3. Removed or disabled the Microsoft XPS Document Writer  
4. Attempted printing → print queue stuck  
5. Spooler service crashed and automatically stopped

### ❗ Resulting issues
- Printer shows **Offline**  
- Print queue stuck  
- Spooler Status = **Stopped**  
- Event Viewer logs **7031 / 7034** (Service Control Manager)

### 📁 Broken State Evidence
- `screenshots/01_printer_error.png`
- `logs/print_services_status.txt`
- `logs/spooler_reg_before.txt`
- `logs/spooler_events_before.txt`

---

## 🔍 Step 3 — Diagnosis

### ✔ Findings  
1. Print Spooler service was not running.  
2. PRINTERS folder contained corrupt/unfinished print jobs.  
3. Printer driver was missing or unresponsive.  
4. Event Viewer logged:
   - **7031** – Print Spooler terminated unexpectedly  
   - **7034** – Print Spooler crashed repeatedly  

### 🧠 Root Cause  
Corrupted spool files + misconfigured/missing virtual printer driver caused the Print Spooler service to continuously stop.

---

## 🛠 Step 4 — Fix Procedure

### ✔ 1. Stop the Spooler
```powershell
net stop spooler
```

### ✔ 2. Clear all print job files
```powershell
Remove-Item "C:\Windows\System32\spool\PRINTERS\*" -Force -ErrorAction SilentlyContinue
```

### ✔ 3. Start the Spooler
```powershell
net start spooler
```

### ✔ 4. Reinstall virtual printer (if missing)
```powershell
Remove-Printer -Name "Microsoft XPS Document Writer" -ErrorAction SilentlyContinue
Add-Printer -Name "Microsoft XPS Document Writer" -DriverName "Microsoft XPS Document Writer v4" -PortName "PORTPROMPT:"
```

### ✔ 5. Verify service and printer state
- Spooler = **Running**  
- Printer = **Ready**  

---

## 🧾 Step 5 — Evidence (After Fix)

| Type | Description | File |
|------|-------------|------|
| Screenshot | Spooler running normally | `screenshots/02_spooler_running.png` |
| Screenshot | Printer online/ready | `screenshots/03_printer_ready.png` |
| Logs | Spooler status OK | `logs/spooler_status_after.txt` |
| Logs | No new 7031/7034 errors | `logs/spooler_events_after.txt` |

---

## 🧩 Optional Scripts Used

### `scripts/Collect-SpoolerEvidence.ps1`
Collects:
- Spooler service status  
- Registry configuration  
- Event Viewer logs  

### `scripts/Repair-SpoolerService.ps1`
Automates:
- Clearing print queue  
- Restarting Spooler  
- Reinstalling XPS printer  

### Usage:
```powershell
cd C:\ITSupportLabs\Case2_PrinterNotWorking\scripts
.\Collect-SpoolerEvidence.ps1
.\Repair-SpoolerService.ps1
```

Logs automatically saved to:
```
C:\ITSupportLabs\Case2_PrinterNotWorking\logs
```

---

## ✅ Step 6 — Verification

✔ Print Spooler stays running  
✔ No spooler crash messages  
✔ Printer responds normally  
✔ Printing succeeds  
✔ No stuck queue  

---

## 🧩 Skills Demonstrated

- Print Spooler troubleshooting  
- Clearing corrupted print queues  
- Virtual printer driver management  
- Services & Event Viewer analysis  
- PowerShell automation  
- Professional documentation with logs and screenshots  
- End-to-end troubleshooting workflow

---

## 📌 Status: **Resolved**  
Printer is online and operational. Print Spooler restored successfully.
