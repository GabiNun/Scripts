winget source remove msstore
winget install fastfetch

Set-ExecutionPolicy Bypass

New-Item -Force $PROFILE -Value 'clear
flashfetch
$Host.UI.RawUI.ForegroundColor = "Blue"

function prompt {
    "[" + (Get-Location) + "] # "
}'
