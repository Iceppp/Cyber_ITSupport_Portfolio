# 🛠 Case 8 — Audio Not Working / No Sound  
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** Audio Services Not Running / No Output Device

---

## 🎯 Scenario  
User reports:

> “There is no sound. The audio icon shows an X and Windows says no audio device.”

This lab simulates an audio failure caused by **Windows Audio services being disabled**, which commonly occurs due to misconfiguration, system corruption, or third-party optimization tools.

The goal is to reproduce the issue, diagnose the root cause, restore audio services, and verify functionality.

---

## 🧪 Step 1 — Baseline (Normal State)

Before causing the issue, system audio was confirmed to be in a healthy state.

### ✔ Baseline Checks  
- Windows Audio service **Running**  
- Windows Audio Endpoint Builder **Running**  
- Sound Settings shows an output device (or no error)

### ✔ Baseline Screenshots  
- `baseline_audio_services_running.png`  
- `baseline_sound_settings.png`

### ✔ Baseline Logs  

CMD:
```
sc query audiosrv
sc query AudioEndpointBuilder
```

PowerShell:
```
Get-Service audiosrv, AudioEndpointBuilder
```

📁 Files:
- `baseline_audio_service.txt`
- `baseline_endpoint_service.txt`
- `baseline_services.txt`

---

## 🧨 Step 2 — Simulation (Break the Audio System)

To replicate a real-world “no sound” issue, the following services were intentionally stopped and disabled:

1. **Windows Audio (audiosrv)**  
2. **Windows Audio Endpoint Builder**

### 🔥 Broken Behavior Observed  
- Audio icon displayed ❌  
- Sound Settings showed errors (e.g. “Audio services not running”)  
- No output device detected  
- Audio playback impossible

### 📸 Broken State Screenshots  
- `audio_services_stopped.png`  
- `sound_settings_error.png`

### 📄 Broken Logs  

CMD:
```
sc query audiosrv
sc query AudioEndpointBuilder
```

PowerShell:
```
Get-Service audiosrv, AudioEndpointBuilder
```

📁 Files:
- `case8_audio_service_status_fail.txt`
- `case8_endpoint_service_status_fail.txt`
- `case8_services_broken.txt`

---

## 🔍 Step 3 — Diagnosis

### ✔ Findings  
1. Sound Settings produced *“No output device found”* / *“Audio services not running”*.  
2. Services console showed:
   - **Windows Audio = Stopped, Disabled**
   - **Audio Endpoint Builder = Stopped, Disabled**
3. Without these services, Windows cannot initialize the audio engine.  
4. No driver issues detected—root cause is purely service-level.

### 🧠 Root Cause  
Audio failure was caused by **Windows Audio services being disabled**, preventing the OS from detecting or loading any audio devices.

---

## 🛠 Step 4 — Fix Procedure

### ✔ Re-enable Windows Audio Services  
Open `services.msc` and for both services:

1. Set **Startup Type → Automatic**  
2. Click **Start**  
3. Apply and confirm service status is **Running**

Services restored:
- Windows Audio  
- Windows Audio Endpoint Builder  

### 📁 Evidence (After Fix Logs)  
- `case8_audio_service_status_after_fix.txt`
- `case8_endpoint_service_status_after_fix.txt`
- `case8_services_after_fix.txt`

### 📸 After Fix Screenshots  
- `audio_services_running_after.png`  
- `sound_settings_ok_after_fix.png`

---

## ✅ Step 5 — Verification

After restoring the services:

✔ No more X on the audio icon  
✔ Sound Settings loads with no error  
✔ Audio services remain Running and Automatic  
✔ Playback works without error (VM does not require real audio device)

System successfully restored to normal operation.

---

## 🧩 Skills Demonstrated

- Diagnosing audio failures  
- Understanding service dependencies (AudioEndpointBuilder)  
- Using Services console and service management commands  
- Using:
  - `sc query`
  - PowerShell `Get-Service`
- Troubleshooting Windows sound subsystem  
- Structured process: baseline → simulate → diagnose → fix → verify  
- Professional evidence collection (logs + screenshots)

---

## 📌 Status: **Resolved**  
Audio subsystem restored. Sound functionality returned successfully.
