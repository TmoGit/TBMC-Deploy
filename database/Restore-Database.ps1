[CmdletBinding()]
param([Parameter(Mandatory)][string]$ArtifactDir,[Parameter(Mandatory)][string]$IdentityKey)
$ErrorActionPreference='Stop'
& "$PSScriptRoot\Restore-MariaDB.ps1" -ArtifactDir $ArtifactDir -IdentityKey $IdentityKey
Write-Host 'MariaDB application restore completed. Review destination credentials and endpoints before starting Ignition.'
