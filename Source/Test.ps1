$Services = "TrkWks"

foreach ($Service in $Services) { Set-Service $Service Disabled }
