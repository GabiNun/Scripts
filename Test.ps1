Measure-Command { $ProgressPreference = 'SilentlyContinue' }

Measure-Command { irm raw.githubusercontent.com/GabiNun/Scripts/main/RegEdit.ps1 | iex }

Measure-Command { irm raw.githubusercontent.com/GabiNun/Disable-Windows-Defender/main/Main.ps1 | iex }

Measure-Command { powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c }

Measure-Command { powercfg /change monitor-timeout-ac 60 }

Measure-Command { powercfg /h off }

Measure-Command { & $env:SystemRoot\System32\OneDriveSetup.exe /uninstall }

Measure-Command { Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0 }

Measure-Command { ps *edge*|spps -fo }

Measure-Command { gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0 }
