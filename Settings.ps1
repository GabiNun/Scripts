winget source remove msstore
winget install glazewm
winget remove zebar
 
$Config = irm 'pastebin.com/raw/zGgVsPFm'
New-Item "$Home\.glzr\glazewm\config.yaml" -Value $Config -Force

Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GlazeWM.lnk"
Remove-Item "C:\Program Files (x86)\Microsoft.NET" -Recurse
Remove-Item "C:\ProgramData\Microsoft OneDrive" -Recurse
Remove-Item "$Env:LocalAppData\Temp\*" -Recurse -Force -ErrorAction 0
Remove-Item "$Env:AppData\Adobe" -Recurse
Remove-Item $Env:OneDrive -Recurse -Force
Remove-Item "$Home\Script.reg" -Force
Remove-Item "C:\Windows.old"

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Home\.glzr"
attrib +h "$Home\Videos"
attrib +h "$Home\Searches"
attrib +h "$Home\Saved Games"
attrib +h "$Home\Pictures"
attrib +h "$Home\Music"
attrib +h "$Home\Links"
attrib +h "$Home\Favorites"
attrib +h "$Home\Documents"
attrib +h "$Home\Contacts"
attrib -h "$Home\AppData"
attrib +h "C:\inetpub"
attrib +h $Env:Public

Clear-RecycleBin -Force

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off

($Settings = (Get-ItemProperty HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3).Settings)[8] = 3
Set-ItemProperty HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 Settings $Settings
