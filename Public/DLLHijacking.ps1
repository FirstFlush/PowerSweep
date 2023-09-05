
function activeDLLs {
    Get-Process | ForEach-Object {
        $process = $_
        $modules = $process.Modules
        foreach ($module in $modules) {
            if ($module.FileName -like "*.dll*") {
                Write-Host "Process $($process.ProcessName) (ID: $($process.Id)) is using $($module.FileName)"
            }
        }
        Write-Host ""
    }
}


function Get-DLLHijacking {
    $targetProcessName = "Code"  # Replace with the name of your target process
    # $dllName = "malicious.dll"  # Replace with the name of your malicious DLL
    
    # Get the target process
    $targetProcess = Get-Process -Name $targetProcessName
    write-host $targetProcess
    # Monitor DLL loading for the target process
    Register-WmiEvent -Class Win32_ProcessStartTrace -SourceIdentifier "DLLMonitor" -Action {
        $processName = $event.SourceEventArgs.NewEvent.TargetInstance.Name
        $commandLine = $event.SourceEventArgs.NewEvent.TargetInstance.CommandLine
    
        # Check if the process is loading the malicious DLL
        if ($processName -eq $targetProcessName -and $commandLine -like "*dll") {
            Write-Host "Potential DLL hijacking detected in process: $processName"
            Write-Host "Command line: $commandLine"
        }
    }
    
    # Wait for events
    Write-Host "Monitoring for DLL hijacking..."
    try {
        Wait-Event -SourceIdentifier "DLLMonitor"
    } finally {
        Unregister-Event -SourceIdentifier "DLLMonitor"
    }
}

Get-DLLHijacking