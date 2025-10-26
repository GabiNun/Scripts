Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection
& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall

$Packages = @(
)

foreach ($Package in $Packages) {Get-AppxPackage $Package | Remove-AppPackage}
