takeown /f "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
icacls "C:\Windows\System32\IntegratedServicesRegionPolicySet.json" /grant Administrators:F
$jsonPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$json = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json

foreach ($item in $json) {
    if ($item.guid -eq "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}") {
        $item.defaultState = "enabled"
    }
}

$json | ConvertTo-Json -Depth 10 | Set-Content -Path $jsonPath -Force

& "C:\Program Files (x86)\Microsoft\Edge\Application\140.0.3485.81\Installer\setup.exe" --uninstall --msedge --channel=stable --system-level --verbose-logging
