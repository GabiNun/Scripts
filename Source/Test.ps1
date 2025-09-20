$jsonPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$guidValue = "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}"

takeown /f $jsonPath
icacls $jsonPath /grant Administrators:F

$policy = $policyData.Policies | Where-Object guid -eq $guidValue

$policyData | ConvertTo-Json -Depth 100 | Set-Content $jsonPath -Encoding UTF8
