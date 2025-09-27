$json = Invoke-RestMethod "https://raw.githubusercontent.com/ChrisTitusTech/winutil/refs/heads/main/config/tweaks.json"

foreach ($s in $json.WPFTweaksServices.service) {
    $startType = switch ($s.StartupType.ToLower()) {
        "automatic" { "auto" }
        "manual"    { "demand" }
        "disabled"  { "disabled" }
        "AutomaticDelayedStart" { "delayed-auto" }
    }

    sc.exe config $s.Name start= $startType
}
