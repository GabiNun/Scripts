Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection

& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall

$Packages = (
    "Microsoft.MicrosoftSolitaireCollection", "MicrosoftCorporationII.QuickAssist", "Microsoft.WindowsSoundRecorder",
    "Microsoft.MicrosoftStickyNotes", "Microsoft.PowerAutomateDesktop", "Microsoft.StartExperiencesApp",
    "Microsoft.WebMediaExtensions", "Microsoft.WindowsFeedbackHub", "Microsoft.MicrosoftOfficeHub",
    "MicrosoftWindows.CrossDevice", "Microsoft.OutlookForWindows", "Microsoft.WindowsCalculator",
    "Microsoft.XboxGamingOverlay", "Microsoft.WindowsTerminal", "Microsoft.Windows.DevHome", "Microsoft.Windows.Photos",
    "Microsoft.WindowsCamera", "Microsoft.WindowsAlarms", "Microsoft.WindowsStore", "Microsoft.Application*",
    "Microsoft.ScreenSketch", "Microsoft.BingWeather", "Microsoft.BingSearch", "Microsoft.YourPhone",
    "Microsoft.Xbox.TCUI", "Microsoft.GamingApp", "Clipchamp.Clipchamp", "Microsoft.ZuneMusic", "Microsoft.BingNews",
    "Microsoft.Copilot", "Microsoft.GetHelp", "Microsoft.Todos", "Microsoft.Paint", "MSTeams"
)

foreach ($Package in $Packages) {Get-AppxPackage $Package | Remove-AppPackage }
