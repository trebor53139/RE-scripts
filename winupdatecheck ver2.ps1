# Function to output a list of all installed Windows updates to a text file and open the file
function Export-WindowsUpdates {
    $updates = Get-HotFix
    $outputPath = "C:\temp\winupdates list.txt"

    $updates | Select-Object HotFixID, Description | Format-Table -AutoSize | Out-String > $outputPath
    Start-Process notepad.exe $outputPath
    explorer.exe /select,$outputPath
}

# Function to check if a specific KB number is installed and perform a Bing search
function Check-KBUpdate {
    param (
        [string]$KBNumber
    )

    $isInstalled = $false
    $updates = Get-HotFix
    foreach ($update in $updates) {
        if ($update.HotFixID -eq $KBNumber) {
            $isInstalled = $true
            break
        }
    }

    if ($isInstalled) {
        Write-Host "The update $KBNumber is installed on this machine."
    } else {
        Write-Host "The update $KBNumber is not installed on this machine."
    }

    $searchUrl = "https://www.bing.com/search?q=$KBNumber+Microsoft+Knowledge+Base"
    Start-Process $searchUrl
}

# Function to prompt the user for their choice of action
function Get-UserChoice {
    do {
        Write-Host "Please enter your desired option:"
        Write-Host "1. Export list of installed Windows updates to file"
        Write-Host "2. Check if a specific KB number is installed and search online for it"
        
        $choice = Read-Host "Enter your choice (1 or 2)"
        
        if ($choice -ne '1' -and $choice -ne '2') {
            Write-Host "Invalid choice. Please enter either 1 or 2."
        }
    } while ($choice -ne '1' -and $choice -ne '2')
    
    return $choice
}

# Main script logic
do {
    $choice = Get-UserChoice
    
    if ($choice -eq '1') {
        Export-WindowsUpdates
    } elseif ($choice -eq '2') {
        $KBNumber = Read-Host "Enter the Knowledge Base (KB) number you want to check (e.g., KB1234567)"
        Check-KBUpdate -KBNumber $KBNumber
    }

    do {
        $runAgain = Read-Host "Would you like to run the program again? (1 for Yes, 2 for No)"
        
        if ($runAgain -ne '1' -and $runAgain -ne '2') {
            Write-Host "Invalid choice. Please enter either 1 for Yes or 2 for No."
        }
    } while ($runAgain -ne '1' -and $runAgain -ne '2')

    if ($runAgain -eq '1') {
        Clear-Host
    } elseif ($runAgain -eq '2') {
        Write-Host "Program complete."
    }
} while ($runAgain -eq '1')
