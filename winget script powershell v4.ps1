function displaymenu {
    Write-Host "Select a task to perform (1-6):"
    Write-Host "1. Install a program using winget"
    Write-Host "2. Uninstall a program using winget"
    Write-Host "3. Export a list of installed programs"
    Write-Host "4. Create a JSON backup file of installed programs"
    Write-Host "5. Reinstall programs from JSON file"
    Write-Host "6. Upgrade programs to the latest version"
}

do {
    cls
    displaymenu

    do {
        $choice = Read-Host "Which option do you want to run? Choose 1-6" # user choice input
    } while ($choice -lt 1 -or $choice -gt 6) # error check

    switch ($choice) {
        1 {
            # Start winget install code
            # Prompt the user for the program name
            $programName = Read-Host "Enter the name of the program you want to install"

            # Search for the program using winget
            $searchResults = winget search $programName

            if ($searchResults) {
                Write-Host "Search results:"
                $searchResults

                # Prompt the user for the program ID
                $programId = Read-Host "Enter the ID of the program you want to install"

                # Check if the program is already installed
                $installedPrograms = winget list

                if ($installedPrograms | Select-String -Pattern $programId) {
                    Write-Host "The program '$programName' is already installed."
                } else {
                    # Install the program using the provided ID
                    winget install --id $programId --disable-interactivity
                }
            } else {
                Write-Host "No results found for '$programName'. Please try again."
            }
        }

        2 {
            # Start winget uninstall code
            # Prompt the user for the program name
            $programName = Read-Host "Enter the name of the program you want to uninstall"
            # Uninstall the program using the provided program name
            winget uninstall $programName --silent
        }

        3 {
            # Start Export a list of installed programs
            Get-WmiObject -Query "SELECT * FROM Win32_Product" | Select-Object -Property Name | Out-File -FilePath "C:\temp\installed_programs.txt" -Force
            Write-Host "Program list exported"
        }

        4 {
            # Start Create a JSON backup file of installed programs
            $tempFolder = "C:\temp"
            if (-not (Test-Path $tempFolder)) {
                New-Item -ItemType Directory -Path $tempFolder
            }

            $jsonFile = Join-Path -Path $tempFolder -ChildPath "wingetbackup.json"

            # Remove the JSON file if it already exists
            if (Test-Path $jsonFile) {
                Remove-Item -Path $jsonFile -Force
            }

            winget export -o $jsonFile
            Write-Host "JSON backup file created at $jsonFile"
            Invoke-Item $tempFolder
        }

        5 {
            # Start Reinstall programs from JSON file
            $jsonFile = "C:\temp\wingetbackup.json"
            if (-not (Test-Path $jsonFile)) {
                Write-Host "Backup file not found. Please ensure it's named 'wingetbackup.json' and placed in C:\temp."
                pause
            } else {
                winget import -i $jsonFile
            }
        }

        6 {
            # Start upgrade code
            # Run winget upgrade to show a list of all programs available for upgrade
            $upgradeList = winget upgrade

            if ($upgradeList) {
                Write-Host "Available upgrades:"
                $upgradeList

                # Ask the user if they would like to upgrade all programs or a single program
                $upgradeChoice = Read-Host "Would you like to upgrade (1) all programs or (2) a single program?"

                if ($upgradeChoice -eq "1") {
                    # Upgrade all programs
                    winget upgrade --all
                    Write-Host "All programs have been upgraded."
                } elseif ($upgradeChoice -eq "2") {
                    $anotherUpgrade = $true

                    while ($anotherUpgrade) {
                        # Prompt the user to specify the name of the program to upgrade
                        $programName = Read-Host "Enter the name of the program you want to upgrade"
                        winget upgrade --name $programName

                        # Ask if they would like to upgrade another program
                        $anotherChoice = Read-Host "Would you like to upgrade another program? (yes/no)"
                        if ($anotherChoice -ne "yes") {
                            $anotherUpgrade = $false
                        }
                    }
                } else {
                    Write-Host "Invalid choice. Please run the script again and choose a valid option."
                }
            } else {
                Write-Host "No upgradeable programs found."
            }
        }
    }

    do {
        $runAgain = Read-Host "Would you like to run the program again? (1 for yes, 2 for no)"
    } while ($runAgain -ne 1 -and $runAgain -ne 2) # error check

} while ($runAgain -eq 1)

Write-Host "Program complete."
