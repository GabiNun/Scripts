ni HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education | Out-Null
ni HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start | Out-Null
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer | Out-Null
ni HKCU:\Software\Policies\Microsoft\Windows\Explorer | Out-Null

Set-ItemProperty HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableNotificationCenter 1
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education IsEducationEnvironment 1
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start HideRecommendedSection 1
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer HideRecommendedSection 1
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel '{645FF040-5081-101B-9F08-00AA002F954E}' 1

rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk" -Fo
rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" -Fo
rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Fo
rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge' -Fo
