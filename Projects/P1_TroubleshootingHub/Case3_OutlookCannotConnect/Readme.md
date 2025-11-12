# 🧩 Case 3 – Outlook Cannot Connect (DNS Misconfiguration)

### 🎯 Objective
Simulate and resolve a network connectivity issue where Outlook Web cannot connect due to incorrect DNS configuration.  
This case demonstrates how IT Support engineers diagnose and repair DNS-related service disruptions.

---

## 🧠 Scenario Overview
A user reports that **Outlook Web (Office 365)** cannot connect.  
Investigation reveals that DNS resolution is pointing to an incorrect IP (127.0.0.1), preventing access to Microsoft’s mail servers.

This case simulates that failure by manually editing the Windows `hosts` file to redirect Outlook-related domains to localhost.

---

## ⚙️ Environment Setup
- **Windows 10/11 VM (VirtualBox / Hyper-V)**
- **Local Administrator Account**
- **PowerShell (Run as Administrator)**
- Folder structure:
C:\ITSupportLabs\Case3_OutlookCannotConnect


---

## 🧩 Step 1 – Simulate DNS Failure
Use the PowerShell script below to intentionally misconfigure DNS resolution for Outlook-related domains.

```powershell
.\Simulate-OutlookDNSFail.ps1

Affected Domains
outlook.office.com
outlook.office365.com
outlook.live.com
login.microsoftonline.com
graph.microsoft.com
login.live.com

Expected Result

When accessing https://outlook.office365.com
, the browser displays:

“Hmmm... can’t reach this page”
(ERR_CONNECTION_REFUSED)

📸 Screenshot:
screenshots/01_outlook_disconnected.png

---

 ## 🧩 Step 2 – Collect Evidence (Before Fix)
Run the evidence collection script to record DNS and TCP connectivity before fixing.
.\Collect-Connectivity.ps1 -Phase before
Generated Logs
File	| Description
dns_status_before.txt |	Shows Outlook domain resolving to 127.0.0.1
network_test_before.txt |	TCP connection test fails (TcpTestSucceeded: False)

📂 Location: logs/

---

## 🧩 Step 3 – Repair DNS Configuration
Restore the original hosts file and flush the DNS cache.
.\Restore-Hosts.ps1

This removes the invalid DNS entries or restores from backup.
Then, re-run the connectivity test: .\Collect-Connectivity.ps1 -Phase after

---

## 🧩 Step 4 – Verification (After Fix)
✅ Expected Results
Check	| Result
Resolve-DnsName outlook.office365.com |	Returns real Microsoft IP (e.g., 52.x.x.x)
Test-NetConnection |	TcpTestSucceeded : True
Outlook Web	| Loads successfully and shows Microsoft login screen

📸 Screenshot:
screenshots/02_outlook_connected.png

---
## 🧩 Step 5 – Quick Verification (Optional)
You can run this helper script to quickly verify connectivity and open Outlook Web automatically.
.\Quick-Verify.ps1

This will:

- Run Resolve-DnsName and Test-NetConnection

- Launch Outlook Web in your browser

- Save a summary file at logs\quick_verify.txt

---
## 🧩 Step 6 – Learning Outcomes
✅ Understand how DNS misconfiguration affects Outlook and Microsoft 365 services
✅ Learn to simulate and diagnose Outlook connection failures
✅ Practice restoring the hosts file and clearing the DNS cache
✅ Document troubleshooting steps for your IT portfolio
