Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\EdgeUpdate\ClientState\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}' -Name 'experiment_control_labels'

New-Item -Path 'HKLM:\SOFTWARE\Microsoft\EdgeUpdateDev'
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\EdgeUpdateDev' -Name 'AllowUninstall' -Value '1'

(Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge').UninstallString + ' --force-uninstall'
