Register-ScheduledTask -TaskName "Test" -Action (New-ScheduledTaskAction -Execute "cmd.exe") -Principal (New-ScheduledTaskPrincipal -UserId "SYSTEM" )

Start-ScheduledTask -TaskName "Test"
