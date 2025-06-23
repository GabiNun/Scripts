Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value ((Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb) -Force
Remove-Item "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" -ErrorAction SilentlyContinue; icacls "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger" /deny SYSTEM:`(OI`)`(CI`)F | Out-Null
Curl https://raw.githubusercontent.com/GabiNun/Scripts/main/file.reg -OutFile $env:TEMP\file.reg; Curl https://raw.githubusercontent.com/GabiNun/Scripts/main/file.ps1 -OutFile $env:TEMP\file.ps1
[Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')
powershell -ExecutionPolicy Bypass -File "$env:TEMP\file.ps1"
$ErrorActionPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
reg import $env:TEMP\file.reg | Out-Null

Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online | Out-Null
Get-AppxPackage -AllUsers | Where SignatureKind -ne 'System' | ForEach { Remove-AppxPackage -Package $_.PackageFullName -AllUsers | Out-Null }
Get-WindowsOptionalFeature -Online | Where State -eq Enabled | ForEach{try{Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -Remove -NoRestart | Out-Null }catch{}}
Get-WindowsCapability -Online | Where-Object { $_.State -eq 'Installed' -and $_.Name -notmatch 'Ethernet|WiFi|Notepad' } | ForEach-Object { Remove-WindowsCapability -Online -Name $_.Name | Out-Null }

"Program Files","Program Files (x86)"|%{
  Get-ChildItem "C:\$_" -Dir -Force|%{
    $f=$_.FullName
    Get-CimInstance Win32_Process|?{ $_.CommandLine -and $_.CommandLine.Contains($f) }|%{Stop-Process -Id $_.ProcessId -Force}
    takeown /F $f /R /D Y >$null 2>&1;icacls $f /grant Administrators:F /T /C >$null 2>&1;Remove-Item $f -Recurse -Force
  }
}


Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait
Remove-Item "$env:UserProfile\OneDrive" -Recurse -Force
Remove-Item "$env:LocalAppData\Microsoft\OneDrive" -Recurse -Force
Remove-Item "$env:ProgramData\Microsoft OneDrive" -Recurse -Force
Remove-Item "$env:ProgramData\Microsoft\EdgeUpdate" -Recurse -Force
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" -Force
Remove-Item "$env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk" -Force
Remove-Item "$env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk" -Force
Remove-Item "$env:LocalAppData\Programs" -Recurse -Force
Remove-Item "$env:USERPROFILE\Saved Games" -Recurse -Force
Remove-Item "$env:AppData\Adobe" -Recurse -Force
Remove-Item "$env:LocalAppData\Packages\*" -Recurse -Force
Remove-Item "$env:LocalAppData\Temp\*" -Recurse -Force
Remove-Item "$env:USERPROFILE\Contacts" -Recurse -Force
Remove-Item "$env:USERPROFILE\Documents" -Recurse -Force
Remove-Item "$env:USERPROFILE\Links" -Recurse -Force
Remove-Item "$env:USERPROFILE\Music" -Recurse -Force
Remove-Item "$env:USERPROFILE\Searches" -Recurse -Force
Remove-Item "$env:USERPROFILE\Videos" -Recurse -Force
Remove-Item "$env:PUBLIC\Desktop\Microsoft Edge.lnk" -Force
gci "$env:LocalAppData\Microsoft" -Force | ? Name -ne 'Windows' | % { ri $_.FullName -r -fo -ea 0 }
gci "$env:AppData\Microsoft" -Force | ? Name -ne 'Windows' | % { ri $_.FullName -r -fo -ea 0 }

attrib +h +s "$env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h +s "$env:LocalAppData\PlaceholderTileLogoFolder"
attrib +h +s "$env:LocalAppData\ConnectedDevicesPlatform"
attrib +h +s "$env:LocalAppData\VirtualStore"
attrib +h +s "$env:LocalAppData\Publishers"
attrib +h +s "$env:LocalAppData\D3DSCache"
attrib +h +s "$env:LocalAppData\Comms" | Out-Null
attrib +h +s "$env:USERPROFILE\Pictures"
attrib +h +s "$env:USERPROFILE\Favorites"
attrib -h "$env:USERPROFILE\AppData"
attrib +h +s "$env:PUBLIC"

Rename-Computer -NewName 'Gabi' -Force | Out-Null
tzutil /s "Israel Standard Time"
