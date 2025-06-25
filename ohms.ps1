# =========================
# Ohm’s Law Wheel Calculator
# =========================

# --- 12 Formula Functions ---
function Get-VoltageFromIR { param($I, $R)      return $I * $R }
function Get-VoltageFromPI { param($P, $I)      return $P / $I }
function Get-VoltageFromPR { param($P, $R)      return [math]::Sqrt($P * $R) }

function Get-CurrentFromVR { param($V, $R)      return $V / $R }
function Get-CurrentFromPV { param($P, $V)      return $P / $V }
function Get-CurrentFromPR { param($P, $R)      return [math]::Sqrt($P / $R) }

function Get-ResistanceFromVI { param($V, $I)   return $V / $I }
function Get-ResistanceFromV2P { param($V, $P)   return ($V * $V) / $P }
function Get-ResistanceFromIP { param($P, $I)   return $P / ($I * $I) }

function Get-PowerFromVI { param($V, $I)        return $V * $I }
function Get-PowerFromV2R { param($V, $R)      return ($V * $V) / $R }
function Get-PowerFromIR { param($I, $R)       return ($I * $I) * $R }

# --- Helper to read a non-negative number ---
function Read-NonNegative {
    param([string]$Prompt)
    while ($true) {
        $input = Read-Host $Prompt
        # pre-declare the out-variable
        $parsed = 0.0
        if (-not [double]::TryParse($input, [ref]$parsed)) {
            Write-Host "  → Invalid entry. Please type a numeric value." -ForegroundColor Yellow
        }
        elseif ($parsed -lt 0) {
            Write-Host "  → Value cannot be negative." -ForegroundColor Yellow
        }
        else {
            return $parsed
        }
    }
}

# --- Main Loop ---
do {
    Clear-Host

    # Menu
    Write-Host "Select which two properties you KNOW (1–6):`n"
    Write-Host " 1) Voltage (V) & Current (I)"
    Write-Host " 2) Voltage (V) & Resistance (R)"
    Write-Host " 3) Voltage (V) & Power (P)"
    Write-Host " 4) Current (I) & Resistance (R)"
    Write-Host " 5) Current (I) & Power (P)"
    Write-Host " 6) Resistance (R) & Power (P)"

    [int]$choice = 0
    while ($choice -lt 1 -or $choice -gt 6) {
        $raw = Read-Host "Enter choice (1–6)"
        if (-not [int]::TryParse($raw, [ref]$choice) -or $choice -lt 1 -or $choice -gt 6) {
            Write-Host "  → Please enter a number between 1 and 6." -ForegroundColor Yellow
            $choice = 0
        }
    }

    switch ($choice) {
        1 {
            $V = Read-NonNegative "Enter Voltage (V)"
            $I = Read-NonNegative "Enter Current (I)"
            $R = Get-ResistanceFromVI $V $I
            $P = Get-PowerFromVI      $V $I
            Write-Host "`nCalculated:`n  R = $R Ω`n  P = $P W"
        }
        2 {
            $V = Read-NonNegative "Enter Voltage (V)"
            $R = Read-NonNegative "Enter Resistance (R)"
            $I = Get-CurrentFromVR    $V $R
            $P = Get-PowerFromV2R     $V $R
            Write-Host "`nCalculated:`n  I = $I A`n  P = $P W"
        }
        3 {
            $V = Read-NonNegative "Enter Voltage (V)"
            $P = Read-NonNegative "Enter Power (P)"
            $I = Get-CurrentFromPV    $P $V
            $R = Get-ResistanceFromV2P $V $P
            Write-Host "`nCalculated:`n  I = $I A`n  R = $R Ω"
        }
        4 {
            $I = Read-NonNegative "Enter Current (I)"
            $R = Read-NonNegative "Enter Resistance (R)"
            $V = Get-VoltageFromIR    $I $R
            $P = Get-PowerFromIR      $I $R
            Write-Host "`nCalculated:`n  V = $V V`n  P = $P W"
        }
        5 {
            $I = Read-NonNegative "Enter Current (I)"
            $P = Read-NonNegative "Enter Power (P)"
            $V = Get-VoltageFromPI    $P $I
            $R = Get-ResistanceFromIP $P $I
            Write-Host "`nCalculated:`n  V = $V V`n  R = $R Ω"
        }
        6 {
            $R = Read-NonNegative "Enter Resistance (R)"
            $P = Read-NonNegative "Enter Power (P)"
            $V = Get-VoltageFromPR    $P $R
            $I = Get-CurrentFromPR    $P $R
            Write-Host "`nCalculated:`n  V = $V V`n  I = $I A"
        }
    }

    $again = Read-Host "`nRun another calculation? (Y/N)"
} while ($again -match '^[Yy]')

Write-Host "`nGoodbye!`n"
