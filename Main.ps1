New-Item HKCU:\System\GameConfigStor -Fo | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows -Fo | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows\Explorer -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Fo | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Fo | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings -Fo | Out-Null

Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseSpeed -Value "0" -Fo
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold1 -Value "0" -Fo
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold2 -Value "0" -Fo
Set-ItemProperty -Path HKCU:\System\GameConfigStor -Name GameDVR_Enabled -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Value 1 -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name HideRecommendedSection -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR -Name AppCaptureEnabled -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name HideClock -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Name DisableNotificationCenter -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications -Name ToastEnabled -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarBadges -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowStatusBar -Value 0 -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Name HideRecommendedSection -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Fo
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $env:SystemRoot\Web\Wallpaper\Windows\img19.jpg -Fo
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1 -Type DWord -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Name IsEducationEnvironment -Value 1 -Fo
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Fo
Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -Type DWord -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Value 0 -Type DWord -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Name UserSetting_DisableStartupSound -Value 1 -Type DWord -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Value 1 -Fo

Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Fo
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth"
Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge'
Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView'
Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update'
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'

$ProgressPreference = 'SilentlyContinue'
& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
ps *edge*|spps -fo; gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c;powercfg /change monitor-timeout-ac 60
schtasks /create /tn Defender /tr "powershell.exe -Command rm -r -fo 'C:\Program Files*\Windows Defender*'; rm -fo C:\Windows\System32\smartscreen.exe,C:\Windows\System32\SecurityHealthService.exe" /sc once /st 00:00 /RL HIGHEST /RU SYSTEM /F
Register-ScheduledTask -TaskName 'Defender' -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command `"rm -r -fo 'C:\Program Files*\Windows Defender*';rm -fo C:\Windows\System32\smartscreen.exe,C:\Windows\System32\SecurityHealthService.exe`"") -Force; $svc=New-Object -ComObject 'Schedule.Service'; $svc.Connect(); $svc.GetFolder('\').GetTask('Defender').RunEx($null,0,0,'NT SERVICE\TrustedInstaller')
$store = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore'; $appx = Get-AppxPackage -Name Microsoft.SecHealthUI; $sids = @('S-1-5-18'); $sids += Get-ChildItem $store -ea 0 | % { $_.PSChildName } | ? { $_.StartsWith('S-1-5-21') }; New-Item -Path "$store\Deprovisioned\$($appx.PackageFamilyName)" -ItemType RegistryKey -Force | Out-Null; foreach ($sid in $sids) { New-Item -Path "$store\EndOfLife\$sid\$($appx.PackageFullName)" -ItemType RegistryKey -Force | Out-Null }; $appx | Remove-AppxPackage
