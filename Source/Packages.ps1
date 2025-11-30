Stop-Process -Name Widgets
Get-AppxPackage Microsoft.WindowsNotePad | Remove-AppxPackage
Get-AppxPackage | ? { !$_.IsFramework -and !$_.NonRemovable } | Remove-AppxPackage
Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection
& $Env:SystemRoot\System32\OneDriveSetup.exe /uninstall
