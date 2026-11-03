#requires -Version 5.1
<#
.SYNOPSIS
 Single-entry TBMC deployment for Database server, on an existing Windows Server.
.DESCRIPTION
 Extracts a locally supplied TBMC-Deploy GitHub ZIP (if not already staged),
 validates the package, prepares directories, runs the repository installer
 dry-run, then invokes the repository installer for real if preflight succeeds.
 Never bypasses the underlying installer's safeguards.
.EXAMPLE
 .\Deploy-TBMC-Database.ps1 -ZipPath 'E:\TBMC-Deploy-main.zip'
.EXAMPLE
 .\Deploy-TBMC-Database.ps1 -ZipPath 'E:\TBMC-Deploy-main.zip' -ConfigFile 'E:\client.json' -AgeIdentityPath 'E:\deploy.key'
.EXAMPLE
 .\Deploy-TBMC-Database.ps1 -ZipPath 'E:\TBMC-Deploy-main.zip' -DryRunOnly
#>
[CmdletBinding()]
param(
 [string]$ZipPath,
 [string]$DestinationRoot = 'C:\TBMC',
 [string]$ConfigFile,
 [string]$AgeIdentityPath,
 [string]$InstallerPath,
 [switch]$DryRunOnly,
 [switch]$Resume
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$Role = 'Database'
$Entry = 'database\Install-Database.ps1'
function Assert-Admin {
 $id=[Security.Principal.WindowsIdentity]::GetCurrent()
 $p=New-Object Security.Principal.WindowsPrincipal($id)
 if (-not $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { throw 'Run Windows PowerShell as Administrator.' }
}
function Resolve-Existing([string]$p,[string]$name) {
 if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { throw "$name not found: $p" }
 return (Resolve-Path -LiteralPath $p).ProviderPath
}
function Assert-Under([string]$path,[string]$base) {
 $b=[IO.Path]::GetFullPath($base).TrimEnd('\','/')+'\'
 $f=[IO.Path]::GetFullPath($path)
 if (-not $f.StartsWith($b,[StringComparison]::OrdinalIgnoreCase)) { throw "Unsafe ZIP entry: $path" }
}
function Get-SingleRepo([string]$staging) {
 $paths=@($staging)+@(Get-ChildItem -LiteralPath $staging -Directory | ForEach-Object {$_.FullName})
 $matches=@($paths | Where-Object {
    (Test-Path -LiteralPath (Join-Path $_ 'ignition\Install-Ignition.ps1')) -and
    (Test-Path -LiteralPath (Join-Path $_ 'database\Install-Database.ps1'))
 })
 if ($matches.Count -ne 1) {throw 'Archive must contain one TBMC-Deploy folder with both orchestrators.'}
 return $matches[0]
}
function Assert-Parse([string]$scriptPath) {
 $tokens=$null; $parseErrors=$null
 [void][Management.Automation.Language.Parser]::ParseFile($scriptPath,[ref]$tokens,[ref]$parseErrors)
 if ($parseErrors.Count -gt 0) {throw "PowerShell syntax errors: $scriptPath"}
}
Assert-Admin
$root=[IO.Path]::GetFullPath($DestinationRoot)
$repo=Join-Path $root 'TBMC-Deploy'
$installers=if($InstallerPath){$InstallerPath}else{Join-Path $root 'Installers'}
$key=if($AgeIdentityPath){$AgeIdentityPath}else{Join-Path $root 'Secure\deploy.key'}
foreach($dir in @($root,$installers,(Join-Path $root 'Logs'),(Join-Path $root 'Backups'),(Join-Path $root 'Secure'))){
 if(-not(Test-Path -LiteralPath $dir)){New-Item -ItemType Directory -Path $dir -Force | Out-Null}
}
if(-not(Test-Path -LiteralPath (Join-Path $repo $Entry))){
 if (-not $ZipPath) {
   $zips=@(Get-ChildItem -LiteralPath $PSScriptRoot -File -Filter '*.zip' | Where-Object {$_.Name -match 'TBMC.?Deploy'})
   if($zips.Count -ne 1){throw 'Supply -ZipPath to the TBMC-Deploy ZIP (or place exactly one matching ZIP beside this script).'}
   $ZipPath=$zips[0].FullName
 }
 $zip=Resolve-Existing $ZipPath 'Repository ZIP'
 $staging=Join-Path $root ('_extract_'+[guid]::NewGuid().ToString('N'))
 New-Item -ItemType Directory -Path $staging | Out-Null
 Add-Type -AssemblyName System.IO.Compression
 Add-Type -AssemblyName System.IO.Compression.FileSystem
 try {
   $archive=[IO.Compression.ZipFile]::OpenRead($zip)
   try {
     $sum=[long]0
     foreach($e in $archive.Entries){
       $relative=$e.FullName.Replace('/','\')
       if([string]::IsNullOrWhiteSpace($relative)){continue}
       if([IO.Path]::IsPathRooted($relative) -or $relative.StartsWith('\')){throw "Unsafe ZIP path: $relative"}
       $dest=Join-Path $staging $relative
       Assert-Under $dest $staging
       $sum += $e.Length
       if($sum -gt 10GB){throw 'ZIP expands over 10 GB; check package before deployment.'}
       if($e.FullName.EndsWith('/')){New-Item -ItemType Directory -Path $dest -Force | Out-Null;continue}
       New-Item -ItemType Directory -Path (Split-Path -Parent $dest) -Force | Out-Null
       [IO.Compression.ZipFileExtensions]::ExtractToFile($e,$dest,$false)
     }
   } finally {$archive.Dispose()}
   $source=Get-SingleRepo $staging
   Assert-Parse (Join-Path $source $Entry)
   if(Test-Path -LiteralPath $repo){throw "Existing repository folder at $repo is incomplete. Back it up or remove it manually; refusing overwrite."}
   Move-Item -LiteralPath $source -Destination $repo
 } finally {if(Test-Path -LiteralPath $staging){Remove-Item -LiteralPath $staging -Recurse -Force}}
 Write-Host "Extracted TBMC-Deploy to $repo" -ForegroundColor Cyan
}
$entryPath=Join-Path $repo $Entry
Assert-Parse $entryPath
$configDir=Join-Path $repo 'config'
$configDest=Join-Path $configDir 'client.json'
if($ConfigFile){
 $provided=Resolve-Existing $ConfigFile 'Client deployment configuration'
 if((Test-Path -LiteralPath $configDest) -and ((Resolve-Path -LiteralPath $configDest).ProviderPath -ne $provided)){
   throw "Configuration already exists at $configDest. Refusing to overwrite; review it or use existing configuration."
 }
 if(-not(Test-Path -LiteralPath $configDest)){Copy-Item -LiteralPath $provided -Destination $configDest}
}
if(-not(Test-Path -LiteralPath $configDest)){
 $template=Join-Path $configDir 'deployment.example.json'
 if(-not(Test-Path -LiteralPath $template)){throw 'No client.json or deployment.example.json in repository.'}
 Copy-Item -LiteralPath $template -Destination $configDest
 Write-Warning "Created $configDest from example. Review all required values before live installation."
}
try {$null=Get-Content -LiteralPath $configDest -Raw | ConvertFrom-Json}
catch{throw "Invalid JSON configuration: $configDest ($($_.Exception.Message))"}
if(-not(Test-Path -LiteralPath $key -PathType Leaf)){
 throw "age private identity key is missing: $key. Copy it securely from the source host (never commit it to Git)."
}
Write-Host "`nPreparing $Role using $entryPath" -ForegroundColor Cyan
Write-Host "Configuration: $configDest"
Write-Host "Offline installers: $installers"
Write-Host 'Running mandatory installation dry run...' -ForegroundColor Yellow
Push-Location $repo
try {
 $params=@{ConfigPath=$configDest; InstallerPath=$installers; AgeIdentityPath=$key}
 & $entryPath @params -DryRun
 if(-not $?){throw 'Deployment dry run returned an unsuccessful status.'}
 if($DryRunOnly){Write-Host 'Dry run completed; no live installation requested.' -ForegroundColor Green;return}
 Write-Host 'Dry run finished. Starting deployment orchestrator...' -ForegroundColor Yellow
 if($Resume){& $entryPath @params -Resume}else{& $entryPath @params}
 if(-not $?){throw 'Deployment orchestrator returned an unsuccessful status.'}
 Write-Host "`n$Role orchestration returned successfully. Run service/application validation and review logs before cutover." -ForegroundColor Green
}finally{Pop-Location}
