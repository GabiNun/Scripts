#  irm github.com/GabiNun/Scripts/raw/main/Source/Setup.ps1 | iex | Out-Null

winget source remove msstore
winget install fastfetch
New-Item -Force $PROFILE
"clear`nfastfetch" | Out-File -Append -FilePath $PROFILE
