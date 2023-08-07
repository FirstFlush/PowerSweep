# Import the Get-UnquotedPath function from the external .ps1 file
. "$PSScriptRoot\UnquotedPath.ps1"
. "$PSScriptRoot\AlwaysInstallElevated.ps1"
. "$PSScriptRoot\ACLs.ps1"
. "$PSScriptRoot\AVDetails.ps1"
. "$PSScriptRoot\AccessChk.ps1"

$global:accessChk = $null
$global:services = (Get-WmiObject win32_service)
$global:servicePaths = @()
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


# foreach ($servicePath in $servicePaths) {
#     Write-Host "$servicePath"
# }
# $global:services = Get-Service
# function Initialize-AccessChk {
#     #Check if accesschk.exe is installed on local machine
#     if ($accessChk -eq $null) {
#         Write-Host "Looking for accesschk.exe on the local system..."
#         Write-Host "This may take a minute or two."
#         $global:accessChk = Get-ChildItem -Path C:\ -Recurse -Name "accesschk.exe" -ErrorAction SilentlyContinue
#     }
# }


# Export the functions so they are available as cmdlets when the module is imported
Export-ModuleMember -Function Get-UnquotedServicePaths, Get-AlwaysInstallElevated, Get-ACLs, Get-AVDetails, Install-AccessChk