winget source remove msstore
winget install minecraft
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

attrib +h C:\inetpub
attrib +h C:\Users\Public
attrib -h C:\Users\Gabi\AppData
attrib +h "C:\Users\Gabi\Saved Games"
attrib +h C:\Users\Gabi\Videos
attrib +h C:\Users\Gabi\Pictures
attrib +h C:\Users\Gabi\Music
attrib +h C:\Users\Gabi\Links
attrib +h C:\Users\Gabi\Favorites
attrib +h C:\Users\Gabi\Documents
attrib +h C:\Users\Gabi\Contacts
