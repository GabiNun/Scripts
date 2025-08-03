($json=irm raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json) | Out-Null
$json.WPFTweaksServices.service | Where-Object { $_.Name -and $_.StartupType } | ForEach-Object { Set-Service -Name $_.Name -StartupType $_.StartupType -ea 0 }
$json.WPFTweaksTele.registry | ForEach-Object { Set-ItemProperty -Path $_.Path -Name $_.Name -Value $_.Value -Type $_.Type -ea 0 }
$json.WPFTweaksTele.ScheduledTask | ForEach-Object { Disable-ScheduledTask -TaskName $_.Name -ea 0 | Out-Null }
