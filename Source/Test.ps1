$json = Invoke-RestMethod "https://raw.githubusercontent.com/ChrisTitusTech/winutil/refs/heads/main/config/tweaks.json"

foreach ($s in $json.WPFTweaksServices.service) {
    sc.exe config $s.Name start= $s.StartupType
}
