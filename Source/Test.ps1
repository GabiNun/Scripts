Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "rm -r -fo 'C:\Program Files*\Windows Defender*';sc.exe delete SecurityHealthService") -U 'NT SERVICE\TrustedInstaller' | Out-Null
Start-ScheduledTask Defender | Out-Null

Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection | Out-Null
& $Env:SystemRoot\System32\OneDriveSetup.exe /uninstall

irm github.com/GabiNun/Scripts/raw/main/Source/Settings.ps1 | iex | Out-Null
