Set-ExecutionPolicy Bypass

winget source remove msstore
winget install fastfetch

New-Item -Force $PROFILE -Value 'clear
flashfetch
$Host.UI.RawUI.ForegroundColor = "Blue"

function prompt {
    "[" + (Get-Location) + "] # "
}'
