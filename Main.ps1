$ProgressPreference = 'SilentlyContinue'
& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall
Get-AppxPackage|?{!$_.NonRemovable}|Remove-AppxPackage -ea 0
ps *edge*|spps -fo; gci C:\ -r -fo -ea 0 | ? Name -match 'edge' | ri -r -fo -ea 0
Register-ScheduledTask -TaskName 'Defender' -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command `"irm 'https://raw.githubusercontent.com/GabiNun/Scripts/main/Defender.ps1' | iex`"") -Force; $svc=New-Object -ComObject 'Schedule.Service'; $svc.Connect(); $svc.GetFolder('\').GetTask('Defender').RunEx($null,0,0,'NT SERVICE\TrustedInstaller')
$store = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore'; $appx = Get-AppxPackage -Name Microsoft.SecHealthUI; $sids = @('S-1-5-18'); $sids += Get-ChildItem $store -ea 0 | % { $_.PSChildName } | ? { $_.StartsWith('S-1-5-21') }; New-Item -Path "$store\Deprovisioned\$($appx.PackageFamilyName)" -ItemType RegistryKey -Force | Out-Null; foreach ($sid in $sids) { New-Item -Path "$store\EndOfLife\$sid\$($appx.PackageFullName)" -ItemType RegistryKey -Force | Out-Null }; $appx | Remove-AppxPackage
