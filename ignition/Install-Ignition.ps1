[CmdletBinding()]
param([Parameter(Mandatory)][string]$Installer,[string]$Config="$PSScriptRoot\\..\\config\\deployment.example.json",[switch]$AllowExisting)
$ErrorActionPreference='Stop'
if(-not (Test-Path $Installer)){throw "Ignition installer not found: $Installer"}
if(-not(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))){throw 'Run as Administrator.'}
if(-not (Test-Path $Config)){throw "Deployment config not found: $Config"}
$existing=Get-Service Ignition -ErrorAction SilentlyContinue
if($existing -and -not $AllowExisting){throw 'Existing Ignition service detected. Review destination before proceeding.'}
$p=Start-Process $Installer -ArgumentList '/quiet' -Wait -PassThru
if($p.ExitCode -ne 0){throw "Ignition installer exit code $($p.ExitCode)"}
Write-Host 'Ignition installed; restore MariaDB before enabling ignitionDB.'
