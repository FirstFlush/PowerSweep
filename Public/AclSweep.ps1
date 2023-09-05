
function Get-AclSweep {
    
    acls = @(Get-ServiceExeAcl)
    acls += @(Get-TaskAcl)
    acls += @(Get-TaskExeAcl)

    foreach ($acl in $acls) {
        foreach ($ace in $acl.Access) {
            # check identity and then privs 
        }
    }

    Get-TaskExeAcl

}
