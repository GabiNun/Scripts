Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value ((Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb) -Force
Remove-Item "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" -ErrorAction SilentlyContinue; icacls "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger" /deny SYSTEM:`(OI`)`(CI`)F | Out-Null
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

$serviceGroups = @{
    "Automatic" = @(
        "AudioEndpointBuilder", "AudioSrv", "BFE", "BrokerInfrastructure", "BthAvctpSvc", "CoreMessagingRegistrar",
        "CryptSvc", "DPS", "DcomLaunch", "Dhcp", "Dnscache", "DusmSvc", "EventLog", "EventSystem",
        "FontCache", "IKEEXT", "KeyIso", "LSM", "LanmanWorkstation", "MpsSvc", "Netlogon", "Power",
        "ProfSvc", "RpcEptMapper", "RpcSs", "SamSs", "Schedule", "SENS", "ShellHWDetection",
        "Spooler", "SystemEventsBroker", "TermService", "Themes", "TrkWks", "UserManager",
        "VaultSvc", "Wcmsvc", "WinDefend", "Winmgmt", "WlanSvc"
    )
    "Manual" = @(
        "ALG", "AppIDSvc", "AppMgmt", "AppReadiness", "AppXSvc", "Appinfo", "AssignedAccessManagerSvc",
        "AxInstSV", "BDESVC", "Browser", "CDPSvc", "COMSysApp", "CertPropSvc", "ClipSVC", "CscService",
        "DevQueryBroker", "DeviceAssociationService", "DeviceInstall", "DisplayEnhancementService",
        "DmEnrollmentSvc", "DsSvc", "DsmSvc", "EFS", "EapHost", "EntAppSvc", "FDResPub", "FrameServer",
        "FrameServerMonitor", "GraphicsPerfSvc", "HvHost", "InstallService", "InventorySvc",
        "IpxlatCfgSvc", "KtmRm", "LicenseManager", "LxpSvc", "MSDTC", "MSiSCSI", "McpManagementService",
        "MicrosoftEdgeElevationService", "MsKeyboardFilter", "NaturalAuthentication", "NcaSvc",
        "NcbService", "NcdAutoSetup", "NetSetupSvc", "Netman", "NgcCtnrSvc", "NgcSvc", "NlaSvc",
        "PcaSvc", "PeerDistSvc", "PerfHost", "PhoneSvc", "PlugPlay", "PolicyAgent", "PrintNotify",
        "PushToInstall", "QWAVE", "RasAuto", "RasMan", "RemoteAccess", "RemoteRegistry", "RetailDemo",
        "RmSvc", "RpcLocator", "SCPolicySvc", "SCardSvr", "SDRSVC", "SEMgrSvc", "SNMPTRAP", "SSDPSRV",
        "ScDeviceEnum", "SecurityHealthService", "Sense", "SensorDataService", "SensorService",
        "SensrSvc", "SessionEnv", "SharedAccess", "SmsRouter", "SstpSvc", "StateRepository", "StiSvc",
        "StorSvc", "TapiSrv", "TextInputManagementService", "TieringEngineService", "TimeBrokerSvc",
        "TokenBroker", "TroubleshootingSvc", "TrustedInstaller", "UmRdpService", "UsoSvc", "VSS",
        "W32Time", "WEPHOSTSVC", "WFDSConMgrSvc", "WManSvc", "WPDBusEnum", "WaaSMedicSvc",
        "WalletService", "WarpJITSvc", "WbioSrvc", "WdiServiceHost", "WdiSystemHost", "WebClient",
        "Wecsvc", "WerSvc", "WiaRpc", "WinHttpAutoProxySvc", "WinRM", "WpcMonSvc", "WpnService",
        "XblAuthManager", "XblGameSave", "XboxGipSvc", "XboxNetApiSvc", "autotimesvc", "bthserv",
        "camsvc", "cloudidsvc", "dcsvc", "defragsvc", "diagsvc", "dmwappushservice", "dot3svc",
        "embeddedmode", "fdPHost", "fhsvc", "hidserv", "icssvc", "lfsvc", "lltdsvc", "lmhosts",
        "msiserver", "netprofm", "perceptionsimulation", "pla", "seclogon", "smphost", "svsvc",
        "swprv", "upnphost", "vds", "vmicguestinterface", "vmicheartbeat", "vmickvpexchange",
        "vmicrdv", "vmicshutdown", "vmictimesync", "vmicvmsession", "vmicvss", "wbengine", "wcncsvc",
        "webthreatdefsvc", "wuauserv", "wercplsupport", "wisvc", "wlidsvc", "wlpasvc", "wmiApSrv"
    )
    "Disabled" = @(
        "AppVClient", "DiagTrack", "DialogBlockingService", "RemoteAccess",
        "RemoteRegistry", "UevAgentService", "shpamsvc", "tzautoupdate"
    )
    "DelayedAuto" = @(
        "BITS", "wscsvc", "sppsvc", "WSearch", "DoSvc"
    )
}

foreach ($startupType in $serviceGroups.Keys) {
    foreach ($service in $serviceGroups[$startupType]) {
        try {
            if ($startupType -eq "DelayedAuto") {
                sc.exe config $service start= delayed-auto *> $null
            } else {
                Set-Service -Name $service -StartupType $startupType -ErrorAction Stop
            }
        } catch {}
    }
}

$wildcards = @(
    "BcastDVRUserService_*", "BluetoothUserService_*", "CDPUserSvc_*", "CaptureService_*",
    "ConsentUxUserSvc_*", "CredentialEnrollmentManagerUserSvc_*", "DeviceAssociationBrokerSvc_*",
    "DevicePickerUserSvc_*", "DevicesFlowUserSvc_*", "MessagingService_*", "NPSMSvc_*",
    "P9RdrService_*", "PenService_*", "PimIndexMaintenanceSvc_*", "PrintWorkflowUserSvc_*",
    "UdkUserSvc_*", "UnistoreSvc_*", "UserDataSvc_*", "WpnUserService_*", "cbdhsvc_*",
    "webthreatdefusersvc_*"
)

foreach ($pattern in $wildcards) {
    Get-Service -Name $pattern -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            if ($_.ServiceType -notlike "*UserService*") {
                Set-Service -InputObject $_ -StartupType Manual
            }
        } catch {}
    }
}

New-Item -Path "HKCU:\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -Force
New-Item -Path "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Force
New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -PropertyType DWORD -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Value 2 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Type String -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\Ndu" -Name "Start" -Value 4 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Value 30 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseSpeed -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold1 -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold2 -Value 0 -Force | Out-Null
set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name EnableSnapAssistFlyout -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name SnapAssist -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WindowArrangementActive -Value 0 -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name Flags -Value 58 -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Config\Microsoft.MicrosoftEdge.Stable_8wekyb3d8bbwe" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Config\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Config\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge" -Recurse -Force | Out-Null
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" -Recurse -Force | Out-Null
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\RegisteredApplications" -Name "Microsoft Edge" -Force | Out-Null
Remove-ItemProperty -Path "HKLM:\SOFTWARE\RegisteredApplications" -Name "Microsoft Edge" -Force | Out-Null
Remove-Item -Path "HKCU:\Software\Microsoft\EdgeUpdate" -Recurse -Force | Out-Null
Remove-Item -Path "HKCU:\Software\Microsoft\Edge" -Recurse -Force | Out-Null

Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online
Get-AppxPackage -AllUsers | Where SignatureKind -ne 'System' | ForEach { Remove-AppxPackage -Package $_.PackageFullName -AllUsers }
Get-WindowsOptionalFeature -Online | Where State -eq Enabled | ForEach{try{Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -Remove -NoRestart}catch{}}
Get-WindowsCapability -Online | Where-Object { $_.State -eq 'Installed' -and $_.Name -notmatch 'Ethernet|WiFi|Notepad' } | ForEach-Object { Remove-WindowsCapability -Online -Name $_.Name }

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
