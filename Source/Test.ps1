$EdgePath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
$EdgeUWP  = "$Env:SystemRoot\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"

New-Item $EdgeUWP\MicrosoftEdge.exe -Force | Out-Null

if (Test-Path $EdgePath) {
  cmd /c ((Get-ItemProperty $EdgePath).UninstallString + ' --force-uninstall')
} else {
    Write-Output "Edge is not installed"
}

Remove-Item $EdgeUWP -Recurse

Stop-Process -Name MicrosoftEdgeUpdate -Force
Remove-Item "$env:ProgramFiles (x86)\Microsoft\EdgeUpdate" -Recurse
sc.exe delete edgeupdate  | Out-Null
sc.exe delete edgeupdatem | Out-Null

$Appx = (Get-AppxPackage Microsoft.MicrosoftEdgeDevToolsClient).PackageFullName;$Sid = (glu $Env:USERNAME).Sid.Value
New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Appx -Force; Remove-AppxPackage $Appx
