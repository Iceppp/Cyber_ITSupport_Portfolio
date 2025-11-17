# 🛠 Case 4 — Network Connected but No Internet  
**Issue Type:** DNS Misconfiguration + Missing Default Gateway  
**Category:** P1 – Troubleshooting Hub

---

## 🎯 Scenario  
User reports:  
> “The computer shows Connected, but the internet is not working.”

This issue was simulated inside a VM.  
Even though the VM uses an Ethernet adapter, the symptoms match real Wi-Fi issues.

---

## 🧪 Step 1 — Baseline (Before Breaking)

Verified normal operation.

### ✔ Commands
 - `ipconfig /all`
 - `ping google.com`

### ✔ Evidence
- baseline_ipconfig_all.txt  
- baseline_ping_google.txt  

---

## 🧨 Step 2 — Simulation (Breaking the Network)

To intentionally break the network:

- Changed IPv4 DNS servers to **1.2.3.4** and **5.6.7.8**
- Windows removed the Default Gateway
- DNS resolution failed
- Browser unable to load any website

### ✔ Evidence
- wrong_dns_setting.png

---

## 🚨 Step 3 — Broken State Evidence

### ✔ Commands
- `ipconfig /all`
- `ping 8.8.8.8`
- `ping google.com`
- `nslookup google.com`

### ❗ Observed
- Default Gateway missing  
- DNS servers incorrect  
- `ping 8.8.8.8` → General failure  
- `ping google.com` → Host not found  
- `nslookup` → No response from server  
- Browser → DNS_PROBE_FINISHED_NO_INTERNET  

### ✔ Evidence
- case4_ipconfig_wrong_dns.txt  
- case4_ping_8.8.8.8_fail.txt  
- case4_ping_google_fail.txt  
- case4_nslookup_fail.txt  
- browser_dns_error.png  

---

## 🔍 Step 4 — Diagnosis

### ✔ Findings
1. Valid IPv4 address  
2. **Missing Default Gateway** → no routing  
3. **Invalid DNS servers** → cannot resolve domains  
4. `ping` to IP fails because no gateway  
5. `ping` to domain + `nslookup` fail because DNS unreachable  

### 🧠 Root Cause
Manual DNS settings caused Windows to drop gateway configuration.  
Result: **No routing** + **Broken DNS**.

---

## 🛠 Step 5 — Fix Procedure (Command-Line)

### ✔ Restore DHCP for IP + DNS
netsh interface ip set address name="Ethernet" source=dhcp
netsh interface ip set dns name="Ethernet" source=dhcp

### ✔ Reset TCP/IP stack
ipconfig /flushdns
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset

Rebooted once.

---

## ✅ Step 6 — Verification (After Fix)

### ✔ Commands
- `ipconfig /all`
- `ping 8.8.8.8`
- `ping google.com`
- `nslookup google.com`

### ✔ Success
- Default Gateway restored  
- DNS restored  
- All ping tests successful  
- nslookup resolves normally  
- Browser loads google.com  

---

## 📁 Evidence (After Fix)

| Type       | Description                   | File                               |
|------------|-------------------------------|-------------------------------------|
| Screenshot | Browser working after fix     | `browser_after_fix.png`             |
| Screenshot | Successful ping to google.com | `ping_google_after_fix.png`         |
| Log        | ipconfig (after fix)          | `case4_ipconfig_after_fix.txt`      |
| Log        | ping 8.8.8.8 (after fix)      | `case4_ping_8.8.8.8_after_fix.txt`  |
| Log        | ping google.com (after fix)   | `case4_ping_google_after_fix.txt`   |
| Log        | nslookup (after fix)          | `case4_nslookup_after_fix.txt`      |

---

## 🧩 Skills Demonstrated
- Network troubleshooting  
- Understanding of DNS, DHCP, gateway routing  
- Using:  
  - `ipconfig`  
  - `ping`  
  - `nslookup`  
  - `netsh`  
- Full troubleshooting workflow  
- Professional evidence collection  

---

## 📌 Status: **Resolved**
System restored and connectivity verified.
