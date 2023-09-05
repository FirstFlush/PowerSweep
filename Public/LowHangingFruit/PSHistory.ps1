function Get-PSHistory {
    <#
    .SYNOPSIS
    This cmdlet prints the contents of the PowerShell console history file.

    .DESCRIPTION
    The Get-PSHistory cmdlet prints the contents of the console history file used by PowerShell.

    .EXAMPLE
    Get-PSHistory
    Prints the contents of the console history file.

    #>
    $historyPath = "$($env:USERPROFILE)\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    $history = Get-Content $historyPath -Raw

    if ($history -ne $null) {
        Write-Host $history
        Write-Host "PS History found in:" -ForegroundColor DarkGreen
        Write-Host $historyPath -ForegroundColor DarkGreen
        Write-Host ""
    } else{
        $otherHistoryPaths = @( 
            "$($env:APPDATA)\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt",
            "$($env:USERPROFILE)\My Documents\WindowsPowerShell\PSReadline\ConsoleHost_history.txt",
            "$($env:USERPROFILE)\Documents\WindowsPowerShell\PSReadline\ConsoleHost_history.txt",
            "$($env:USERPROFILE)\Documents\WindowsPowerShell\PSReadline\_history.txt"
        )
        foreach ($otherHistoryPath in $otherHistoryPaths) {
            $history = Get-Content $otherHistoryPath -ErrorAction SilentlyContinue -Raw
            if ($history -ne $null) {
                Write-Host $history
                Write-Host "PS History found in:" -ForegroundColor DarkGreen
                Write-Host $otherHistoryPath -ForegroundColor DarkGreen
                Write-Host ""
            }
        }
    }
}


# reg query HKCU\Software\Policies\Microsoft\Windows\PowerShell\Transcription
# reg query HKCU\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription
# reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\Transcription
# reg query HKLM\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription
# reg query HKCU\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
# reg query HKLM\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
# reg query HKCU\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
# reg query HKLM\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
# Get-ItemProperty -Path HKCU\Software\Policies\Microsoft\Windows\PowerShell\Transcription
# Get-WinEvent -LogName "windows Powershell" | select -First 15
# reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit
# reg query HKLM\Software\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager

