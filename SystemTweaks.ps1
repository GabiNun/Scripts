if(-not ([bool](net session 2>$null))){Start-Process powershell -Verb runAs -Args "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -NoExit"; exit}
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
  schtasks /Change /TN $_ /Disable *> $null
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

$regs = @(
  @{ Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; Values=@{ EnableActivityFeed=0; PublishUserActivities=0; UploadUserActivities=0 } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"; Values=@{ AllowTelemetry=0 } }
  @{ Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"; Values=@{ AllowTelemetry=0; DoNotShowFeedbackNotifications=1 } }
  @{ Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"; Values=@{ DisabledByGroupPolicy=1 } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting"; Values=@{ Disabled=1 } }
  @{ Path="HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"; Values=@{ DisableTailoredExperiencesWithDiagnosticData=1 } }
  @{ Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"; Values=@{ DisableWindowsConsumerFeatures=1 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; Values=@{
      ContentDeliveryAllowed=0; OemPreInstalledAppsEnabled=0; PreInstalledAppsEnabled=0; PreInstalledAppsEverEnabled=0;
      SilentInstalledAppsEnabled=0; 'SubscribedContent-338387Enabled'=0; 'SubscribedContent-338388Enabled'=0;
      'SubscribedContent-338389Enabled'=0; 'SubscribedContent-353698Enabled'=0; SystemPaneSuggestionsEnabled=0 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Siuf\Rules"; Values=@{ NumberOfSIUFInPeriod=0 } }
  @{ Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"; Values=@{ AllowGameDVR=0 } }
  @{ Path="HKCU:\System\GameConfigStore"; Values=@{ GameDVR_Enabled=0; GameDVR_FSEBehavior=2; GameDVR_HonorUserFSEBehaviorMode=1; GameDVR_EFSEFeatureFlags=0 } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"; Values=@{ Value="Deny" } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"; Values=@{ SensorPermissionState=0 } }
  @{ Path="HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"; Values=@{ Status=0 } }
  @{ Path="HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"; Values=@{ Value=0 } }
  @{ Path="HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"; Values=@{ Value=0 } }
  @{ Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"; Values=@{ NoAutoUpdate=1; AUOptions=1 } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"; Values=@{ DODownloadMode=0 } }
  @{ Path="HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"; Values=@{ LongPathsEnabled=1 } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"; Values=@{ SystemResponsiveness=0; NetworkThrottlingIndex=4294967295 } }
  @{ Path="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; Values=@{ ClearPageFileAtShutdown=0 } }
  @{ Path="HKLM:\SYSTEM\ControlSet001\Services\Ndu"; Values=@{ Start=4 } }
  @{ Path="HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"; Values=@{ IRPStackSize=30 } }
  @{ Path="HKCU:\Software\Policies\Microsoft\Windows\Explorer"; Values=@{ DisableNotificationCenter=1 } }
  @{ Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications"; Values=@{ ToastEnabled=0 } }
  @{ Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Values=@{ BingSearchEnabled=0; SearchboxTaskbarMode=1 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Values=@{
      ShowTaskViewButton=0; LaunchTo=1; HideFileExt=0; TaskbarAl=0; EnableSnapAssistFlyout=0; SnapAssist=0 } }
  @{ Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"; Values=@{ TaskbarEndTask=1 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"; Values=@{ PeopleBand=0 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager"; Values=@{ EnthusiastMode=1 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"; Values=@{ AppsUseLightTheme=0; SystemUsesLightTheme=0 } }
  @{ Path="HKCU:\Control Panel\Desktop"; Values=@{ MenuShowDelay="1"; AutoEndTasks="1"; WindowArrangementActive=0 } }
  @{ Path="HKCU:\Control Panel\Accessibility\StickyKeys"; Values=@{ Flags="506" } }
  @{ Path="HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"; Values=@{ EnableFeeds=0 } }
  @{ Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; Values=@{ HideSCAMeetNow=1 } }
  @{ Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement"; Values=@{ ScoobeSystemSettingEnabled=0 } }
  @{ Path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"; Values=@{ "01"=0 } }
  @{ Path="HKLM:\SYSTEM\Maps"; Values=@{ AutoUpdateEnabled=0 } }
  @{ Path="HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance"; Values=@{ fAllowToGetHelp=0 } }
  @{ Path="HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"; Values=@{ SearchOrderConfig=1 } }
)

foreach ($item in $regs) {
  New-Item -Path $item.Path -Force | Out-Null
  foreach ($name in $item.Values.Keys) {
    $value = $item.Values[$name]
    $type = if ($value -is [int]) { "DWord" } else { "String" }
    Set-ItemProperty -Path $item.Path -Name $name -Value $value -Type $type -Force | Out-Null
  }
}

Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -Force
Remove-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Edge" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Edge" -Recurse -Force
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Edge" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\EdgeUpdate" -Recurse -Force
Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\EdgeUpdate" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge" -Recurse -Force
Remove-Item -Path "HKCU:\Software\Microsoft\MicrosoftEdge" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge" -Recurse -Force
Stop-Process -Name msedge -Force

dism /online /Get-Features | ? {$_ -like "Feature Name*"} | % {
    $f = ($_ -replace "Feature Name : ", "").Trim()
    if ($f) { dism /online /Disable-Feature /FeatureName:$f /NoRestart *> $null }
}

Get-WindowsCapability -Online |
Where-Object { $_.State -eq 'Installed' -and $_.Name -notmatch 'Ethernet|WiFi|Notepad' } |
ForEach-Object {
    Start-Job { param($cap) Remove-WindowsCapability -Online -Name $cap } -ArgumentList $_.Name | Out-Null
}

Get-AppxProvisionedPackage -Online | Remove-AppxProvisionedPackage -Online
Get-AppxPackage -AllUsers | Where SignatureKind -ne 'System' | ForEach { Remove-AppxPackage -Package $_.PackageFullName -AllUsers }

$roots = @($env:ProgramFiles, ${env:ProgramFiles(x86)}) | Where-Object { Test-Path $_ }
foreach ($r in $roots) {
    Get-ChildItem $r -Directory | ForEach-Object {
        takeown.exe /F $_.FullName /R /D Y > $null 2>&1
        icacls.exe $_.FullName /grant Administrators:F /T /C > $null 2>&1
        Remove-Item $_.FullName -Recurse -Force > $null 2>&1
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

attrib +h +s "$env:LocalAppData\PlaceholderTileLogoFolder"
attrib +h +s "$env:LocalAppData\ConnectedDevicesPlatform"
attrib +h +s "$env:LocalAppData\VirtualStore"
attrib +h +s "$env:LocalAppData\Publishers"
attrib +h +s "$env:LocalAppData\D3DSCache"
attrib +h +s "$env:LocalAppData\Comms" *> $null
attrib +h +s "$env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +h +s "$env:USERPROFILE\Desktop"
attrib -h "$env:USERPROFILE\AppData"
attrib +h +s "$env:PUBLIC"

pnputil /add-driver "D:\Things\Items\Things\Store\Drivers\Intel Serial IO\*.inf" /install *> $null
pnputil /add-driver "D:\Things\Items\Things\Store\Drivers\Intel ChipSet\*.inf" /install *> $null
Rename-Computer -NewName 'Gabi' -Force *> $null
tzutil /s "Israel Standard Time"
