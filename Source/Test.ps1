takeown /f "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
icacls "C:\Windows\System32\IntegratedServicesRegionPolicySet.json" /grant Administrators:F

$filePath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"

$text = Get-Content -Raw -Path $filePath

$guid = "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}"

$pattern = '(?<={[^}]*"guid"\s*:\s*"' + [regex]::Escape($guid) + '"[^}]*"defaultState"\s*:\s*")[^"]+'

$replacement = "enabled"

$newText = [regex]::Replace($text, $pattern, $replacement)

Set-Content -Path $filePath -Value $newText -Force -Encoding UTF8

& "C:\Program Files (x86)\Microsoft\Edge\Application\140.0.3485.81\Installer\setup.exe" --uninstall --msedge --channel=stable --system-level --verbose-logging
