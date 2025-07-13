$files = @(
  "C:\Windows\WinSxS\FileMaps\*windows-defender*.manifest",
  "C:\Windows\System32\*SecurityHealth*.exe",
  "C:\Windows\System32\*SecurityHealth*.dll",
  "C:\Windows\System32\SecurityAndMaintenance*.png",
  "C:\Windows\System32\wsc*.dll",
  "C:\Windows\System32\smartscreen*",
  "C:\Windows\SysWOW64\smartscreen*",
  "C:\Windows\System32\DWWIN.EXE",
  "C:\Windows\System32\drivers\Wd*",
  "C:\Windows\System32\drivers\SgrmAgent.sys",
  "C:\Windows\System32\drivers\MsSecFlt*",
  "C:\Windows\System32\drivers\msseccore.sys",
  "C:\Windows\System32\GameBarPresenceWriter.exe",
  "C:\Windows\SysWOW64\GameBarPresenceWriter.exe",
  "C:\Windows\SysWOW64\DeviceCensus.exe",
  "C:\Windows\SysWOW64\CompatTelRunner.exe"
)

$dirs = @(
  "C:\ProgramData\Microsoft\Windows Defender*",
  "C:\Program Files*\Windows Defender*",
  "C:\Program Files*\Windows Mail",
  "C:\Windows\System32\Tasks*\Microsoft\Windows\Windows Defender",
  "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\Defender*",
  "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender*",
  "C:\Windows\SystemApps\Microsoft.Windows.AppRep*",
  "C:\Windows\System32\SecurityHealth",
  "C:\Windows\System32\Sgrm",
  "C:\Windows\System32\WebThreatDefSvc",
  "C:\Windows\System32\HealthAttestationClient",
  "C:\Windows\GameBarPresenceWriter",
  "C:\Windows\bcastdvr",
  "C:\Windows\Containers\*WindowsDefenderApplicationGuard.wim",
  "C:\Windows\WinSxS\*windows-defender*",
  "C:\Windows\WinSxS\*security-octagon*"
)

$files | % { ri $_ -Force }
$dirs  | % { ri $_ -Recurse -Force }
