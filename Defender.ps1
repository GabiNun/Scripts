gci C:\ -r -fo -ea 0 | ? Name -match 'Defender|Security' | ri -r -fo -ea 0

$file = @(
  "C:\Windows\System32\drivers\SgrmAgent.sys",
  "C:\Windows\System32\drivers\WdDevFlt.sys",
  "C:\Windows\System32\drivers\WdBoot.sys",
  "C:\Windows\System32\drivers\WdFilter.sys",
  "C:\Windows\System32\drivers\WdNisDrv.sys",
  "C:\Windows\system32\drivers\msseccore.sys",
  "C:\Windows\system32\drivers\MsSecFltWfp.sys",
  "C:\Windows\system32\drivers\MsSecFlt.sys",
  "C:\Windows\System32\wscproxystub.dll",
  "C:\Windows\System32\wscsvc.dll",
  "C:\Windows\System32\wscisvif.dll",
  "C:\Windows\System32\smartscreen*",
  "C:\Windows\SysWOW64\smartscreen*",
  "C:\Windows\System32\DWWIN.EXE",
  "C:\Windows\System32\wscapi.dll",
  "C:\Windows\System32\wscadminui.exe",
  "C:\Windows\SysWOW64\GameBarPresenceWriter.exe",
  "C:\Windows\System32\GameBarPresenceWriter.exe",
  "C:\Windows\SysWOW64\DeviceCensus.exe",
  "C:\Windows\SysWOW64\CompatTelRunner.exe"
)

$dirs = @(
  "C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy",
  "C:\ProgramData\Microsoft\Storage Health",
  "C:\WINDOWS\System32\drivers\wd",
  "C:\Windows\System32\WebThreatDefSvc",
  "C:\Windows\System32\Sgrm",
  "C:\Windows\System32\HealthAttestationClient",
  "C:\Windows\GameBarPresenceWriter",
  "C:\Windows\bcastdvr"
)

$file | ? { Test-Path $_ } | % { ri $_ -Force }
$dirs | ? { Test-Path $_ } | % { ri $_ -Recurse -Force }
