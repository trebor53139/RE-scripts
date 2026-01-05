1 - program.7z

1- disk cleanup in admin mode without user  intervention
2 - clear printer queue 
3- doing their work reset and restart the computer
4. Disable IP version 6 on all network adapters and release and renew the IP address.
5. Run the dism commands check health,  scan health, and restore health
6. Run system file Checker to check for file corruption in Windows OS
7. Run chkdsk cmd to check for bad drive sectors on hard drive.
8. Repair or salvage Wmi in windows when broken.

The script is powershell script that runs in the commandline style window. To run it double click run as admin shorcut in the file folder. This will open an admin command prompt window which in turn runs a power shell script inside of it.

While I have done testing of the script in a Windows 11 virtual machine. Any use of the script is done so at your own risk. I accept no responsibility for any consequences arising from your use of the script period. If you have concerns about using it look for a paid tool from a reputable vendor you trust.


2 - driverbackupfinal

This PowerShell script creates a folder named “drivers” at the root of the C drive, exports the installed drivers to this folder, and then compresses the folder into a ZIP file. It opens the C drive in File Explorer and prompts the user to confirm whether to delete the “drivers” folder. If confirmed, the original “drivers” folder is deleted, but the compressed ZIP file with the backup of the drivers is kept.  Finally, it displays a completion message and waits for the user to press Enter before closing.The script was created using Microsoft copilot and tested using a Windows 11 virtual machine and a windows 10 desktop. The script was run using admin powershell ise with an unrestricted execution policy.

Disclaimer: Any use of this script is done so at user's own risk I assume no responsibility for consequences arising from its use.

3 - winupdatecheck ver3

This PowerShell script provides two main functionalities related to Windows updates:

(1) Exporting a list of installed updates to a text file named winupdates list.txt located at C:\temp, and displaying the file's content and location in File Explorer

(2) Checking if a specific Knowledge Base (KB) number is installed on the machine and performing a Bing search for the entered KB number. The script continuously prompts the user to choose between these options, ensuring valid input through a loop, and offers the option to run the program again after completion.

Disclaimer: Any use of this script is done so at user's own risk I assume no responsibility for consequences arising from its use. I test it on a window 10 physcial machine.

4 - bookmark backup

The provided PowerShell script automates the backup of bookmarks from Chrome and Edge browsers. It creates a directory at C:\temp\bookmarks if it doesn't already exist, then it copies the bookmarks from each browser into this directory, naming the backup files according to the browser and the current date. Finally, it opens the backup directory and pauses, waiting for user input before closing.

created using microsoft copilot use at own risk but has been tested.


5 - winget program
### Winget Automation Script

This PowerShell script automates package management using **Winget**. It checks for Winget's availability and prompts manual installation if missing. The script provides an interactive menu for installing, uninstalling, backing up, restoring, and upgrading applications.

Key features:
- **Ensure-WingetInstalled**: Verifies Winget installation and opens the Microsoft Store if missing.
- **InstallProgram / Uninstall-Program**: Allows users to install or remove applications via Winget.
- **JSON Backup & Restore**: Exports installed programs to a JSON file and restores them when needed.
- **Upgrade Programs**: Supports upgrading individual packages or all installed programs.
- **Error Handling & Validation**: Includes checks for package availability and ensures valid user input.

The script runs in a loop, allowing multiple operations in a single session.

wifi details
A PowerShell script that extracts all saved Wi-Fi SSIDs and their clear-text passwords into a CSV file.
Key Features

    Automated Export: Extracts names and passwords to C:\temp\Wi-Fi network details.csv.
    Self-Managing: Automatically creates the destination folder and overwrites old reports.
    Instant Access: Opens the export folder automatically upon completion.


