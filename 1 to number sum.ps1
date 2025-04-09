do {
    do {
        Write-Host "Please enter a positive number"
        [int]$number = Read-Host
    } while ($number -le 0)

    # Calculation
    [int]$sum = ($number * ($number + 1)) / 2
    Write-Host "The sum of 1 to $number is $sum"

    # Ask if the user wants to run the script again
    do {
        Write-Host "Do you want to run the script again? (1 for yes, 2 for no)"
        [int]$choice = Read-Host
    } while ($choice -ne 1 -and $choice -ne 2)

} while ($choice -eq 1)

Write-Host "Script ended. Have a great day!"

