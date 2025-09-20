$jsonPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$guidValue = "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}"

takeown /f $jsonPath
icacls $jsonPath /grant Administrators:F

$policyData = Get-Content $jsonPath -Raw | ConvertFrom-Json
$policy = $policyData.Policies | Where-Object guid -eq $guidValue

if ($policy) {
    $policy.defaultState = "enabled"
    $policyData | ConvertTo-Json -Depth 100 | Set-Content $jsonPath -Encoding UTF8
}
