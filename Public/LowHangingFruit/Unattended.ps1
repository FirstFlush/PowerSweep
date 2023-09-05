function Get-Unattended {
    <#
    .SYNOPSIS
        Retrieves and displays the content of unattended setup files with highlighting of keywords.

    .DESCRIPTION
        This cmdlet searches for common unattended setup files and displays their content with keyword highlighting.
        Keywords highlighted (case insensitive):
        -key
        -token
        -credential
        -password
        -private
        -any 128-bit hash in hex format (NTLM, MD5, etc)
        
    .NOTES
        File Paths:
        - C:\Unattend.xml
        - C:\Windows\Panther\Unattend.xml
        - C:\Windows\Panther\Unattend\Unattend.xml
        - C:\Windows\system32\sysprep.inf
        - C:\Windows\system32\sysprep\sysprep.xml

    .EXAMPLE
        Get-Unattended

        Retrieves and displays the content of unattended setup files with keyword highlighting.

    #>
    $unattended = @(
        "C:\Unattend.xml",
        "C:\Windows\Panther\Unattend.xml",
        "C:\Windows\Panther\Unattend\Unattend.xml",
        "C:\Windows\system32\sysprep.inf",
        "C:\Windows\system32\sysprep\sysprep.xml"
    )
    $searchStrings = @(
        "key",
        "token",
        "credential"
    )
    $searchStringsSpecial = @(
        "password",
        "private"
    )
    $pattern = ($searchStrings | ForEach-Object { [regex]::Escape($_) }) -join "|"
    $patternSpecial = (($searchStringsSpecial | ForEach-Object { [regex]::Escape($_) }) -join "|")+"|[0-9A-Fa-f]{32}" #NTLM hash regex
    $esc = "$([char]27)"
    $FormatWrapYellow = "$esc[33m{0}$esc[0m"
    $FormatWrapRed = "$esc[91m{0}$esc[0m"
    
    foreach ($file in $unattended) {
        Write-Host $file.ToString() -ForegroundColor DarkGreen
        $fileContents = Get-Content $file -ErrorAction SilentlyContinue
        if ($fileContents -eq $null) {
            Write-Host "File not found"
        } else {
            foreach ($line in $fileContents) {
                if ($line -match $patternSpecial) { $FormatWrapRed -f $line }
                elseif ($line -match $pattern) { $FormatWrapYellow -f $line }
                else {$line} 
            }
        }
        Write-Host "`n"
    }
}