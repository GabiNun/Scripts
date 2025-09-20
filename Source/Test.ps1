Get-AppxPackage -AllUsers | Where-Object {
    $_.Name -notmatch 'Microsoft.WindowsStore|Microsoft.Windows.Cortana|Microsoft.DesktopAppInstaller|Microsoft.Windows.StartMenuExperienceHost|Microsoft.Windows.ShellExperienceHost|Microsoft.Windows.CBS' 
} | Remove-AppxPackage
