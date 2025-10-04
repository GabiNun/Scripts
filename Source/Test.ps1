Register-ScheduledTask Defender -Ac (New-ScheduledTaskAction powershell "-C rm -r -fo 'C:\Program Files*\Windows Defender*',C:\WINDOWS\system32\SecurityHealthService.exe,C:\Windows\System32\SecurityHealthSystray.exe") | Out-Null

$svc = New-Object -ComObject 'Schedule.Service'
$svc.Connect()
$svc.GetFolder('\').GetTask('Defender').RunEx("", 0, 0, 'NT SERVICE\TrustedInstaller')
