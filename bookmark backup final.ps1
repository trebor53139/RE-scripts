# Define the backup directory
$backupDir = "C:\temp\bookmarks"

# Create the backup directory if it doesn't exist
if (-not (Test-Path -Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir
}

# Get the current date in yyyy-MM-dd format
$date = Get-Date -Format "yyyy-MM-dd"

# Backup Chrome bookmarks
$chromeBackup = "$backupDir\ChromeBackup_$date.json"
$chromeProfilePath = Join-Path $env:LOCALAPPDATA 'Google\Chrome\User Data\Default\Bookmarks'
if (Test-Path -Path $chromeProfilePath) {
    Copy-Item -Path $chromeProfilePath -Destination $chromeBackup
} else {
    Write-Output "Chrome profile not found."
}

# Backup Edge bookmarks
$edgeBackup = "$backupDir\EdgeBackup_$date.json"
$edgeProfilePath = Join-Path $env:LOCALAPPDATA 'Microsoft\Edge\User Data\Default\Bookmarks'
if (Test-Path -Path $edgeProfilePath) {
    Copy-Item -Path $edgeProfilePath -Destination $edgeBackup
} else {
    Write-Output "Edge profile not found."
}

# Open the backup directory
Start-Process "explorer.exe" $backupDir

# Pause to keep the window open
Read-Host -Prompt "Press Enter to close"
