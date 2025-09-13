$ProgressPreference = 'SilentlyContinue'
irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Settings.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Defender.ps1 | iex
irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Packages.ps1 | iex
powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off
