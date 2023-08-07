function findAccessChk {
    #Check if accesschk.exe is installed on local machine
    if ($global:accessChk -eq $null) {
        Write-Host "`nSearching for accesschk.exe on the local system..."
        Write-Host "This may take a minute or two.`n"
        Write-Host "You can skip this search by running:" 
        Write-Host "Install-AccessChk" -NoNewline -ForegroundColor Yellow
        Write-Host " -NoSearch`n" -ForegroundColor DarkCyan
        $global:accessChk = Get-ChildItem -Path C:\ -Recurse -Name "accesschk.exe" -ErrorAction SilentlyContinue
    } else {
        Write-Host "`nFound accesschk.exe in the following directory:"
        Write-Host "$global:accessChk`n" -ForegroundColor Yellow
    }
}

function Install-AccessChk {
    <#
    .SYNOPSIS
        Install-AccessChk cmdlet downloads and installs the AccessChk.exe sysinternals tool.
    .DESCRIPTION
        Install-AccessChk cmdlet will download and unzip the accesschk.exe sysinternals tool from:
        
            https://download.sysinternals.com/files/AccessChk.zip
        
        Before downloading, it will check if accesschk.exe is already installed on the local machine. This search can be skipped by passing in the -NoSearch parameter.
        It will download accesschk.zip into your current directory. Then it will extract the contents into a newly-created ./Accessck/ directory and finally delete the no-longer-needed accesschk.zip file.
    .PARAMETER NoSearch
        Skips the search for an existing accesschk.exe on the local machine when specified.
    .EXAMPLE
        Install-AccessChk
        Description:
            Downloads and installs AccessChk.exe from https://download.sysinternals.com/files/AccessChk.zip.
    .EXAMPLE
        Install-AccessChk -NoSearch
        Description:
            Downloads and installs AccessChk.exe without searching for an existing installation.
    #>
    [CmdletBinding()]
    param (
        [switch]$NoSearch = $false
    )
    if (-not $NoSearch) {
        findAccessChk
    }
    if ($global:accessChk -eq $null) {
        $url = "https://download.sysinternals.com/files/AccessChk.zip"
        $zipFile = "AccessChk.zip"
        Write-Host "`nDownloading and unzipping AccessChk.zip from:"
        Write-Host "$url`n"
        try {
            Invoke-WebRequest -uri $url -OutFile $zipFile
        } 
        catch {
            Write-Host "`nFailed to download AccessChk.zip"
            Write-Host "Perhaps downloading files to this directory is restricted?`n"
            return
        }
        Expand-Archive -Path "$zipFile" -DestinationPath "./AccessChk" -Force
        Remove-Item -Path $zipFile
        Write-Host "Download and extraction complete.`n"
    }
}