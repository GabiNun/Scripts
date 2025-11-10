Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*';sc.exe delete SecurityHealthService") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force; Remove-AppxPackage $Appx
