[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$ArtifactDir,
    [Parameter(Mandatory)] [string]$IdentityKey,
    [string]$IgnitionDir = 'C:\Program Files\Inductive Automation\Ignition'
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $ArtifactDir)) { throw "Artifact directory not found: $ArtifactDir" }
if (-not (Test-Path -LiteralPath $IdentityKey)) { throw "Age identity key not found: $IdentityKey" }
$age = Get-Command age.exe -ErrorAction Stop
$service = Get-Service Ignition -ErrorAction SilentlyContinue
if ($service -and $service.Status -ne 'Stopped') { Stop-Service Ignition -Force }
if ($PSCmdlet.ShouldProcess($IgnitionDir, 'Restore encrypted Ignition gateway backup')) {
    Get-ChildItem -LiteralPath $ArtifactDir -Filter '*.age' | ForEach-Object {
        $name = $_.Name.Substring(0, $_.Name.Length - 4)
        $target = Join-Path $IgnitionDir ('data\' + $name)
        & $age.Source --decrypt --identity $IdentityKey --output $target $_.FullName
        if ($LASTEXITCODE -ne 0) { throw "age decryption failed for $($_.Name)" }
    }
}
if ($service) { Start-Service Ignition }
