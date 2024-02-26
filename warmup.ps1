# Start time
$startTime = Get-Date

# Duration to run the warm-up (5 minutes)
$duration = New-TimeSpan -Minutes 5

# Function to calculate Fibonacci
function Get-Fibonacci {
    param([int]$n)
    if ($n -le 0) {
        return 0
    } elseif ($n -eq 1) {
        return 1
    } else {
        return (Get-Fibonacci -n ($n - 1)) + (Get-Fibonacci -n ($n - 2))
    }
}

# Initial Fibonacci number to calculate
$fibNumber = 15
$fibCount = 0

# Main loop
while ((Get-Date) -lt $startTime.Add($duration)) {
    # Calculate Fibonacci
    $result = Get-Fibonacci -n $fibNumber
    $fibCount++

    # Calculate time left
    $currentTime = Get-Date
    $timeLeft = $startTime.Add($duration).Subtract($currentTime)
    $minutesLeft = $timeLeft.Minutes
    $secondsLeft = $timeLeft.Seconds

    # Update the line with the current status
    Write-Host "`rFibonacci count: $fibCount, Time left: $minutesLeft min $secondsLeft sec" -NoNewline
}

# New line after loop completion
Write-Host ""
Write-Host "Warm-up complete."
