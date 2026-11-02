[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$ArtifactDir,
    [Parameter(Mandatory)] [string]$IdentityKey,
    [string]$MariaDbBin = 'C:\\Program Files\\MariaDB 10.11\\bin'
)
$ErrorActionPreference = 'Stop'
$age = (Get-Command age.exe -ErrorAction Stop).Source
$dump = Join-Path $env:TEMP ('tbmc-mariadb-' + [guid]::NewGuid() + '.sql')
try {
    $artifact = Join-Path $ArtifactDir 'mariadb-ignition_config.sql.age'
    if (-not (Test-Path $artifact)) { throw "MariaDB application dump not found" }
    & $age --decrypt --identity $IdentityKey --output $dump $artifact
    if ($LASTEXITCODE -ne 0) { throw 'MariaDB dump decryption failed' }
    $client = Join-Path $MariaDbBin 'mariadb.exe'
    if (-not (Test-Path $client)) { throw "MariaDB client not found: $client" }
    if ($PSCmdlet.ShouldProcess('destination MariaDB', 'Restore ignition_config logical backup')) {
        & $client --protocol=TCP --host=127.0.0.1 --port=3306 --user=root $dump
        if ($LASTEXITCODE -ne 0) { throw 'MariaDB restore failed' }
    }
} finally { Remove-Item $dump -Force -ErrorAction SilentlyContinue }
