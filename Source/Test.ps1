Get-AppxPackage -AllUsers | Where-Object {
    $_.Name -notmatch 'Microsoft.WindowsStore|Microsoft.Windows.Cortana|Microsoft.DesktopAppInstaller|Microsoft.Windows.StartMenuExperienceHost|Microsoft.Windows.ShellExperienceHost|Microsoft.Windows.Shell|Microsoft.Windows.People|Microsoft.Windows.OOBENetworkCaptivePortal|Microsoft.Windows.Search|Microsoft.Windows.CloudExperienceHost|Microsoft.Windows.SecureAssessmentBrowser'
} | Remove-AppxPackage -ErrorAction 0
