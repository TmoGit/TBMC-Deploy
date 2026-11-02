[CmdletBinding()] param(
 [Parameter(Mandatory)][string]$ConfigPath,[string]$InstallerPath,[string]$AgeIdentityPath,
 [switch]$DryRun,[switch]$Resume,[switch]$ValidateOnly,[switch]$AllowExisting
)
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
. "$PSScriptRoot\..\shared\Test-Prerequisites.ps1";. "$PSScriptRoot\..\shared\Get-VerifiedInstaller.ps1";. "$PSScriptRoot\..\shared\Install-Dependencies.ps1"
if(-not(Test-Path $ConfigPath)){throw "Config not found: $ConfigPath"};$cfg=Get-Content $ConfigPath -Raw|ConvertFrom-Json
$statePath=Join-Path (Split-Path $ConfigPath) 'ignition-install.state.json';$logPath=Join-Path (Split-Path $ConfigPath) 'ignition-install.log'
$state=if(Test-Path $statePath){Get-Content $statePath -Raw|ConvertFrom-Json}else{[pscustomobject]@{Stages=@{}}}
function Done([string]$name){return ($Resume -and $state.Stages.$name -eq 'completed')}
function Mark([string]$name){$state.Stages|Add-Member NoteProperty $name 'completed' -Force;Write-TbmcState $statePath @{Stages=$state.Stages;Updated=(Get-Date).ToUniversalTime().ToString('o')}}
$transcript=$false
try {
 Test-TbmcPrerequisites 'Ignition/MariaDB' -DryRun:$DryRun|Out-Null
 if($ValidateOnly){& "$PSScriptRoot\Test-Ignition.ps1" -IgnitionDir $cfg.serverA.ignitionInstallDir;return}
 if(-not $AllowExisting -and (Get-Service MariaDB,Ignition -ErrorAction SilentlyContinue)){throw 'Existing MariaDB or Ignition service detected; approve -AllowExisting explicitly.'}
 if(-not $DryRun -and -not $AgeIdentityPath){throw 'Age identity key is required'}
 if(-not $cfg.ignitionVersion){throw 'Exact ignitionVersion is required; refusing latest-version substitution.'}
 $m=Get-TbmcVerifiedInstaller $cfg.mariaDbInstallerName '10.11' $InstallerPath $cfg.mariaDbInstallerUrl $cfg.mariaDbInstallerSha256 -DryRun:$DryRun
 $g=Get-TbmcVerifiedInstaller $cfg.ignitionInstallerName $cfg.ignitionVersion $InstallerPath $cfg.ignitionInstallerUrl $cfg.ignitionInstallerSha256 -DryRun:$DryRun
 if($DryRun){Write-Host 'DRY RUN: no installation, extraction, restore, service, state, or log changes made.';return}
 Start-Transcript $logPath -Append|Out-Null;$transcript=$true
 if(-not (Done 'MariaDB')){Invoke-TbmcInstaller $m.Path $cfg.mariaDbInstallerArguments;& "$PSScriptRoot\..\database\Restore-MariaDB.ps1" -ArtifactDir $cfg.artifactDirectory -IdentityKey $AgeIdentityPath;Mark 'MariaDB'}
 if(-not (Done 'Ignition')){Invoke-TbmcInstaller $g.Path $cfg.ignitionInstallerArguments;& "$PSScriptRoot\Restore-Ignition.ps1" -ArtifactDir $cfg.artifactDirectory -IdentityKey $AgeIdentityPath;Mark 'Ignition'}
 & "$PSScriptRoot\Test-Ignition.ps1" -IgnitionDir $cfg.serverA.ignitionInstallDir
} finally {if($transcript){Stop-Transcript|Out-Null}}
