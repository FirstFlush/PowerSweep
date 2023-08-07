function Get-ACLs {
    <#
    .SYNOPSIS
    Get-ACLs retrieves the access control lists (ACLs) for Windows services and highlights ACLs with potential high privileges.

    .DESCRIPTION
    The Get-ACLs cmdlet retrieves the access control lists (ACLs) for Windows services on the local computer. It then checks each ACL to see if it has an access control type set to "Allow" and applies to the following users:
        - Everyone
        - BUILTIN\Users
        - The specified $Username parameter

    If any ACL meets these conditions, it will be highlighted in yellow.

    Additionally, if any of these highlighted ACLs for the specified users have the following FileSystemRights:
        - FullControl
        - Modify
        - Write
        - ChangePermissions
        - TakeOwnership
        - Delete

    The ACL will be highlighted in purple to indicate its potential high privilege.

    .PARAMETER Username
    Specifies the username for which to check high privilege ACLs. If no value is provided, the current user's username ($env:USERNAME) will be used.

    .EXAMPLE
    Get-ACLs
    Get access control lists for all Windows services using the default user ($env:USERNAME).

    .EXAMPLE
    Get-ACLs -Username "SomeUser"
    Get access control lists for all Windows services using the specified user "SomeUser".

    #>
    param (
        [string]$username = $env:USERNAME
    )
    $ids = @(
        "Everyone", 
        "$username", 
        "BUILTIN\Users"
    )
    $rights = @(
        "FullControl",
        "Modify",
        "Write",
        "ChangePermissions",
        "TakeOwnership",
        "Delete"
    )
    $rightsHashSet = [System.Collections.Generic.HashSet[string]]@($rights)
    foreach ($path in $servicePaths) {
        $acl = Get-Acl -Path "$path" -ErrorAction SilentlyContinue
        foreach ($ace in $acl.Access) {
            $foreground = "Green"
            $aceRightsEnum = [System.Security.AccessControl.FileSystemRights]$ace.FileSystemRights
            $hasHighPrivilege = $false
            if ($ids -contains $ace.IdentityReference -and $ace.AccessControlType -eq "Allow") {
                foreach ($right in $aceRightsEnum) {
                    if ($rightsHashSet -contains $right) {
                        $hasHighPrivilege = $true
                    }
                }
                if ($hasHighPrivilege) {
                    $foreground = "Magenta"
                } else {
                    $foreground = "Yellow"
                }
            }
            Write-Host "Path`t: $($path)" -ForegroundColor $foreground
            Write-Host "Owner`t: $($acl.Owner)" -ForegroundColor $foreground
            Write-Host "Group`t: $($acl.Group)" -ForegroundColor $foreground
            Write-Host "`tIdentityReference: $($ace.IdentityReference)" -ForegroundColor $foreground
            Write-Host "`tAccessControlType: $($ace.AccessControlType)" -ForegroundColor $foreground
            Write-Host "`tFileSystemRights: $($ace.FileSystemRights)" -ForegroundColor $foreground
            Write-Host "`tIsInherited: $($ace.IsInherited)" -ForegroundColor $foreground
            Write-Host "`tPropagationFlags: $($ace.PropagationFlags)" -ForegroundColor $foreground
            Write-Host "`tInheritanceFlags: $($ace.InheritanceFlags)" -ForegroundColor $foreground
            Write-Host "Audit`t: $($acl.Audit)" -ForegroundColor $foreground
            Write-Host "Sddl`t: $($acl.Sddl)" -ForegroundColor $foreground
            Write-Host ""
        }   
    }
}