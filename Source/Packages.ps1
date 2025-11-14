Get-AppxPackage | ? { !$_.IsFramework -and !$_.NonRemovable -and $_.Name -ne "Microsoft.WindowsNotepad" } | Remove-AppxPackage
Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection
& $Env:SystemRoot\System32\OneDriveSetup.exe /uninstall
