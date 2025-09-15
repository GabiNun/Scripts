# irm raw.githubusercontent.com/GabiNun/Scripts/main/Source/Set-Tweaks.ps1 | iex

function Set-Tweaks {
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\DiskDiagnostic' -TaskName 'Microsoft-Windows-DiskDiagnosticDataCollector'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Application Experience' -TaskName 'Microsoft Compatibility Appraiser'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Customer Experience Improvement Program' -TaskName 'Consolidator'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Customer Experience Improvement Program' -TaskName 'UsbCeip'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Feedback\Siuf' -TaskName 'DmClientOnScenarioDownload'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Windows Error Reporting' -TaskName 'QueueReporting'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Application Experience' -TaskName 'StartupAppTask'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Application Experience' -TaskName 'PcaPatchDbTask'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Application Experience' -TaskName 'MareBackup'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Feedback\Siuf' -TaskName 'DmClient'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Maps' -TaskName 'MapsUpdateTask'
  Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Autochk' -TaskName 'Proxy'

  rm 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU'

  ni HKCU:\SOFTWARE\Microsoft\Siuf\Rules -Fo
  ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent -Fo
  ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo -Fo
  ni 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -Fo
  ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization -Fo
  ni HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer -Fo
  ni HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement -Fo
  ni HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -Fo
  ni HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config -Fo
  ni HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Fo
  ni 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell' -Fo

  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager SubscribedContent-338387Enabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager SubscribedContent-338388Enabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager SubscribedContent-338389Enabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager SubscribedContent-353698Enabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager SystemPaneSuggestionsEnabled 0
  sp HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableTailoredExperiencesWithDiagnosticData 1
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager PreInstalledAppsEverEnabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager SilentInstalledAppsEnabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager OemPreInstalledAppsEnabled 0
  sp HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement ScoobeSystemSettingEnabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager EnthusiastMode 1
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager PreInstalledAppsEnabled 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager ContentDeliveryAllowed 0
  sp HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config DODownloadMode 0
  sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection DoNotShowFeedbackNotifications 1
  sp HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection AllowTelemetry 0
  sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableWindowsConsumerFeatures 1
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced ShowTaskViewButton 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People PeopleBand 0
  sp HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer HideSCAMeetNow 1
  sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo DisabledByGroupPolicy 1
  sp HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters IRPStackSize 30
  sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization DODownloadMode 0
  sp HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced LaunchTo 1
  sp HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection AllowTelemetry 0
  sp HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem LongPathsEnabled 1
  sp HKCU:\SOFTWARE\Microsoft\Siuf\Rules NumberOfSIUFInPeriod 0
  sp HKCU:\SOFTWARE\Microsoft\Siuf\Rules PeriodInNanoSeconds 0
  sp HKLM:\SYSTEM\ControlSet001\Services\Ndu Start 2

  sp 'HKCU:\Control Panel\Desktop' AutoEndTasks 1
  sp 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' EnableFeeds 0
  sp 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' fAllowToGetHelp 0
  sp 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' ClearPageFileAtShutdown 0
  sp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile' SystemResponsiveness 0
  sp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile' NetworkThrottlingIndex 4294967295
  sp 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell' FolderType NotSpecified

  $ram = (Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1KB
  sp HKLM:\SYSTEM\CurrentControlSet\Control SvcHostSplitThresholdInKB $ram

  sc.exe config AssignedAccessManagerSvc start=disabled
  sc.exe config DiagTrack start=disabled
  sc.exe config MsKeyboardFilter start=demand
  sc.exe config edgeupdate start=demand
  sc.exe config WpnService start=demand
  sc.exe config CDPSvc start=demand
  sc.exe config PcaSvc start=demand
  sc.exe config StorSvc start=demand
  sc.exe config BITS start=delayed-auto
  sc.exe config WSearch start=delayed-auto

}
