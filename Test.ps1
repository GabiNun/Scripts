$keys = @(
    "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education",
    "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer",
    "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
)
$keys | ForEach-Object { ni $_ | Out-Null }

$values = @{
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" = @{ AppCaptureEnabled = 0 }
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" = @{ HideRecommendedSection = 1 }
    "HKCU:\Software\Policies\Microsoft\Windows\Explorer" = @{
        DisableNotificationCenter = 1
        DisableSearchBoxSuggestions = 1
    }
    "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" = @{ HideRecommendedSection = 1 }
    "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" = @{ IsEducationEnvironment = 1 }
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" = @{ '{645FF040-5081-101B-9F08-00AA002F954E}' = 1 }
}
foreach ($path in $values.Keys) { foreach ($name in $values[$path].Keys) { sp $path $name $values[$path][$name] } }

$files = @(
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Accessibility"
)
$files | ForEach-Object { if (Test-Path $_) { rm $_ -Recurse -Force } }

rm 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge'
