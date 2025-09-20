# Take ownership and grant permissions
takeown /f "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
icacls "C:\Windows\System32\IntegratedServicesRegionPolicySet.json" /grant Administrators:F

# Path to JSON file
$jsonPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"

# Load JSON
$json = Get-Content -Raw -Path $jsonPath | ConvertFrom-Json

# Recursive function to find and update the matching GUID
function Update-GuidState {
    param($obj)

    if ($obj -is [System.Collections.IEnumerable] -and -not ($obj -is [string])) {
        foreach ($o in $obj) { Update-GuidState $o }
    }
    elseif ($obj -is [pscustomobject]) {
        if ($obj.guid -eq "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}") {
            $obj.defaultState = "enabled"
        }
        foreach ($p in $obj.PSObject.Properties.Value) {
            Update-GuidState $p
        }
    }
}

# Run the update
Update-GuidState $json

# Save JSON back (compressed to avoid full reformatting)
$json | ConvertTo-Json -Depth 10 -Compress | Set-Content -Path $jsonPath -Force -Encoding UTF8

& "C:\Program Files (x86)\Microsoft\Edge\Application\140.0.3485.81\Installer\setup.exe" --uninstall --msedge --channel=stable --system-level --verbose-logging
