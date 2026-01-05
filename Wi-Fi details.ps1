# 1. Define paths and check for/create the C:\temp folder
$tempPath = "C:\temp"
$csvFileName = "Wi-Fi network details.csv"
$fullPath = Join-Path $tempPath $csvFileName

if (-not (Test-Path $tempPath)) {
    New-Item -Path $tempPath -ItemType Directory | Out-Null
}

# 2. Obtain Wi-Fi names and clear-text passwords
$profiles = netsh wlan show profiles | Select-String "\:(.+)$" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }

$wifiDetails = foreach ($profile in $profiles) {
    # Get the details for each profile including clear text keys
    $profileInfo = netsh wlan show profile name="$profile" key=clear
    
    # Extract the password (Key Content) field
    $passwordLine = $profileInfo | Select-String "Key Content\W+\:(.+)$"
    $password = if ($passwordLine) { $passwordLine.Matches.Groups[1].Value.Trim() } else { "None/Open" }

    # Create a custom object for the CSV columns
    [PSCustomObject]@{
        "network name" = $profile
        "password"     = $password
    }
}

# 3. Export to CSV (overwrites existing file by default)
$wifiDetails | Export-Csv -Path $fullPath -NoTypeInformation -Force

# 4. Open the folder and display completion message
Invoke-Item $tempPath
Write-Host "Program complete. Wi-Fi details exported to $fullPath" -ForegroundColor Green
