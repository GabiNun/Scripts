irm https://github.com/GabiNun/Scripts/blob/main/Script.reg -Out Script.reg
regedit /s Script.reg
Remove-Item Script.reg

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null; Remove-AppxPackage $Appx

$ProgressPreference = 'SilentlyContinue'

Stop-Process -Name Widgets
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|terminal'} | Remove-AppxPackage
Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection | Out-Null
& $Env:SystemRoot\System32\OneDriveSetup /uninstall

irm gist.github.com/GabiNun/68d843555f96dbd21d4d47ef23eff5ce/raw/Edge.ps1 | iex | Out-Null
