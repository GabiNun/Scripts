Register-ScheduledTask Test -Action (New-ScheduledTaskAction cmd) -User SYSTEM

Start-ScheduledTask Test
