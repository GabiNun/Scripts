Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel '{645FF040-5081-101B-9F08-00AA002F954E}' 1

Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk" -Fo
Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" -Fo
Rm "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Fo
Rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge' -Fo
