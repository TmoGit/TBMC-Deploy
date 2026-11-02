[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$ArtifactDir,
    [Parameter(Mandatory)] [string]$IdentityKey,
    [string]$Destination = 'C:\\Program Files\\Inductive Automation\\Ignition'
)
$ErrorActionPreference = 'Stop'
$age = (Get-Command age.exe -ErrorAction Stop).Source
if (-not (Test-Path $IdentityKey)) { throw "Age identity key not found" }
$work = Join-Path $env:TEMP ('tbmc-restore-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $work | Out-Null
try {
    $decrypt = {
        param($src, $dst)
        & $age --decrypt --identity $IdentityKey --output $dst $src
        if ($LASTEXITCODE -ne 0) { throw "Decryption failed: $src" }
    }
    Get-ChildItem $ArtifactDir -Filter '*.age' | Where-Object Name -match '^(gateway\.xml|modules\.json|commissioning\.json|ignition\.conf)\.age$' | ForEach-Object {
        $target = Join-Path $work $_.Name.Substring(0, $_.Name.Length - 4)
        & $age --decrypt --identity $IdentityKey --output $target $_.FullName
        if ($LASTEXITCODE -ne 0) { throw "Decryption failed: $($_.Name)" }
    }
    if ($PSCmdlet.ShouldProcess($Destination, 'Restore VM 133 encrypted supplemental archives')) {
        Get-ChildItem $ArtifactDir -Filter 'projects.tar.gz.age' | ForEach-Object { & $age --decrypt --identity $IdentityKey --output (Join-Path $work 'projects.tar.gz') $_.FullName }
        Get-ChildItem $ArtifactDir -Filter 'gateway-resources.tar.gz.age' | ForEach-Object { & $age --decrypt --identity $IdentityKey --output (Join-Path $work 'gateway-resources.tar.gz') $_.FullName }
        Get-ChildItem $ArtifactDir -Filter 'csv-historian.tar.gz.age' | ForEach-Object { & $age --decrypt --identity $IdentityKey --output (Join-Path $work 'csv-historian.tar.gz') $_.FullName }
        $parts = Get-ChildItem $ArtifactDir -Filter 'modules.part.*.age' | Sort-Object Name
        $moduleTar = Join-Path $work 'modules.tar.gz'
        $out = [IO.File]::Open($moduleTar, [IO.FileMode]::Create)
        try { foreach ($part in $parts) { $tmp = Join-Path $work $part.Name; & $age --decrypt --identity $IdentityKey --output $tmp $part.FullName; if ($LASTEXITCODE -ne 0) { throw "Decryption failed: $($part.Name)" }; $bytes=[IO.File]::ReadAllBytes($tmp); $out.Write($bytes,0,$bytes.Length) } } finally { $out.Dispose() }
        tar.exe -xzf (Join-Path $work 'projects.tar.gz') -C $Destination
        tar.exe -xzf (Join-Path $work 'gateway-resources.tar.gz') -C $Destination
        tar.exe -xzf $moduleTar -C (Join-Path $Destination 'user-lib')
        Write-Host 'Encrypted artifacts decrypted and extracted. Review external endpoints before starting Ignition.'
    }
} finally { Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue }
