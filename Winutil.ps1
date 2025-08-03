foreach ($svc in (irm raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json).WPFTweaksServices.service | Where-Object { $_.Name -and $_.StartupType }) {
    Set-Service -Name $svc.Name -StartupType $svc.StartupType -ea 0
}

irm "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json"|
Select-Object -ExpandProperty WPFTweaksTele|
Select-Object -ExpandProperty ScheduledTask|
ForEach-Object {Disable-ScheduledTask -TaskName $_.Name -ea 0 | Out-Null}
