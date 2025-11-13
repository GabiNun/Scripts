New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education
New-Item HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer
New-Item HKCU:\Software\Policies\Microsoft\Windows\Explorer

Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR AppCaptureEnabled 0
Set-ItemProperty HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableNotificationCenter 1
Set-ItemProperty HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableSearchBoxSuggestions 1

Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer HideRecommendedSection 1
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start HideRecommendedSection 1
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education IsEducationEnvironment 1

attrib +h "$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off
