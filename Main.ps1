New-Item HKCU:\System\GameConfigStor -Fo | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows -Fo | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows\Explorer -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Fo | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Fo | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Fo | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings -Fo | Out-Null

Set-ItemProperty -Path HKCU:\System\GameConfigStor -Name GameDVR_Enabled -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Value 1 -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name HideRecommendedSection -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR -Name AppCaptureEnabled -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name HideClock -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Name DisableNotificationCenter -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications -Name ToastEnabled -Value 0 -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Name HideRecommendedSection -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Fo
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $env:SystemRoot\Web\Wallpaper\Windows\img19.jpg -Fo
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1 -Type DWord -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Name IsEducationEnvironment -Value 1 -Fo
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Fo
Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name TaskbarAl -Type DWord -Value 0 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Fo
Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -Type DWord -Value 1 -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Value 0 -Type DWord -Fo
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Name UserSetting_DisableStartupSound -Value 1 -Type DWord -Fo
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Value 1 -Fo

Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Fo
Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge'
Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView'
Remove-Item -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update'
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'

$ProgressPreference = 'SilentlyContinue'
& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
ps *edge*|spps -fo; gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0

$a = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -Command irm raw.githubusercontent.com/GabiNun/Scripts/main/Defender.ps1 | iex"
Register-ScheduledTask -TaskName 'Defender' -Action $a
$svc = New-Object -ComObject 'Schedule.Service'
$svc.Connect()
$user = 'NT SERVICE\TrustedInstaller'
$folder = $svc.GetFolder('\')
$task = $folder.GetTask('Defender')
$task.RunEx($null, 0, 0, $user)
