New-Item $env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe -I D
New-Item $env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe

cmd /c ((Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge').UninstallString + ' --force-uninstall')
