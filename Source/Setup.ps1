irm github.com/GabiNun/Scripts/raw/main/Source/Setup.ps1 | iex | Out-Null
Set-ExecutionPolicy Bypass

winget source remove msstore
winget install fastfetch

New-Item -Force $PROFILE -Value 'clear
flashfetch
$Host.UI.RawUI.ForegroundColor = "Blue"

function prompt {
    "[" + (Get-Location) + "] # "
}'
