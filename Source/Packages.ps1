cmd /c ((gp 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge').UninstallString + ' --force-uninstall')

& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall

Get-AppxPackage Microsoft.WindowsCalculator | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage Microsoft.Copilot | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsStore | Remove-AppxPackage
Get-AppxPackage Microsoft.Todos | Remove-AppxPackage
Get-AppxPackage Microsoft.OutlookForWindows | Remove-AppxPackage
Get-AppxPackage Microsoft.Paint | Remove-AppxPackage
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage
Get-AppxPackage Microsoft.ScreenSketch | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsTerminal | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSearch | Remove-AppxPackage
Get-AppxPackage Microsoft.Edge.GameAssist | Remove-AppxPackage
Get-AppxPackage Microsoft.PowerAutomateDesktop | Remove-AppxPackage
Get-AppxPackage Microsoft.StartExperiencesApp | Remove-AppxPackage
Get-AppxPackage Microsoft.WebMediaExtensions | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.DevHome | Remove-AppxPackage
Get-AppxPackage Microsoft.Application* | Remove-AppxPackage
Get-AppxPackage MicrosoftCorporationII.QuickAssist | Remove-AppxPackage
Get-AppxPackage MicrosoftWindows.CrossDevice | Remove-AppxPackage
Get-AppxPackage Clipchamp.Clipchamp | Remove-AppxPackage
winget source remove msstore | Out-Null
winget remove xbox | Out-Null
