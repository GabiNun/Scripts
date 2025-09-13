$ProgressPreference = 'SilentlyContinue'
irm raw.githubusercontent.com/GabiNun/Scripts/main/Settings.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/Defender.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/RemoveApps.ps1 | iex
powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off
