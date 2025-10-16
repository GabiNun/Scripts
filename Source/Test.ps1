irm gist.github.com/GabiNun/53d72fc294b5da4c1c3199b0fbf264f3/raw/Defender.reg -OutFile $Env:Temp\Defender.reg

Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell 'regedit.exe /s $Env:Temp\Defender.reg') -U 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender
