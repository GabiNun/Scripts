Register-ScheduledTask Test -Action (New-ScheduledTaskAction cmd) -User SYSTEM -RunLevel Highest

Start-ScheduledTask Test
