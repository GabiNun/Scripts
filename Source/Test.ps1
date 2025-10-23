(New-Object -ComObject Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | 
    Where-Object {$_.Name -eq 'Microsoft Edge'} | 
    ForEach-Object {
        $_.Verbs() | 
        Where-Object {$_.Name.Replace('&', '') -match 'Unpin from taskbar'} | 
        ForEach-Object { $_.DoIt() }
    }

Get-Process *edge* | Stop-Process -Force

$edgePaths = @(
    "${env:ProgramFiles(x86)}\Microsoft\Edge"
    "${env:ProgramFiles(x86)}\Microsoft\EdgeUpdate"
    "${env:ProgramFiles(x86)}\Microsoft\EdgeCore"
    "$env:LOCALAPPDATA\Microsoft\Edge"
    "$env:PROGRAMDATA\Microsoft\EdgeUpdate"
    "$env:PUBLIC\Desktop\Microsoft Edge.lnk"
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
)

$edgeRegKeys = @(
    "HKCU:\Software\Microsoft\Edge"
    "HKLM:\SOFTWARE\Microsoft\Edge"
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge"
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate"
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
    "HKLM:\SOFTWARE\Classes\MSEdgeMHT"
    "HKLM:\SOFTWARE\Classes\MSEdgeHTM"
    "HKLM:\SOFTWARE\Classes\MSEdgePDF"
    "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components{9459C573-B17A-45AE-9F64-1857B5D58CEE}"
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{1FD49718-1D00-4B19-AF5F-070AF6D5D54C}"
)

$services = @(
    "edgeupdate"
    "edgeupdatem"
    "MicrosoftEdgeElevationService"
)

foreach ($path in $edgePaths) {
    if (Test-Path $path) {
        Remove-Item $path -Recurse -Force
    }
}

foreach ($key in $edgeRegKeys) {
    if (Test-Path $key) {
        Remove-Item $key -Recurse -Force
    }
}

foreach ($service in $services) {
    sc.exe delete $service | Out-Null
}

Unregister-ScheduledTask -TaskName "MicrosoftEdge*" -Confirm:$false
Remove-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "MicrosoftEdge*"
