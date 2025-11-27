# Case 1 – Basic Connectivity & Routing Diagnostics  
*P2 – Network Diagnostics Project*

## 1. Scenario Overview
A common real-world IT Support incident was simulated:  
**“User is connected to the network but cannot access the internet.”**

To reproduce this issue, the system’s DHCP lease was intentionally released using:

```
ipconfig /release
```

This forced the device to lose its IPv4 configuration entirely, resulting in:
- No IPv4 address  
- No Default Gateway  
- No DNS Servers  
- APIPA address assigned (169.254.x.x)  
- No routing capability  

This scenario accurately reflects issues seen in workplaces when DHCP servers fail, access points misbehave, or network adapters lose their lease.

---

## 2. Diagnostic Workflow (MSP Methodology)
The troubleshooting sequence followed a standard MSP (Managed Service Provider) approach:

1. Verify IP configuration  
2. Test default gateway reachability  
3. Test internet reachability via IP  
4. Test DNS resolution  
5. Trace packet route  
6. Inspect routing table  
7. Inspect ARP cache  
8. Check interface status  
9. Check packet-level errors  
10. Capture PowerShell transcript  

All evidence collected is stored under:

```
/screenshots
/raw_output
```

---

## 3. Evidence Summary & Interpretation

### 🔹 IP Configuration (`ipconfig /all`)
- IPv4 address missing  
- Autoconfiguration address: **169.254.x.x (APIPA)**  
- No default gateway  
- No DNS servers  
- DHCP Enabled = Yes (but server not responding)

**Conclusion:** DHCP failure → device isolated at Layer 3.

---

### 🔹 Router Connectivity Test (`ping 192.168.1.1`)
- All requests failed

**Conclusion:** Device cannot reach the gateway.

---

### 🔹 Internet Connectivity Test (`ping 8.8.8.8`)
- Result: **General Failure**

**Conclusion:** Routing failure even when bypassing DNS.

---

### 🔹 DNS Test (`ping google.com`)
- DNS name could not be resolved

**Conclusion:** DNS fails due to missing gateway.

---

### 🔹 Route Trace (`tracert google.com`)
- Fails at hop 1

**Conclusion:** No outbound route available.

---

### 🔹 Routing Table (`route print`)
Findings:
- **No default route (0.0.0.0/0)**  
- Link-local routes only  
- Interface bound to APIPA  

**Conclusion:** Device cannot route packets beyond local host.

---

### 🔹 ARP Cache (`arp -a`)
- No MAC entry for gateway  
- Only APIPA & multicast entries visible  

**Conclusion:** Layer 2 resolution to gateway failed.

---

### 🔹 Interface Status (`netsh wlan show interfaces`)
- Wireless service disabled (Ethernet in use)  

---

### 🔹 Adapter Error Check (`netstat -e`)
- Errors: 0  
- Discards: 0  

**Conclusion:** NIC functioning correctly; issue purely routing/DHCP.

---

### 🔹 PowerShell Transcript (`Start-Transcript`)
Full session recorded here:

```
raw_output/session_log.txt
```

**Purpose:** Provides an auditable, timestamped record of all actions performed.

---

## 4. Root Cause Summary

### **Primary Root Cause:**  
### ✅ Loss of DHCP Lease → APIPA Assigned → No Gateway → No Routing → No Internet

Layer summary:
- **Layer 2:** Gateway ARP not resolved  
- **Layer 3:** Default route missing  
- **DNS:** Unable to operate  
- **Result:** Complete network isolation  

---

## 5. Resolution Steps
DHCP lease restored using:

```
ipconfig /renew
```

After renewal:
- Valid IPv4 received  
- Default gateway restored  
- DNS servers restored  
- Internet connectivity verified  

---

## 6. Lessons Learned
- Identify DHCP failures via APIPA  
- Distinguish Layer 2 vs Layer 3 issues  
- DNS errors may be secondary symptoms  
- Understand routing and ARP behavior  
- Use transcript logging for MSP-grade documentation  
- Apply structured troubleshooting methodology  

---

## 7. Skills Demonstrated
- Network Layer 1–3 troubleshooting  
- DHCP and routing diagnostics  
- ARP-level analysis  
- DNS troubleshooting  
- Command-line networking tools  
- Professional documentation  
- PowerShell transcript logging  
- Evidence-based reporting  

---

## 8. Evidence Directory

```
Case1_Connectivity/
│
├── screenshots/
│   ├── 0_release.png
│   ├── 1_ipconfig_all.png
│   ├── 2_ping_router.png
│   ├── 3_ping_8.8.8.8.png
│   ├── 4_ping_google.png
│   ├── 5_tracert_google.png
│   ├── 6_route_print.png
│   ├── 7_arp_table.png
│   ├── 8_wlan_interface.png
│   └── 9_netstat_e.png
│
└── raw_output/
    ├── ipconfig_all.txt
    ├── ping_router.txt
    ├── ping_8.8.8.8.txt
    ├── ping_google.txt
    ├── tracert_google.txt
    ├── route_print.txt
    ├── arp_table.txt
    ├── wlan_interface.txt
    ├── netstat_e.txt
    └── session_log.txt
```

