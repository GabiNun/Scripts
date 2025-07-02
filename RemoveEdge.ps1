$ErrorActionPreference = 'SilentlyContinue'
Stop-Process -Name msedge,MicrosoftEdgeUpdate -Force
Remove-Item -LiteralPath "$env:ProgramFiles\WindowsApps\Microsoft.Edge.GameAssist*" -Force -Recurse
Remove-Item -LiteralPath "$env:ProgramFiles\WindowsApps\Microsoft.MicrosoftEdge*" -Force -Recurse
Remove-Item -LiteralPath "$env:ProgramFiles\WindowsApps\MicrosoftWindows.Client.WebExperience_424.1301.270.9_x64__cw5n1h2txyewy\Dashboard\StaticWidgetRegistrations\images\microsoftedge*" -Force -Recurse
Remove-Item -LiteralPath 'C:\Program Files (x86)\Microsoft' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\EdgeUpdate' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\Windows\AppRepository\Microsoft.Edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\Windows\AppRepository\Microsoft.MicrosoftEdge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.Edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\Windows\AppRepository\Packages\Microsoft.MicrosoftEdge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk' -Force
Remove-Item -LiteralPath 'C:\ProgramData\Packages\Microsoft.MicrosoftEdge*' -Force -Recurse
Remove-Item -LiteralPath "$env:LOCALAPPDATA\Microsoft\Edge" -Force -Recurse
Remove-Item -LiteralPath "$env:LOCALAPPDATA\Packages\Microsoft.MicrosoftEdge*" -Force -Recurse
Remove-Item -LiteralPath "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" -Force
Remove-Item -LiteralPath "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" -Force
Remove-Item -LiteralPath "$env:APPDATA\Microsoft\Windows\Recent\edge_results.lnk" -Force
Remove-Item -LiteralPath "$env:APPDATA\Microsoft\Windows\Recent\edge_top_level_only.lnk" -Force
Remove-Item -LiteralPath 'C:\Users\Public\Desktop\Microsoft Edge.lnk' -Force
Remove-Item -LiteralPath 'C:\Windows\PolicyDefinitions\EdgeUI.admx' -Force
Remove-Item -LiteralPath 'C:\Windows\PolicyDefinitions\MicrosoftEdge.admx' -Force
Remove-Item -LiteralPath 'C:\Windows\PolicyDefinitions\en-US\EdgeUI.adml' -Force
Remove-Item -LiteralPath 'C:\Windows\PolicyDefinitions\en-US\MicrosoftEdge.adml' -Force
Remove-Item -LiteralPath 'C:\Windows\servicing\Packages\Microsoft-Edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\servicing\Packages\Microsoft-OneCore-Edg*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\servicing\Packages\Microsoft-Windows-MicrosoftEdge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\System32\Microsoft-Edge-WebView' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\System32\edgeangle.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\EdgeContent.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\edgehtml.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\edgeIso.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\EdgeManager.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\EdgeResetPlugin.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\MicrosoftEdgeBCHost.exe' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\MicrosoftEdgeCP.exe' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\MicrosoftEdgeDevTools.exe' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\MicrosoftEdgeSH.exe' -Force
Remove-Item -LiteralPath 'C:\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Microsoft-Edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Microsoft-OneCore-Edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Microsoft-Windows-MicrosoftEdge*' -Force -Recurse
Remove-Item -LiteralPath "$env:SystemRoot\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" -Force
Remove-Item -LiteralPath "$env:SystemRoot\System32\Dism\EdgeProvider.dll" -Force
Remove-Item -LiteralPath "$env:SystemRoot\System32\Dism\en-US\EdgeProvider.dll.mui" -Force
Remove-Item -LiteralPath "$env:SystemRoot\System32\en-US\edgehtml.dll.mui" -Force
Remove-Item -LiteralPath "$env:SystemRoot\System32\Microsoft-Edge-WebView\edge*" -Force -Recurse
Remove-Item -LiteralPath "$env:SystemRoot\System32\Tasks\MicrosoftEdge*" -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\SystemApps\Microsoft.MicrosoftEdge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\SystemResources\edgehtml.dll.mun' -Force
Remove-Item -LiteralPath 'C:\Windows\SysWOW64\edgehtml.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\SysWOW64\edgeIso.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\SysWOW64\EdgeManager.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\SysWOW64\Dism\EdgeProvider.dll' -Force
Remove-Item -LiteralPath 'C:\Windows\SysWOW64\Dism\en-US\EdgeProvider.dll.mui' -Force
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-windows-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-windows-d..ders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-windows-d..t-winproviders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-windows-e..crosoftedgede*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-windows-e..microsoftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\amd64_microsoft-windows-reset-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\FileMaps\$$_systemapps_microsoft.microsoftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\wow64_microsoft-windows-d..ders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\wow64_microsoft-windows-d..t-winproviders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\FileMaps\$$_system32_microsoft-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-windows-d..ders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-windows-d..t-winproviders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-windows-e..crosoftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-windows-e..ftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-windows-e..microsoftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\amd64_microsoft-windows-reset-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\wow64_microsoft-windows-d..ders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\wow64_microsoft-windows-d..t-winproviders-edge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\wow64_microsoft-windows-e..crosoftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\wow64_microsoft-windows-e..ftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\wow64_microsoft-windows-e..microsoftedge*' -Force -Recurse
Remove-Item -LiteralPath 'C:\Windows\WinSxS\Manifests\wow64_microsoft-windows-reset-edge*' -Force -Recurse
