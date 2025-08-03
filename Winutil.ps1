foreach ($svc in (irm raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json).WPFTweaksServices.service | Where-Object { $_.Name -and $_.StartupType }) {
    Set-Service -Name $svc.Name -StartupType $svc.StartupType -ea 0
}

Invoke-WebRequest raw.githubusercontent.com/ChrisTitusTech/winutil/main/config/tweaks.json -UseBasicParsing |
Select-Object -ExpandProperty Content | ConvertFrom-Json |
% { $_.WPFTweaksTele.registry | % {
    if (-not (Test-Path $_.Path)) { New-Item -Path $_.Path -Force | Out-Null }
    if ($_.Value -ne "<RemoveEntry>") {
        $v = if ($_.Type -eq "DWord") { [uint32]$_.Value } else { $_.Value }
        if (Get-ItemProperty -Path $_.Path -Name $_.Name -ea 0) {
            Set-ItemProperty -Path $_.Path -Name $_.Name -Value $v | Out-Null
        } else {
            New-ItemProperty -Path $_.Path -Name $_.Name -Value $v -PropertyType $_.Type -ea 0 | Out-Null
        }
    } else {
        Remove-ItemProperty -Path $_.Path -Name $_.Name -ea 0 | Out-Null
    }
} }
