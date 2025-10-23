Write-Host "Terminating Edge processes..." -ForegroundColor Cyan
Get-Process | Where-Object { $_.Name -like "*edge*" } | Stop-Process -Force -ErrorAction SilentlyContinue

Write-Host "Cleaning Edge folders..." -ForegroundColor Cyan
$edgePaths = @(
    "$env:LOCALAPPDATA\Microsoft\Edge",
    "$env:PROGRAMFILES\Microsoft\Edge",
    "${env:ProgramFiles(x86)}\Microsoft\Edge",
    "${env:ProgramFiles(x86)}\Microsoft\EdgeUpdate",
    "${env:ProgramFiles(x86)}\Microsoft\EdgeCore",
    "$env:LOCALAPPDATA\Microsoft\EdgeUpdate",
    "$env:PROGRAMDATA\Microsoft\EdgeUpdate",
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk",
    "$env:PUBLIC\Desktop\Microsoft Edge.lnk"
)

foreach ($path in $edgePaths) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $path" -ForegroundColor Cyan
        takeown /F $path /R /D Y | Out-Null
        icacls $path /grant administrators:F /T | Out-Null
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Cleaning Edge registry entries..." -ForegroundColor Cyan
$edgeRegKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update",
    "HKLM:\SOFTWARE\Microsoft\EdgeUpdate",
    "HKCU:\Software\Microsoft\Edge",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeUpdate",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeUpdate",
    "HKLM:\SOFTWARE\Microsoft\Edge",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
)

foreach ($key in $edgeRegKeys) {
    if (Test-Path $key) {
        Write-Host "Deleting registry key: $key" -ForegroundColor Cyan
        Remove-Item -Path $key -Recurse -Force -ErrorAction SilentlyContinue
    }
}

$services = @(
    "edgeupdate",
    "edgeupdatem",
    "MicrosoftEdgeElevationService"
)

foreach ($service in $services) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    sc.exe delete $service
}

Stop-Process -Name explorer
