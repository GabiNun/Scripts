Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*',HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $env:UserName).Sid.Value
ni HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -f; Remove-AppxPackage $appx
