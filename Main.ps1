New-Item HKCU:\System\GameConfigStor -Force | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows -Force | Out-Null
New-Item HKCU:\Software\Policies\Microsoft\Windows\Explorer -Force | Out-Null
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Force | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Force | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Force | Out-Null
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Force | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Force | Out-Null
New-Item HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings -Force | Out-Null

Set-ItemProperty -Path HKCU:\System\GameConfigStor -Name GameDVR_Enabled -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Value 1 -Force
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name HideRecommendedSection -Value 1 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR -Name AppCaptureEnabled -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name HideClock -Value 1 -Force
Set-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Name DisableNotificationCenter -Value 1 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications -Name ToastEnabled -Value 0 -Force
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -Name HideRecommendedSection -Value 1 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Force
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $env:SystemRoot\Web\Wallpaper\Windows\img19.jpg -Force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1 -Type DWord -Force
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -Name IsEducationEnvironment -Value 1 -Force
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Force
Set-ItemProperty -Path HKCU:\software\microsoft\windows\currentversion\explorer\advanced -Name TaskbarAl -Type DWord -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Force
Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -Type DWord -Value 1 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Value 0 -Type DWord -Force
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\EditionOverrides -Name UserSetting_DisableStartupSound -Value 1 -Type DWord -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Value 1 -Force

Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}' -Force
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}' -Force

$ProgressPreference = 'SilentlyContinue'
& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage | ? {!$_.IsFramework -and !$_.NonRemovable} | Remove-AppxPackage
irm https://raw.githubusercontent.com/ionuttbara/windows-defender-remover/refs/heads/main/RemoveSecHealthApp.ps1 | iex *>$null
Start-Process powershell -WindowStyle Hidden -ArgumentList 'iex "&{$(irm https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1)} -UninstallEdge -RemoveEdgeData"'

Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk" -Force
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Force
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" -Force
