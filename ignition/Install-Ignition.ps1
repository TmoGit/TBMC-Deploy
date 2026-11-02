[CmdletBinding()]
param([Parameter(Mandatory)][string]$Installer)
$ErrorActionPreference='Stop'
if(-not (Test-Path $Installer)){throw "Ignition installer not found: $Installer"}
if(-not(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))){throw 'Run as Administrator.'}
$p=Start-Process $Installer -ArgumentList '/quiet' -Wait -PassThru
if($p.ExitCode -ne 0){throw "Ignition installer exit code $($p.ExitCode)"}
Write-Host 'Ignition installed; restore MariaDB before enabling ignitionDB.'
