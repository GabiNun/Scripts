$ProgressPreference = 'SilentlyContinue'
irm raw.githubusercontent.com/GabiNun/Scripts/main/Settings.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Disable-Windows-Defender/main/Main.ps1 | iex
powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off

& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
spps -N *edge* -f;gci C:\ -r -fo -ea 0 -filter *edge*|ri -r -fo -ea 0
