# 🛠 Case 5 — DNS Not Resolving  
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** DNS Resolution Failure (Domain names cannot be resolved)

---

## 🎯 Scenario  
User reports:

> “Internet seems connected, but websites won’t load.  
> Ping to IP works, but ping to domain fails.”

This lab simulates a real-world DNS failure where Internet routing is still functional,  
but **DNS resolution is broken**.

The goal:  
- Reproduce the issue  
- Diagnose the broken DNS configuration  
- Fix using proper CLI tools  
- Verify full recovery  
- Document with logs + screenshots

---

## 🧪 Step 1 — Baseline (Normal State)

Verified that everything works before breaking it.

### ✔ Commands:
 - `ipconfig /all`
 - `ping 8.8.8.8`
 - `ping google.com`
 - `nslookup google.com`

### ✔ Expected:
- IP & Gateway OK  
- ping 8.8.8.8 OK  
- ping google.com OK  
- nslookup resolves normally  
- Browser loads google.com

### 📁 Evidence:
- baseline_ipconfig_all.txt  
- baseline_ping_ip.txt  
- baseline_ping_domain.txt  
- baseline_nslookup.txt  
- baseline_browser_ok.png  

---

## 🧨 Step 2 — Simulation (Breaking DNS Only)

To simulate DNS failure without breaking routing:

- Open `Ethernet → IPv4 Settings`
- Set invalid DNS servers:
  - `9.9.9.7`
  - `123.123.123.123`

**Important:**  
Only DNS was modified — IP & Default Gateway remain DHCP → routing still works.

### 📸 Evidence:
- wrong_dns_setting.png

---

## 🚨 Step 3 — Broken State

Now websites cannot resolve, but IP-level traffic is OK.

### ✔ Commands:
 - `ipconfig /all`
 - `ping 8.8.8.8`
 - `ping google.com`
 - `nslookup google.com`

### ❗ Observed:
- Default Gateway still present → routing OK  
- ping 8.8.8.8 → **OK** (Internet available)  
- ping google.com → ❌ Host not found  
- nslookup google.com → ❌ Request timed out  
- Browser → **DNS_PROBE_FINISHED_NXDOMAIN**

### 📁 Evidence:
- case5_ipconfig_wrong_dns.txt  
- case5_ping_ip_ok.txt  
- case5_ping_google_fail.txt  
- case5_nslookup_fail.txt  
- browser_dns_error.png  

---

## 🔍 Step 4 — Diagnosis

### ✔ Findings:
1. **IP & Gateway are correct**  
   → Device can reach the internet  
2. **ping 8.8.8.8 = Success**  
   → Routing, NAT, ISP all working  
3. **ping google.com = Fail**  
   → Cannot resolve domain  
4. **nslookup = timeouts**  
   → DNS server unreachable  
5. **DNS settings are incorrect**  
   → (9.9.9.7 / 123.123.123.123)

### 🧠 Root Cause:
DNS misconfiguration.  
The system cannot resolve domain names due to invalid DNS server entries.

---

## 🛠 Step 5 — Fix Procedure (CLI Method)

Performed the fix using command-line tools for professional workflow.

### ✔ Reset DNS to DHCP
- `netsh interface ip set dns name="Ethernet" source=dhcp`

### ✔ Flush DNS Cache
- `ipconfig /flushdns`

### ✔ Renew DHCP (IP + DNS)
- `ipconfig /release`
- `ipconfig /renew`

### 📸 Evidence:
- dns_setting_fixed.png  
- dns_setting_fixed_command.png  

---

## ✅ Step 6 — Verification (After Fix)

### ✔ Commands:
- `ipconfig /all`
- `ping 8.8.8.8`
- `ping google.com`
- `nslookup google.com`

### ✔ Results:
- DNS restored  
- ping IP works  
- ping domain works  
- nslookup resolves successfully  
- Browser loads normally  

### 📁 Evidence (After Fix):

| Type       | Description                   | File                                 |
|------------|-------------------------------|---------------------------------------|
| Log        | ipconfig after fix            | `case5_ipconfig_after_fix.txt`        |
| Log        | ping 8.8.8.8 OK               | `case5_ping_ip_after_fix.txt`         |
| Log        | ping google.com OK            | `case5_ping_google_after_fix.txt`     |
| Log        | nslookup OK                   | `case5_nslookup_after_fix.txt`        |
| Screenshot | Browser resolved normally     | `browser_after_fix.png`               |
| Screenshot | DNS fixed via GUI/CLI         | `dns_setting_fixed.png`               |
| Screenshot | CLI fix commands              | `dns_setting_fixed_command.png`       |

---

## 🧩 Skills Demonstrated

- DNS troubleshooting (nslookup, ping, ipconfig)
- Network fundamentals: routing vs. name resolving
- Using `netsh` to configure networking  
- Identifying misconfigurations  
- Professional evidence documentation  
- Full IT Support troubleshooting workflow

---

## 📌 Status: **Resolved**
DNS functionality restored and tested successfully.
