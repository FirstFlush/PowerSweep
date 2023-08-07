

function Get-DLLHijacking {
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

Get-DLLHijacking