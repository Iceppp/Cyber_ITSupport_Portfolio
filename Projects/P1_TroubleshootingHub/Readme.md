# 🛠️ P1 – Troubleshooting Hub  
**Complete IT Support / Service Desk Troubleshooting Portfolio**  
**Author:** Passawut Sawongkhan  
**Environment:** Windows 10 VM (VirtualBox)  

This project contains **8 real-world IT Support issues** that were fully reproduced, diagnosed, fixed, verified, and documented.  
Each case includes professional-grade logs, screenshots, and technical writeups similar to what MSP (Managed Service Provider) technicians produce.

---

# 📌 Project Overview

The P1 Troubleshooting Hub is designed to simulate the most common issues handled by:

- IT Support Technicians  
- Service Desk Analysts  
- Desktop Support / EUC  
- MSP Level 1 Engineers  

Each case follows the same professional workflow:

1. **Baseline (Normal State)**
2. **Simulation (Break Something Intentionally)**
3. **Diagnosis**
4. **Fix / Remediation**
5. **Verification**
6. **Evidence Collection (Logs + Screenshots)**

This project demonstrates strong capability in Windows troubleshooting, networking, DNS, print services, permissions, performance analysis, and system recovery.

---

# 📁 Folder Structure

```
P1_TroubleshootingHub/
│
├── Case1_WindowsLoginError/
├── Case2_PrinterNotWorking/
├── Case3_OutlookCannotConnect/
├── Case4_WifiConnectButNoInternet/
├── Case5_DNSNotResolving/
├── Case6_SlowPerformance_HighCPU/
├── Case7_PermissionDenied_SharedFolder/
├── Case8_AudioNotWorking/
│
└── README.md  ← This file
```

Each case includes:
- README.md (case documentation)
- /screenshots  
- /logs  
- /scripts (if used)

---

# 🧩 **List of All Troubleshooting Cases**

Below is the summary of all 8 cases with the issues, root cause, and key skills demonstrated.

---

## **1️⃣ Case 1 — Windows Login Error (Temporary Profile / User Profile Cannot Be Loaded)**  
**Symptoms:**  
- “We can’t sign in to your account”  
- Temporary profile loaded  

**Root Cause:**  
Corrupted Windows profile (ProfileList registry issue, incorrect RefCount/State)

**Skills:**  
Registry repair, NTUSER.DAT handling, Event Viewer, NTFS permissions

---

## **2️⃣ Case 2 — Printer Not Working (Print Spooler Failure)**  
**Symptoms:**  
- Printer offline  
- Queue stuck  
- Spooler service crashes (7031/7034)

**Root Cause:**  
Corrupt spool files / missing XPS printer driver

**Skills:**  
Spooler service management, print queue cleanup, driver recovery

---

## **3️⃣ Case 3 — Outlook Cannot Connect (DNS Misconfiguration)**  
**Symptoms:**  
- Outlook Web cannot load  
- DNS resolves Microsoft domains to 127.0.0.1  

**Root Cause:**  
Incorrect hosts file entries

**Skills:**  
DNS resolution, hosts file recovery, Resolve-DnsName, Test-NetConnection

---

## **4️⃣ Case 4 — WiFi Connected but No Internet (Wrong DNS Settings)**  
**Symptoms:**  
- IP connectivity OK  
- Unable to browse  
- nslookup fails  

**Root Cause:**  
Incorrect static DNS settings

**Skills:**  
ipconfig, nslookup, DNS configuration, network stack reset

---

## **5️⃣ Case 5 — DNS Not Resolving (Browser Cannot Reach Websites)**  
**Symptoms:**  
- Ping by IP works  
- Ping by domain fails  
- DNS_PROBE_FINISHED_NO_INTERNET  

**Root Cause:**  
Manual DNS misconfiguration

**Skills:**  
DNS flush, adapter configuration, troubleshooting flow

---

## **6️⃣ Case 6 — Slow Performance (High CPU Usage)**  
**Symptoms:**  
- CPU 100%  
- System freezes  

**Root Cause:**  
Simulated high CPU load (PowerShell infinite loop)

**Skills:**  
Task Manager analysis, Get-Process, performance troubleshooting

---

## **7️⃣ Case 7 — Permission Denied (Shared Folder / SMB Issue)**  
**Symptoms:**  
- Cannot access shared folder  
- “Access Denied”  

**Root Cause:**  
Incorrect Share & NTFS permissions

**Skills:**  
SMB share diagnostics, ACL permissions, `net share`, `Get-SmbShare`

---

## **8️⃣ Case 8 — Audio Not Working (Windows Audio Services Stopped)**  
**Symptoms:**  
- No audio  
- Audio icon shows X  
- Output device not detected  

**Root Cause:**  
Windows Audio / Endpoint Builder services disabled

**Skills:**  
Services troubleshooting, audio stack repair, Device Manager checks

---

# 🧠 Skills Demonstrated Across All Cases

### 🔧 Technical Competencies
- Windows OS troubleshooting  
- DNS / DHCP / TCP-IP  
- Print spooler recovery  
- Registry & profile repair  
- Shared folder troubleshooting (SMB/NTFS)  
- Audio service stack  
- High CPU analysis  
- Browser/network diagnostics  

### 🧰 Tools & Utilities
- PowerShell  
- CMD diagnostic tools  
- Event Viewer  
- Services.msc  
- Registry Editor  
- Device Manager  
- Task Manager  
- Network and Sharing Center  

### 📄 Documentation Skills
- Before/After evidence  
- Technical explanation  
- Root cause analysis  
- Step-by-step repair workflow  
- MSP-style ticket documentation  

---

# 🚀 Why This Project Is Valuable (For Recruiters)

This project demonstrates:

✔ Real troubleshooting skills  
✔ Ability to diagnose Windows issues end-to-end  
✔ Understanding of enterprise tools (Event Viewer, Services, Device Manager)  
✔ Strong documentation (critical in IT Support roles)  
✔ Ability to communicate technical findings clearly  
✔ Hands-on capability vs. only theory  

It strongly supports applications to:

- Service Desk Analyst  
- IT Support Level 1  
- Desktop Support Technician  
- MSP Junior Technician  
- IT Technician / Helpdesk  

---

# 📌 Status: **Completed — All 8 Cases Documented with Evidence**

This project is part of a full IT Support / Cybersecurity learning roadmap.

If you'd like a **GitHub banner**, **portfolio index**, or **PDF export**, just let me know!
