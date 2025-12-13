$ProgressPreference = 'SilentlyContinue'

$Urls =
  'github.com/GabiNun/Scripts/raw/main/Source/Settings.ps1',
  'github.com/GabiNun/Scripts/raw/main/Source/Defender.ps1',
  'github.com/GabiNun/Scripts/raw/main/Source/Packages.ps1',
  'gist.github.com/GabiNun/68d843555f96dbd21d4d47ef23eff5ce/raw/Edge.ps1'

foreach ($Url in $Urls) {
    Start-Process powershell -WindowStyle Hidden -ArgumentList "-Command irm $Url | iex"
}
