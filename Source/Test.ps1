$json = Invoke-RestMethod "https://raw.githubusercontent.com/ChrisTitusTech/winutil/refs/heads/main/config/tweaks.json"

foreach ($s in $json.WPFTweaksServices.service) {
    if ($s.StartupType -ne $s.OriginalType) {
        Write-Output "Name: $($s.Name)"
        Write-Output "StartupType: $($s.StartupType)"
        Write-Output "OriginalType: $($s.OriginalType)"
        Write-Output "--------------------------"
    }
}
