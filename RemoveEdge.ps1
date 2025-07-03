Get-Process | Where-Object { $_.Name -like '*edge*' } | Stop-Process -Force

$matches = Get-ChildItem -Path C:\ -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'edge' }
foreach ($item in $matches) {
    takeown /F $item.FullName /R /D Y | Out-Null
    icacls $item.FullName /grant "$($env:USERNAME):(F)" /T | Out-Null
    Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
}

takeown /F "C:\Program Files\Internet Explorer" /R /D Y | Out-Null
icacls "C:\Program Files\Internet Explorer" /grant "$($env:USERNAME):(F)" /T | Out-Null
Remove-Item -Path "C:\Program Files\Internet Explorer" -Recurse -Force
