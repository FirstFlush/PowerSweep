@{
    ModuleVersion = '1.0.0'
    RootModule = 'PowerSweep.psm1'
    FunctionsToExport = @(
        'Get-UnquotedServicePaths',
        'Get-AlwaysInstallElevated',
        'Get-ACLs',
        'Get-AVDetails',
        'Install-AccessChk',
        'Get-AutoRuns',
        'Get-Unattended',
        'Get-EnvVars',
        'Get-PSHistory',
        'Get-WebConfig'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    ModuleList = @()
    ModuleVersion = '1.0.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    PrivateData = @{
        PSData = @{
            ProjectUri = 'https://github.com/FirstFlush/PowerSweep'
            LicenseUri = 'https://github.com/FirstFlush/PowerSweep/blob/main/LICENSE'
            ReleaseNotes = 'Initial release.'
        }
    }
    RequiredModules = @()
    ScriptsToProcess = @()
}