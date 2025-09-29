$uninstall = (Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge").UninstallString + " --force-uninstall"
$edgeUWP   = "$env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"

New-Item $edgeUWP -ItemType Directory
New-Item "$edgeUWP\MicrosoftEdge.exe"

Start-Process cmd "/c $uninstall"
