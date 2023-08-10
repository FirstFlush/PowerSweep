

$excludedDirs = @(
    "HKEY_LOCAL_MACHINE\Software\Classes",
    "HKLM:\Software\Classes",
    "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Classes"

)
$excludedDirsSet = [System.Collections.Generic.HashSet[string]]@($excludedDirs)

function Get-WeakRegistryKeys {
    param (
        [string]$basePath = "HKEY_LOCAL_MACHINE\Software"
    )
    # if ($excludedDirsSet -icontains $basePath) {
    #     Write-Host "Skipping directory: $path"
    #     return
    # }
# Navigate to the services registry key
    # Set-Location "HKLM:\System\CurrentControlSet\Services"
    

    Get-ChildItem -Path "HKLM:\System\CurrentControlSet\Services" | ForEach-Object {
        Write-Host (Get-ItemProperty -Path $_.PSPath -Name "ImagePath" -ErrorAction SilentlyContinue).ImagePath
        
    }

    # Get a list of all service keys
    # $serviceKeys = Get-ChildItem

    # # Loop through each service key and display its ImagePath property
    # foreach ($serviceKey in $serviceKeys) {
    #     $imagePath = (Get-ItemProperty -Path $serviceKey.PSPath -Name "ImagePath").ImagePath
    #     Write-Host "$($serviceKey.Name) - $imagePath"
    # }
}



Get-WeakRegistryKeys


    # write-host $basePath
    # Get-ChildItem 
    # Get-ChildItem -Path $basePath | ForEach-Object {
    #     Write-Host $_
    # }
    # get-childitem -path $basePath | fl
    # Get-ChildItem -Path $basePath | ForEach-Object {
    #     write-host $_.Name
    #     if ($_.SubKeyCount -gt 0) {
    #         write-host "$($basePath)$($_)"
    #         # Get-WeakRegistryKeys -basePath $_.FullName
    #     } 
    # }


    # Get-ChildItem -Path $basePath -Recurse -Exclude "HKEY_LOCAL_MACHINE\Software\Classes" |
    #     ForEach-Object {
    #         $key = $_
    #         write-host $key
            
            # if (-not $key.ToString().Contains('*') -or $key.ToString().Contains("\Software\Classes")) {
            #     write-host $key
            # }
            # write-host $key.DirectoryName
            # write-host ""
            # Get-Acl -Path $key.PSPath -ErrorAction SilentlyContinue
            # write-host ""
            # write-host ""
            # $acl = Get-Acl -Path $key.PSPath -ErrorAction SilentlyContinue

            # Write-Host ""
            # write-host $key -ForegroundColor DarkGreen
            # if ($acl) {
            #     foreach ($ace in $acl.Access) {
            #         Write-Host $ace.IdentityReference
            #     }
            # }
        # }
