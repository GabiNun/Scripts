Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rmdir -r 'C:\Program Files*\Windows Defender*',HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run") -User 'NT SERVICE\TrustedInstaller' | Out-Null
Start-ScheduledTask Defender

$sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value;$appx = Get-AppxPackage *SecHealthUI
ni HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$sid\$($appx.PackageFullName) -f | Out-Null; $appx | Remove-AppxPackage
