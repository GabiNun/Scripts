$Services =
    "TrkWks", "camsvc", "DiagTrack", "DusmSvc", "InstallService", "lfsvc", "NcbService",
    "PcaSvc", "SENS", "SharedAccess", "Spooler", "SSDPSRV", "WSAIFabricSvc", "BDESVC",
    "DispBrokerDesktopSvc", "hidserv", "InventorySvc", "lmhosts", "WpnService",
    "RmSvc", "SharedAccess", "smphost", "SysMain", "whesvc"

foreach ($Service in Get-Service $Services) { Set-Service $Service -StartupType Disabled }
