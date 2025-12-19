$ProgressPreference = 'SilentlyContinue'

New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start | Out-Null
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows\Explorer | Out-Null

Set-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' DisableAntiSpyware 1
Set-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' DisableAntiVirus 1
Set-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' ServiceKeepAlive 1

Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR AppCaptureEnabled 0
Set-ItemProperty HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableNotificationCenter 1
Set-ItemProperty HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableSearchBoxSuggestions 1

Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer HideRecommendedSection 1
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start HideRecommendedSection 1
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education IsEducationEnvironment 1

Remove-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' SecurityHealth

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off

$Appx = (Get-AppxPackage *SecHealthUI).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force | Out-Null; Remove-AppxPackage $Appx

Stop-Process -Name Widgets
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable -and $_.Name -notmatch 'Notepad|terminal'} | Remove-AppxPackage
Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection | Out-Null
& $Env:SystemRoot\System32\OneDriveSetup.exe /uninstall

irm gist.github.com/GabiNun/68d843555f96dbd21d4d47ef23eff5ce/raw/Edge.ps1 | iex
