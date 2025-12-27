$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force;Remove-AppxPackage $Appx

Stop-Process -Name Widgets
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|terminal'} | Remove-AppxPackage
Get-WindowsOptionalFeature -Online | ? State -eq Enabled | Disable-WindowsOptionalFeature -Online -NoRestart
& $Env:SystemRoot\System32\OneDriveSetup /uninstall
