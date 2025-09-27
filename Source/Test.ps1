$json = Invoke-RestMethod "https://raw.githubusercontent.com/ChrisTitusTech/winutil/refs/heads/main/config/tweaks.json"

foreach ($s in $json.WPFTweaksServices.service) {
    $startType = switch ($s.StartupType.ToLower()) {
        "automatic" { "auto" }
        "manual"    { "demand" }
        "disabled"  { "disabled" }
        "AutomaticDelayedStart" { "delayed-auto" }
    }

    sc.exe config $s.Name start= $startType | Out-Null
}

foreach ($s in $json.WPFTweaksServices.service) {
    $startType = switch ($s.StartupType.ToLower()) {
        "automatic" { "auto" }
        "manual"    { "demand" }
        "disabled"  { "disabled" }
        "automaticdelayedstart" { "delayed-auto" }
    }

    try {
        $result = sc.exe config $s.Name start= $startType 2>&1
        foreach ($line in $result) {
            if ($line -match "OpenService FAILED 1060") {
                Write-Host "Service not found: $($s.Name)"
            }
            elseif ($line -match "OpenService FAILED 5") {
                Write-Host "Access denied: $($s.Name)"
            }
        }
    } catch {
        Write-Host "Unexpected error with service $($s.Name): $_"
    }
}
