# Get-DeviceInventory.ps1
# Basic device inventory export for Windows machines

$cs   = Get-CimInstance Win32_ComputerSystem
$bios = Get-CimInstance Win32_BIOS
$os   = Get-CimInstance Win32_OperatingSystem

$device = [PSCustomObject]@{
    "Asset ID"       = ""
    "Device Name"    = $cs.Name
    "Device Type"    = "Laptop"
    "Manufacturer"   = $cs.Manufacturer
    "Model"          = $cs.Model
    "Serial Number"  = $bios.SerialNumber
    "User"           = $env:USERNAME
    "Department"     = ""
    "Location"       = "Sydney Office"
    "Status"         = "In Use"
    "Purchase Date"  = ""
    "Warranty Expiry Date" = ""
    "Age (Years)"    = ""
    "Purchase Cost (AUD)" = ""
    "Notes"          = "Imported from PowerShell script"
}

$exportPath = ".\device-inventory.csv"

if (Test-Path $exportPath) {
    $device | Export-Csv $exportPath -NoTypeInformation -Append
} else {
    $device | Export-Csv $exportPath -NoTypeInformation
}

Write-Host "Device inventory exported to $exportPath" -ForegroundColor Green