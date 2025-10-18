#  irm github.com/GabiNun/Scripts/raw/main/Source/Setup.ps1 | iex | Out-Null
Set-ExecutionPolicy 0

winget source remove msstore
winget install fastfetch

New-Item -Force $PROFILE -Value "clear`nfastfetch"
