Stop-Process -Name "msedge","MicrosoftEdgeUpdate" -Force
$u=[System.Security.Principal.WindowsIdentity]::GetCurrent().Name; gci C:\ -Recurse -Force | ? { $_.Name -like '*Edge*' -and $_.FullName -notlike 'C:\Windows\WinSxS\*' } | % {
$p=$_.FullName; if (Test-Path $p) {
if ($_.PSIsContainer) { takeown /f "$p" /r /d Y; icacls "$p" /grant "${u}:(F)" /t /c }
else { takeown /f "$p"; icacls "$p" /grant "${u}:(F)" }
Remove-Item "$p" -Recurse -Force } }


































'$env:ProgramFiles\\WindowsApps\Microsoft.Edge.GameAssist_1.0.3336.0_x64__8wekyb3d8bbwe'
'$env:ProgramFiles\\WindowsApps\Microsoft.MicrosoftEdge.Stable_138.0.3351.65_neutral__8wekyb3d8bbwe'
'$env:ProgramFiles\WindowsApps\MicrosoftWindows.Client.WebExperience_424.1301.270.9_x64__cw5n1h2txyewy\Dashboard\StaticWidgetRegistrations\images\MicrosoftE*'
'$env:ProgramFiles(x86)\Microsoft'
'$env:ProgramData\Microsoft\EdgeUpdate'
'$env:ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.MicrosoftEdge'
'$env:ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.Edge*'
'$env:ProgramData\Microsoft\Windows\AppRepository\Microsoft.Edge*'
'$env:ProgramData\Packages\Microsoft.MicrosoftEdge*'
'$env:LocalAppData\Microsoft\Edge'
'$env:AppData\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk'
'$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk'
'$env:Public\Desktop\Microsoft Edge.lnk'
'$env:SystemRoot\PolicyDefinitions\EdgeUI.admx'
'$env:SystemRoot\PolicyDefinitions\MicrosoftEdgeUI.admx'
'$env:SystemRoot\PolicyDefinitions\en-US\EdgeUI.admx'
'$env:SystemRoot\PolicyDefinitions\en-US\MicrosoftEdgeUI.admx'
'$env:SystemRoot\Prefetch\MICROSOFTEDGE*'
'$env:SystemRoot\Prefetch\MSEDGE*'
'$env:SystemRoot\servicing\Packages\Microsoft-Edge*'
'$env:SystemRoot\servicing\Packages\Microsoft-OneCore-Edge*'
'$env:SystemRoot\servicing\Packages\Microsoft-Windows-MicrosoftEdge*'
'$env:SystemRoot\System32\Microsoft-Edge-WebView'
'$env:SystemRoot\System32\edgeangle.dll'
'$env:SystemRoot\System32\EdgeContent.dll'
'$env:SystemRoot\System32\edgehtml.dll'
'$env:SystemRoot\System32\edgeIso.dll'
'$env:SystemRoot\System32\EdgeManager.dll'
'$env:SystemRoot\System32\EdgeResetPlugin.dll'
'$env:SystemRoot\System32\MicrosoftEdgeBCHost.exe'
'$env:SystemRoot\System32\MicrosoftEdgeCP.exe'
'$env:SystemRoot\System32\MicrosoftEdgeDevTools.exe'
'$env:SystemRoot\System32\MicrosoftEdgeSH.exe'
