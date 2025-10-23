Get-Process *edge* | Stop-Process -Force

$edgePaths = @(
    "$env:LOCALAPPDATA\Microsoft\Edge",
    "${env:ProgramFiles(x86)}\Microsoft\Edge",
    "${env:ProgramFiles(x86)}\Microsoft\EdgeUpdate",
    "${env:ProgramFiles(x86)}\Microsoft\EdgeCore",
    "$env:PROGRAMDATA\Microsoft\EdgeUpdate",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk",
    "$env:PUBLIC\Desktop\Microsoft Edge.lnk"
)

$edgeRegKeys = @(
    "HKCU:\Software\Microsoft\Edge",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe",
    "HKLM:\SOFTWARE\Microsoft\Edge",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
)

$services = @(
    "edgeupdate",
    "edgeupdatem",
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

Stop-Process -Name explorer

$edgeProgIds = @(
    "MSEdgeHTM",
    "MSEdgePDF",
    "MSEdgeMHT"
)

foreach ($progId in $edgeProgIds) {
    $paths = @(
        "HKLM:\SOFTWARE\Classes\$progId",
        "HKLM:\SOFTWARE\Wow6432Node\Classes\$progId",
        "HKCU:\SOFTWARE\Classes\$progId"
    )

    foreach ($path in $paths) {
        if (Test-Path $path) {
            Write-Host "$path exists"
        } else {
            Write-Host "$path does not exist"
        }
    }
}
