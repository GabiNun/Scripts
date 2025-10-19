$protocols = @(
    "http", "https", "ftp", "mailto", "news", "nntp",
    "snews", "telnet", "wais", "file", "ms-help",
    "ms-settings", "microsoft-edge"
)

foreach ($protocol in $protocols) {
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Classes\$protocol\shell\open\command").'(default)' -like "*msedge*") {
        Remove-Item "HKLM:\SOFTWARE\Classes\$protocol\shell\open" -Recurse -Force
    }
}
