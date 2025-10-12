sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR AppCaptureEnabled 0
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -N HideRecommendedSection -V 1 -f | Out-Null
ni HKCU:\Software\Policies\Microsoft\Windows\Explorer -N DisableNotificationCenter -V 1 -f | Out-Null
ni HKCU:\Software\Policies\Microsoft\Windows\Explorer -N DisableSearchBoxSuggestions -V 1 -f | Out-Null
ni HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start -N HideRecommendedSection -V 1 -f | Out-Null
ni HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education -N IsEducationEnvironment -V 1 -f | Out-Null
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate -N ExcludeWUDriversInQualityUpdate -V 1 -f | Out-Null
ni HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -N '{645FF040-5081-101B-9F08-00AA002F954E}' -V 1 -f | Out-Null
