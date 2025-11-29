# P5 – Backup & Recovery SOP

## 🎯 Objective
This project demonstrates real-world Backup & Recovery procedures used in MSP and IT Support environments.  
The goal is to protect business data from accidental deletion, corruption, and ransomware-style incidents.

## 🧱 Environment
- Windows 10 VM  
- Source Data: `C:\CompanyData`  
- Manual Backup: `C:\Backups_Manual`  
- Automated Backup: `C:\DailyBackup`  
- PowerShell Script: `scripts/backup.ps1`

---

# 📂 Project Structure
```
P5_Backup_Recovery/
│── README.md
│── scripts/
│ └── backup.ps1
│── documents/
│ ├── P5_Backup_Recovery_SOP.md
│ ├── P5_Recovery_Testing_Checklist.md
│── assets/
│ ├── P5_Backup_Recovery_SOP.pdf
│ ├── P5_Recovery_Testing_Checklist.pdf
│── screenshots/
```

---

# 🛠️ Tasks Completed

### ✔ Manual Backup
- Copied company data to backup directory
- Verified folder size & file integrity

### ✔ Automated Backup Script
- Developed PowerShell script to create timestamped backups  
- Generates `backup_log.txt` for auditability

### ✔ Accidental Deletion Recovery
- Deleted business file
- Restored correct version from automated backup
- Verified file integrity

### ✔ Ransomware Simulation
- Encrypted file using `.locked`  
- Added fake ransom note  
- Restored clean data from backup  
- Removed malicious files safely

### ✔ Documentation
- Full SOP covering backup, recovery, and incident handling  
- Recovery testing checklist with PASS result  
- Exported PDFs included in assets/

---

# 🖼 Evidence Screenshots
(Upload key images here or link to `/screenshots` folder)

---

# 📌 Key Skills Demonstrated
- Backup planning and execution  
- PowerShell scripting  
- Incident Recovery (Deletion + Ransomware)  
- Documentation (SOP, checklist, logs)  
- Version control & portfolio structuring  

---

# 🔚 Status: **Completed**
