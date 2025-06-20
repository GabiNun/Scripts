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

Set-Service -Name "ALG" -StartupType "Manual" *> $null
Set-Service -Name "AppIDSvc" -StartupType "Manual" *> $null
Set-Service -Name "AppMgmt" -StartupType "Manual" *> $null
Set-Service -Name "AppReadiness" -StartupType "Manual" *> $null
Set-Service -Name "AppVClient" -StartupType "Disabled" *> $null
Set-Service -Name "AppXSvc" -StartupType "Manual" *> $null
Set-Service -Name "Appinfo" -StartupType "Manual" *> $null
Set-Service -Name "AssignedAccessManagerSvc" -StartupType "Disabled" *> $null
Set-Service -Name "AudioEndpointBuilder" -StartupType "Automatic" *> $null
Set-Service -Name "AudioSrv" -StartupType "Automatic" *> $null
Set-Service -Name "AxInstSV" -StartupType "Manual" *> $null
Set-Service -Name "BDESVC" -StartupType "Manual" *> $null
Set-Service -Name "BFE" -StartupType "Automatic" *> $null
Set-Service -Name "BTAGService" -StartupType "Manual" *> $null
Get-Service -Name "BcastDVRUserService_*" | Set-Service -StartupType "Manual" *> $null
Get-Service -Name "BluetoothUserService_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "BrokerInfrastructure" -StartupType "Automatic" *> $null
Set-Service -Name "Browser" -StartupType "Manual" *> $null
Set-Service -Name "BthAvctpSvc" -StartupType "Automatic" *> $null
Set-Service -Name "CDPSvc" -StartupType "Manual" *> $null
Get-Service -Name "CDPUserSvc_*" | Set-Service -StartupType "Automatic" *> $null
Set-Service -Name "COMSysApp" -StartupType "Manual" *> $null
Get-Service -Name "CaptureService_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "CertPropSvc" -StartupType "Manual" *> $null
Set-Service -Name "ClipSVC" -StartupType "Manual" *> $null
Get-Service -Name "ConsentUxUserSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "CoreMessagingRegistrar" -StartupType "Automatic" *> $null
Get-Service -Name "CredentialEnrollmentManagerUserSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "CryptSvc" -StartupType "Automatic" *> $null
Set-Service -Name "CscService" -StartupType "Manual" *> $null
Set-Service -Name "DPS" -StartupType "Automatic" *> $null
Set-Service -Name "DcomLaunch" -StartupType "Automatic" *> $null
Set-Service -Name "DevQueryBroker" -StartupType "Manual" *> $null
Get-Service -Name "DeviceAssociationBrokerSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "DeviceAssociationService" -StartupType "Manual" *> $null
Set-Service -Name "DeviceInstall" -StartupType "Manual" *> $null
Get-Service -Name "DevicePickerUserSvc_*" | Set-Service -StartupType "Manual" *> $null
Get-Service -Name "DevicesFlowUserSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "Dhcp" -StartupType "Automatic" *> $null
Set-Service -Name "DiagTrack" -StartupType "Disabled" *> $null
Set-Service -Name "DialogBlockingService" -StartupType "Disabled" *> $null
Set-Service -Name "DispBrokerDesktopSvc" -StartupType "Automatic" *> $null
Set-Service -Name "DisplayEnhancementService" -StartupType "Manual" *> $null
Set-Service -Name "DmEnrollmentSvc" -StartupType "Manual" *> $null
Set-Service -Name "Dnscache" -StartupType "Automatic" *> $null
Set-Service -Name "DsSvc" -StartupType "Manual" *> $null
Set-Service -Name "DsmSvc" -StartupType "Manual" *> $null
Set-Service -Name "DusmSvc" -StartupType "Automatic" *> $null
Set-Service -Name "EFS" -StartupType "Manual" *> $null
Set-Service -Name "EapHost" -StartupType "Manual" *> $null
Set-Service -Name "EntAppSvc" -StartupType "Manual" *> $null
Set-Service -Name "EventLog" -StartupType "Automatic" *> $null
Set-Service -Name "EventSystem" -StartupType "Automatic" *> $null
Set-Service -Name "FDResPub" -StartupType "Manual" *> $null
Set-Service -Name "FontCache" -StartupType "Automatic" *> $null
Set-Service -Name "FrameServer" -StartupType "Manual" *> $null
Set-Service -Name "FrameServerMonitor" -StartupType "Manual" *> $null
Set-Service -Name "GraphicsPerfSvc" -StartupType "Manual" *> $null
Set-Service -Name "HvHost" -StartupType "Manual" *> $null
Set-Service -Name "IKEEXT" -StartupType "Manual" *> $null
Set-Service -Name "InstallService" -StartupType "Manual" *> $null
Set-Service -Name "InventorySvc" -StartupType "Manual" *> $null
Set-Service -Name "IpxlatCfgSvc" -StartupType "Manual" *> $null
Set-Service -Name "KeyIso" -StartupType "Automatic" *> $null
Set-Service -Name "KtmRm" -StartupType "Manual" *> $null
Set-Service -Name "LSM" -StartupType "Automatic" *> $null
Set-Service -Name "LanmanWorkstation" -StartupType "Automatic" *> $null
Set-Service -Name "LicenseManager" -StartupType "Manual" *> $null
Set-Service -Name "LxpSvc" -StartupType "Manual" *> $null
Set-Service -Name "MSDTC" -StartupType "Manual" *> $null
Set-Service -Name "MSiSCSI" -StartupType "Manual" *> $null
Set-Service -Name "McpManagementService" -StartupType "Manual" *> $null
Get-Service -Name "MessagingService_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "MicrosoftEdgeElevationService" -StartupType "Manual" *> $null
Set-Service -Name "MpsSvc" -StartupType "Automatic" *> $null
Set-Service -Name "MsKeyboardFilter" -StartupType "Manual" *> $null
Get-Service -Name "NPSMSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "NaturalAuthentication" -StartupType "Manual" *> $null
Set-Service -Name "NcaSvc" -StartupType "Manual" *> $null
Set-Service -Name "NcbService" -StartupType "Manual" *> $null
Set-Service -Name "NcdAutoSetup" -StartupType "Manual" *> $null
Set-Service -Name "NetSetupSvc" -StartupType "Manual" *> $null
Set-Service -Name "Netlogon" -StartupType "Automatic" *> $null
Set-Service -Name "Netman" -StartupType "Manual" *> $null
Set-Service -Name "NgcCtnrSvc" -StartupType "Manual" *> $null
Set-Service -Name "NgcSvc" -StartupType "Manual" *> $null
Set-Service -Name "NlaSvc" -StartupType "Manual" *> $null
Get-Service -Name "P9RdrService_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "PcaSvc" -StartupType "Manual" *> $null
Set-Service -Name "PeerDistSvc" -StartupType "Manual" *> $null
Get-Service -Name "PenService_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "PerfHost" -StartupType "Manual" *> $null
Set-Service -Name "PhoneSvc" -StartupType "Manual" *> $null
Get-Service -Name "PimIndexMaintenanceSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "PlugPlay" -StartupType "Manual" *> $null
Set-Service -Name "PolicyAgent" -StartupType "Manual" *> $null
Set-Service -Name "Power" -StartupType "Automatic" *> $null
Set-Service -Name "PrintNotify" -StartupType "Manual" *> $null
Get-Service -Name "PrintWorkflowUserSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "ProfSvc" -StartupType "Automatic" *> $null
Set-Service -Name "PushToInstall" -StartupType "Manual" *> $null
Set-Service -Name "QWAVE" -StartupType "Manual" *> $null
Set-Service -Name "RasAuto" -StartupType "Manual" *> $null
Set-Service -Name "RasMan" -StartupType "Manual" *> $null
Set-Service -Name "RemoteAccess" -StartupType "Disabled" *> $null
Set-Service -Name "RemoteRegistry" -StartupType "Disabled" *> $null
Set-Service -Name "RetailDemo" -StartupType "Manual" *> $null
Set-Service -Name "RmSvc" -StartupType "Manual" *> $null
Set-Service -Name "RpcEptMapper" -StartupType "Automatic" *> $null
Set-Service -Name "RpcLocator" -StartupType "Manual" *> $null
Set-Service -Name "RpcSs" -StartupType "Automatic" *> $null
Set-Service -Name "SCPolicySvc" -StartupType "Manual" *> $null
Set-Service -Name "SCardSvr" -StartupType "Manual" *> $null
Set-Service -Name "SDRSVC" -StartupType "Manual" *> $null
Set-Service -Name "SEMgrSvc" -StartupType "Manual" *> $null
Set-Service -Name "SENS" -StartupType "Automatic" *> $null
Set-Service -Name "SNMPTRAP" -StartupType "Manual" *> $null
Set-Service -Name "SSDPSRV" -StartupType "Manual" *> $null
Set-Service -Name "SamSs" -StartupType "Automatic" *> $null
Set-Service -Name "ScDeviceEnum" -StartupType "Manual" *> $null
Set-Service -Name "Schedule" -StartupType "Automatic" *> $null
Set-Service -Name "SecurityHealthService" -StartupType "Manual" *> $null
Set-Service -Name "Sense" -StartupType "Manual" *> $null
Set-Service -Name "SensorDataService" -StartupType "Manual" *> $null
Set-Service -Name "SensorService" -StartupType "Manual" *> $null
Set-Service -Name "SensrSvc" -StartupType "Manual" *> $null
Set-Service -Name "SessionEnv" -StartupType "Manual" *> $null
Set-Service -Name "SgrmBroker" -StartupType "Automatic" *> $null
Set-Service -Name "SharedAccess" -StartupType "Manual" *> $null
Set-Service -Name "ShellHWDetection" -StartupType "Automatic" *> $null
Set-Service -Name "SmsRouter" -StartupType "Manual" *> $null
Set-Service -Name "Spooler" -StartupType "Automatic" *> $null
Set-Service -Name "SstpSvc" -StartupType "Manual" *> $null
Set-Service -Name "StateRepository" -StartupType "Manual" *> $null
Set-Service -Name "StiSvc" -StartupType "Manual" *> $null
Set-Service -Name "StorSvc" -StartupType "Manual" *> $null
Set-Service -Name "SysMain" -StartupType "Automatic" *> $null
Set-Service -Name "SystemEventsBroker" -StartupType "Automatic" *> $null
Set-Service -Name "TapiSrv" -StartupType "Manual" *> $null
Set-Service -Name "TermService" -StartupType "Automatic" *> $null
Set-Service -Name "TextInputManagementService" -StartupType "Manual" *> $null
Set-Service -Name "Themes" -StartupType "Automatic" *> $null
Set-Service -Name "TieringEngineService" -StartupType "Manual" *> $null
Set-Service -Name "TimeBrokerSvc" -StartupType "Manual" *> $null
Set-Service -Name "TokenBroker" -StartupType "Manual" *> $null
Set-Service -Name "TrkWks" -StartupType "Automatic" *> $null
Set-Service -Name "TroubleshootingSvc" -StartupType "Manual" *> $null
Set-Service -Name "TrustedInstaller" -StartupType "Manual" *> $null
Get-Service -Name "UdkUserSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "UevAgentService" -StartupType "Disabled" *> $null
Set-Service -Name "UmRdpService" -StartupType "Manual" *> $null
Get-Service -Name "UnistoreSvc_*" | Set-Service -StartupType "Manual" *> $null
Get-Service -Name "UserDataSvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "UserManager" -StartupType "Automatic" *> $null
Set-Service -Name "UsoSvc" -StartupType "Manual" *> $null
Set-Service -Name "VSS" -StartupType "Manual" *> $null
Set-Service -Name "VaultSvc" -StartupType "Automatic" *> $null
Set-Service -Name "W32Time" -StartupType "Manual" *> $null
Set-Service -Name "WEPHOSTSVC" -StartupType "Manual" *> $null
Set-Service -Name "WFDSConMgrSvc" -StartupType "Manual" *> $null
Set-Service -Name "WManSvc" -StartupType "Manual" *> $null
Set-Service -Name "WPDBusEnum" -StartupType "Manual" *> $null
Set-Service -Name "WaaSMedicSvc" -StartupType "Manual" *> $null
Set-Service -Name "WalletService" -StartupType "Manual" *> $null
Set-Service -Name "WarpJITSvc" -StartupType "Manual" *> $null
Set-Service -Name "WbioSrvc" -StartupType "Manual" *> $null
Set-Service -Name "Wcmsvc" -StartupType "Automatic" *> $null
Set-Service -Name "WdNisSvc" -StartupType "Manual" *> $null
Set-Service -Name "WdiServiceHost" -StartupType "Manual" *> $null
Set-Service -Name "WdiSystemHost" -StartupType "Manual" *> $null
Set-Service -Name "WebClient" -StartupType "Manual" *> $null
Set-Service -Name "Wecsvc" -StartupType "Manual" *> $null
Set-Service -Name "WerSvc" -StartupType "Manual" *> $null
Set-Service -Name "WiaRpc" -StartupType "Manual" *> $null
Set-Service -Name "WinDefend" -StartupType "Automatic" *> $null
Set-Service -Name "WinHttpAutoProxySvc" -StartupType "Manual" *> $null
Set-Service -Name "WinRM" -StartupType "Manual" *> $null
Set-Service -Name "Winmgmt" -StartupType "Automatic" *> $null
Set-Service -Name "WlanSvc" -StartupType "Automatic" *> $null
Set-Service -Name "WpcMonSvc" -StartupType "Manual" *> $null
Set-Service -Name "WpnService" -StartupType "Manual" *> $null
Get-Service -Name "WpnUserService_*" | Set-Service -StartupType "Automatic" *> $null
Set-Service -Name "XblAuthManager" -StartupType "Manual" *> $null
Set-Service -Name "XblGameSave" -StartupType "Manual" *> $null
Set-Service -Name "XboxGipSvc" -StartupType "Manual" *> $null
Set-Service -Name "XboxNetApiSvc" -StartupType "Manual" *> $null
Set-Service -Name "autotimesvc" -StartupType "Manual" *> $null
Set-Service -Name "bthserv" -StartupType "Manual" *> $null
Set-Service -Name "camsvc" -StartupType "Manual" *> $null
Get-Service -Name "cbdhsvc_*" | Set-Service -StartupType "Manual" *> $null
Set-Service -Name "cloudidsvc" -StartupType "Manual" *> $null
Set-Service -Name "dcsvc" -StartupType "Manual" *> $null
Set-Service -Name "defragsvc" -StartupType "Manual" *> $null
Set-Service -Name "diagsvc" -StartupType "Manual" *> $null
Set-Service -Name "dmwappushservice" -StartupType "Manual" *> $null
Set-Service -Name "dot3svc" -StartupType "Manual" *> $null
Set-Service -Name "edgeupdate" -StartupType "Manual" -ErrorAction SilentlyContinue *> $null
Set-Service -Name "edgeupdatem" -StartupType "Manual" -ErrorAction SilentlyContinue *> $null
Set-Service -Name "embeddedmode" -StartupType "Manual" *> $null
Set-Service -Name "fdPHost" -StartupType "Manual" *> $null
Set-Service -Name "fhsvc" -StartupType "Manual" *> $null
Set-Service -Name "gpsvc" -StartupType "Automatic" *> $null
Set-Service -Name "hidserv" -StartupType "Manual" *> $null
Set-Service -Name "icssvc" -StartupType "Manual" *> $null
Set-Service -Name "iphlpsvc" -StartupType "Automatic" *> $null
Set-Service -Name "lfsvc" -StartupType "Manual" *> $null
Set-Service -Name "lltdsvc" -StartupType "Manual" *> $null
Set-Service -Name "lmhosts" -StartupType "Manual" *> $null
Set-Service -Name "mpssvc" -StartupType "Automatic" *> $null
Set-Service -Name "msiserver" -StartupType "Manual" *> $null
Set-Service -Name "netprofm" -StartupType "Manual" *> $null
Set-Service -Name "nsi" -StartupType "Automatic" *> $null
Set-Service -Name "perceptionsimulation" -StartupType "Manual" *> $null
Set-Service -Name "pla" -StartupType "Manual" *> $null
Set-Service -Name "seclogon" -StartupType "Manual" *> $null
Set-Service -Name "shpamsvc" -StartupType "Disabled" *> $null
Set-Service -Name "smphost" -StartupType "Manual" *> $null
Set-Service -Name "svsvc" -StartupType "Manual" *> $null
Set-Service -Name "swprv" -StartupType "Manual" *> $null
Set-Service -Name "tzautoupdate" -StartupType "Disabled" *> $null
Set-Service -Name "upnphost" -StartupType "Manual" *> $null
Set-Service -Name "vds" -StartupType "Manual" *> $null
Set-Service -Name "vmicguestinterface" -StartupType "Manual" *> $null
Set-Service -Name "vmicheartbeat" -StartupType "Manual" *> $null
Set-Service -Name "vmickvpexchange" -StartupType "Manual" *> $null
Set-Service -Name "vmicrdv" -StartupType "Manual" *> $null
Set-Service -Name "vmicshutdown" -StartupType "Manual" *> $null
Set-Service -Name "vmictimesync" -StartupType "Manual" *> $null
Set-Service -Name "vmicvmsession" -StartupType "Manual" *> $null
Set-Service -Name "vmicvss" -StartupType "Manual" *> $null
Set-Service -Name "wbengine" -StartupType "Manual" *> $null
Set-Service -Name "wcncsvc" -StartupType "Manual" *> $null
Set-Service -Name "webthreatdefsvc" -StartupType "Manual" *> $null
Get-Service -Name "webthreatdefusersvc_*" | Set-Service -StartupType "Automatic" *> $null
Set-Service -Name "wuauserv" -StartupType "Manual" *> $null
Set-Service -Name "wercplsupport" -StartupType "Manual" *> $null
Set-Service -Name "wisvc" -StartupType "Manual" *> $null
Set-Service -Name "wlidsvc" -StartupType "Manual" *> $null
Set-Service -Name "wlpasvc" -StartupType "Manual" *> $null
Set-Service -Name "wmiApSrv" -StartupType "Manual" *> $null
sc.exe config "BITS" start= delayed-auto *> $null
sc.exe config "wscsvc" start= delayed-auto *> $null
sc.exe config "sppsvc" start= delayed-auto *> $null
sc.exe config "WSearch" start= delayed-auto *> $null
sc.exe config "DoSvc" start= delayed-auto *> $null

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -Force | Out-Null
$CDMPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
New-Item -Path $CDMPath -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "ContentDeliveryAllowed" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "OemPreInstalledAppsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "PreInstalledAppsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "PreInstalledAppsEverEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "SilentInstalledAppsEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "SubscribedContent-338387Enabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "SubscribedContent-338388Enabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "SubscribedContent-338389Enabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "SubscribedContent-353698Enabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $CDMPath -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\System\GameConfigStore" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Value 2 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Type String -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Type DWord -Value 1 -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Type DWord -Value 1 -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 0 -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\ControlSet001\Services\Ndu" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\Ndu" -Name "Start" -Value 4 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Value 30 -Type DWord -Force | Out-Null
Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1 -Type DWord -Force | Out-Null
$AdvExplorerPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $AdvExplorerPath -Name "ShowTaskViewButton" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $AdvExplorerPath -Name "LaunchTo" -Value 1 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $AdvExplorerPath -Name "HideFileExt" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $AdvExplorerPath -Name "TaskbarAl" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $AdvExplorerPath -Name "EnableSnapAssistFlyout" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path $AdvExplorerPath -Name "SnapAssist" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name "TaskbarEndTask" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\Control Panel\Desktop" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 1 -Type String -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value "1" -Type String -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WindowArrangementActive" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506" -Type String -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\Maps" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Value 0 -Type DWord -Force | Out-Null
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 1 -Type DWord -Force | Out-Null
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

dism /online /Get-Features | ? {$_ -like "Feature Name*"} | % {
    $f = ($_ -replace "Feature Name : ", "").Trim()
    if ($f) { dism /online /Disable-Feature /FeatureName:$f /NoRestart *> $null }
}

Get-WindowsCapability -Online |
Where-Object { $_.State -eq 'Installed' -and $_.Name -notmatch 'Ethernet|WiFi|Notepad' } |
ForEach-Object {
    Start-Job { param($cap) Remove-WindowsCapability -Online -Name $cap } -ArgumentList $_.Name | Out-Null
}

Get-AppxPackage -AllUsers | Where SignatureKind -ne 'System' | ForEach { Remove-AppxPackage -Package $_.PackageFullName -AllUsers }

$roots = @($env:ProgramFiles, ${env:ProgramFiles(x86)}) | Where-Object { Test-Path $_ }
foreach ($r in $roots) {
    Get-ChildItem $r -Directory | ForEach-Object {
        takeown.exe /F $_.FullName /R /D Y > $null 2>&1
        icacls.exe $_.FullName /grant Administrators:F /T /C > $null 2>&1
        Remove-Item $_.FullName -Recurse -Force > $null 2>&1
    }
}

Stop-Process -Name msedge -Force
Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait
Remove-Item "$env:UserProfile\OneDrive" -Recurse -Force
Remove-Item "$env:LocalAppData\Microsoft\OneDrive" -Recurse -Force
Remove-Item "$env:ProgramData\Microsoft OneDrive" -Recurse -Force
Remove-Item "${env:ProgramFiles(x86)}\Microsoft" -Recurse -Force
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
