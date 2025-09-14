& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
spps -N *edge* -f;gci C:\ -r -fo -ea 0 -fi *edge*|ri -r -fo -ea 0
