function Get-WebConfig {
    <#
    .SYNOPSIS
    Searches for web.config files and parses them for potential cleartext credentials.

    .DESCRIPTION
    This script searches for "web.config" files and performs a search within those files for the term "connectionString" to identify potential cleartext credentials.

    .NOTES
    File paths being searched (recursively):
    - C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config
    - C:\inetpub\wwwroot

    .EXAMPLE
    Search-WebConfig
    Runs the script to search for web.config file(s) and parse them for
    potential cleartext credentials.

    #>
    # 2 potential paths for web.config file, depending on IIS version
    $configPaths = @(
        "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config",
        "C:\inetpub\wwwroot"
    )
    foreach ($configPath in $configPaths) {
        Get-ChildItem $configPath -Recurse -ErrorAction SilentlyContinue | 
        Where-Object -Property Name -eq "web.config" | 
        ForEach-Object {
            $content = Get-Content $_.FullName -ErrorAction SilentlyContinue
            if ($content -ne $null) {
                Write-Host "`nSearching web.config for the string 'connectionString'" -ForegroundColor DarkGreen
                $content | Select-String "connectionString"
                Write-Host "`n`nFound web.config file:`n$($_.FullName)" -ForegroundColor DarkGreen            
            } 
        }
    }
}





#     # 2 potential paths for web.config file, depending on IIS version
#     $configPaths = @(
#         "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config",
#         "C:\inetpub\wwwroot\web.config"
#     )
#     foreach ($configPath in $configPaths) {
#         $content = Get-Content $configPath -ErrorAction SilentlyContinue
#         if ($content -ne $null) {
#             Write-Host "`nSearching web.config for the string 'connectionString'" -ForegroundColor DarkGreen
#             $content | Select-String "connectionString"
#             Write-Host "`n`nFound web.config file:`n$configPath" -ForegroundColor DarkGreen            
#         } 
#     }
# }
