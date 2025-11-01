New-Item HKLM:\SOFTWARE\Policies\Google\Chrome -Force

sp HKLM:\SOFTWARE\Policies\Google\Chrome WebRTCIPHandlingPolicy -Value disable_non_proxied_udp
