(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge').UninstallString + ' --force-uninstall'
Start-Process cmd.exe "/c $uninstallString" -WindowStyle Hidden
