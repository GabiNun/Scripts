$RegPath = HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer

New-Item -Path "$RegPath" -Force

New-Item -Path "$RegPath\DisallowRun" -Force

New-ItemProperty -Path "$RegPath\DisallowRun" -Name 1 -Value "msedge.exe" -Force

New-ItemProperty -Path "$RegPath" -Name "DisallowRun" -Value 1 -PropertyType DWord -Force
