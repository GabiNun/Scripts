$ProgressPreference = 'SilentlyContinue'

$Commands =
  'irm github.com/GabiNun/Scripts/raw/main/Source/Settings.ps1 | iex',
  'irm github.com/GabiNun/Scripts/raw/main/Source/Defender.ps1 | iex',
  'irm github.com/GabiNun/Scripts/raw/main/Source/Packages.ps1 | iex',
  'irm github.com/GabiNun/Scripts/raw/main/Source/FuckEdge.ps1 | iex',
  'irm github.com/GabiNun/Scripts/raw/main/Source/Services.ps1 | iex'

foreach ($Command in $Commands) {
    Start-Process powershell -WindowStyle Hidden -ArgumentList "-Command $Command"
}
