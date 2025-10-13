Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "-c rm -r -fo 'C:\Program Files*\Windows Defender*',C:\WINDOWS\system32\SecurityHealthService.exe,C:\Windows\System32\SecurityHealthSystray.exe") -User 'NT SERVICE\TrustedInstaller' | Out-Null
Start-ScheduledTask Defender

$store = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore';$appx = Get-AppxPackage *SecHealthUI
$sids  = @('S-1-5-18') + (gci $store -ea 0 | % PSChildName | ?{ $_ -like 'S-1-5-21*' });$sids | % { ni "$store\EndOfLife\$_\$($appx.PackageFullName)" -Fo | Out-Null };$appx | Remove-AppxPackage
