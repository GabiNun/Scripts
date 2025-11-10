Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection
& $Env:SystemRoot\System32\OneDriveSetup.exe /uninstall

$Packages = "Microsoft.WindowsCalculator","Microsoft.WindowsCamera","Microsoft.WindowsAlarms",
    "Microsoft.WindowsFeedbackHub","Microsoft.ZuneMusic","Microsoft.MicrosoftOfficeHub",
    "Microsoft.BingSearch","Microsoft.BingWeather","Microsoft.BingNews","Clipchamp.Clipchamp",
    "MSTeams","Microsoft.Todos","Microsoft.OutlookForWindows","Microsoft.Paint","Microsoft.YourPhone",
    "Microsoft.Windows.Photos","MicrosoftCorporationII.QuickAssist","Microsoft.ScreenSketch",
    "Microsoft.MicrosoftSolitaireCollection","Microsoft.WindowsSoundRecorder","Microsoft.Application*",
    "Microsoft.StartExperiencesApp","Microsoft.MicrosoftStickyNotes","Microsoft.WindowsTerminal",
    "Microsoft.WebMediaExtensions","Microsoft.GamingApp","Microsoft.PowerAutomateDesktop",
    "Microsoft.Xbox.TCUI","Microsoft.Windows.DevHome","Microsoft.XboxGamingOverlay",
    "Microsoft.GetHelp","Microsoft.WindowsStore","MicrosoftWindows.CrossDevice","Microsoft.Edge.GameAssist"

foreach ($Package in $Packages) { Get-AppxPackage $Package | Remove-AppPackage }
