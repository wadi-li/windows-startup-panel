$ErrorActionPreference = 'Stop'
$key = 'HKCU:\Software\Classes\wadim-startup'
if (Test-Path $key) { Remove-Item -Path $key -Recurse -Force }
$dest = Join-Path $env:LOCALAPPDATA 'WadimStartupPanel'
foreach ($name in @('Launcher.ps1','Windows_Startup_Panel.html')) {
    $path = Join-Path $dest $name
    if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path -Force }
}
if ((Test-Path -LiteralPath $dest) -and -not (Get-ChildItem -LiteralPath $dest -Force)) { Remove-Item -LiteralPath $dest }
Write-Host 'Windows Startup Panel handler removed.'
