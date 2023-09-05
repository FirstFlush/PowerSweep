

function cleanPath {
    <#
    It takes a service path like:
        "C:\Program Files\your\service.exe -k -p"
    and returns:
        C:\Program Files\your\service.exe
    #>
    param (
        [string]$path
    )
    $path = "$($path)" -replace '"', ''
    $index = $path.LastIndexOf(".exe")
    $path = $path.Substring(0, $index + 4) # +4 to include the entire '.exe'
    return $path
}


function _isExe {
    <#
    .SYNOPSIS
    Checks if the given path contains the substring ".exe".

    .PARAMETER path
    The path to check for the ".exe" substring.

    .RETURN
    Returns $true if ".exe" is found in the path, otherwise returns $false.
    #>
    param (
        [string]$path
    )
    return $path.Contains(".exe")
}

function _firstCharQuotes {
    <#
    .SYNOPSIS
    Checks if the given path starts with double quotes.

    .PARAMETER path
    The path to check.

    .RETURN
    Returns $true if first char is duble quotes, otherwise returns $false.
    #>
    param (
        [string]$path
    )
    return ($path[0] -eq '"')
}
