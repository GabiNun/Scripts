winget source remove msstore
winget install glazewm
winget remove zebar
 
Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GlazeWM.lnk"
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "GlazeWM" -Value "C:\Program Files\glzr.io\GlazeWM\glazewm.exe"
 
$Config = irm 'pastebin.com/raw/zGgVsPFm'
 
New-Item "$Home\.glzr\glazewm\config.yaml" -Value $Config -Force
 
attrib +h  "$Home\.glzr"
 
& "C:\Program Files\glzr.io\GlazeWM\glazewm.exe"

Remove-Item "C:\Program Files (x86)\Microsoft.NET" -Recurse
Remove-Item "C:\ProgramData\Microsoft OneDrive" -Recurse
Remove-Item "$Env:LocalAppData\Temp\*" -Recurse -Force -ErrorAction 0
Remove-Item "$Env:AppData\Adobe" -Recurse
Remove-Item $Env:OneDrive -Recurse -Force
Remove-Item "$Home\Script.reg" -Force
Remove-Item "C:\Windows.old"

attrib +h "C:\inetpub"
attrib +h $Env:Public
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

Clear-RecycleBin -Force

attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off
