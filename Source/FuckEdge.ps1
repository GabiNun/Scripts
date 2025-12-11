$EdgePath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
$EdgeUWP  = "$Env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"

New-Item $EdgeUWP\MicrosoftEdge.exe -Force

if (Test-Path $EdgePath) {
  cmd /c ((Get-ItemProperty $EdgePath).UninstallString + ' --force-uninstall --delete-profile')
} else {
    Write-Output "Edge is not installed"
    return
}

Get-Process *Edge*,SearchHost | Stop-Process -Force
Remove-Item "$Env:ProgramFiles (x86)\Microsoft" -Recurse -Force
sc.exe delete edgeupdate  | Out-Null
sc.exe delete edgeupdatem | Out-Null
Unregister-ScheduledTask *Edge* -Confirm:$false

$Appx = (Get-AppxPackage *EdgeDevToolsClient).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force;Remove-AppxPackage $Appx
