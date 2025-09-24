Register-ScheduledTask -TaskName Test -Action (New-ScheduledTaskAction -Execute powershell -Argument "-Command rm -r -fo 'C:\Program Files*\Windows Defender*',C:\WINDOWS\system32\SecurityHealthService.exe,C:\Windows\System32\SecurityHealthSystray.exe") -Principal (New-ScheduledTaskPrincipal -UserId "SYSTEM" )

Start-ScheduledTask -TaskName "Test"
