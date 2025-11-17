# 🧩 Case 1 — Windows Login Error (“User Profile Cannot Be Loaded”)  
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** User Profile Corruption / Temporary Profile Loaded

---

## 🎯 Scenario  
User reports:

> “We can’t sign in to your account. You are logged in with a temporary profile.”

Windows loads a temporary profile when it cannot read the user’s original profile directory. This typically occurs when the NTUSER.DAT file or the registry ProfileList entry is corrupted.

---

## 🧪 Step 1 — Baseline (Normal Profile State)

Before simulating the issue, a working test user was created:

- **Administrator:** `Passawut_IT_Security`  
- **Test User:** `TestUser`  

Verified normal login behavior and confirmed:

- Profile folder exists under: `C:\Users\TestUser`
- Registry contains valid ProfileList entry
- No temporary profile messages

📁 Baseline Folder:  
`C:\ITSupportLabs\Case1_WindowsLoginError`

---

## 🧨 Step 2 — Simulation (Reproduce the Error)

To intentionally trigger the profile corruption issue:

1. Logged into `TestUser` once so Windows creates the profile.
2. Logged out and returned to the Administrator account.
3. Renamed:
```
C:\Users\TestUser\NTUSER.DAT → NTUSER.DAT.broken
```
4. Logged in again as `TestUser`.

### ❗ Broken Behavior Observed:
- Windows displayed:
  **“We can’t sign in to your account.”**
- A **temporary profile** was loaded.
- User changes did not persist.
- Event Viewer logged **Event ID 1511 & 1515**.

---

## 🧾 Evidence (Broken State)

| Type | Description | File |
|------|-------------|------|
| Screenshot | Temporary profile error message | `01_error_login.png` |
| Registry | Damaged ProfileList entry, `.bak` present, `State ≠ 0`, `RefCount ≠ 0` | `02_regedit_before.png` |
| Event Logs | Event ID 1511 & 1515 | `ups_events.txt` |
| CMD Output | User & folder listings | `net_user.txt`, `users_folder.txt` |

**Event ID Details:**
- **1511** — Windows cannot find the local profile  
- **1515** — Windows backed up the user profile

---

## 🔍 Step 3 — Diagnosis

### ✔ Findings:
1. Windows was unable to read the profile registry key.  
2. Profile registry entry had a `.bak` suffix.  
3. `State` and `RefCount` values were non-zero.  
4. Folder permissions on `C:\Users\TestUser` were inconsistent.  
5. Profile corruption prevented NTUSER.DAT from loading.

### 🧠 Root Cause:
Corrupted or misconfigured **ProfileList** registry key caused Windows to create a temporary profile instead of loading the real user profile.

---

## 🛠 Step 4 — Fix Procedure

### ✔ 1. Backup Registry
Exported registry key:

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList
```

Saved as: `ProfileList_Backup.reg`.

---

### ✔ 2. Registry Repair

1. Located the SID entry referencing:
```
C:\Users\TestUser
```

2. Fixed the following:
   - Removed the `.bak` suffix (if present)  
   - Updated values to:
     ```
     RefCount = 0
     State = 0
     ProfileImagePath = C:\Users\TestUser
     ```

---

### ✔ 3. Reset Folder Permissions (Ownership Fix)

```powershell
takeown /F "C:\Users\TestUser" /R /D Y
icacls "C:\Users\TestUser" /inheritance:e
icacls "C:\Users\TestUser" /grant TestUser:(OI)(CI)F /T
```

---

### ✔ 4. Restart & Verify

- Rebooted system  
- Logged into `TestUser` successfully  
- Desktop loaded normally without temporary profile message  

---

## 🧾 Evidence (After Fix)

| Type | Description | File |
|------|-------------|------|
| Screenshot | Successful login, full profile loaded | `03_desktop_after.png` |
| Registry | `.bak` removed; `State = 0`, `RefCount = 0` | `04_regedit_after.png` |
| Event Logs | No new profile-related errors | `ups_events_after.txt` |

---

## ✅ Step 5 — Verification

✔ TestUser profile loads normally  
✔ No “temporary profile” alert  
✔ Registry ProfileList entry fully corrected  
✔ Folder permissions valid  
✔ Changes persist after logout/login  

User profile successfully restored.

---

## 🧩 Skills Demonstrated

- Windows profile troubleshooting  
- Event Viewer log analysis  
- Registry editing (ProfileList)  
- NTFS permissions + ownership recovery  
- CMD & PowerShell usage  
- Structured troubleshooting workflow  
- Professional documentation with screenshots/logs  

---

## 📌 Status: **Resolved**  
User profile recovered and permanent login restored.


