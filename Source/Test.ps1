(Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge').UninstallString + ' --force-uninstall'
Start-Process cmd.exe "/c $uninstallString" -WindowStyle Hidden
