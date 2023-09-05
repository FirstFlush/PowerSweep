function Get-ServiceACL {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ServiceName
    )
    
    $service = New-Object System.ServiceProcess.ServiceController $ServiceName
    
    if ($null -eq $service) {
        throw "Failed to create ServiceController object for service $ServiceName."
    }

    $serviceHandle = $service.ServiceHandle
    
    if ($null -eq $serviceHandle) {
        throw "Failed to get service handle for service $ServiceName."
    }

    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Advapi32 {
        [DllImport("advapi32.dll", SetLastError=true, CharSet=CharSet.Unicode)]
        public static extern bool QueryServiceObjectSecurity(SafeHandle serviceHandle, System.Security.AccessControl.SecurityInfos secInfo, byte[] lpSecDesrBuf, uint bufSize, out uint bufSizeNeeded);
    }
"@ -Language CSharp

    $buffer = New-Object byte[] 4096
    $returnLength = 0
    $result = [Advapi32]::QueryServiceObjectSecurity($serviceHandle, [System.Security.AccessControl.SecurityInfos]::DiscretionaryAcl, $buffer, 4096, [ref]$returnLength)

    if (-not $result) {
        throw "Failed to query service permissions."
    }

    $sd = New-Object System.Security.AccessControl.RawSecurityDescriptor $buffer, 0
    return $sd.DiscretionaryAcl
}

$serviceName = "AppIDSvc"
Get-ServiceACL -ServiceName $serviceName