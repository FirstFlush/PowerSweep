$ids = @(
    $env:USERNAME,
    "Domain\$($env:USERNAME)",
    "Everyone",
    "Authenticated Users",
    "BUILTIN\Users",
    "BUILTIN\Guests"
)

$privs = @{
    "FullControl" = @{
        Threat = "Admin"
        Origin = "Built-in"
    }
    "SeTakeOwnership" = @{
        Threat = "Admin"
        Origin = "Built-in"
    }
    "TakeOwnership" = @{
        Therat = "Depends on file"
        Origin = "Built-in"
    }
    "Modify" = @{
        Threat = "Admin"
        Origin = "Built-in"
    }
    "Write" = @{
        Threat = "Admin"
        Origin = "Built-in"
    }
    "WriteData" = @{
        Threat = "Admin"
        Origin = "Built-in"
    }
    "Delete" = @{
        Threat = "Depends on file"
        Origin = "Built-in"
    }
    "ChangePermissions" = @{
        Threat = "Admin"
        Origin = "Built-in"
    }
    "SeAudit" = @{
        Threat = "Threat"
        Origin = "3rd party"
    }
    "SeBackup" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeAssignPrimaryToken" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeIncreaseBasePriority" = @{
        Threat = "Availability"
        Origin = "Built-in"
    }
    "SeRemoteShutdown" = @{
        Threat = "Availability"
        Origin = "Built-in"
    }
    "SeRestore" = @{
        Threat = "Admin"
        Origin = "PowerShell"
    }
    "SeSecurity" = @{
        Threat = "Threat"
        Origin = "Built-in"
    }
    "SeShutdown" = @{
        Threat = "Availability"
        Origin = "Built-in"
    }
    "SeSystemtime" = @{
        Threat = "Threat"
        Origin = "Built-in"
    }
    "SeTcb" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeTimeZone" = @{
        Threat = "Messy"
        Origin = "3rd party"
    }
    "SeTrustedCredManAccess" = @{
        Threat = "Threat"
        Origin = "3rd party"
    }
    "SeCreateToken" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeDebug" = @{
        Threat = "Admin"
        Origin = "PowerShell"
    }
    "SeImpersonate" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeIncreaseQuota" = @{
        Threat = "Availability"
        Origin = "3rd party"
    }
    "SeLoadDriver" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeLockMemory" = @{
        Threat = "Availability"
        Origin = "3rd party"
    }
    "SeManageVolume" = @{
        Threat = "Admin"
        Origin = "3rd party"
    }
    "SeRelabel" = @{
        Threat = "Threat"
        Origin = "3rd party"
    }
}

