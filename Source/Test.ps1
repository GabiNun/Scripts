Stop-Process -Name msedge,SearchHost,msedgewebview2,MicrosoftEdgeUpdate -Force -ea 0
Remove-Item -Recurse -Force "C:\Program Files (x86)\Microsoft"
