irm https://gist.github.com/GabiNun/c576d453134e73868d535f52bcf5d120/raw/RemoveEdge.ps1 | iex

Get-Process *Edge*,SearchHost | Stop-Process -Force
Remove-Item "$Env:ProgramFiles (x86)\Microsoft" -Recurse -Force
sc.exe delete edgeupdate  | Out-Null
sc.exe delete edgeupdatem | Out-Null
Unregister-ScheduledTask *Edge* -Confirm:$false

$Appx = (Get-AppxPackage *EdgeDevToolsClient).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force;Remove-AppxPackage $Appx
