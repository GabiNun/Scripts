$ProgressPreference = 'SilentlyContinue'

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off

irm github.com/GabiNun/Scripts/raw/main/Script.reg -Out Script.reg;regedit /s Script.reg

irm github.com/GabiNun/Scripts/raw/main/Packages.ps1 | iex | Out-Null

irm gist.github.com/GabiNun/68d843555f96dbd21d4d47ef23eff5ce/raw/Edge.ps1 | iex | Out-Null

irm pastebin.com/raw/vfJ061e2 | iex | Out-Null
irm pastebin.com/raw/wxwgM97h | iex | Out-Null
