irm github.com/GabiNun/Scripts/raw/main/Settings.reg -Out Script.reg;regedit /s Script.reg;Stop-Process -Name explorer;Remove-Item Script.reg
irm github.com/GabiNun/Scripts/raw/main/Settings.ps1 | iex | Out-Null
irm github.com/GabiNun/Scripts/raw/main/Packages.ps1 | iex | Out-Null
irm gist.github.com/GabiNun/68d843555f96dbd21d4d47ef23eff5ce/raw/Edge.ps1 | iex | Out-Null
