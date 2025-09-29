$reg = [Microsoft.Win32.RegistryKey]::OpenBaseKey(
    [Microsoft.Win32.RegistryHive]::LocalMachine,
    [Microsoft.Win32.RegistryView]::Registry32
).OpenSubKey('SOFTWARE\Microsoft', $true)

$uninstall = $reg.OpenSubKey('Windows\CurrentVersion\Uninstall\Microsoft Edge').GetValue('UninstallString') + ' --force-uninstall'
$fakeHost  = "$env:SystemRoot\SystemTemp\dllhost.exe"
$edgeUWP   = "$env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"

Copy-Item "$env:SystemRoot\System32\cmd.exe" $fakeHost
$reg.OpenSubKey('EdgeUpdate\ClientState\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}', $true).DeleteValue('experiment_control_labels')
$reg.CreateSubKey('EdgeUpdateDev').SetValue('AllowUninstall', '')

New-Item $edgeUWP -ItemType Directory
New-Item "$edgeUWP\MicrosoftEdge.exe"

Start-Process $fakeHost "/c $uninstall" -WindowStyle Hidden -Wait

Remove-Item "$edgeUWP\MicrosoftEdge.exe"
Remove-Item $fakeHost
Remove-Item $edgeUWP
