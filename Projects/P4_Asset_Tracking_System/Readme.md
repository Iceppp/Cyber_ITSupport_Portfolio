# P4 – IT Asset Tracking System (Excel + PowerShell Automation)

## 📝 Overview
This project demonstrates an end-to-end IT Asset Management workflow used by real IT Support and MSP teams.  
It includes a fully designed Excel inventory template, dropdown validation, and an automated PowerShell script that exports actual device information into CSV format.

This simulates how IT Support manages laptops, desktops, and peripherals inside a corporate environment.

---

## 📁 Project Structure
```
P4_Asset_Tracking_System/
│
├─ README.md
│
├─ assets/
│ ├─ Asset_Inventory_Blank_Template.xlsx
│ ├─ Role_Matrix.xlsx
│ ├─ User_List.csv
│
├─ scripts/
│ ├─ Get-DeviceInventory.ps1
│ └─ device-inventory.csv
│
└─ screenshots/
├─ 01_Asset_Template_Blank.png
├─ 02_Filled_Inventory.png
├─ 03_DeviceType_Dropdown.png
├─ 04_Location_Dropdown.png
├─ 05_Status_Dropdown.png
└─ 06_PowerShell_Export.png
```

---

## 🧩 Features

### ✔ Excel Asset Inventory Template
The inventory tracks:
- Asset ID  
- Device Name  
- Device Type  
- Manufacturer  
- Model  
- Serial Number  
- User  
- Department  
- Location  
- Status  
- Purchase Date  
- Warranty Expiry  
- Age (auto-calculated)  
- Cost  
- Notes  

Includes:
- **Dropdown lists** (Device Type, Location, Status)
- **Auto age formula**
- **Table formatting**
- **Filters enabled**

---

## ⚙ PowerShell Automation

### Script: `Get-DeviceInventory.ps1`
Exports real device information from Windows:

Information collected:
- Device Name  
- Manufacturer  
- Model  
- Serial Number  
- Username  
- OS Version  
- Notes  

Output file:
scripts/device-inventory.csv

yaml
Copy code

This simulates how IT Support engineers automate asset discovery.

---

## 📸 Evidence (Screenshots)

Included in `/screenshots`:
- Excel blank template  
- Inventory filled with sample data  
- Dropdown lists  
- PowerShell script execution  
- Exported CSV result  

---

## 🎯 Key Outcomes
- Designed full IT Asset Management template  
- Implemented dropdown validation for consistency  
- Automated device info export using PowerShell  
- Demonstrated real-world IT Support skills  
- Created documentation following corporate standards

---

## 🧠 Skills Demonstrated
- Excel asset management  
- Data validation  
- Inventory control  
- PowerShell scripting  
- IT asset lifecycle management  
- Documentation & technical writing  

---

## 🏁 Result
This project replicates what Level 1–2 IT Support engineers and MSP technicians do daily.  
It proves hands-on skills in managing hardware assets, automation, and documenting processes clearly.
