Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "-c Get-AppxPackage *SecHealthUI | Remove-AppxPackage) -User 'NT SERVICE\TrustedInstaller'
Start-ScheduledTask Defender
