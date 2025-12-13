irm https://github.com/ionuttbara/windows-defender-remover/raw/refs/heads/main/Remove_Defender/RemoveDefender.reg -Out $Temp\RemoveDefender.reg

Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*','C:\ProgramData\Microsoft\Windows Defender*';sc.exe delete 'C:\ProgramData\Microsoft\Windows Defender*';regedit /s $Temp\RemoveDefender.reg") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force; Remove-AppxPackage $Appx

ScheduledTask '*Defender*' | Unregister-ScheduledTask -Confirm:$False
