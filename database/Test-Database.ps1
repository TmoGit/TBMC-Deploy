[CmdletBinding()]
param([string]$MariaDbBin='C:\\Program Files\\MariaDB 10.11\\bin')
$ErrorActionPreference='Stop'
foreach($svc in 'MariaDB','QuestDB','InfluxDB') {
    $s=Get-Service $svc -ErrorAction SilentlyContinue
    if($s){ [pscustomobject]@{Service=$svc;Status=$s.Status;StartType=$s.StartType} }
}
if(Test-Path (Join-Path $MariaDbBin 'mariadb.exe')) { Write-Host 'MariaDB client present' }
Write-Host 'Historical time-series data is intentionally not restored by this package.'
