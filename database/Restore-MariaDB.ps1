[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$ArtifactDir,
    [Parameter(Mandatory)] [string]$IdentityKey,
    [string]$ArtifactName = 'mariadb-ignition_config-full-2026-11-04.sql.age',
    [string]$ArtifactPartsPrefix = 'mariadb-ignition_config-full-2026-11-04.sql.age.part.',
    [string]$MariaDbBin = 'C:\\Program Files\\MariaDB 10.11\\bin'
)
$ErrorActionPreference = 'Stop'
$age = (Get-Command age.exe -ErrorAction Stop).Source
$dump = Join-Path $env:TEMP ('tbmc-mariadb-' + [guid]::NewGuid() + '.sql')
    $encryptedTemp = Join-Path $env:TEMP ('tbmc-mariadb-' + [guid]::NewGuid() + '.age')
try {
    $artifact = Join-Path $ArtifactDir $ArtifactName
    if (-not (Test-Path $artifact)) {
        $parts = Get-ChildItem -LiteralPath $ArtifactDir -Filter ($ArtifactPartsPrefix + '*') | Sort-Object Name
        if (-not $parts) { throw "MariaDB application dump or parts not found" }
        $destination = [System.IO.File]::Open($encryptedTemp, [System.IO.FileMode]::Create)
        try {
            foreach ($part in $parts) {
                $source = [System.IO.File]::OpenRead($part.FullName)
                try { $source.CopyTo($destination) } finally { $source.Dispose() }
            }
        } finally { $destination.Dispose() }
        $artifact = $encryptedTemp
    }
    & $age --decrypt --identity $IdentityKey --output $dump $artifact
    if ($LASTEXITCODE -ne 0) { throw 'MariaDB dump decryption failed' }
    $client = Join-Path $MariaDbBin 'mariadb.exe'
    if (-not (Test-Path $client)) { throw "MariaDB client not found: $client" }
    if ($PSCmdlet.ShouldProcess('destination MariaDB', 'Restore ignition_config logical backup')) {
        & $client --protocol=TCP --host=127.0.0.1 --port=3306 --user=root $dump
        if ($LASTEXITCODE -ne 0) { throw 'MariaDB restore failed' }
    }
} finally {
    Remove-Item $dump, $encryptedTemp -Force -ErrorAction SilentlyContinue
}
