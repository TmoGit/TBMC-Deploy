[CmdletBinding()]
param([Parameter(Mandatory)][string]$ArtifactDir,[Parameter(Mandatory)][string]$IdentityKey)
$ErrorActionPreference='Stop'
& "$PSScriptRoot\..\Windows\Restore-VM133Artifacts.ps1" -ArtifactDir $ArtifactDir -IdentityKey $IdentityKey
