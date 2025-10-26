Disable-WindowsOptionalFeature -O -F Microsoft-RemoteDesktopConnection
& $env:SystemRoot\System32\OneDriveSetup.exe /uninstall

$Packages = @(
    "Microsoft.Application*",
    "Microsoft.MicrosoftSolitaireCollection",
    "MicrosoftCorporationII.QuickAssist",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.Windows*",
    "Microsoft.StartExperiencesApp",
    "Microsoft.WebMediaExtensions",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.Xbox*",
    "Microsoft.OutlookForWindows",
    "Clipchamp.Clipchamp",
    "Microsoft.Bing*",
    "Microsoft.GetHelp",
    "Microsoft.Todos",
    "Microsoft.Paint",
    "MSTeams"
)

foreach ($Package in $Packages) {Get-AppxPackage $Package | Remove-AppPackage}
