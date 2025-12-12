$Services = "TrkWks"

foreach ($Service in $Services) { Set-Service $Service -StartupType Disabled }
