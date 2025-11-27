# P2 – Network Diagnostics Project  
Comprehensive troubleshooting scenarios demonstrating Layer 1–3 analysis, DNS diagnostics, latency investigations, and full evidence-based reporting.

This project contains **3 real-world IT Support / MSP cases**, each designed to replicate issues commonly encountered in enterprise and small-business environments. The goal is to analyze symptoms, gather evidence, identify root causes, and document solutions professionally.

---

# 📁 Project Structure
```
P2_Network Diagnostics/
│
├── Case1_Connectivity/
├── Case2_DNSFailure/
└── Case3_SlowPerformance/
```

Each case includes:
- **screenshots/** → visual evidence  
- **raw_output/** → captured logs  
- **analysis.md** → full documentation  

---

# 🎯 Project Objectives
- Develop hands-on diagnostic skills using Windows networking tools  
- Learn how to isolate failures in Layer 1–3  
- Identify common issues such as DHCP loss, DNS failure, and high-latency congestion  
- Demonstrate professional incident documentation suitable for MSP work  
- Build portfolio-ready troubleshooting cases for IT Support / Network roles  

---

# 🧪 Overview of Cases

---

## ✅ **Case 1 – Basic Connectivity Failure (DHCP / Gateway Issue)**  
A DHCP lease was intentionally released, causing the system to fall back to an APIPA address (169.254.x.x). This simulated conditions where users lose access to the router and internet.

### Skills Demonstrated:
- DHCP troubleshooting  
- APIPA analysis  
- Gateway reachability tests  
- Routing table inspection  
- ARP/MAC-layer diagnostics  
- PowerShell transcript logging  

📄 *See:* `Case1_Connectivity/analysis.md`

---

## ✅ **Case 2 – DNS Failure (Name Resolution Broken)**  
DNS server was modified to `127.0.0.1`, breaking all name resolution while IP-based connectivity remained functional.

### Skills Demonstrated:
- DNS resolution tests (ping, nslookup)  
- Distinguishing network vs DNS failures  
- Understanding ICMP vs DNS lookup patterns  
- Validating routing despite name resolution issues  
- Documentation following MSP standards  

📄 *See:* `Case2_DNSFailure/analysis.md`

---

## ✅ **Case 3 – Slow Performance (High Latency / Congestion)**  
YouTube 4K streaming was used to generate real-world bandwidth saturation, demonstrating jitter, latency spikes, and intermittent hop timeouts.

### Skills Demonstrated:
- Latency and jitter analysis  
- Using ping for performance monitoring  
- Traceroute hop-by-hop diagnosis  
- Identifying congestion vs hardware errors  
- NIC/ARP stability verification  

📄 *See:* `Case3_SlowPerformance/analysis.md`

---

# 🛠 Tools Used
- **Command Prompt**  
  - `ipconfig`, `ping`, `tracert`, `arp`, `netstat`
- **PowerShell Transcript**  
  - `Start-Transcript`, `Stop-Transcript`
- **Web Diagnostics**  
  - Speed tests  
  - Load simulation (YouTube 4K)

---

# 📚 Skills Gained from P2
- Network Layer 1–3 troubleshooting  
- DHCP, DNS, and gateway diagnostics  
- Congestion and latency investigation  
- Interpreting routing paths  
- Using NIC counters to validate hardware health  
- ARP/MAC-layer understanding  
- Professional incident documentation  
- Evidence-based reporting for MSP environments  

---

# 🧩 Why This Project Matters (For Recruiters)
This project demonstrates:
- Real hands-on troubleshooting  
- Clear, structured documentation  
- Ability to resolve common network/user issues  
- Practical understanding of Windows networking  
- Strong analytical + diagnostic reasoning  

These skills directly apply to roles such as:
- IT Support Technician  
- Service Desk / Helpdesk  
- Network Support / Junior Network Admin  
- MSP Support Technician  
- Cybersecurity Analyst (Foundational Networking component)  

---

# ✔ Completed Cases
- [x] Case 1 – Connectivity Failure  
- [x] Case 2 – DNS Failure  
- [x] Case 3 – Slow Performance  

P2 is officially **100% complete** 🎉  

---

# 👤 Author
**Passawut Sawongkhan (Ice)**  
IT Support | Network Diagnostics | Cybersecurity (Foundational)  
Australia 🇦🇺 • Portfolio-Driven Learning

