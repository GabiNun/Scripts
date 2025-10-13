Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "-c rm -r -fo 'C:\Program Files*\Windows Defender*',C:\WINDOWS\system32\SecurityHealthService.exe,C:\Windows\System32\SecurityHealthSystray.exe") -User 'NT SERVICE\TrustedInstaller' | Out-Null
Start-ScheduledTask Defender

$sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
$appx = Get-AppxPackage *SecHealthUI; @('$sid') | % { ni "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$_\$($appx.PackageFullName)" -Fo | Out-Null }; $appx | Remove-AppxPackage
