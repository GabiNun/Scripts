$jsonPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json";$guidValue = "{1bca278a-5d11-4acf-ad2f-f9ab6d7f93a6}"

takeown /f $jsonPath;icacls $jsonPath /grant Administrators:F

(gc $jsonPath -Raw | ConvertFrom-Json | % {($_.Policies | ? guid -eq $guidValue).defaultState="enabled"; $_} | ConvertTo-Json -Depth 100) | sc $jsonPath -Encoding UTF8
