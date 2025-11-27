# Case 1 – Basic Connectivity & Routing Diagnostics  
*P2 – Network Diagnostics Project*

## 1. Scenario Overview
A common real-world IT Support incident was simulated:  
**“User is connected to the network but cannot access the internet.”**

To reproduce this issue, the system’s DHCP lease was intentionally released using:

ipconfig /release

markdown
Copy code

This caused the device to lose its IPv4 configuration entirely, resulting in:
- No IPv4 address  
- No Default Gateway  
- No DNS Servers  
- APIPA address assigned (169.254.x.x)  
- No routing capability  

This scenario accurately reflects issues seen in workplaces when DHCP servers fail, access points misbehave, or network adapters lose their lease.

---

## 2. Diagnostic Workflow (MSP Methodology)
The following troubleshooting sequence follows standard MSP (Managed Service Provider) procedures:

1. **Verify IP configuration**  
2. **Test default gateway reachability**  
3. **Test internet reachability via IP (bypass DNS)**  
4. **Test DNS resolution**  
5. **Trace network path (tracert)**  
6. **Inspect routing table**  
7. **Inspect ARP table (Layer 2)**  
8. **Check WiFi/Ethernet interface status**  
9. **Check packet-level errors**  
10. **Capture PowerShell transcript for full audit**  

All evidence collected is stored under:

/screenshots
/raw_output

yaml
Copy code

---

## 3. Evidence Summary & Interpretation

### 🔹 IP Configuration (`ipconfig /all`)
- IPv4 address missing  
- Autoconfiguration address assigned: **169.254.x.x (APIPA)**  
- No default gateway  
- No DNS servers  
- DHCP Enabled = Yes (but not responding)

**Conclusion:** DHCP lease lost → device cannot participate in routed network.

---

### 🔹 Router Connectivity Test (`ping 192.168.1.1`)
- Requests failed (timed out / unreachable)

**Conclusion:** Device cannot reach default gateway → routing impossible.

---

### 🔹 Internet Connectivity Test (`ping 8.8.8.8`)
- Results: **General Failure**

**Conclusion:** Device cannot reach external network even by IP (DNS bypassed).  
Strong evidence of Layer 3 routing failure.

---

### 🔹 DNS Test (`ping google.com`)
- DNS name could not be resolved

**Conclusion:** Expected result; DNS cannot function without gateway access.

---

### 🔹 Route Trace (`tracert google.com`)
- Fails immediately at hop 1

**Conclusion:** No route to gateway → no possible internet traversal.

---

### 🔹 Routing Table Inspection (`route print`)
Key findings:
- **No default route (0.0.0.0/0)**  
- All routes are **link-local only**  
- Interface bound to APIPA address 169.254.x.x  
- No gateway route present

**Conclusion:** Layer 3 routing is completely missing.

---

### 🔹 ARP Table (`arp -a`)
- No MAC entry for any default gateway  
- Only APIPA and multicast entries visible

**Conclusion:** Device cannot resolve gateway at Layer 2 → L2/L3 failure stack.

---

### 🔹 Interface Status (`netsh wlan show interfaces` / Ethernet)
- Wireless service not running (expected; wired interface in use)
- Confirms issue not related to WiFi

---

### 🔹 Adapter Error Check (`netstat -e`)
- Errors: **0**  
- Discards: **0**

**Conclusion:** Network adapter functioning normally; no Layer 2 hardware issues.

---

### 🔹 PowerShell Transcript (`Start-Transcript`)
Full troubleshooting session captured in:

Raw_output/session_log.txt

yaml
Copy code

**Purpose:**  
Provides an auditable, timestamped record of all diagnostic commands executed, matching MSP incident documentation standards.

---

## 4. Root Cause Summary
Based on all collected evidence:

### **Primary Root Cause:**  
### ✅ Loss of DHCP Lease → APIPA Address Assigned → No Default Gateway → No Routing → No Internet

### Technical Breakdown:
- **Layer 2:** No ARP entry for gateway  
- **Layer 3:** No IPv4 address or default route  
- **DNS:** Inoperable due to lack of gateway  
- **Result:** Complete network isolation despite being “connected”

---

## 5. Resolution Steps
The issue was resolved by renewing the DHCP lease:

ipconfig /renew

yaml
Copy code

After renewal:
- IPv4 address restored  
- Default gateway populated  
- DNS servers restored  
- ping, tracert, and routing returned to normal  

Connectivity fully restored.

---

## 6. Lessons Learned
This case reinforced key IT Support diagnostic skills:

- How to identify DHCP failures via APIPA signatures  
- How to differentiate Layer 2 vs Layer 3 failures  
- Why DNS issues can be a *symptom*, not the cause  
- How to read routing tables and ARP entries accurately  
- MSP-standard documentation using PowerShell transcripts  
- Importance of testing IP connectivity before DNS  
- Understanding gateway failure cascades  
- Using structured troubleshooting frameworks for consistency  

---

## 7. Skills Demonstrated
- Network Layer 1–3 troubleshooting  
- DHCP analysis  
- Routing table inspection  
- ARP-level diagnostics  
- DNS diagnostic methodology  
- Command-line networking tools  
- Professional incident documentation  
- PowerShell transcript logging  
- Evidence-based reporting  

---

## 8. Evidence Directory
Case1_Connectivity/
│
├── screenshots/
│ ├── 0_release.png
│ ├── 1_ipconfig_all.png
│ ├── 2_ping_router.png
│ ├── 3_ping_8.8.8.8.png
│ ├── 4_ping_google.png
│ ├── 5_tracert_google.png
│ ├── 6_route_print.png
│ ├── 7_arp_table.png
│ ├── 8_wlan_interface.png
│ └── 9_netstat_e.png
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