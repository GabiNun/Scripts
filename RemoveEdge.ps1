Get-Process | Where-Object { $_.Name -like '*edge*' } | Stop-Process -Force
Get-ChildItem C:\ -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*edge*' } | ForEach-Object { try { takeown /F "$($_.FullName)" /A | Out-Null; cmd /c "icacls `"$($_.FullName)`" /grant `"$env:USERNAME`":F" | Out-Null; Remove-Item "$($_.FullName)" -Force -Recurse | Out-Null } catch { } }
takeown /F "C:\Program Files\Internet Explorer" /R /D Y | Out-Null
icacls "C:\Program Files\Internet Explorer" /grant "$($env:USERNAME):(F)" /T | Out-Null
Remove-Item -Path "C:\Program Files\Internet Explorer" -Recurse -Force
