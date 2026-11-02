[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$Installer,
    [string]$InstallDir = 'C:\Program Files\Inductive Automation\Ignition'
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $Installer)) { throw "Installer not found: $Installer" }
$p = Start-Process -FilePath $Installer -ArgumentList '/quiet' -Wait -PassThru
if ($p.ExitCode -ne 0) { throw "Ignition installer exited with $($p.ExitCode)" }
Write-Host "Ignition installed at $InstallDir"
