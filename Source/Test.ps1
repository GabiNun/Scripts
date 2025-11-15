Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*';sc.exe delete SecurityHealthService") -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender

Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection
& $Env:SystemRoot\System32\OneDriveSetup.exe /uninstall

irm github.com/GabiNun/Scripts/raw/main/Source/Settings.ps1 | iex | Out-Null
