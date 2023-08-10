function Get-EnvVars {
    <#
    .SYNOPSIS
    Prints out all the environment variables.

    .DESCRIPTION
    This function retrieves and prints all the environment variables available in the current PowerShell session. Each variable is displayed with its name and value.

    .EXAMPLE
    Print-EnvironmentVariables
    #>
    Write-Host "`nEnvironment Variables:" -ForegroundColor DarkGreen
    Get-ChildItem -Path Env:
}

