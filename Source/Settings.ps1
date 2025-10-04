ni $env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe -F | Out-Null
ni HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education | Out-Null
ni HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start | Out-Null
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate | Out-Null
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer | Out-Null
ni HKCU:\Software\Policies\Microsoft\Windows\Explorer | Out-Null

sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR AppCaptureEnabled 0
sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer HideRecommendedSection 1
sp HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableNotificationCenter 1
sp HKCU:\Software\Policies\Microsoft\Windows\Explorer DisableSearchBoxSuggestions 1
sp HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start HideRecommendedSection 1
sp HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education IsEducationEnvironment 1
sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate ExcludeWUDriversInQualityUpdate 1
sp HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel '{645FF040-5081-101B-9F08-00AA002F954E}' 1

attrib +h "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off
