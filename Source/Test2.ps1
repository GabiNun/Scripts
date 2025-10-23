$ErrorActionPreference = "SilentlyContinue"

$edgeProgIds = @(
    "MSEdgeHTM",
    "MSEdgePDF",
    "MSEdgeMHT"
)

$edgeAppIds = @("MSEdge", "Microsoft Edge")

$protocols = @("http", "https", "ftp", "mailto", "news", "nntp", "snews", "telnet", "wais", "file", "ms-help", "ms-settings", "microsoft-edge")

$fileAssociations = @(".htm", ".html", ".pdf", ".shtml", ".svg", ".webp", ".xht", ".xhtml", ".mht", ".mhtml")

Get-Process -Name "msedge", "MicrosoftEdge*", "edge*" | Stop-Process -Force
Start-Sleep -Seconds 2

foreach ($progId in $edgeProgIds) {
    Remove-Item "HKLM:\SOFTWARE\Classes\$progId" -Recurse -Force
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Classes\$progId" -Recurse -Force
    Remove-Item "HKCU:\SOFTWARE\Classes\$progId" -Recurse -Force
}

Get-ChildItem "HKLM:\SOFTWARE\Clients\StartMenuInternet" | Where-Object { $_.PSChildName -like "*Edge*" } | Remove-Item -Recurse -Force
Get-ChildItem "HKCU:\SOFTWARE\Clients\StartMenuInternet" | Where-Object { $_.PSChildName -like "*Edge*" } | Remove-Item -Recurse -Force

foreach ($protocol in $protocols) {
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Classes\$protocol\shell\open\command").'(default)' -like "*msedge*") {
        Remove-Item "HKLM:\SOFTWARE\Classes\$protocol\shell\open" -Recurse -Force
    }
    if ((Get-ItemProperty "HKCU:\SOFTWARE\Classes\$protocol\shell\open\command").'(default)' -like "*msedge*") {
        Remove-Item "HKCU:\SOFTWARE\Classes\$protocol\shell\open" -Recurse -Force
    }
}

foreach ($ext in $fileAssociations) {
    Remove-ItemProperty "HKLM:\SOFTWARE\Classes\$ext" -Name "(default)" -Force
    Remove-ItemProperty "HKCU:\SOFTWARE\Classes\$ext" -Name "(default)" -Force
    foreach ($progId in $edgeProgIds) {
        Remove-ItemProperty "HKLM:\SOFTWARE\Classes\$ext\OpenWithProgids" -Name $progId -Force
        Remove-ItemProperty "HKCU:\SOFTWARE\Classes\$ext\OpenWithProgids" -Name $progId -Force
    }
}

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" -Recurse -Force
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" -Recurse -Force

Get-ItemProperty "HKLM:\SOFTWARE\RegisteredApplications" | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -like "*Edge*" } | ForEach-Object { Remove-ItemProperty "HKLM:\SOFTWARE\RegisteredApplications" -Name $_.Name -Force }

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Capabilities" | Where-Object { $_.PSChildName -like "*Edge*" } | Remove-Item -Recurse -Force

Remove-ItemProperty "HKLM:\SOFTWARE\Clients\StartMenuInternet" -Name "(default)" -Force
Remove-Item "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -Force
Remove-Item "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate" -Recurse -Force
Remove-Item "HKCU:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -Force
