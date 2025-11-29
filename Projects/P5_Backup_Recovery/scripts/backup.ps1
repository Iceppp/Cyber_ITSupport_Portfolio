# backup.ps1
# Automated backup script (C: drive version)

$source = "C:\CompanyData"
$destination = "C:\DailyBackup"

# create timestamp folder
$date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$target = "$destination\$date"

# Create target folder
if (!(Test-Path -Path $target)) {
    New-Item -ItemType Directory -Path $target | Out-Null
}

# Copy files recursively
Copy-Item -Path $source -Destination $target -Recurse -Force

# Write log
$logMessage = "Backup completed at $date → $target"
$logFile = "$destination\backup_log.txt"
$logMessage | Out-File $logFile -Append -Encoding utf8