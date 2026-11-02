[CmdletBinding()]
param(
    [string]$QuestDbInstaller,
    [string]$InfluxDbInstaller,
    [string]$MariaDbInstaller,
    [string]$Config = "$PSScriptRoot\\..\\config\\deployment.example.json",
    [switch]$AllowExisting
)
$ErrorActionPreference = 'Stop'
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { throw 'Run as Administrator.' }
if (-not $AllowExisting -and (Get-Service MariaDB,QuestDB,InfluxDB -ErrorAction SilentlyContinue)) { throw 'Existing database services detected. Review the destination and use -AllowExisting only with explicit approval.' }
if (-not (Test-Path $Config)) { throw "Deployment config not found: $Config" }
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
