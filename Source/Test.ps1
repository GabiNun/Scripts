$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath
    New-Item -Path $RegPath\DisallowRun
}

New-ItemProperty -Path "$RegPath\DisallowRun" -Name 1 -Value "msedge.exe"
New-ItemProperty -Path "$RegPath" -Name "DisallowRun" -Value 1 -PropertyType DWord
