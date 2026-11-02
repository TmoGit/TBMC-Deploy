[CmdletBinding()] param(
 [Parameter(Mandatory)][string]$ConfigPath,[string]$InstallerPath,[string]$AgeIdentityPath,
 [switch]$DryRun,[switch]$Resume,[switch]$ValidateOnly,[switch]$AllowExisting
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
. "$PSScriptRoot\..\shared\Test-Prerequisites.ps1"
. "$PSScriptRoot\..\shared\Get-VerifiedInstaller.ps1"
. "$PSScriptRoot\..\shared\Install-Dependencies.ps1"
if(-not(Test-Path $ConfigPath)){throw "Config not found: $ConfigPath"}
$cfg=Get-Content $ConfigPath -Raw|ConvertFrom-Json
$statePath=Join-Path (Split-Path $ConfigPath) 'database-install.state.json'
$logPath=Join-Path (Split-Path $ConfigPath) 'database-install.log'
$state=if(Test-Path $statePath){Get-Content $statePath -Raw|ConvertFrom-Json}else{[pscustomobject]@{Stages=@{}}}
function Done([string]$name){return ($Resume -and $state.Stages.$name -eq 'completed')}
function Mark([string]$name){$state.Stages|Add-Member NoteProperty $name 'completed' -Force;Write-TbmcState $statePath @{Stages=$state.Stages;Updated=(Get-Date).ToUniversalTime().ToString('o')}}
function Expand-TbmcDistribution([string]$archive,[string]$destination){
 if(-not(Test-Path $destination)){New-Item -ItemType Directory -Force $destination|Out-Null}
 if($archive -match '\.zip$'){Expand-Archive -LiteralPath $archive -DestinationPath $destination -Force}
 elseif($archive -match '\.tar\.gz$'){
   & tar.exe -xzf $archive -C $destination
   if($LASTEXITCODE -ne 0){throw "Could not extract $archive"}
 } else {throw "Unsupported distribution format: $archive"}
}
function Register-TbmcService([string]$name,[string]$binary,[string]$args,[string]$workdir){
 if(Get-Service $name -ErrorAction SilentlyContinue){if(-not $AllowExisting){throw "Service $name already exists."};return}
 if($DryRun){Write-Host "DRY RUN: register $name";return}
 New-Service -Name $name -BinaryPathName "`"$binary`" $args" -DisplayName $name -StartupType Automatic -Description 'TBMC deployment service'|Out-Null
}
$transcript=$false
try {
 if(-not $DryRun){Start-Transcript $logPath -Append|Out-Null;$transcript=$true}
 Test-TbmcPrerequisites 'Time-Series Databases' -DryRun:$DryRun|Out-Null
 if($ValidateOnly){& "$PSScriptRoot\Test-Database.ps1";return}
 if($cfg.questDbVersion -ne '9.3.3'){throw 'questDbVersion must be exactly 9.3.3'}
 if($cfg.influxDbVersion -ne '2.8.0'){throw 'influxDbVersion must be exactly 2.8.0'}
 $q=Get-TbmcVerifiedInstaller $cfg.questDbInstallerName '9.3.3' $InstallerPath $cfg.questDbInstallerUrl $cfg.questDbInstallerSha256 -DryRun:$DryRun
 $i=Get-TbmcVerifiedInstaller $cfg.influxDbInstallerName '2.8.0' $InstallerPath $cfg.influxDbInstallerUrl $cfg.influxDbInstallerSha256 -DryRun:$DryRun
 if($DryRun){Write-Host 'DRY RUN: distributions verified or required inputs identified; no extraction, service, state, or log changes made.';return}
 if(-not (Done 'QuestDB')){Expand-TbmcDistribution $q.Path $cfg.serverB.questDbRoot;Register-TbmcService 'QuestDB' (Join-Path $cfg.serverB.questDbRoot 'bin\questdb.exe') "service -d $($cfg.serverB.questDbRoot)\data" (Join-Path $cfg.serverB.questDbRoot 'bin');Mark 'QuestDB'}
 if(-not (Done 'InfluxDB')){Expand-TbmcDistribution $i.Path $cfg.serverB.influxDbRoot;Register-TbmcService 'InfluxDB' (Join-Path $cfg.serverB.influxDbRoot 'influxd.exe') "--bolt-path `"$($cfg.serverB.influxDbRoot)\influxd.bolt`" --engine-path `"$($cfg.serverB.influxDbRoot)\engine`"" $cfg.serverB.influxDbRoot;Mark 'InfluxDB'}
 if($AgeIdentityPath){& "$PSScriptRoot\Restore-TimeSeriesMetadata.ps1" -ArtifactDir $cfg.artifactDirectory -IdentityKey $AgeIdentityPath -QuestDbEndpoint $cfg.serverB.questDbHttpEndpoint}
 if(-not $DryRun){& "$PSScriptRoot\Test-Database.ps1"}
} finally {if($transcript){Stop-Transcript|Out-Null}}
