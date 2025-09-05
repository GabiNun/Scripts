"HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education",
"HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start",
"HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer",
"HKCU:\Software\Policies\Microsoft\Windows\Explorer" | % { ni $_ | Out-Null }

sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR AppCaptureEnabled 0
sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer HideRecommendedSection 1
sp HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableNotificationCenter 1
sp HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableSearchBoxSuggestions 1
sp HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start HideRecommendedSection 1
sp HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education IsEducationEnvironment 1
sp HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel '{645FF040-5081-101B-9F08-00AA002F954E}' 1

"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk",
"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility",
"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" | % { if(Test-Path $_){rm $_ -Recurse -Force} }

rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge'
