[CmdletBinding()]
param([string]$IgnitionDir='C:\\Program Files\\Inductive Automation\\Ignition')
$ErrorActionPreference='Stop'
$svc=Get-Service Ignition -ErrorAction SilentlyContinue
[pscustomobject]@{Installed=(Test-Path $IgnitionDir);ServiceStatus=if($svc){$svc.Status}else{'NotInstalled'};GatewayXml=Test-Path "$IgnitionDir\data\gateway.xml";Projects=Test-Path "$IgnitionDir\data\projects"}
Write-Host 'External PLC, MQTT, InfluxDB, and database endpoints require destination-specific review.'
