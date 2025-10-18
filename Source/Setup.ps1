winget source remove msstore
winget install fastfetch
winget install steam
winget install chrome

Set-ExecutionPolicy Bypass

$Content = irm pastebin.com/raw/Kh248grz
New-Item $Profile -Force -Value $Content

Remove-Item C:\Windows.old
Remove-Item $Env:Public\Desktop\*
Remove-Item $Env:OneDrive -Recurse -Force
Remove-Item $Env:AppData\Adobe -Recurse -Force
Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Steam" -Recurse

attrib +h "$Env:UserProfile\Saved Games"
attrib +h $Env:UserProfile\Favorites
attrib +h $Env:UserProfile\Documents
attrib +h $Env:UserProfile\Contacts
attrib +h $Env:UserProfile\Searches
attrib +h $Env:UserProfile\Pictures
attrib -h $Env:UserProfile\AppData
attrib +h $Env:UserProfile\Videos
attrib +h $Env:UserProfile\Music
attrib +h $Env:UserProfile\Links
attrib +h $Env:Public
attrib +h C:\inetpub

irm github.com/GabiNun/RemoveEdge/raw/main/ManualRemoval/Edge.exe -OutFile $Env:Tmp\Edge.exe
& $Env:Tmp\Edge.exe
