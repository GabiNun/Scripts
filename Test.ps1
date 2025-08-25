$ProgressPreference = 'SilentlyContinue'
irm raw.githubusercontent.com/GabiNun/Disable-Windows-Defender/main/Main.ps1 | iex
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c;powercfg /change monitor-timeout-ac 60

& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
ps *edge*|spps -fo; gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0

Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk" -Fo
Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" -Fo
Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Fo
Rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge' -Fo
