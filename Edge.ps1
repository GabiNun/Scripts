if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "SilentlyContinue"

$policyPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$backupPath = "C:\BK_IntegratedServicesRegionPolicySet.json"

if (Test-Path $policyPath) {
    $acl = Get-Acl $policyPath

    takeown /f $policyPath /a 
    icacls $policyPath /grant Administrators:F

    $json = Get-Content $policyPath | ConvertFrom-Json

    foreach ($policy in $json.policies) {
        if ($policy.'$comment' -like "*Edge*" -and $policy.'$comment' -like "*uninstall*") {
            $policy.defaultState = 'enabled'
            $policy.conditions.region.enabled = @(
                "AT","BE","BG","CH","CY","CZ","DE","DK","EE","ES","FI","FR","GF","GP","GR","HR","HU","IE","IS","IT","LI","LT","LU","LV","MT","MQ","NL","NO","PL","PT","RE","RO","SE","SI","SK","YT",
                "AD","AE","AF","AG","AI","AL","AM","AO","AQ","AR","AS","AU","AW","AX","AZ","BA","BB","BD","BF","BH","BI","BJ","BL","BM","BN","BO","BQ","BR","BS","BT","BV","BW","BY","BZ","CA","CC",
                "CD","CF","CG","CI","CK","CL","CM","CN","CO","CR","CU","CV","CW","CX","DJ","DM","DO","DZ","EC","EG","EH","ER","ET","FK","FM","FO","GA","GB","GD","GE","GG","GH","GI","GL","GM","GN",
                "GQ","GS","GT","GU","GW","GY","HK","HM","HN","HT","ID","IL","IM","IN","IO","IQ","IR","JE","JM","JO","JP","KE","KG","KH","KI","KM","KN","KP","KR","KW","KY","KZ","LA","LB","LC","LK",
                "LR","LS","LY","MA","MC","MD","ME","MF","MG","MH","MK","ML","MM","MN","MO","MP","MR","MS","MU","MV","MW","MX","MY","MZ","NA","NC","NE","NF","NG","NI","NP","NR","NU","NZ","OM","PA",
                "PE","PF","PG","PH","PK","PM","PN","PR","PS","PW","PY","QA","RE","RS","RU","RW","SA","SB","SC","SD","SG","SH","SJ","SL","SM","SN","SO","SR","SS","ST","SV","SX","SY","SZ","TC","TD",
                "TF","TG","TH","TJ","TK","TL","TM","TN","TO","TT","TV","TW","TZ","UA","UG","UM","US","UY","UZ","VA","VC","VE","VG","VI","VN","VU","WF","WS","YE","YT","ZA","ZM","ZW"
            )
        }
    }

    $json | ConvertTo-Json -Depth 100 | Set-Content $backupPath
    Copy-Item $backupPath $policyPath -Force
    Set-Acl $policyPath $acl

    Stop-Process -Name "MsEdge" -Force

    winget uninstall "Microsoft.Edge" --accept-source-agreements --silent
    winget uninstall --name "Microsoft Edge" --accept-source-agreements --silent
}
