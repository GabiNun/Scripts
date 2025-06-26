[Environment]::SetEnvironmentVariable("Path", "D:\Things\Items\Things\Compilers\tcc;D:\Things\Items\Things\Compilers\gcc\bin;D:\Things\Items\Things\java\jdk-24\bin;D:\Things\Items\Things\Winget;D:\Things\Items\Things\Compilers\Rust\bin;" + [Environment]::GetEnvironmentVariable("Path", "Machine"), "Machine")
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value ((Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb) -Force; Set-ExecutionPolicy Bypass -Scope LocalMachine -Force
Remove-Item "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" -ErrorAction SilentlyContinue; icacls "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger" /deny SYSTEM:`(OI`)`(CI`)F | Out-Null
iwr "https://raw.githubusercontent.com/GabiNun/Scripts/main/file.reg" -OutFile "$env:TEMP\file.reg"; iwr "https://raw.githubusercontent.com/GabiNun/Scripts/main/file.ps1" -OutFile "$env:TEMP\file.ps1"; reg import "$env:TEMP\file.reg"; & "$env:TEMP\file.ps1"
iwr https://aka.ms/vs/17/release/vc_redist.x64.exe -OutFile $env:TEMP\v.exe; Start-Process $env:TEMP\v.exe -Args '/install','/quiet' -Wait
[Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')
$ErrorActionPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'

Get-WindowsCapability -Online | ? { $_.State -eq 'Installed' -and $_.Name -notmatch 'Ethernet|WiFi|Notepad' } | ForEach-Object -Parallel { Remove-WindowsCapability -Online -Name $_.Name | Out-Null }
Get-WindowsOptionalFeature -Online | ? State -eq Enabled | ForEach-Object -Parallel { try { Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -Remove -NoRestart | Out-Null } catch {} }
Get-AppxPackage -AllUsers | Where-Object { !$_.IsFramework -and $_.SignatureKind -ne 'System' -and !$_.NonRemovable } | ForEach-Object -Parallel { Remove-AppxPackage -Package $_.PackageFullName -AllUsers }
"Program Files","Program Files (x86)"|%{Get-ChildItem "C:\$_" -Dir -Force|?{$_.Name -ne "WindowsApps"}|%{$f=$_.FullName;Get-CimInstance Win32_Process|?{$_.CommandLine -and $_.CommandLine.Contains($f)}|%{Stop-Process -Id $_.ProcessId -Force};takeown /F $f /R /D Y >$null 2>&1;icacls $f /grant Administrators:F /T /C >$null 2>&1;Remove-Item $f -Recurse -Force}}

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
Remove-Item "$env:USERPROFILE\Contacts" -Recurse -Force
Remove-Item "$env:USERPROFILE\Documents" -Recurse -Force
Remove-Item "$env:USERPROFILE\Links" -Recurse -Force
Remove-Item "$env:USERPROFILE\Music" -Recurse -Force
Remove-Item "$env:USERPROFILE\Videos" -Recurse -Force
Remove-Item "$env:PUBLIC\Desktop\Microsoft Edge.lnk" -Force

attrib +h +s "$env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h +s "$env:LocalAppData\PlaceholderTileLogoFolder"
attrib +h +s "$env:LocalAppData\ConnectedDevicesPlatform"
attrib +h +s "$env:LocalAppData\VirtualStore"
attrib +h +s "$env:LocalAppData\Publishers"
attrib +h +s "$env:LocalAppData\D3DSCache"
attrib +h +s "$env:LocalAppData\Comms" | Out-Null
attrib +h +s "$env:USERPROFILE\Pictures"
attrib +h +s "$env:USERPROFILE\Searches"
attrib +h +s "$env:USERPROFILE\Favorites"
attrib -h "$env:USERPROFILE\AppData"
attrib +h +s "$env:PUBLIC"

pnputil /add-driver "D:\Things\Items\Things\Store\Drivers\Intel Serial IO\*.inf" /install | Out-Null
pnputil /add-driver "D:\Things\Items\Things\Store\Drivers\Intel ChipSet\*.inf" /install | Out-Null
RoboCopy "D:\Things\Thorium\Locales\User Data" "$env:LOCALAPPDATA\Thorium\User Data" /E | Out-Null
regsvr32 /s "D:\Things\Items\Things\7-Zip\7-zip.dll"
Rename-Computer -NewName 'Gabi' -Force
tzutil /s "Israel Standard Time"
control.exe "mmsys.cpl,,2f"