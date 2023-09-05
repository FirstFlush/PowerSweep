function Get-TaskAcl {
    <#
    .SYNOPSIS
    This function retrieves the Access Control List (ACL) for each Scheduled Task object in the input array.

    .DESCRIPTION
    The Get-TaskAcl function takes an array of Scheduled Task objects as input.
    For each Scheduled Task object in this array, the function retrieves and returns the corresponding ACL.
    The ACL defines the permissions associated with the Scheduled Task object.

    .PARAMETER Tasks
    An array of Scheduled Task objects for which the ACLs will be retrieved.
    If this parameter is not provided, the function defaults to using the output of the Get-ScheduledTask cmdlet.

    .EXAMPLE
    Get-ScheduledTask | Get-TaskAcl

    This example retrieves all Scheduled Task objects on the system using Get-ScheduledTask,
    pipes them to Get-TaskAcl, and then retrieves and displays the ACL for each of these Scheduled Task objects.

    .EXAMPLE
    $MyTasks = Get-ScheduledTask -TaskName "*Microsoft*"
    Get-TaskAcl -Tasks $MyTasks

    This example first retrieves Scheduled Task objects in the "\Microsoft\" path,
    stores them in the $MyTasks variable, and then retrieves and displays the ACL for each of these tasks using Get-TaskAcl.
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [CimInstance[]]$Tasks = (Get-ScheduledTask)
    )    
    process {
        Get-Acl -Path "C:\Windows\System32\Tasks$($Tasks.URI)" -ErrorAction SilentlyContinue
    }
}

function Get-TaskExeAcl {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [CimInstance[]]$Tasks = (Get-ScheduledTask) 
    )    
    process {
        $path = "$($Tasks.Actions.Execute)" -replace '"', ''
        if (-not [string]::IsNullOrEmpty($path)) {
            Get-Acl -Path "$path" -ErrorAction SilentlyContinue

        }
    }
}

function Get-ServiceAcl {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [CimInstance[]]$Tasks = (Get-ScheduledTask) 
    )    

}



# function _cleanPath {
#     <#
#     It takes a service path like:
#         "C:\Program Files\your\service.exe -k -p"
#     and returns:
#         C:\Program Files\your\service.exe
#     #>
#     param (
#         [string]$path
#     )
#     $path = "$($path)" -replace '"', ''
#     $index = $path.LastIndexOf(".exe")
#     $path = $path.Substring(0, $index + 4) # +4 to include the entire '.exe'
#     return $path
# }

function Get-ServiceExeAcl {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [PSObject]$Service
    )
    begin {
        $Services = @()
    }
    process {
        # If we have received a Service from the pipeline, we add it to the $Services array
        if ($PSBoundParameters.ContainsKey('Service')) {
            $Services += $Service
        }
    }
    end {
        # If no services were received via the pipeline, we fetch all services
        if (-not $PSBoundParameters.ContainsKey('Service')) {
            $Services = Get-WmiObject win32_service
        }
        # Process each service
        $UniqueServices = $Services | Select-Object -Unique -Property PathName
        foreach ($svc in $UniqueServices) {
            $path = $svc.PathName -replace '"', ''
            $index = $path.LastIndexOf(".exe")
            if ($index -ge 0 -and $index + 4 -le $path.Length -and -not [string]::IsNullOrEmpty($path)) {
                Write-Output $path.Substring(0, $index + 4) # +4 to include '.exe'
            }
        }
    }
}

(Get-WmiObject win32_service | Get-ServiceExeAcl).Length