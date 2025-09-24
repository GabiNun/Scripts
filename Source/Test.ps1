Register-ScheduledTask -TaskName "Test" -Action (New-ScheduledTaskAction -Execute "C:\Windows\System32\cmd.exe") -Principal (New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest)

Start-ScheduledTask -TaskName "Test"
