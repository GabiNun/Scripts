$ErrorActionPreference = 'SilentlyContinue'
Get-Process | Where-Object { $_.Name -like '*edge*' } | Stop-Process -Force
Remove-Item -LiteralPath 'C:\Program Files (x86)\Microsoft' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\EdgeUpdate' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk' -Force
Remove-Item -LiteralPath "$env:LOCALAPPDATA\Microsoft\Edge" -Force -Recurse
Remove-Item -LiteralPath "$env:LOCALAPPDATA\Packages\Microsoft.MicrosoftEdge*" -Force -Recurse
Remove-Item -LiteralPath "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" -Force
Remove-Item -LiteralPath "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" -Force
Remove-Item -LiteralPath 'C:\Users\Public\Desktop\Microsoft Edge.lnk' -Force
