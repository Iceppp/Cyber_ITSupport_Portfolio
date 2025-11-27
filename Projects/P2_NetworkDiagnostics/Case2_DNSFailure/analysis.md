# Case 2 – DNS Failure Diagnostics  
*P2 – Network Diagnostics Project*

---

## 1. Scenario Overview
A real-world IT Support issue was simulated:

**“Internet works when using IP addresses, but any domain name fails to load.”**

To reproduce this, the DNS server was manually misconfigured using:

```
netsh interface ip set dns "Ethernet" static 127.0.0.1
```

This forced Windows to use **localhost** as the DNS server—where no DNS service is running—resulting in complete DNS failure while network connectivity remained intact.

---

## 2. Diagnostic Workflow
Standard MSP troubleshooting methodology was followed:

1. Verify IP configuration  
2. Test connectivity using IP (bypassing DNS)  
3. Test DNS name resolution  
4. Check DNS server reachability  
5. Validate routing path  
6. Inspect adapter configuration  
7. Capture transcript for audit  

All evidence stored under:

```
screenshots/
raw_output/
```

---

## 3. Evidence Summary & Interpretation

### 🔹 IP Configuration (`ipconfig /all`)
Key findings:
- IPv4: **10.x.x.x** assigned correctly  
- Default Gateway: **10.0.0.138** (router)  
- DHCP Server responding normally  
- DNS Server = **127.0.0.1 (INCORRECT)**

**Conclusion:**  
Network is healthy → DNS misconfiguration is isolated root cause.

---

### 🔹 Connectivity Test (By IP)
```
ping 8.8.8.8
```
- Replies successful  
- 0% packet loss  
- Normal latency

**Conclusion:**  
Internet connectivity is fully functional at Layer 3.

---

### 🔹 Domain Name Test
```
ping google.com
```
Result:
```
Ping request could not find host google.com.
```

**Conclusion:**  
DNS resolution is failing, but network itself is not.

---

### 🔹 DNS Lookup Test (`nslookup`)
```
Server: Unknown
Address: 127.0.0.1
*** Unknown can't find google.com: No response from server
```

**Conclusion:**  
DNS service unreachable → Windows cannot resolve domains.

---

### 🔹 DNS Server Reachability (`ping 127.0.0.1`)
Result:
- Ping successful (localhost)

**Interpretation:**  
The DNS *server address* is reachable, but **no DNS service is listening on port 53**.  
This confirms **DNS server misconfiguration**, not network failure.

---

### 🔹 Routing Path (`tracert 8.8.8.8`)
Trace successfully reaches 8.8.8.8 through multiple hops.

**Conclusion:**  
Routing is correct → No ISP or gateway issue.

---

### 🔹 PowerShell Transcript
All diagnostics were captured using:

```
Start-Transcript -Path ".\Raw_Output\session_case2.txt"
```

This provides a full audit trail of the incident.

---

## 4. Root Cause Summary
### **Primary Root Cause:**  
### ❌ DNS server was manually set to `127.0.0.1`  
No DNS service exists on localhost → all DNS queries fail.

### Technical Breakdown:
- DNS unreachable  
- Domain resolution impossible  
- IP connectivity unaffected  
- Routing and gateway normal  

This is a **classic isolated DNS failure**.

---

## 5. Resolution Steps

### ✔ Step 1 — Restore correct DNS
Either restore DHCP-controlled DNS:

```
netsh interface ip set dns "Ethernet" dhcp
```

or manually set public DNS:

```
netsh interface ip set dns "Ethernet" static 8.8.8.8
netsh interface ip add dns "Ethernet" 1.1.1.1 index=2
```

### ✔ Step 2 — Verify fix
After restoration:

```
ipconfig /all
ping google.com
nslookup google.com
```

Expected results:
- DNS server no longer 127.0.0.1  
- ping google.com → SUCCESS  
- nslookup → resolves to real IPs  

Connectivity restored.

---

## 6. Lessons Learned
- DNS issues can be isolated while network works perfectly  
- Always test IP connectivity before DNS resolution  
- nslookup provides deeper DNS-level visibility than ping  
- Misconfigured DNS results in complete domain lookup failure  
- Proper documentation includes both failure and recovery evidence  
- PowerShell transcripts are essential for auditing in MSP workflows  

---

## 7. Skills Demonstrated
- DNS troubleshooting  
- Layer 3 connectivity validation  
- Name resolution diagnostics  
- Command-line network tools  
- Routing verification  
- Professional incident documentation  
- PowerShell transcript auditing  

---

## 8. Evidence Directory (RAW)
```
Case2_DNSFailure/
│
├── screenshots/
│   ├── 1_set_wrong_dns.png
│   ├── 2_ping_8.8.8.8.png
│   ├── 3_ping_google_fail.png
│   ├── 4_nslookup_fail.png
│   ├── 5_ipconfig_dns_wrong.png
│   ├── 6_ping_dns_server.png
│   ├── 7_tracert_8.8.8.8.png
│   ├── 8_transcript_case2.png
│   ├── 9_dns_fix_ipconfig.png
│   ├── 10_dns_fix_ping_google.png
│   └── 11_dns_fix_nslookup.png
│
└── raw_output/
    ├── ipconfig_dns_wrong.txt
    ├── ping_8.8.8.8.txt
    ├── ping_google_fail.txt
    ├── nslookup_fail.txt
    ├── tracert_8.8.8.8.txt
    ├── ping_dns_server_fail.txt
    ├── session_case2.txt
    ├── ipconfig_after_fix.txt
    ├── ping_google_after_fix.txt
    └── nslookup_after_fix.txt
```
