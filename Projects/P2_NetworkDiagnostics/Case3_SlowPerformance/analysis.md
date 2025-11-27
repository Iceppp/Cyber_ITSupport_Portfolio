# Case 3 – Slow Network Performance (High Latency / Congestion)
*P2 – Network Diagnostics Project*

---

## 1. Scenario Overview  
A common user complaint was simulated:

**“Internet works, but everything feels slow.”**

This scenario represents real-world cases where users experience:
- Delayed loading times  
- High latency during browsing or gaming  
- Video buffering  
- Intermittent slowness without full connectivity loss  

To reproduce this condition, a high-bandwidth load (YouTube 4K streaming) was introduced while performing network diagnostics using ICMP tools.

---

## 2. Diagnostic Workflow  

The MSP-standard troubleshooting approach was followed:

1. Verify local configuration  
2. Measure latency under load  
3. Identify latency spikes and jitter  
4. Perform traceroute to observe hop behavior  
5. Check NIC statistics  
6. Confirm ARP stability  
7. Capture full session transcript  

Evidence stored in:
```
screenshots/
raw_output/
```

---

## 3. Evidence Summary & Interpretation  

### 🔹 IP Configuration (`ipconfig /all`)  
- IPv4 and Gateway assigned correctly  
- DHCP functioning normally  
- No local misconfiguration  
- Confirms Layer 1–3 connectivity is healthy

---

### 🔹 Latency Test (`ping -n 20 8.8.8.8`)  
**Results:**  
- Minimum: 22 ms  
- Maximum: **158 ms**  
- Average: **68 ms**  

**Analysis:**  
- Significant latency spikes (22 → 158 ms)  
- Jitter extremely high  
- Zero packet loss (connection stable but slow)  
- Classic indicator of congestion or high load on the network path  

This reproduces the user symptom accurately.

---

### 🔹 Traceroute (`tracert 8.8.8.8`)  
Key findings:
- Hop 1–2: Normal LAN & ISP access (low latency)  
- Hop 3: Latency jump (41–55 ms) → first congestion point  
- Hop 4: `Request timed out` (common on congested or ICMP-deprioritized routers)  
- Subsequent hops: 35–50 ms  
- Destination reached successfully  

**Conclusion:**  
Routing path is functional but contains **intermittent congestion** on intermediate hops.

---

### 🔹 NIC Statistics (`netstat -e`)  
All counters normal:
- Errors = 0  
- Discards = 0  
- Unknown protocols = 0  

**Conclusion:**  
NIC hardware is not the cause → rules out Layer 1/LAN issues.

---

### 🔹 ARP Table (`arp -a`)  
- Gateway ARP resolved normally  
- No incomplete entries  
- No unusual MAC addresses  

**Conclusion:**  
Layer 2 is healthy. No ARP storm, conflict, or poisoning.  
Slowness is not related to local LAN.

---

### 🔹 PowerShell Transcript  
Full diagnostic session captured using:

```
Start-Transcript -Path ".\Raw_Output\session_case3.txt"
```

This provides an auditable timeline of commands and outputs.

---

## 4. Root Cause Summary  

### **Primary Root Cause:**  
### ✅ High network congestion resulting in latency spikes and unstable response times.

### Supporting Evidence:
- Ping spike up to **158 ms**  
- Jitter across all packets  
- Traceroute hop timeout at hop 4  
- Latency jump starting from hop 3  
- NIC + ARP normal  

### Confirmed Non-Issues:
- No hardware errors  
- No DHCP issues  
- No DNS issues  
- No routing failure  
- No ARP conflict  

This is a classic case of **WAN congestion** under heavy load.

---

## 5. Resolution Steps  

### ✔ 1. Reduce network load
- Pause high-bandwidth applications (YouTube 4K, downloads, streaming).  
- Limit background traffic from other devices.

### ✔ 2. Restart router / modem  
Often clears upstream congestion or resets routing conditions.

### ✔ 3. If persistent:  
- Contact ISP to investigate international routing or peering congestion.  
- Run tests at different times to confirm pattern.  

### ✔ 4. Optional:  
Introduce QoS settings on router to prevent saturation.

---

## 6. Lessons Learned  
- High latency does not always indicate packet loss  
- Traceroute may appear normal even when ping is unstable  
- Intermediate router timeouts do not imply failure  
- Congestion typically appears as latency spikes and jitter  
- NIC stats help verify whether issue is local or upstream  
- Layer-by-layer troubleshooting isolates the root cause efficiently  

---

## 7. Skills Demonstrated  
- Latency and jitter diagnostics  
- Congestion analysis  
- ICMP-based troubleshooting  
- Traceroute hop interpretation  
- Layer 1–3 network validation  
- NIC performance evaluation  
- Professional incident documentation  
- PowerShell transcript logging  

---

## 8. Evidence Directory (RAW)
```
Case3_SlowPerformance/
│
├── screenshots/
│   ├── 1_ipconfig_all.png
│   ├── 2_ping_latency_spike.png
│   ├── 3_tracert_8.8.8.8.png
│   ├── 4_netstat_e.png
│   ├── 5_arp_table.png
│   └── 6_transcript_case3.png
│
└── raw_output/
    ├── ipconfig_all.txt
    ├── ping_latency.txt
    ├── tracert_8.8.8.8.txt
    ├── netstat_e.txt
    ├── arp_table.txt
    └── session_case3.txt
```
