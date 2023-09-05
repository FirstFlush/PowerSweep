$taskPaths = @()




Get-ScheduledTask | ForEach-Object {
    $path = "$($_.Actions.Execute)".Trim()
    if ($path.Contains('%')) {
        $path = [System.Environment]::ExpandEnvironmentVariables("$path")
    }
    if ($path[0] -eq '"') {
        $path = $path.Substring(1)
    }
    if ($path[-1] -eq '"') {
        $path = $path.Substring(0, $path.Length - 1)
    }
    $taskPaths += $path
}

$taskPaths = $taskPaths | Where-Object { $_ -ne '' }
foreach($path in $taskPaths) {
    if (-not $path.Contains("C:")) {
        $newPath = ($path -split ' ')[0].Trim()
        $command = Get-Command $newPath -ErrorAction SilentlyContinue
        if ($command) {
            $index = $($taskPaths.IndexOf($path))
            $taskPaths[$index] = $command.Source
        }
    }
}

foreach ($path in $taskPaths) {
    $acls = (Get-ACL).Access
    foreach ($acl in $acls) {
        # write-host $acl
        foreach($ace in $acl){
            write-host $ace.AccessControlType
        }
        write-host "===="
    }
}



