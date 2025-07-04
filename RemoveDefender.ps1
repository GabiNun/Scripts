Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/Remove_SecurityComp/Remove_SecurityComp.reg" -OutFile "$env:TEMP\Remove_SecurityComp.reg"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/Remove_Defender/RemoveDefender.reg" -OutFile "$env:TEMP\RemoveDefender.reg"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/PowerRun.exe" -OutFile "$env:TEMP\PowerRun.exe"
Invoke-WebRequest -Uri "https://github.com/ionuttbara/windows-defender-remover/raw/main/PowerRun.ini" -OutFile "$env:TEMP\PowerRun.ini"
irm raw.githubusercontent.com/ionuttbara/windows-defender-remover/main/RemoveSecHealthApp.ps1 | iex
& "$env:TEMP\PowerRun.exe" reg.exe import "$env:TEMP\Remove_SecurityComp.reg"
& "$env:TEMP\PowerRun.exe" reg.exe import "$env:TEMP\RemoveDefender.reg"

foreach ($file in @(
    "C:\Windows\WinSxS\FileMaps\wow64_windows-defender*.manifest",
    "C:\Windows\WinSxS\FileMaps\x86_windows-defender*.manifest",
    "C:\Windows\WinSxS\FileMaps\amd64_windows-defender*.manifest",
    "C:\Windows\System32\SecurityAndMaintenance_Error.png",
    "C:\Windows\System32\SecurityAndMaintenance.png",
    "C:\Windows\System32\SecurityHealthSystray.exe",
    "C:\Windows\System32\SecurityHealthService.exe",
    "C:\Windows\System32\SecurityHealthHost.exe",
    "C:\Windows\System32\drivers\SgrmAgent.sys",
    "C:\Windows\System32\drivers\WdDevFlt.sys",
    "C:\Windows\System32\drivers\WdBoot.sys",
    "C:\Windows\System32\drivers\WdFilter.sys",
    "C:\Windows\System32\wscsvc.dll",
    "C:\Windows\System32\drivers\WdNisDrv.sys",
    "C:\Windows\System32\wscsvc.dll",
    "C:\Windows\System32\wscproxystub.dll",
    "C:\Windows\System32\wscisvif.dll",
    "C:\Windows\System32\SecurityHealthProxyStub.dll",
    "C:\Windows\System32\smartscreen.dll",
    "C:\Windows\SysWOW64\smartscreen.dll",
    "C:\Windows\System32\smartscreen.exe",
    "C:\Windows\SysWOW64\smartscreen.exe",
    "C:\Windows\System32\DWWIN.EXE",
    "C:\Windows\SysWOW64\smartscreenps.dll",
    "C:\Windows\System32\smartscreenps.dll",
    "C:\Windows\System32\SecurityHealthCore.dll",
    "C:\Windows\System32\SecurityHealthSsoUdk.dll",
    "C:\Windows\System32\SecurityHealthUdk.dll",
    "C:\Windows\System32\SecurityHealthAgent.dll"
)) {
    & "$env:TEMP\PowerRun.exe" cmd.exe /c del /f "$file"
}

foreach ($dir in @(
    "C:\Windows\WinSxS\amd64_security-octagon*",
    "C:\Windows\WinSxS\x86_windows-defender*",
    "C:\Windows\WinSxS\wow64_windows-defender*",
    "C:\Windows\WinSxS\amd64_windows-defender*",
    "C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy",
    "C:\ProgramData\Microsoft\Windows Defender",
    "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection",
    "C:\Program Files (x86)\Windows Defender Advanced Threat Protection",
    "C:\Program Files\Windows Defender Advanced Threat Protection",
    "C:\ProgramData\Microsoft\Windows Security Health",
    "C:\ProgramData\Microsoft\Storage Health",
    "C:\WINDOWS\System32\drivers\wd",
    "C:\Program Files (x86)\Windows Defender",
    "C:\Program Files\Windows Defender",
    "C:\Windows\System32\SecurityHealth",
    "C:\Windows\System32\WebThreatDefSvc",
    "C:\Windows\System32\Sgrm",
    "C:\Windows\Containers\WindowsDefenderApplicationGuard.wim",
    "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance",
    "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance",
    "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\Defender",
    "C:\Windows\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender",
    "C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender",
    "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender",
    "C:\Windows\System32\HealthAttestationClient",
    "C:\Windows\GameBarPresenceWriter",
    "C:\Windows\bcastdvr",
    "C:\Windows\Containers\serviced\WindowsDefenderApplicationGuard.wim"
)) {
    & "$env:TEMP\PowerRun.exe" cmd.exe /c rmdir "$dir" /s /q
}
