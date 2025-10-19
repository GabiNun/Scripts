$protocols = @(
    "http", "https", "ftp", "mailto", "news", "nntp",
    "snews", "telnet", "wais", "file", "ms-help",
    "ms-settings", "microsoft-edge"
)

$fileAssociations = @(
    ".htm", ".html", ".pdf", ".shtml", ".svg",
    ".webp", ".xht", ".xhtml", ".mht", ".mhtml"
)

foreach ($protocol in $protocols) {
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Classes\$protocol\shell\open\command" 2>$null).'(default)' -like "*msedge*") {
        Remove-Item "HKLM:\SOFTWARE\Classes\$protocol\shell\open" -Recurse -Force
    }
}
