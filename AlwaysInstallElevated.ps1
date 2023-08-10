

function _writeAlwaysInstallElevated {
    param (
        [bool]$is_enabled,
        [string]$hive
    )
    if ($is_enabled) {
        Write-Host "AlwaysInstallElevated $($hive)  " -NoNewline
        Write-Host "enabled" -ForegroundColor Yellow    
    } else {
        Write-Host "AlwaysInstallElevated $($hive)  " -NoNewline
        Write-Host "disabled" -ForegroundColor Red
    }
}

function Get-AlwaysInstallElevated {
    <#
    .SYNOPSIS
    Prints whether the AlwaysInstallElevated policy is enabled or not.

    .DESCRIPTION
    This function checks the registry to determine if the AlwaysInstallElevated policy is enabled
    and prints the result.

    .EXAMPLE
    Get-AlwaysInstallElevated
    #>
    $regPathHKLM = "HKLM:\Software\Policies\Microsoft\Windows\Installer"
    $regPathHKCU = "HKCU:\Software\Policies\Microsoft\Windows\Installer"
    $installElevatedHKLM = (Get-ItemProperty -Path $regPathHKLM `
        -Name AlwaysInstallElevated -ErrorAction SilentlyContinue
    ).AlwaysInstallElevated -eq 1
    $installElevatedHKCU = (Get-ItemProperty -Path $regPathHKCU `
        -Name AlwaysInstallElevated -ErrorAction SilentlyContinue
    ).AlwaysInstallElevated -eq 1
    Write-Host ""
    _writeAlwaysInstallElevated -is_enabled $installElevatedHKLM -hive "HKLM"
    _writeAlwaysInstallElevated -is_enabled $installElevatedHKCU -hive "HKCU"
    Write-Host ""
}
