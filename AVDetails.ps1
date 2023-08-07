

function Get-AVDetails {
    $antivirusProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class "AntiVirusProduct"
    Write-Host ""
    foreach ($product in $antivirusProducts) {
        Write-Host "Name`t" -ForegroundColor Yellow -NoNewline
        Write-Host ": $($product.displayName)"
        Write-Host "Path`t" -ForegroundColor Yellow -NoNewline
        Write-Host ": $($product.pathToSignedProductExe)"
        Write-Host "Vendor`t" -ForegroundColor Yellow -NoNewLine
        Write-Host ": $($product.companyName)"
        Write-Host "Version`t" -ForegroundColor Yellow -NoNewLine
        Write-Host ": $($product.productVersion)"
        Write-Host ""
    }
}


function Get-Firewall {
    $firewallServices = Get-WmiObject -Class Win32_Service | Where-Object { $_.Name -like "*Firewall*" }
    foreach ($service in $firewallServices) {
        Write-Host "Service Name: $($service.Name)"
        Write-Host "Display Name: $($service.DisplayName)"
        Write-Host "Status: $($service.State)"
        Write-Host "----------------------------------"
    }

}


# Get-Firewall
# Get-AVDetails