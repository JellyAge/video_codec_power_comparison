# Assuming the video directory is the current script directory
$videoDirectory = Get-Location
$energyBridgePath = "C:\Users\j-hsc\Downloads\energibridge-v0.0.4-x86_64-pc-windows-msvc\energibridge.exe"
$vlcPath = "C:\Program Files\VideoLAN\VLC\vlc.exe"

# Define video files
$videos = @("av1.mp4", "h264.mp4", "h265.mp4")

# Generate test order - 30 measurements for each codec, shuffled
$testOrder = @()
for ($i = 0; $i -lt 30; $i++) {
    $testOrder += $videos
}
$shuffledTestOrder = Get-Random -InputObject $testOrder -Count $testOrder.Count

# Loop through the shuffled test order
foreach ($video in $shuffledTestOrder) {
    # Construct the output file name
    $outputFile = Join-Path $videoDirectory ("$(Get-Date -Format "yyyyMMddHHmmss")_$video.csv")
    

	
    # Command to play video (1 minute) and then exit
    $commandToMonitor = "`"$vlcPath`" --play-and-exit --fullscreen --no-audio --stop-time 60 `"$video`" vlc://quit"

    # Construct the EnergyBridge command
    $energyBridgeCommand = "$energyBridgePath -o `"$outputFile`" $commandToMonitor"

    # Debug: Print the command to be executed
    Write-Host "Executing command: $energyBridgeCommand"

    try {
        # Execute the EnergyBridge command
        Invoke-Expression $energyBridgeCommand
    } catch {
        Write-Host "An error occurred: $_"
    }
    
    # Wait for 1 minutes between measurements to allow system stabilization
    Start-Sleep -Seconds 60

}

Write-Host "All measurements completed."
