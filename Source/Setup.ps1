winget source remove msstore
winget install minecraft-launcher
winget install fastfetch
winget install steam
winget install chrome

Set-ExecutionPolicy Bypass

New-Item -Force $PROFILE -Value '
clear
flashfetch
$Host.UI.RawUI.ForegroundColor = "Blue"

function prompt {
    "[" + (Get-Location) + "] # "
}'
