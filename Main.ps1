$ProgressPreference = 'SilentlyContinue'
irm raw.githubusercontent.com/GabiNun/Scripts/main/RegEdit.ps1 | iex
write-host "ran regedit"
irm raw.githubusercontent.com/GabiNun/Disable-Windows-Defender/main/Main.ps1 | iex
write-host "ran disable-defender"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c;powercfg /change monitor-timeout-ac 60;powercfg /h off
write-host "ran powercfg"

& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
write-host "ran onedrive uninstaller"
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
write-host "ran removing apps"
ps *edge*|spps -fo; gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0
write-host "ran removing edge"
