# P3 – Microsoft 365 Administration Simulation  
### *Hybrid: IT Support & Microsoft 365 Administrator*

This project simulates a real corporate Microsoft 365 environment for **Northbridge Consulting Pty Ltd** (Sydney, Australia).  
I acted as both an **IT Support Engineer** and **Microsoft 365 Administrator**, performing end-to-end user lifecycle and identity management tasks used in real companies and MSPs.

---

## 🧩 Scenario Overview
**Company:** Northbridge Consulting Pty Ltd  
**Environment:** Microsoft 365 Business Standard Tenant  
**Role:** Hybrid – IT Support & Microsoft 365 Administrator

Simulated corporate employees:

| Name | Role | Email |
|------|------|--------|
| **Alice Johnson** | Staff | alice@northbridgeconsult.onmicrosoft.com |
| **Bob Smith** | Helpdesk Technician | bob@northbridgeconsult.onmicrosoft.com |
| **Chloe Brown** | Manager | chloe@northbridgeconsult.onmicrosoft.com |

---

## 🔧 Tasks Performed

### 1️⃣ Tenant Setup
- Created Microsoft 365 tenant using trial subscription  
- Verified access to Microsoft 365 Admin Center & Entra ID  
📸 `01_Tenant_Creation.png`

---

### 2️⃣ User Onboarding
Created three users with appropriate usernames, roles, and license assignments.

📸 `02_UserCreation_Alice.png`  
📸 `03_UserCreation_Bob.png`  
📸 `04_UserCreation_Chloe.png`

---

### 3️⃣ Password Reset (Helpdesk Task)
Performed secure password reset workflows for staff.

📸 `11_ResetPassword_Alice.png`  
📸 `12_ResetPassword_Chloe.png`

---

### 4️⃣ License Administration
Assigned and verified Microsoft 365 Business Standard licenses.

📸 `12_AssignLicense_Alice.png`  
📸 `12_AssignLicense_Bob.png`  
📸 `12_AssignLicense_Chloe.png`

---

### 5️⃣ MFA Enforcement
Enabled MFA for Alice via Entra ID per-user MFA.

📸 `08_MFA_Enabled_Alice.png`

---

### 6️⃣ Group & Teams Management
Created Microsoft 365 groups and configured membership:

- Sales Team  
- Marketing Team  
- HR Team  

📸 `05_Group_Sales.png`  
📸 `06_Group_Marketing.png`  
📸 `07_Group_HR.png`

---

### 7️⃣ RBAC Role Assignment
Assigned administrative roles following least-privilege principles:

- **Bob Smith → Helpdesk Administrator**  
- **Chloe Brown → Reports Reader**

📸 `10_RoleAssignment_Alice_HelpdeskAdmin.png`

---

### 8️⃣ User Offboarding (Employee Exit)
Simulated real offboarding workflow:

- Block sign-in  
- Remove license  
- Remove group membership  

📸 `13_BlockSignIn_User.png`  
📸 `14_RemoveLicense_Bob.png`  
📸 `09_User_Offboarding_Bob.png`

---

## 📂 Folder Structure
P3_M365_Admin_Simulation/
│
├── README.md
│
├── docs/
│ ├── P3_M365_Admin_Workflow_v1.pdf
│ ├── P3_OnePage_Summary.pdf
│
├── screenshots/
│ ├── 01_Tenant_Creation.png
│ ├── 02_UserCreation_Alice.png
│ ├── 03_UserCreation_Bob.png
│ ├── 04_UserCreation_Chloe.png
│ ├── 05_Group_Sales.png
│ ├── 06_Group_Marketing.png
│ ├── 07_Group_HR.png
│ ├── 08_MFA_Enabled_Alice.png
│ ├── 09_User_Offboarding_Bob.png
│ ├── 10_RoleAssignment_Alice_HelpdeskAdmin.png
│ ├── 11_ResetPassword_Alice.png
│ ├── 12_ResetPassword_Chloe.png
│ ├── 12_AssignLicense_Alice.png
│ ├── 12_AssignLicense_Bob.png
│ ├── 12_AssignLicense_Chloe.png
│ ├── 13_BlockSignIn_User.png
│ ├── 14_RemoveLicense_Bob.png
│
└── assets/
├── User_List.csv
├── Role_Matrix.xlsx

---

## 🎯 Key Outcomes
This project demonstrates my ability to perform core Microsoft 365 administration and IT Support tasks including:

- User lifecycle management (onboarding → offboarding)  
- MFA enforcement & authentication security  
- Group and Teams membership administration  
- Password reset & Helpdesk workflows  
- License provisioning and governance  
- RBAC role assignment (Helpdesk Admin / Reports Reader)  
- Identity and access management using Entra ID  

---

## 🧠 Technical Skills Demonstrated
- Microsoft 365 Admin Center  
- Microsoft Entra ID (Azure AD)  
- Multi-Factor Authentication (MFA)  
- Password Reset & Account Recovery  
- Role-Based Access Control (RBAC)  
- License & subscription management  
- Group-based permissioning (M365 Groups & Security Groups)  
- User onboarding/offboarding  
- Cloud identity management & governance  

---

## 📄 Documentation
Full workflow and project documentation:

- **P3_M365_Admin_Workflow_v1.pdf**  
- **P3_OnePage_Summary.pdf**

Located in the `/docs` folder.

---

## ✅ Conclusion
This project accurately simulates real-world responsibilities in modern IT Support, Helpdesk, and MSP environments, demonstrating practical capability with Microsoft 365 identity and access management.
