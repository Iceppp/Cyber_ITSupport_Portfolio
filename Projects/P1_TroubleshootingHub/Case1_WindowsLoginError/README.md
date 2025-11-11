# 🧩 Case 1 – Windows Login Error (“User Profile Cannot Be Loaded”)

**Goal:** Repair a corrupted Windows user profile that causes a temporary login session.  
**Test Environment:** Windows 10 VM (Oracle VirtualBox)  
**User Accounts:**  
- `Passawut_IT_Security` → Administrator  
- `TestUser` → Profile with error  

---

## 🧠 Root Cause
Windows could not load the user profile and created a temporary session.  
Common reasons:
- Missing or damaged `NTUSER.DAT`
- Registry key renamed with `.bak`
- Non-zero values in `State` or `RefCount`
- Folder permission or ownership issues

---

## 🧪 Setup Overview

| Component | Details |
|------------|----------|
| Virtualization | Oracle VirtualBox |
| Operating System | Windows 10 |
| Tools | Event Viewer, Registry Editor, PowerShell |
| Folder | `C:\ITSupportLabs\Case1_WindowsLoginError` |

---

## ⚙️ How the Issue Was Reproduced
1. Created `TestUser` and logged in once.  
2. Renamed the file `C:\Users\TestUser\NTUSER.DAT` to `NTUSER.DAT.broken`.  
3. Logged in again → error appeared:  
   **“We can’t sign in to your account”**  
4. Windows loaded a **temporary profile** instead.

---

## 🧾 Evidence (Before Fix)

| Type | Description | File |
|------|--------------|------|
| Screenshot | Error screen | `01_error_login.png` |
| Registry | `.bak` key under `ProfileList`; `State = 33284` | `02_regedit_before.png` |
| Event Log | IDs **1511** and **1515** confirm temporary profile creation | `ups_events.txt` |
| Command Output | Local users and profile folders | `net_user.txt`, `users_folder.txt` |

> **Event ID 1511:** Windows cannot find the local profile and logs on with a temporary profile.  
> **Event ID 1515:** Windows backed up this user profile.

---

## 🧰 Fix Procedure

### **1. Backup Registry**
Exported key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList
Saved as `ProfileList_Backup.reg`.

### **2. Registry Repair**
- Located the key referencing `C:\Users\TestUser`.  
- If `.bak` existed → removed the suffix.  
- Ensured values:
ProfileImagePath = C:\Users\TestUser
RefCount = 0
State = 0

### **3. Folder Ownership Fix**
```powershell
takeown /F "C:\Users\TestUser" /R /D Y
icacls "C:\Users\TestUser" /inheritance:e
icacls "C:\Users\TestUser" /grant TestUser:(OI)(CI)F /T

### **4. Restart and Verify**

Logged in successfully with TestUser.
No “temporary profile” message appeared.

## 🧾 Evidence (After Fix)

| Type | Description | File |
|------|--------------|------|
| Screenshot | Successful login | `03_desktop_after.png` |
| Registry | `.bak` removed ; `State = 0` ; `RefCount = 0` | `04_regedit_after.png` |
| Event Log | No new errors | `ups_events_after.txt` |


