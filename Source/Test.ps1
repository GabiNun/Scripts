Stop-Process -Force -Name msedge,SearchHost,msedgewebview2,MicrosoftEdgeUpdate
Remove-Item -Recurse -Force "C:\Program Files (x86)\Microsoft"
Remove-Item "C:\Users\Public\Desktop\Microsoft Edge.lnk"
Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
