$ProgressPreference = 'SilentlyContinue'

irm https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x64.zip -Out PowerShell-7.5.4-win-x64.zip

Expand-Archive .\PowerShell-7.5.4-win-x64.zip 'C:\Program Files\PowerShell\7'

Remove-Item .\PowerShell-7.5.4-win-x64.zip
