Measure-Command { $ProgressPreference = 'SilentlyContinue' };Write-Host "SilentlyContinue"

Measure-Command { irm raw.githubusercontent.com/GabiNun/Scripts/main/RegEdit.ps1 | iex };Write-Host "RegEdit"

Measure-Command { irm raw.githubusercontent.com/GabiNun/Disable-Windows-Defender/main/Main.ps1 | iex };Write-Host "Disable-Windows-Defender"

Measure-Command { powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c };Write-Host "powercfg /setactive"

Measure-Command { powercfg /change monitor-timeout-ac 60 };Write-Host "powercfg /change monitor-timeout-ac"

Measure-Command { powercfg /h off };Write-Host "powercfg /h off"

Measure-Command { & $env:SystemRoot\System32\OneDriveSetup.exe /uninstall };Write-Host "OneDriveSetup"

Measure-Command { Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0 };Write-Host "Remove-AppxPackage"

Measure-Command { ps *edge*|spps -fo };Write-Host "TaskKill"

Measure-Command { gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0 };Write-Host "Remove Edge"
