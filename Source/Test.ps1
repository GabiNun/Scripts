$regView = [Microsoft.Win32.RegistryView]::Registry32
$microsoft = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $regView).
OpenSubKey('SOFTWARE\Microsoft', $true)

$edgeClient = $microsoft.OpenSubKey('EdgeUpdate\ClientState\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}', $true)
if ($null -ne $edgeClient.GetValue('experiment_control_labels')) {
	$edgeClient.DeleteValue('experiment_control_labels')
}

$microsoft.CreateSubKey('EdgeUpdateDev').SetValue('AllowUninstall', '')

$uninstallRegKey = $microsoft.OpenSubKey('Windows\CurrentVersion\Uninstall\Microsoft Edge')
$uninstallString = $uninstallRegKey.GetValue('UninstallString') + ' --force-uninstall'
Start-Process cmd.exe "/c $uninstallString" -WindowStyle Hidden
