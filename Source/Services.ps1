$Services =
    "TrkWks", "camsvc", "DiagTrack", "DusmSvc", "InstallService", "lfsvc", "NcbService",
    "PcaSvc", "SENS", "SharedAccess", "Spooler", "SSDPSRV", "WSAIFabricSvc", "BDESVC",
    "DispBrokerDesktopSvc", "hidserv", "InventorySvc", "lmhosts", "WpnService", "whesvc",
    "RmSvc", "smphost", "SysMain"

foreach ($Service in Get-Service $Services) { if ($Service) { Set-Service $Service -StartupType Disabled }
