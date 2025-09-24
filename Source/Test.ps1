Register-ScheduledTask -TaskName "Test" -Action (New-ScheduledTaskAction -Execute cmd)

Start-ScheduledTask -TaskName "Test"
