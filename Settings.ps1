winget source remove msstore
winget install glazewm
winget remove zebar
 
New-Item .glzr\glazewm\config.yaml -Value (irm 'https://pastebin.com/raw/zGgVsPFm') -Force

Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GlazeWM.lnk"
Remove-Item "$Home\OneDrive","C:\Windows.old","Script.reg" -Recurse -Force
Remove-Item "C:\Program Files (x86)\Microsoft.NET" -Recurse
Remove-Item "C:\ProgramData\Microsoft OneDrive" -Recurse


attrib +h "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
attrib +h "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h $Env:Public
attrib +h "Saved Games"
attrib +h C:\inetpub
attrib +h .glzr
attrib +h Videos
attrib +h Searches
attrib +h Pictures
attrib +h Music
attrib +h Links
attrib +h Favorites
attrib +h Documents
attrib +h Contacts
attrib -h AppData

Set-ExecutionPolicy Unrestricted -Force

powercfg /setactive SCHEME_MIN;powercfg /change monitor-timeout-ac 60;powercfg /h off

[System.Environment]::SetEnvironmentVariable('Path', 'C:\Windows;C:\Windows\System32', 'Machine')
[System.Environment]::SetEnvironmentVariable('OneDrive', $null, 'User')
