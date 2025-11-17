# 🛠 Case 6 — Slow Performance / High CPU Usage  
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** High CPU Usage / System Slowdown

---

## 🎯 Scenario  
User reports:

> “Computer is extremely slow. Applications freeze and Task Manager shows high CPU usage.”

This lab simulates a real scenario where the system becomes slow due to **CPU overload**.  
We reproduced the issue using a controlled PowerShell stress script, diagnosed the problem, applied fixes, and verified performance recovery.

---

## 🧪 Step 1 — Baseline (Normal State)

Before causing the issue, system performance was checked to ensure normal operation.

### ✔ Commands (Baseline)
```
systeminfo
tasklist
wmic cpu get loadpercentage
```

PowerShell:
```
Get-Process | Sort CPU -Descending | Select -First 10
```

### ✔ Expected:
- CPU usage low (1–10%)
- No abnormal processes
- System responsive

### 📁 Evidence:
- `baseline_systeminfo.txt`
- `baseline_tasklist.txt`
- `baseline_cpu_load.txt`
- `baseline_top10cpu.txt`
- `baseline_taskmgr.png`
- `baseline_cpu_graph.png`

---

## 🧨 Step 2 — Simulation (Creating High CPU Load)

To reproduce the “slow computer / high CPU” problem,  
CPU overload was generated using the following PowerShell loop:

```powershell
$jobs = @()
for ($i=1; $i -le 4; $i++) {
    $jobs += Start-Job -ScriptBlock { while ($true) { 1+1 } }
}
```

### ❗ Observed Behavior:
- CPU usage spiked to 70–100%
- Device responded slowly or lagged
- Performance graph showed sustained CPU load
- Task Manager listed multiple CPU-heavy script jobs

### 📁 Evidence (Broken State):
- `taskmgr_cpu_high.png`
- `cpu_spike_graph.png`
- `case6_tasklist_high_cpu.txt`
- `case6_cpu_high.txt`
- `case6_top10cpu_high.txt`

---

## 🔍 Step 3 — Diagnosis

### ✔ Findings:
1. CPU usage consistently stayed above 90%.
2. Task Manager showed multiple PowerShell jobs consuming CPU.
3. `tasklist` and `Get-Process` verified CPU-bound loops running in background.
4. System slowdown was caused by CPU saturation, not RAM or disk bottleneck.
5. No malware detected — load was caused by test script.

### 🧠 Root Cause:
A PowerShell infinite loop script created multiple CPU-intensive jobs,  
causing **CPU exhaustion** and overall system slowdown.

---

## 🛠 Step 4 — Fix Procedure

### ✔ Stop CPU Load Jobs
```powershell
Get-Job | Remove-Job -Force
```

### ✔ Verify CPU drops back to normal
```
wmic cpu get loadpercentage
```

### ✔ Confirm active processes
```
tasklist
```

PowerShell:
```
Get-Process | Sort CPU -Descending | Select -First 10
```

### 📁 Evidence (After Fix):
- `taskmgr_cpu_after_fix.png`
- `cpu_graph_after_fix.png`
- `case6_tasklist_after_fix.txt`
- `case6_cpu_after_fix.txt`
- `case6_top10cpu_after_fix.txt`

---

## ✅ Step 5 — Verification

### ✔ Results:
- CPU usage returned to normal levels
- No CPU-heavy processes remained
- Device performance normalized
- Task Manager showed stable CPU graph

System performance successfully restored.

---

## 🧩 Skills Demonstrated

- Identifying CPU bottlenecks
- Using Task Manager, Performance tab
- Interpreting CPU, RAM, and process data
- Using CMD tools:
  - `tasklist`
  - `wmic`
- Using PowerShell for:
  - process inspection
  - job management
- Documenting troubleshooting steps professionally
- Baseline → Simulation → Diagnosis → Fix → Verification workflow

---

## 📌 Status: **Resolved**
CPU load normalized and system responsiveness restored.
