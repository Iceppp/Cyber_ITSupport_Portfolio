# P5 – Recovery Testing Checklist

## Test Information
- Date: 2025-11-29
- Engineer: Passawut Sawongkhan
- Environment: Windows 10 VM
- Data Location: C:\CompanyData
- Backup Locations: 
  - Manual: C:\Backups_Manual
  - Script: C:\DailyBackup

---

## Scenario 1 — Accidental Deletion

### Steps:
1. Deleted file: C:\CompanyData\Finance\monthly_report_Q1.txt
2. Verified file missing.
3. Retrieved file from: C:\DailyBackup\<timestamp>\Finance\
4. Restored file to original path.
5. Verified file content.

### Result:
- [x] File restored correctly  
- [x] Timestamp acceptable  
- [x] No corruption  
- Comments: Passed

---

## Scenario 2 — Ransomware Simulation

### Steps:
1. Encrypted file by renaming to `.locked`.
2. Created fake ransom note.
3. Verified files inaccessible.
4. Restored clean version from backup folder: C:\DailyBackup\<timestamp>\HR
5. Deleted encrypted files and ransom note.
6. Verified content integrity.

### Result:
- [x] Clean file restored  
- [x] Encrypted file removed  
- [x] Threat neutralized  
- Comments: Passed

---

## Overall
- [x] Backup folders accessible
- [x] Recovery time under 10 minutes
- [x] All verification steps passed

**Status: PASS**