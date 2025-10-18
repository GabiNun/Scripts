winget source remove msstore
wiget install fastfetch
New-Item -Force $PROFILE
"clear`nfastfetch" | Out-File -Append -FilePath $PROFILE
