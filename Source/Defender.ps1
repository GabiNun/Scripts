Register-ScheduledTask -TaskName TestTask -Action (New-ScheduledTaskAction -Execute powershell -Argument "-Command rm -r -fo 'C:\Program Files*\Windows Defender*'") | Out-Null
$o=New-Object -Com 'Schedule.Service';$o.Connect();$o.GetFolder('\').GetTask('Defender').RunEx($null,0,0,'NT SERVICE\TrustedInstaller')|Out-Null

$store = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore';$appx = Get-AppxPackage *SecHealthUI
$sids = @('S-1-5-18') + (gci $store -ea 0 | % PSChildName | ?{ $_ -like 'S-1-5-21*' });$sids | % { ni "$store\EndOfLife\$_\$($appx.PackageFullName)" -Fo | Out-Null };$appx | Remove-AppxPackage
