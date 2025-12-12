$Services = "TrkWks", "camsvc", "DiagTrack", "DusmSvc", "InstallService", "lfsvc", "NcbService", "NPSMSvc_*", "OneSyncSvc_*", "PcaSvc", "SENS", "SharedAccess", "Spooler", "SSDPSRV", "WSAIFabricSvc"

foreach ($Service in Get-Service $Services) { Set-Service $Service -StartupType Disabled }
