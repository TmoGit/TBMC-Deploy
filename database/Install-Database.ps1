[CmdletBinding()]
param(
    [string]$QuestDbInstaller,
    [string]$InfluxDbInstaller,
    [string]$MariaDbInstaller
)
$ErrorActionPreference = 'Stop'
foreach ($item in @(
    @{Name='QuestDB'; Path=$QuestDbInstaller},
    @{Name='InfluxDB'; Path=$InfluxDbInstaller},
    @{Name='MariaDB'; Path=$MariaDbInstaller}
)) {
    if ($item.Path) {
        if (-not (Test-Path $item.Path)) { throw "$($item.Name) installer not found: $($item.Path)" }
        Write-Host "Installer supplied for $($item.Name): $($item.Path)"
    } else { Write-Warning "$($item.Name) installer was not supplied; obtain the approved version before deployment." }
}
Write-Host 'No database service was started and no live endpoint was configured by this validation script.'
