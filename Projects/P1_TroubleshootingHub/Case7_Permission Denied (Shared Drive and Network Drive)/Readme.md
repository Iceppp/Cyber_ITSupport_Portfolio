# 🛠 Case 7 — Permission Denied (Shared Folder / Network Drive)
**Category:** P1 – Troubleshooting Hub  
**Issue Type:** Access Denied / SMB Share Permission Misconfiguration

---

## 🎯 Scenario

User reports:

> “I can’t access the shared folder. It says *Access Denied*.”

This lab simulates a real-world SMB share permission issue by breaking the Share Permissions, then diagnosing and fixing the problem.

---

## 🧪 Step 1 — Baseline (Normal Access)

A shared folder was created at:

```
C:\DeptShare
Share Name: DeptShare
Path: \\localhost\DeptShare
```

### ✔ Baseline tests:
- Access to the share: **OK**
- Share Permissions: **Everyone – Full Control**
- SMB Share visible under `net share`

### ✔ Commands:
```
dir \\localhost\DeptShare
net share
whoami
```

PowerShell:
```
Get-SmbShare
```

### 📁 Evidence:
- `baseline_share_access.txt`
- `baseline_netshare.txt`
- `baseline_whoami.txt`
- `baseline_smbshare.txt`
- `baseline_share_ok.png`
- `baseline_permissions_ok.png`

---

## 🧨 Step 2 — Simulation (Create Access Denied Issue)

To reproduce the issue, Share Permissions were intentionally modified.

### ❗ Action:
Removed **Everyone** from Share Permissions in:

```
DeptShare → Properties → Sharing → Advanced Sharing → Permissions
```

### ❗ Result:
Access to:

```
\\localhost\DeptShare
```

generated an **Access Denied** error.

### 📁 Evidence (Broken State):
- `share_access_denied.png`
- `share_permission_broken.png`
- `case7_share_fail.txt`
- `case7_netshare_fail.txt`
- `case7_smbshare_fail.txt`
- `case7_whoami.txt`

---

## 🔍 Step 3 — Diagnosis

### ✔ Findings:
1. User attempted to access `\\localhost\DeptShare` → Access Denied.
2. `net share` shows the share still exists (DeptShare).
3. `Get-SmbShare` shows share is active but missing proper permissions.
4. Reviewing Share Permissions showed **Everyone had been removed**.
5. NTFS permissions were still valid, confirming the issue was at **Share Permission level**.

### 🧠 Root Cause:
Misconfigured **Share Permissions** — the share was missing “Everyone” or a valid user group, causing SMB access failure.

---

## 🛠 Step 4 — Fix Procedure

### ✔ Restore proper Share Permissions

1. Open:
```
DeptShare → Properties → Sharing → Advanced Sharing → Permissions
```

2. Add back:
```
Everyone — Allow Full Control
```

### ✔ Verify NTFS Permissions (Security tab)
Ensure:

- Users or Everyone has Modify/Read/Execute  
- Inheritance is enabled  

### ✔ Re-test SMB Access
```
\\localhost\DeptShare
```

### 📁 Evidence (After Fix):
- `share_access_ok_after_fix.png`
- `share_permission_fixed.png`
- `case7_share_after_fix.txt`
- `case7_netshare_after_fix.txt`
- `case7_smbshare_after_fix.txt`
- `case7_whoami_after_fix.txt`

---

## ✅ Step 5 — Verification

After restoring permissions:

✔ Access restored  
✔ No Access Denied errors  
✔ Share visible  
✔ Permission structure correct  

System is functioning as expected.

---

## 🧩 Skills Demonstrated

- SMB Share troubleshooting  
- Understanding of Share Permission vs NTFS Permission  
- Using:
  - `net share`
  - `dir \\server\share`
  - `whoami`
  - PowerShell `Get-SmbShare`
- Diagnosing Access Denied issues  
- Fixing permission misconfigurations  
- Documentation of baseline → broken → fix

---

## 📌 Status: **Resolved**
Shared folder permissions restored and access verified successfully.
