$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath
    New-Item -Path $RegPath\DisallowRun
}

New-ItemProperty -Path "$RegPath\DisallowRun" -Name DisableEdge -Value "msedge.exe"
New-ItemProperty -Path "$RegPath" -Name "DisallowRun" -Value 1 -PropertyType DWord

Get-ScheduledTask -TaskPath "\" |
Where-Object {$_.TaskName -like "MicrosoftEdge*"} |
ForEach-Object {
    Disable-ScheduledTask -TaskName $_.TaskName -TaskPath "\"
}

## Undo Script

Remove-ItemProperty -Path "$RegPath\DisallowRun" -Name DisableEdge

Get-ScheduledTask -TaskPath "\" |
Where-Object {$_.TaskName -like "MicrosoftEdge*"} |
ForEach-Object {
    Set-ScheduledTask -TaskName $_.TaskName -TaskPath "\" -Enable
}
