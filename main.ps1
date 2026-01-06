irm github.com/GabiNun/Scripts/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Stop-Process -Name explorer;Remove-Item Script.reg
irm github.com/GabiNun/Scripts/raw/main/Settings.ps1 | iex | Out-Null
irm github.com/GabiNun/Scripts/raw/main/Packages.ps1 | iex | Out-Null
irm https://gist.github.com/GabiNun/9a55a4317a33916c8d40e9a8b7c360ea/raw/Edge.ps1 | iex | Out-Null
