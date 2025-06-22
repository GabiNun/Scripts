$serviceGroups = @{
    "Automatic" = @(
        "AudioEndpointBuilder", "AudioSrv", "CryptSvc", "DPS", "Dhcp", "DusmSvc", "EventLog", "EventSystem",
        "FontCache", "IKEEXT", "KeyIso", "LanmanWorkstation", "Netlogon", "Power", "ProfSvc",
        "SamSs", "SENS", "ShellHWDetection", "Spooler", "TermService", "Themes", "TrkWks", "UserManager",
        "VaultSvc", "Wcmsvc", "Winmgmt", "WlanSvc"
    )
    "Manual" = @(
        "ALG", "AppMgmt", "AppReadiness", "Appinfo", "AssignedAccessManagerSvc",
        "AxInstSV", "BDESVC", "CDPSvc", "COMSysApp", "CertPropSvc", "CscService",
        "DevQueryBroker", "DeviceAssociationService", "DeviceInstall", "DisplayEnhancementService",
        "DmEnrollmentSvc", "DsSvc", "DsmSvc", "EFS", "EapHost", "FDResPub", "FrameServer",
        "FrameServerMonitor", "GraphicsPerfSvc", "HvHost", "InstallService", "InventorySvc",
        "IpxlatCfgSvc", "KtmRm", "LicenseManager", "LxpSvc", "MSDTC", "MSiSCSI", "McpManagementService",
        "MicrosoftEdgeElevationService", "MsKeyboardFilter", "NaturalAuthentication", "NcaSvc",
        "NcbService", "NcdAutoSetup", "NetSetupSvc", "Netman", "NlaSvc", "PcaSvc",
        "PeerDistSvc", "PerfHost", "PhoneSvc", "PlugPlay", "PolicyAgent", "PrintNotify",
        "PushToInstall", "QWAVE", "RasAuto", "RasMan", "RemoteAccess", "RemoteRegistry", "RetailDemo",
        "RmSvc", "RpcLocator", "SCPolicySvc", "SCardSvr", "SDRSVC", "SEMgrSvc", "SNMPTRAP", "SSDPSRV",
        "ScDeviceEnum", "SensorDataService", "SensorService", "SensrSvc", "SessionEnv",
        "SharedAccess", "SmsRouter", "SstpSvc", "StiSvc", "StorSvc", "TapiSrv", "TieringEngineService",
        "TokenBroker", "TroubleshootingSvc", "TrustedInstaller", "UmRdpService", "UsoSvc", "VSS",
        "W32Time", "WEPHOSTSVC", "WFDSConMgrSvc", "WManSvc", "WPDBusEnum", "WalletService",
        "WarpJITSvc", "WbioSrvc", "WdiServiceHost", "WdiSystemHost", "WebClient", "Wecsvc",
        "WerSvc", "WiaRpc", "WinRM", "WpcMonSvc", "WpnService", "XblAuthManager", "XblGameSave",
        "XboxGipSvc", "XboxNetApiSvc", "autotimesvc", "bthserv", "camsvc", "cloudidsvc", "dcsvc",
        "defragsvc", "diagsvc", "dmwappushservice", "dot3svc", "fdPHost", "fhsvc", "hidserv",
        "icssvc", "lfsvc", "lltdsvc", "lmhosts", "netprofm", "perceptionsimulation", "pla",
        "seclogon", "smphost", "svsvc", "swprv", "upnphost", "vds", "vmicguestinterface",
        "vmicheartbeat", "vmickvpexchange", "vmicrdv", "vmicshutdown", "vmictimesync", "vmicvmsession",
        "vmicvss", "wbengine", "wcncsvc", "wuauserv", "wercplsupport", "wisvc", "wlidsvc", "wlpasvc",
        "wmiApSrv"
    )
    "Disabled" = @(
        "AppVClient", "DiagTrack", "DialogBlockingService", "UevAgentService", "shpamsvc", "tzautoupdate"
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
                Set-Service -Name $service -StartupType $startupType
            }
        } catch {}
    }
}

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
