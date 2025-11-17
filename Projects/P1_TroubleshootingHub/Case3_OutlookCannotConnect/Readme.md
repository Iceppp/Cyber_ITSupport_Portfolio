# 🧩 Case 3 — Outlook Cannot Connect (DNS Misconfiguration)
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** DNS Misconfiguration / Outlook Web Connectivity Failure

---

## 🎯 Scenario  
User reports:

> “Outlook Web won't load. The browser keeps saying it cannot connect.”

This case simulates a real-world issue where incorrect DNS mapping blocks access to Microsoft 365 Outlook. The misconfiguration is applied by editing the Windows `hosts` file to redirect Outlook domains to `127.0.0.1`, causing Outlook Web to fail.

---

## 🧪 Step 1 — Baseline (Normal Network State)

Before breaking DNS, the system was verified to resolve Microsoft 365 domains correctly.

### ✔ Checks performed:
- Correct DNS resolution for:
  - `outlook.office.com`
  - `outlook.office365.com`
  - `login.microsoftonline.com`
- Browser loads Outlook Web login screen normally.
- Test-NetConnection reports `TcpTestSucceeded: True`

### 📁 Baseline Evidence:
- `baseline_dns_status.txt`
- `baseline_network_test.txt`
- `screenshots/baseline_outlook_ok.png`

---

## 🧨 Step 2 — Simulation (Create DNS Failure)

To reproduce the issue, DNS was intentionally misconfigured using a PowerShell script:

```powershell
.\Simulate-OutlookDNSFail.ps1
```

### ✔ What the script does:
Appends invalid entries to:

```
C:\Windows\System32\drivers\etc\hosts
```

Mapping key domains to `127.0.0.1`:

```
outlook.office.com
outlook.office365.com
login.microsoftonline.com
graph.microsoft.com
login.live.com
outlook.live.com
```

### ❗ Broken Behavior Observed:
- Browser shows:
  **“Hmmm… can’t reach this page”**  
  or  
  **ERR_CONNECTION_REFUSED**
- Outlook Web fails to load.
- DNS resolves to `127.0.0.1`.
- Network tests fail.

### 📁 Evidence (Broken State):
- `screenshots/01_outlook_disconnected.png`
- `logs/dns_status_before.txt`
- `logs/network_test_before.txt`

---

## 🔍 Step 3 — Diagnosis

### ✔ Findings:
1. DNS resolution for Outlook domains returned **127.0.0.1** instead of Microsoft’s real IPs.
2. Browser could not connect to Microsoft 365 servers.
3. `Test-NetConnection` confirmed TCP failures.
4. Hosts file contained incorrect manual entries.

### 🧠 Root Cause:
Outlook-related domains were manually overridden in the **hosts file**, redirecting them to localhost and preventing proper DNS resolution.

---

## 🛠 Step 4 — Fix (Restore DNS Configuration)

DNS was repaired using:

```powershell
.\Restore-Hosts.ps1
```

### ✔ What the script does:
- Restores the original hosts file (from backup)
- Removes malicious or incorrect DNS entries
- Flushes DNS cache:
  ```
  ipconfig /flushdns
  ```

After restoring DNS, connectivity tests were re-run:

```powershell
.\Collect-Connectivity.ps1 -Phase after
```

---

## 🧾 Step 5 — Verification (After Fix)

### Expected Results

| Check | Expected Result |
|-------|------------------|
| `Resolve-DnsName outlook.office365.com` | Returns real Microsoft IP (e.g., 52.x.x.x) |
| `Test-NetConnection outlook.office365.com` | `TcpTestSucceeded: True` |
| Browser | Outlook login page loads normally |

### 📁 Evidence (After Fix):
- `screenshots/02_outlook_connected.png`
- `logs/dns_status_after.txt`
- `logs/network_test_after.txt`

---

## 🧩 Optional — Quick Verification Script

Script:
```
.\Quick-Verify.ps1
```

Performs:
- DNS resolution check  
- Network connectivity test  
- Launches Outlook Web automatically  
- Saves summary to:
  ```
  logs/quick_verify.txt
  ```

---

## 🧠 Learning Outcomes

✔ Understand how DNS issues affect Microsoft 365 services  
✔ Learn to modify and restore the Windows hosts file  
✔ Diagnose DNS and connectivity problems with PowerShell  
✔ Use Resolve-DnsName & Test-NetConnection effectively  
✔ Document troubleshooting scenarios professionally  

---

## 📌 Status: **Resolved**  
Outlook Web connectivity restored after fixing DNS misconfiguration.
