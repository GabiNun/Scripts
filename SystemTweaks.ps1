Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value ((Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb) -Force
Remove-Item "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" -ErrorAction SilentlyContinue; icacls "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger" /deny SYSTEM:`(OI`)`(CI`)F | Out-Null
Curl https://raw.githubusercontent.com/GabiNun/Scripts/main/file.reg -OutFile $env:TEMP\file.reg; Curl https://raw.githubusercontent.com/GabiNun/Scripts/main/file.ps1 -OutFile $env:TEMP\file.ps1
[Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')
$ErrorActionPreference = 'SilentlyContinue'

@(
  "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
  "Microsoft\Windows\Autochk\Proxy",
  "Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
  "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
  "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector",
  "Microsoft\Windows\Feedback\Siuf\DmClient",
  "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload",
  "Microsoft\Windows\Windows Error Reporting\QueueReporting",
  "Microsoft\Windows\Application Experience\MareBackup",
  "Microsoft\Windows\Application Experience\StartupAppTask",
  "Microsoft\Windows\Application Experience\PcaPatchDbTask",
  "Microsoft\Windows\Maps\MapsUpdateTask"
) | ForEach-Object {
  schtasks /Change /TN $_ /Disable | Out-Null
}

reg import $env:TEMP\file.reg

Start-Job -ScriptBlock { Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online } | Wait-Job
Start-Job -ScriptBlock { Get-AppxPackage -AllUsers | Where SignatureKind -ne 'System' | ForEach { Remove-AppxPackage -Package $_.PackageFullName -AllUsers } } | Wait-Job
Start-Job -ScriptBlock {
  Get-WindowsOptionalFeature -Online | Where State -eq Enabled | ForEach {
    try { Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -Remove -NoRestart } catch {}
  }
} | Wait-Job
Start-Job -ScriptBlock {
  Get-WindowsCapability -Online | Where-Object { $_.State -eq 'Installed' -and $_.Name -notmatch 'Ethernet|WiFi|Notepad' } | ForEach-Object {
    Remove-WindowsCapability -Online -Name $_.Name
  }
} | Wait-Job

"Program Files","Program Files (x86)"|%{
  Get-ChildItem "C:\$_" -Dir -Force|%{
    $f=$_.FullName
    Get-CimInstance Win32_Process|?{ $_.CommandLine -and $_.CommandLine.Contains($f) }|%{Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue}
    takeown /F $f /R /D Y >$null 2>&1;icacls $f /grant Administrators:F /T /C >$null 2>&1;Remove-Item $f -Recurse -Force -ErrorAction SilentlyContinue
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
Remove-Item "$env:USERPROFILE\Saved Games" -Recurse -Forc
Remove-Item "$env:AppData\Adobe" -Recurse -Force
Remove-Item "$env:LocalAppData\Packages\*" -Recurse -Force
Remove-Item "$env:LocalAppData\Temp\*" -Recurse -Force
Remove-Item "$env:USERPROFILE\Contacts" -Recurse -Force
Remove-Item "$env:USERPROFILE\Documents" -Recurse -Force
Remove-Item "$env:USERPROFILE\Favorites" -Recurse -Force
Remove-Item "$env:USERPROFILE\Links" -Recurse -Force
Remove-Item "$env:USERPROFILE\Music" -Recurse -Force
Remove-Item "$env:USERPROFILE\Pictures" -Recurse -Force
Remove-Item "$env:USERPROFILE\Searches" -Recurse -Force
Remove-Item "$env:USERPROFILE\Videos" -Recurse -Force
Remove-Item "$env:PUBLIC\Desktop\Microsoft Edge.lnk" -Force

attrib +h +s "$env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h +s "$env:LocalAppData\PlaceholderTileLogoFolder"
attrib +h +s "$env:LocalAppData\ConnectedDevicesPlatform"
attrib +h +s "$env:LocalAppData\VirtualStore"
attrib +h +s "$env:LocalAppData\Publishers"
attrib +h +s "$env:LocalAppData\D3DSCache"
attrib +h +s "$env:LocalAppData\Comms" *> $null
attrib +h +s "$env:USERPROFILE\Desktop"
attrib -h "$env:USERPROFILE\AppData"
attrib +h +s "$env:PUBLIC"

Rename-Computer -NewName 'Gabi' -Force *> $null
tzutil /s "Israel Standard Time"
