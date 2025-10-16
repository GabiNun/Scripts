Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*',HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$sid = (glu $env:USERNAME).SID.Value;$appx = (Get-AppxPackage *SecHealthUI).PackageFullName
ni HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$sid\$appx -f; Remove-AppxPackage $appx
