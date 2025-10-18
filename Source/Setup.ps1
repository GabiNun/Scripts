winget source remove msstore
winget install fastfetch
New-Item -Force $PROFILE
"clear`nfastfetch" | Out-File -Append -FilePath $PROFILE
