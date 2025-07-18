Remove-Item -Path 'SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate'
Set-Location "C:\Program Files (x86)\Microsoft\Edge\Application\1*\Installer" ; .\setup.exe -uninstall -system-level -verbose-logging -force-uninstal
