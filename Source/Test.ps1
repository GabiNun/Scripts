$regView = [Microsoft.Win32.RegistryView]::Registry32
$reg = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $regView).
OpenSubKey('SOFTWARE\Microsoft', $true)

$uninstall = $reg.OpenSubKey('Windows\CurrentVersion\Uninstall\Microsoft Edge').
GetValue('UninstallString') + ' --force-uninstall'

$fakeDllhost = "$env:SystemRoot\SystemTemp\dllhost.exe"

Copy-Item "$env:SystemRoot\System32\cmd.exe" $fakeDllhost

$reg.OpenSubKey('EdgeUpdate\ClientState\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}', $true).
DeleteValue('experiment_control_labels')

$reg.CreateSubKey('EdgeUpdateDev').SetValue('AllowUninstall', '')

$edgeUWP = "$env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
New-Item $edgeUWP -ItemType Directory
New-Item "$edgeUWP\MicrosoftEdge.exe"

Start-Process $fakeDllhost "/c $uninstall" -WindowStyle Hidden -Wait

Remove-Item "$edgeUWP\MicrosoftEdge.exe"
Remove-Item $fakeDllhost
Remove-Item $edgeUWP

Write-Output "Edge should now be uninstalled!"
