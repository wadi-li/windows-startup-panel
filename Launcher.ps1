param([Parameter(Mandatory=$true)][ValidatePattern('^wadim-startup://[a-z]+/?$')][string]$Uri)
$ErrorActionPreference = 'Stop'
$id = $Uri -replace '^wadim-startup://','' -replace '/$',''
$sys = Join-Path $env:SystemRoot 'System32'
switch -Exact ($id) {
    'tasks' { Start-Process -FilePath (Join-Path $sys 'mmc.exe') -ArgumentList ('"' + (Join-Path $sys 'taskschd.msc') + '"') }
    'services' { Start-Process -FilePath (Join-Path $sys 'mmc.exe') -ArgumentList ('"' + (Join-Path $sys 'services.msc') + '"') }
    'events' { Start-Process -FilePath (Join-Path $sys 'mmc.exe') -ArgumentList ('"' + (Join-Path $sys 'eventvwr.msc') + '"') }
    'disk' { Start-Process -FilePath (Join-Path $sys 'mmc.exe') -ArgumentList ('"' + (Join-Path $sys 'diskmgmt.msc') + '"') }
    'devices' { Start-Process -FilePath (Join-Path $sys 'mmc.exe') -ArgumentList ('"' + (Join-Path $sys 'devmgmt.msc') + '"') }
    'taskmgr' { Start-Process -FilePath (Join-Path $sys 'taskmgr.exe') }
    'msconfig' { Start-Process -FilePath (Join-Path $sys 'msconfig.exe') }
    'resources' { Start-Process -FilePath (Join-Path $sys 'resmon.exe') }
    'sysinfo' { Start-Process -FilePath (Join-Path $sys 'msinfo32.exe') }
    'startupsettings' { Start-Process 'ms-settings:startupapps' }
    'startupuser' { Start-Process -FilePath (Join-Path $env:SystemRoot 'explorer.exe') -ArgumentList 'shell:startup' }
    'startupall' { Start-Process -FilePath (Join-Path $env:SystemRoot 'explorer.exe') -ArgumentList 'shell:common startup' }
    'reliability' { Start-Process -FilePath (Join-Path $sys 'perfmon.exe') -ArgumentList '/rel' }
    'power' { Start-Process -FilePath (Join-Path $sys 'control.exe') -ArgumentList 'powercfg.cpl' }
    'sfcverify' { Start-Process -FilePath (Join-Path $sys 'cmd.exe') -ArgumentList '/d /k sfc.exe /verifyonly' -Verb RunAs }
    'sfcrepair' { Start-Process -FilePath (Join-Path $sys 'cmd.exe') -ArgumentList '/d /k sfc.exe /scannow' -Verb RunAs }
    default { throw 'Unknown command identifier.' }
}
