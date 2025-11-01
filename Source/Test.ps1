$chromeKey = "HKLM:\SOFTWARE\Policies\Google\Chrome"
if (-not (Test-Path $chromeKey)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google" -Name "Chrome"
}

New-ItemProperty -Path $chromeKey -Name "WebRTCIPHandlingPolicy" -Value 3 -PropertyType DWord -Force
