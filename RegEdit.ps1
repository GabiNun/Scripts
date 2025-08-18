New-Item HKCU:\System\GameConfigStor -Fo | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows\Explorer -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent -Force | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Fo | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Fo | Out-Null

Set-ItemProperty 'HKCU:\Control Panel\Mouse' -Name MouseSpeed -Value "0" -Fo
Set-ItemProperty 'HKCU:\Control Panel\Mouse' -Name MouseThreshold1 -Value "0" -Fo
Set-ItemProperty 'HKCU:\Control Panel\Mouse' -Name MouseThreshold2 -Value "0" -Fo
Set-ItemProperty HKCU:\System\GameConfigStor -Name GameDVR_Enabled -Value 0 -Fo
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Search BingSearchEnabled 1
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer HideRecommendedSection 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR AppCaptureEnabled 0
Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced LaunchTo 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer HideClock 1
Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search SearchBoxTaskbarMode 0
Set-ItemProperty HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableNotificationCenter 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced HideFileExt 0
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications ToastEnabled 0
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableConsumerFeatures 1
Set-ItemProperty HKLM:\Software\Policies\Microsoft\Windows\Explorer DisableSearchBoxSuggestions 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced TaskbarBadges 0
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced ShowStatusBar 0
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start HideRecommendedSection 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize AppsUseLightTheme 0
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced ShowTaskViewButton 0
Set-ItemProperty 'HKCU:\Control Panel\Desktop' Wallpaper $env:SystemRoot\Web\Wallpaper\Windows\img19.jpg
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education IsEducationEnvironment 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize SystemUsesLightTheme 0
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides UserSetting_DisableStartupSound 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel '{645FF040-5081-101B-9F08-00AA002F954E}' 1

Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk" -Fo
Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" -Fo
Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Fo
Rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge' -Fo
Rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView' -Fo
Rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update' -Fo
Rm 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}' -Fo
Rm 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}' -Fo
