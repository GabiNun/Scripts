$ProgressPreference = 'SilentlyContinue'
Measure-Command { irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Settings.ps1 | iex }
Measure-Command { irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Defender.ps1 | iex }
Measure-Command { irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Packages.ps1 | iex }
