$ErrorActionPreference = 'Stop'
$dest = Join-Path $env:LOCALAPPDATA 'WadimStartupPanel'
New-Item -ItemType Directory -Path $dest -Force | Out-Null
foreach ($name in @('Launcher.ps1','Windows_Startup_Panel.html')) {
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot $name) -Destination (Join-Path $dest $name) -Force
}
$key = 'HKCU:\Software\Classes\wadim-startup'
New-Item -Path "$key\shell\open\command" -Force | Out-Null
Set-Item -Path $key -Value 'URL:Windows Startup Panel'
New-ItemProperty -Path $key -Name 'URL Protocol' -Value '' -PropertyType String -Force | Out-Null
$ps = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
$launcher = Join-Path $dest 'Launcher.ps1'
$command = '"' + $ps + '" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "' + $launcher + '" -Uri "%1"'
Set-Item -Path "$key\shell\open\command" -Value $command
Start-Process -FilePath (Join-Path $dest 'Windows_Startup_Panel.html')
Write-Host 'Installed. Open Windows_Startup_Panel.html to use the panel.'
