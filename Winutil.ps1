irm raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json|ForEach-Object { $_.WPFTweaksTele.ScheduledTask } | ForEach-Object { Disable-ScheduledTask -TaskName $_.Name -ea 0 | Out-Null }
foreach ($svc in (irm raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json).WPFTweaksServices.service | Where-Object { $_.Name -and $_.StartupType }) {
    Set-Service -Name $svc.Name -StartupType $svc.StartupType -ea 0
}
