<#
.SYNOPSIS
PowerSweep is a module for enumerating potential privilege escalation vectors on a Windows machine.

.DESCRIPTION
PowerSweep provides a set of functions designed to assist penetration testers and administrators
in identifying security vulnerabilities and potential misconfigurations that could lead to privilege escalation.

.NOTES
File Name       : PowerSweep.psm1
Author          : Michael Pearce
Prerequisite    : Windows PowerShell
        
#>

. "$PSScriptRoot\UnquotedPath.ps1"
. "$PSScriptRoot\AlwaysInstallElevated.ps1"
. "$PSScriptRoot\ACLs.ps1"
. "$PSScriptRoot\AVDetails.ps1"
. "$PSScriptRoot\AccessChk.ps1"
. "$PSScriptRoot\AutoRuns.ps1"
. "$PSScriptRoot\LowHangingFruit\Unattended.ps1"
. "$PSScriptRoot\LowHangingFruit\EnvVars.ps1"
. "$PSScriptRoot\LowHangingFruit\PSHistory.ps1"
. "$PSScriptRoot\LowHangingFruit\WebConfig.ps1"


$global:accessChk = $null
$global:services = (Get-WmiObject win32_service)
$global:servicePaths = @()
$global:rights = @(
    "FullControl",
    "Modify",
    "Write",
    "ChangePermissions",
    "TakeOwnership",
    "Delete"
)
$global:insecurePrivsSet = [System.Collections.Generic.HashSet[string]]@($global:rights)

($services).PathName | ForEach-Object {
    $path = $_
    if ($path -ne $null) {
        if ($path[0] -eq '"') {
            $path = $path.Substring(1)
        }
        if ($path[-1] -eq '"') {
            $path = $path.Substring(0, $path.Length - 1)
        }
        $index = $path.LastIndexOf(".exe")
        if ($index -gt 0) {
            $path = $path.Substring(0, $index + 4) # +4 to include the entire '.exe'    
        }
        $servicePaths += "$path"
    }
}
if ($servicePaths.Count -gt 0) {
    $servicePaths = $servicePaths | Select-object -Unique
}

# Export the functions so they are available as cmdlets when the module is imported
Export-ModuleMember -Function Get-UnquotedServicePaths, Get-AlwaysInstallElevated, 
Get-ACLs, Get-AVDetails, Install-AccessChk, Get-AutoRuns, Get-Unattended, Get-EnvVars,
Get-PSHistory, Get-WebConfig