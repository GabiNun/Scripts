$jsonPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$guid = "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}"

takeown /f $jsonPath
icacls $jsonPath /grant Administrators:F

$policyData = Get-Content $jsonPath -Raw | ConvertFrom-Json
$policy = $policyData.Policies | Where-Object Id -eq $guid

if ($policy) {
    $policy.DefaultState = "Enabled"
    $policyData | ConvertTo-Json -Depth 100 | Set-Content $jsonPath -Encoding UTF8
}
