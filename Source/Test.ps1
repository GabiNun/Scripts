New-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\-1-5-21-3939049671-854807330-977275038-1001\Microsoft.SecHealthUI_cw5n1h2txyewy" -Force
Get-AppxPackage *SecHealthUI | Remove-AppxPackage
