function Get-AutoRuns {
    <#
    .SYNOPSIS
    Get information about auto-running programs from various registry keys.

    .DESCRIPTION
    The Get-AutoRuns cmdlet queries multiple registry keys to find auto-running programs. 
    It checks the following keys:
    
    - HKEY_CURRENT_USER (HKCU):
    - Software\Microsoft\Windows\CurrentVersion\Run
    - Software\Microsoft\Windows\CurrentVersion\RunOnce
    - Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run
    - Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32

    - HKEY_LOCAL_MACHINE (HKLM):
    - Software\Microsoft\Windows\CurrentVersion\Run
    - Software\Microsoft\Windows\CurrentVersion\RunOnce
    - Software\Microsoft\Windows\CurrentVersion\RunOnceEx
    - Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
    - Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run (for 32-bit applications on 64-bit systems)

    The results are then output to the user.

    .EXAMPLE
    Get-AutoRuns
    #>
    $regKeys = @(
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32",
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx",
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run",
        "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
    )
    # $excludePropertiesArr = @('PSPath', 'PSParentPath', 'PSChildName', 'PSDrive', 'PSProvider')
    # $excludeProperties = [System.Collections.Generic.HashSet[string]]@($excludePropertiesArr)
    Write-Host ""
    foreach ($key in $regKeys) {
        Write-Host "$key" -ForegroundColor DarkGreen
        Get-ItemProperty -Path $key -ErrorAction SilentlyContinue
    }
}

