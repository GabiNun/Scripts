Stop-Process -Name -Force -ea 0 msedge,SearchHost,msedgewebview2,MicrosoftEdgeUpdate
Remove-Item -Recurse -Force "C:\Program Files (x86)\Microsoft"
