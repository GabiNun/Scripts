Get-AppxPackage -AllUsers | Where-Object {
    $_.Name -notmatch 'Microsoft.DesktopAppInstaller|Microsoft.Windows.StartMenuExperienceHost|Microsoft.Windows.ShellExperienceHost|Microsoft.Windows.CBS' 
} | Remove-AppxPackage -ErrorAction 0
