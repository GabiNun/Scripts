$file = @(
  "C:\Windows\System32\smartscreen*"
)

$dirs = @(
  "C:\Program Files*\Windows Defender*"
)

$file | ? { Test-Path $_ } | % { ri $_ -Force }
$dirs | ? { Test-Path $_ } | % { ri $_ -Recurse -Force }
