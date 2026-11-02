function Get-TbmcVerifiedInstaller {
 [CmdletBinding()] param([Parameter(Mandatory)][string]$Name,[Parameter(Mandatory)][string]$Version,[string]$InstallerPath,[string]$Url,[string]$Sha256,[switch]$DryRun)
 $file=if($InstallerPath){Join-Path $InstallerPath $Name}else{$null}
 if($file -and (Test-Path $file)){}
 elseif($Url -and -not $DryRun){if(-not $InstallerPath){throw 'InstallerPath is required for downloads.'};New-Item -ItemType Directory -Force $InstallerPath|Out-Null;$file=Join-Path $InstallerPath $Name;Invoke-WebRequest $Url -OutFile $file -UseBasicParsing}
 elseif($DryRun){return [pscustomobject]@{Name=$Name;Version=$Version;Path=$file;DryRun=$true}}
 else{throw "Required $Name $Version installer is missing."}
 if(-not $Sha256){throw "No SHA-256 recorded for $Name $Version."}; $actual=(Get-FileHash $file -Algorithm SHA256).Hash
 if($actual -ne $Sha256){throw "SHA-256 mismatch for $file"}; [pscustomobject]@{Name=$Name;Version=$Version;Path=$file;Sha256=$actual;Verified=$true}
}
