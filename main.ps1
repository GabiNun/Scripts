irm github.com/GabiNun/Scripts/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Stop-Process -Name explorer;Remove-Item Script.reg
irm github.com/GabiNun/Scripts/raw/main/Settings.ps1 | iex | Out-Null
irm github.com/GabiNun/Scripts/raw/main/Packages.ps1 | iex | Out-Null
