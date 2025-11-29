# 🧭 IT Support & Cybersecurity Projects (P1–P5)

Hands-on IT Support portfolio by **Passawut Sawongkhan (Ice)**.  
📍 Based in Sydney, Australia(Open to relocate across Australia) | Visa: Graduate 485 (Full Working Rights)
These projects simulate real issues handled by Service Desk / IT Support / MSP technicians...
These projects simulate real issues handled by **Service Desk / IT Support / MSP technicians** – from Windows troubleshooting and networking, to Microsoft 365 admin, asset tracking, and backup & recovery.

All projects were:
- **Reproduced intentionally**
- **Diagnosed step-by-step**
- **Fixed and verified**
- **Documented with evidence** (logs + screenshots)

---

## 📂 Project Index
```
Projects/
│── P1_TroubleshootingHub
│── P2_NetworkDiagnostics
│── P3_M365_Simulation
│── P4_Asset_Tracking_System
│── P5_Backup_Recovery
│── README.md ← this file
```

---

## 🛠️ P1 – Troubleshooting Hub (8 Real Support Cases)

**Focus:** Windows & end-user troubleshooting on a Windows 10 VM (VirtualBox)  
**Style:** Complete IT Support / Service Desk troubleshooting portfolio

Simulates 8 real IT incidents commonly seen in enterprise & MSP environments:

1. **Windows Login Error – Temporary Profile / Profile Corruption**  
2. **Printer Not Working – Print Spooler Failure**  
3. **Outlook Cannot Connect – DNS / hosts Misconfiguration**  
4. **WiFi Connected, No Internet – Wrong DNS Settings**  
5. **DNS Not Resolving – IP OK, Name Lookup Fails**  
6. **Slow Performance – High CPU Usage (Simulated Load)**  
7. **Permission Denied – Shared Folder (SMB/NTFS) Misconfig**  
8. **Audio Not Working – Windows Audio Services Stopped**

**Key skills:**
- Windows OS troubleshooting  
- DNS/DHCP/TCP-IP diagnostics  
- Print spooler repair  
- Registry & profile fixes  
- SMB share & NTFS permissions  
- Audio service stack recovery  
- Performance analysis (high CPU)  
- Event Viewer, Services.msc, Device Manager, Task Manager  

📂 Folder: `P1_TroubleshootingHub/`  
📝 Each case has its own `README.md`, `/screenshots`, `/logs`, and scripts (where used).

---

## 🌐 P2 – Network Diagnostics Project

**Focus:** Layer 1–3 troubleshooting, DNS diagnostics, latency investigations  
**Cases:** 3 realistic networking scenarios with full evidence and analysis.

1. **Case 1 – Connectivity Failure (DHCP / Gateway Issue)**  
   - Forced APIPA (169.254.x.x) by releasing DHCP  
   - Tested gateway reachability, routing table, ARP, NIC state  

2. **Case 2 – DNS Failure (Name Resolution Broken)**  
   - DNS changed to `127.0.0.1`  
   - IP connectivity works, domain-based access fails  

3. **Case 3 – Slow Performance (High Latency / Congestion)**  
   - Saturated bandwidth using YouTube 4K streaming  
   - Observed latency/jitter and hop timeouts

**Key skills:**
- `ipconfig`, `ping`, `tracert`, `nslookup`, `arp`, `netstat`  
- DHCP vs APIPA analysis  
- DNS vs network path isolation  
- Latency & congestion behaviour  
- PowerShell transcript logging  
- MSP-style incident write-ups  

📂 Folder: `P2_NetworkDiagnostics/`  
🧾 Each case has `analysis.md`, `/screenshots`, `/raw_output`.

---

## ☁️ P3 – Microsoft 365 Administration Simulation

**Focus:** Hybrid IT Support + Microsoft 365 Administrator for a simulated company  
**Company:** *Northbridge Consulting Pty Ltd* (Sydney, Australia)  
**Environment:** Microsoft 365 Business Standard tenant

**Tasks performed:**
- Tenant creation & initial admin setup  
- User onboarding (Alice, Bob, Chloe) with proper UPNs  
- Password reset workflows (helpdesk scenario)  
- License assignment & verification  
- Enforced MFA via Entra ID for security compliance 
- Group creation (Sales, Marketing, HR) + membership management  
- RBAC role assignment (Helpdesk Admin, Reports Reader)  
- User offboarding: block sign-in, remove licenses, remove groups  

**Key skills:**
- Microsoft 365 Admin Center  
- Microsoft Entra ID (Azure AD)  
- MFA, RBAC, license governance  
- User lifecycle (joiner–mover–leaver)  
- Helpdesk + cloud admin workflows  
- CSV user list and role matrix design  

📂 Folder: `P3_M365_Simulation/`  
📄 Docs in `/docs` (workflow PDF + one-page summary)  
🖼 Evidence in `/screenshots`.

---

## 🛠 P4 – IT Asset Tracking System (Excel + PowerShell Automation)

**Focus:** IT Asset Management used by IT Support & MSP teams  

### Excel Inventory Template
Tracks:
- Asset ID, Device Name, Device Type  
- Manufacturer, Model, Serial Number  
- User, Department, Location, Status  
- Purchase Date, Warranty Expiry, Age (formula)  
- Cost, Notes  

Features:
- Dropdown validation (Device Type, Location, Status)  
- Table formatting & filters  
- Clean, reusable template for real environments  

### PowerShell Automation
Script: `Get-DeviceInventory.ps1`  

Collects and exports:
- Device Name, Manufacturer, Model  
- Serial Number  
- Logged-in User  
- OS Version  
- Notes  

Output: `device-inventory.csv` – importable into Excel or CMDB.

**Key skills:**
- Excel design for IT inventory  
- Data validation & consistency  
- PowerShell scripting for asset discovery  
- IT asset lifecycle fundamentals  
- Professional documentation and screenshots  

📂 Folder: `P4_Asset_Tracking_System/`  
Assets in `/assets`, automation in `/scripts`, evidence in `/screenshots`.

---

## 🔥 P5 – Backup & Recovery SOP (with Ransomware Simulation)

**Focus:** Real-world Backup & Recovery process for MSP / IT Support teams  

### Environment
- Windows 10 VM  
- Business data: `C:\CompanyData`  
- Manual backup: `C:\Backups_Manual`  
- Automated backup: `C:\DailyBackup`  
- Script: `scripts/backup.ps1`

### What was implemented

#### ✔ Manual Backup
- Full copy of `C:\CompanyData` to `C:\Backups_Manual`  
- Size & integrity verification  

#### ✔ Automated PowerShell Backup
- Timestamped backup folders under `C:\DailyBackup\<yyyy-MM-dd_HH-mm>`  
- Log file: `backup_log.txt` with backup entries  

#### ✔ Accidental Deletion Recovery
- Deleted a key file from `C:\CompanyData`  
- Restored from latest automated backup  
- Verified content and path  

#### ✔ Ransomware Simulation
- Renamed files with `.locked` extension  
- Created fake ransom note  
- **Restored clean copies from backup**  
- Removed encrypted files + note  

#### ✔ Documentation
- **Backup & Recovery SOP** (`P5_Backup_Recovery_SOP.*`)  
- **Recovery Testing Checklist** with PASS result  

**Key skills:**
- Backup strategy & implementation  
- PowerShell scripting & logging  
- Incident recovery (deletion + ransomware)  
- SOP + checklist creation  
- Portfolio structuring & evidence collection  

📂 Folder: `P5_Backup_Recovery/`  
Docs in `/documents` + `/assets` (PDF), screenshots in `/screenshots`.

---

## 🧠 Overall Skills Demonstrated

### IT Support / Helpdesk
- Windows 10 troubleshooting  
- Printers, audio, profiles, login, Outlook  
- Incident analysis & documentation  

### Networking
- DHCP, DNS, gateway, routing, ARP  
- Latency and congestion diagnosis  
- Solid Layer 1–3 understanding  

### Cloud & Identity (Microsoft 365)
- User and group management  
- License + MFA administration  
- RBAC and offboarding  

### Automation & Scripting
- PowerShell for backup and asset export  
- Logging and evidence collection  

### Cybersecurity Fundamentals (Blue Team)
- Ransomware-style incident simulation  
- Backup-based recovery  
- SOP and runbook creation  

---

👤 **Author:** Passawut Sawongkhan (Ice)  
🌏 Based in Australia – targeting IT Support / Helpdesk / MSP roles  
⭐ Portfolio-driven learning: IT Support → Network → Cybersecurity (Blue Team)
