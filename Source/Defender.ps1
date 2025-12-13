$ServicePath = "HKLM:\SYSTEM\CurrentControlSet\Services"

$DefenderPaths =
  "$ServicePath\WinDefend",
  "$ServicePath\WdNisSvc",
  "$ServicePath\MDCoreSvc",
  "$ServicePath\Sense",
  "$ServicePath\webthreatdef*"

foreach ($DefenderPath in $DefenderPaths) { Remove-Item $DefenderPath -Recurse -Force }

Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*'") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force; Remove-AppxPackage $Appx

ScheduledTask '*Defender*' | Unregister-ScheduledTask -Confirm:$False
