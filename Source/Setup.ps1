winget source remove msstore
winget install fastfetch
winget install steam
winget install chrome

Set-ExecutionPolicy Bypass
New-Item -Force $PROFILE -Value '
clear
flashfetch
$Host.UI.RawUI.ForegroundColor = "Blue"

function prompt {
    "[" + (Get-Location) + "] # "
}'

Remove-Item C:\Windows.old
Remove-Item $Env:OneDrive
Remove-Item $Env:AppData\Adobe

attrib +h "$Env:UserProfile\Saved Games"
attrib +h $Env:UserProfile\Favorites
attrib +h $Env:UserProfile\Documents
attrib +h $Env:UserProfile\Contacts
attrib +h $Env:UserProfile\Pictures
attrib -h $Env:UserProfile\AppData
attrib +h $Env:UserProfile\Videos
attrib +h $Env:UserProfile\Music
attrib +h $Env:UserProfile\Links
attrib +h $Env:Public
attrib +h C:\inetpub
