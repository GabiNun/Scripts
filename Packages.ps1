$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:UserName).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force;Remove-AppxPackage $Appx

Stop-Process -Name Widgets -ErrorAction Ignore
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|terminal'} | Remove-AppxPackage -AllUsers
Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection -NoRestart
C:\Windows\System32\OneDriveSetup /uninstall
