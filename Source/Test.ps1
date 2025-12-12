$Services =
    "TrkWks", "camsvc", "DiagTrack", "DusmSvc", "InstallService", "lfsvc", "NcbService",
    "PcaSvc", "SENS", "SharedAccess", "Spooler", "SSDPSRV", "WSAIFabricSvc", "BDESVC",
    "DispBrokerDesktopSvc", "DoSvc", "hidserv", "InventorySvc", "lmhosts", "NgcSvc",
    "NgcCtnrSvc", "RmSvc", "SharedAccess", "smphost", "SysMain",
    "TextInputManagementService", "TimeBrokerSvc", "UdkUserSvc_*", "whesvc",
    "WpnService", "WpnUserService_*", "ClipSVC", "CDPUserSvc_*", "cbdhsvc_*"

foreach ($Service in Get-Service $Services) { Set-Service $Service -StartupType Disabled }
