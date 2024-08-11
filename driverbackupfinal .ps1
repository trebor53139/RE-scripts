# creation date: 8-10-2024
#created by: Robert Ehrhart using microsoft copilot

#script overview

# This PowerShell script creates a folder named “drivers” at the root of the C drive, exports the installed drivers to this folder,
# and then compresses the folder into a ZIP file. It opens the C drive in File Explorer and prompts the user to confirm whether to delete the “drivers” folder.
# If confirmed, the original “drivers” folder is deleted, but the compressed ZIP file with the backup of the drivers is kept. 
# Finally, it displays a completion message and waits for the user to press Enter before closing.



# Create a folder called "drivers" at the root of the C drive
$driversFolder = "C:\drivers"
New-Item -ItemType Directory -Path $driversFolder -Force

# Export installed drivers to the drivers folder
Export-WindowsDriver -Online -Destination $driversFolder

# Compress the drivers folder into a ZIP file
$zipPath = "C:\zip_drivers.zip"
Compress-Archive -Path $driversFolder -DestinationPath $zipPath

# Open the root of the C drive in File Explorer
Invoke-Item "C:\"

# Prompt user to confirm before deleting the drivers folder
$confirmation = Read-Host "Do you want to delete the drivers folder? (Y/N)"
if ($confirmation -eq "Y") {
    Remove-Item -Path $driversFolder -Recurse -Force
    Write-Host "Drivers folder deleted."
}

# Display completion message
Write-Host "Driver backup and compression completed successfully."

# Wait for user to press Enter before closing the script
Read-Host "Press Enter to exit..."
