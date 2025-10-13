Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "-c rm -r -fo 'C:\Program Files*\Windows Defender*',C:\WINDOWS\system32\SecurityHealthService.exe,C:\Windows\System32\SecurityHealthSystray.exe") -User 'NT SERVICE\TrustedInstaller' | Out-Null
Start-ScheduledTask Defender

$store = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore';$appx = Get-AppxPackage *SecHealthUI
@('S-1-5-18','S-1-5-21-3939049671-854807330-977275038-1001') | % { ni "$store\EndOfLife\$_\$($appx.PackageFullName)" -Fo | Out-Null }; $appx | Remove-AppxPackage
