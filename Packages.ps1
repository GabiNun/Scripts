$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:UserName).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force;Remove-AppxPackage $Appx

Stop-Process -Name Widgets -ErrorAction Ignore
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|terminal'} | Remove-AppxPackage -AllUsers
Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection -NoRestart
C:\Windows\System32\OneDriveSetup /uninstall

New-Item "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe" -Force
cmd /c ((Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge").UninstallString + ' --force-uninstall --delete-profile')

$Appx = (Get-AppxPackage *EdgeDevToolsClient).PackageFullName
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force;Remove-AppxPackage $Appx

Get-Process *Edge*,SearchHost | Stop-Process -Force
Remove-Item "$Env:ProgramFiles (x86)\Microsoft" -Recurse -Force
Remove-Item C:\ProgramData\Microsoft\EdgeUpdate -Recurse -Force
sc.exe delete edgeupdate
sc.exe delete edgeupdatem
Unregister-ScheduledTask *Edge* -Confirm:$False
