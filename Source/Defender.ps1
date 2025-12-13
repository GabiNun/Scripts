$ServicePath = "HKLM:\SYSTEM\CurrentControlSet\Services"

$DefenderPaths = @(
  "$ServicePath\WinDefend",
  "$ServicePath\WdNisSvc",
  "$ServicePath\MDCoreSvc",
  "$ServicePath\Sense",
  "$ServicePath\webthreatdef*",
  "C:\Program Files*\Windows Defender*"
)

$FormatedPaths = $DefenderPaths -join ','

Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "Remove-Item -Recurse -Force $FormatedPaths") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force; Remove-AppxPackage $Appx

ScheduledTask '*Defender*' | Unregister-ScheduledTask -Confirm:$False
