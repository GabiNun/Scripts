foreach ($svc in (irm raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json).WPFTweaksServices.service | Where-Object { $_.Name -and $_.StartupType }) {
    Set-Service -Name $svc.Name -StartupType $svc.StartupType -ea 0
}

Invoke-WebRequest raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json -UseBasicParsing |
Select-Object -ExpandProperty Content | ConvertFrom-Json |
% { $_.WPFTweaksConsumerFeatures.registry | % {
    if (-not (Test-Path $_.Path)) { New-Item $_.Path -Force | Out-Null }
    if (Get-ItemProperty -Path $_.Path -Name $_.Name -ErrorAction SilentlyContinue) {
        Set-ItemProperty $_.Path $_.Name ([int]$_.Value) | Out-Null
    } else {
        New-ItemProperty $_.Path $_.Name ([int]$_.Value) -PropertyType $_.Type | Out-Null
    }
} }
