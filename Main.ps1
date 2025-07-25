$ProgressPreference = 'SilentlyContinue'
irm raw.githubusercontent.com/GabiNun/FireWall/main/Apply.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/RegEdit.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/RemoveApps.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/RemoveDefender.ps1.ps1 | iex
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c;powercfg /change monitor-timeout-ac 60
