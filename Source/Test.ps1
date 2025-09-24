Register-ScheduledTask Test -Action (New-ScheduledTaskAction cmd)

Start-ScheduledTask Test
