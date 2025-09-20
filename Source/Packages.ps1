& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall

spps -n msedge,MicrosoftEdgeUpdate -f
rm -R -Fo "C:\Program Files (x86)\Microsoft"
rm "C:\Users\Public\Desktop\Microsoft Edge.lnk"
rm "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"

Get-AppxPackage Microsoft.WindowsCalculator | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Copilot | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsStore | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Todos | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsNotepad | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.OutlookForWindows | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Paint | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage -ea 0
Get-AppxPackage MicrosoftCorporationII.QuickAssist | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.ScreenSketch | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WindowsTerminal | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.BingSearch | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Edge.GameAssist | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.PowerAutomateDesktop | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.StartExperiencesApp | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.WebMediaExtensions | Remove-AppxPackage -ea 0
Get-AppxPackage Clipchamp.Clipchamp | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.Windows.DevHom | Remove-AppxPackage -ea 0
Get-AppxPackage MicrosoftWindows.CrossDevice | Remove-AppxPackage -ea 0
Get-AppxPackage Microsoft.ApplicationCompatibilityEnhancements | Remove-AppxPackage -ea 0
Get-AppxPackage MSTeams | Remove-AppxPackage -ea 0
winget remove Xbox
