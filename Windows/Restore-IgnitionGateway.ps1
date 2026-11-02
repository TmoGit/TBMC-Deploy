[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$Backup,
    [string]$IgnitionDir = 'C:\Program Files\Inductive Automation\Ignition'
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $Backup)) { throw "Backup not found: $Backup" }
$service = Get-Service Ignition -ErrorAction SilentlyContinue
if ($service -and $service.Status -ne 'Stopped') { Stop-Service Ignition -Force }
if ($PSCmdlet.ShouldProcess($IgnitionDir, 'Restore encrypted Ignition gateway backup')) {
    Expand-Archive -LiteralPath $Backup -DestinationPath $IgnitionDir -Force
}
if ($service) { Start-Service Ignition }
