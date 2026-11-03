#requires -Version 5.1
<#
.SYNOPSIS
 One-click, self-contained Ignition TBMC setup for an existing Windows Server.
.DESCRIPTION
 Run this script from the extracted TBMC-Deploy-main folder on the Windows Desktop.
 It discovers the folder, stages it at C:\TBMC\TBMC-Deploy, prepares support folders,
 copies a supplied client.json and/or age identity key if present on the Desktop,
 checks the underlying installation entry point, runs its dry run, and, after an
 explicit confirmation, launches the actual installer/restorer.

 No Proxmox access is needed. This cannot manufacture missing software packages,
 the age private key, client values, or the unknown Ignition version.
#>
[CmdletBinding()]
param(
    [string]$DestinationRoot = 'C:\TBMC',
    [switch]$DryRunOnly,
    [switch]$Resume
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$Role = 'Ignition'
$RelativeEntry = 'ignition\Install-Ignition.ps1'

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Right-click > Run with PowerShell also works when the user is not already elevated.
if (-not (Test-IsAdministrator)) {
    Write-Host 'Requesting administrator approval (Windows UAC)...' -ForegroundColor Yellow
    $ps = Join-Path $PSHOME 'powershell.exe'
    $launch = '-NoProfile -ExecutionPolicy Bypass -File "' + $PSCommandPath + '"'
    if ($DryRunOnly) { $launch += ' -DryRunOnly' }
    if ($Resume) { $launch += ' -Resume' }
    if ($DestinationRoot -ne 'C:\TBMC') { $launch += ' -DestinationRoot "' + $DestinationRoot + '"' }
    try {
        $proc = Start-Process -FilePath $ps -Verb RunAs -ArgumentList $launch -Wait -PassThru
        exit $proc.ExitCode
    }
    catch {
        Write-Host ('Administrator elevation was not approved: ' + $_.Exception.Message) -ForegroundColor Red
        exit 1
    }
}

function Test-TbmcRepository([string]$Candidate) {
    if ([string]::IsNullOrWhiteSpace($Candidate)) { return $false }
    if (-not (Test-Path -LiteralPath $Candidate -PathType Container)) { return $false }
    return ((Test-Path -LiteralPath (Join-Path $Candidate 'ignition\Install-Ignition.ps1') -PathType Leaf) -and
            (Test-Path -LiteralPath (Join-Path $Candidate 'database\Install-Database.ps1') -PathType Leaf))
}

function Get-DesktopFolders {
    $paths = New-Object 'System.Collections.Generic.List[string]'
    $paths.Add([Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory))
    if ($env:USERPROFILE) { $paths.Add((Join-Path $env:USERPROFILE 'Desktop')) }
    if ($env:PUBLIC) { $paths.Add((Join-Path $env:PUBLIC 'Desktop')) }
    if ($env:OneDrive) { $paths.Add((Join-Path $env:OneDrive 'Desktop')) }
    if ($env:OneDriveCommercial) { $paths.Add((Join-Path $env:OneDriveCommercial 'Desktop')) }
    return @($paths | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Container) } | Select-Object -Unique)
}

function Find-ExtractedRepository {
    $candidates = New-Object 'System.Collections.Generic.List[string]'
    $candidates.Add($PSScriptRoot)
    $candidates.Add((Join-Path $PSScriptRoot 'TBMC-Deploy-main'))
    $candidates.Add((Join-Path $PSScriptRoot 'TBMC-Deploy'))
    foreach ($desktop in @(Get-DesktopFolders)) {
        $candidates.Add((Join-Path $desktop 'TBMC-Deploy-main'))
        $candidates.Add((Join-Path $desktop 'TBMC-Deploy'))
        foreach ($dir in @(Get-ChildItem -LiteralPath $desktop -Directory -ErrorAction SilentlyContinue |
                     Where-Object { $_.Name -like 'TBMC-Deploy*' })) {
            $candidates.Add($dir.FullName)
        }
    }
    foreach ($candidate in @($candidates | Select-Object -Unique)) {
        if (Test-TbmcRepository $candidate) { return (Resolve-Path -LiteralPath $candidate).ProviderPath }
    }
    return $null
}

function Assert-PowerShellSyntax([string]$Path) {
    $tokens = $null
    $parseErrors = $null
    [void][Management.Automation.Language.Parser]::ParseFile($Path, [ref]$tokens, [ref]$parseErrors)
    if (@($parseErrors).Count -gt 0) {
        $details = @($parseErrors | Select-Object -First 3 | ForEach-Object { $_.Message }) -join '; '
        throw ('PowerShell syntax errors in ' + $Path + ': ' + $details)
    }
}

function Copy-TreeWithoutJunctions([string]$Source, [string]$Destination) {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    # Never copy deploy.key into the repository: it belongs outside Git.
    & robocopy.exe $Source $Destination /E /XJ /R:2 /W:1 /COPY:DAT /DCOPY:DAT /NP /NJH /NJS /NFL /NDL /XF deploy.key | Out-Null
    $result = $LASTEXITCODE
    $global:LASTEXITCODE = 0
    if ($result -ge 8) { throw ('File staging failed; robocopy exit code ' + $result) }
}

function Protect-KeyFile([string]$Path) {
    # Readable only by current account, local Administrators, and SYSTEM.
    $acl = Get-Acl -LiteralPath $Path
    $acl.SetAccessRuleProtection($true, $false)
    $currentSid = [Security.Principal.WindowsIdentity]::GetCurrent().User
    $sids = @($currentSid,
              (New-Object Security.Principal.SecurityIdentifier('S-1-5-18')),
              (New-Object Security.Principal.SecurityIdentifier('S-1-5-32-544')))
    foreach ($sid in $sids) {
        $rule = [System.Security.AccessControl.FileSystemAccessRule]::new(
            $sid, [System.Security.AccessControl.FileSystemRights]::FullControl,
            [System.Security.AccessControl.AccessControlType]::Allow)
        $acl.SetAccessRule($rule)
    }
    Set-Acl -LiteralPath $Path -AclObject $acl
}

function Confirm-Installation([string]$RoleLabel) {
    try {
        Add-Type -AssemblyName System.Windows.Forms
        $answer = [System.Windows.Forms.MessageBox]::Show(
            "Dry run completed. Start the LIVE $RoleLabel installation and restoration on this Windows machine?`n`nChoose No to exit without installing anything.",
            'TBMC deployment - approval required',
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning,
            [System.Windows.Forms.MessageBoxDefaultButton]::Button2)
        return ($answer -eq [System.Windows.Forms.DialogResult]::Yes)
    }
    catch {
        $answer = Read-Host 'To start LIVE installation, type INSTALL (otherwise press Enter)'
        return ($answer -eq 'INSTALL')
    }
}

try {
    Write-Host "`nTBMC Deployment: $Role Server" -ForegroundColor Cyan
    Write-Host 'Step 1/5 - Locate extracted repository on the Windows desktop'
    $root = [IO.Path]::GetFullPath($DestinationRoot)
    $repo = Join-Path $root 'TBMC-Deploy'
    $source = Find-ExtractedRepository
    if (-not $source -and -not (Test-TbmcRepository $repo)) {
        throw 'Cannot find TBMC-Deploy-main on this Windows desktop. Unzip the GitHub repository to the Desktop and run the script from inside that folder.'
    }
    if ($source) { Write-Host ('Found source: ' + $source) }

    Write-Host 'Step 2/5 - Prepare C:\TBMC folders and stage deployment files'
    foreach ($folder in @($root, (Join-Path $root 'Installers'), (Join-Path $root 'Backups'),
                         (Join-Path $root 'Logs'), (Join-Path $root 'Secure'))) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
    }
    if (Test-TbmcRepository $repo) {
        Write-Host ('Using previously staged repository: ' + $repo) -ForegroundColor Yellow
        Write-Host 'Existing client configuration and deployment journals have been preserved.'
    }
    else {
        if (Test-Path -LiteralPath $repo) {
            throw ('An incomplete folder already exists at ' + $repo + '. Refusing to overwrite it.')
        }
        if (-not $source) { throw 'No extracted repository folder was found.' }
        Copy-TreeWithoutJunctions $source $repo
        Write-Host ('Repository staged at: ' + $repo) -ForegroundColor Green
    }

    $entryPath = Join-Path $repo $RelativeEntry
    Assert-PowerShellSyntax $entryPath
    $configDir = Join-Path $repo 'config'
    $configOut = Join-Path $configDir 'client.json'
    $configCreatedFromTemplate = $false
    if (-not (Test-Path -LiteralPath $configOut -PathType Leaf)) {
        $copied = $false
        foreach ($folder in @($PSScriptRoot) + @(Get-DesktopFolders)) {
            $externalConfig = Join-Path $folder 'client.json'
            if (Test-Path -LiteralPath $externalConfig -PathType Leaf) {
                Copy-Item -LiteralPath $externalConfig -Destination $configOut
                $copied = $true
                Write-Host ('Client configuration copied from: ' + $externalConfig)
                break
            }
        }
        if (-not $copied) {
            $template = Join-Path $configDir 'deployment.example.json'
            if (-not (Test-Path -LiteralPath $template -PathType Leaf)) {
                throw 'Missing config\deployment.example.json and no client.json was supplied.'
            }
            Copy-Item -LiteralPath $template -Destination $configOut
            $configCreatedFromTemplate = $true
            Write-Warning 'Created client.json from the EXAMPLE template. It must be reviewed before live installation.'
        }
    }
    try { $null = Get-Content -LiteralPath $configOut -Raw | ConvertFrom-Json }
    catch { throw ('Invalid config\client.json: ' + $_.Exception.Message) }
    $templatePath = Join-Path $configDir 'deployment.example.json'
    $configIsTemplate = $false
    if (Test-Path -LiteralPath $templatePath -PathType Leaf) {
        $configIsTemplate = ((Get-FileHash -LiteralPath $configOut -Algorithm SHA256).Hash -eq
                             (Get-FileHash -LiteralPath $templatePath -Algorithm SHA256).Hash)
    }

    # Automatically stage a separately supplied installer folder when present.
    $installerDest = Join-Path $root 'Installers'
    foreach ($folder in @($PSScriptRoot) + @(Get-DesktopFolders)) {
        foreach ($name in @('TBMC-Installers','Installers')) {
            $possible = Join-Path $folder $name
            if ((Test-Path -LiteralPath $possible -PathType Container) -and
                -not ($possible.TrimEnd('\') -ieq $installerDest.TrimEnd('\'))) {
                Copy-TreeWithoutJunctions $possible $installerDest
                Write-Host ('Offline installers staged from: ' + $possible)
            }
        }
    }

    Write-Host 'Step 3/5 - Find the age decryption identity, if supplied'
    $key = Join-Path $root 'Secure\deploy.key'
    if (-not (Test-Path -LiteralPath $key -PathType Leaf)) {
        $keyCandidates = New-Object 'System.Collections.Generic.List[string]'
        foreach ($folder in @($PSScriptRoot) + @(Get-DesktopFolders)) {
            $keyCandidates.Add((Join-Path $folder 'deploy.key'))
        }
        foreach ($possible in @($keyCandidates | Select-Object -Unique)) {
            if (Test-Path -LiteralPath $possible -PathType Leaf) {
                Copy-Item -LiteralPath $possible -Destination $key
                Write-Host ('Private key staged securely from: ' + $possible)
                Write-Warning 'After deployment, securely remove any unprotected Desktop copy of deploy.key.'
                break
            }
        }
    }
    if (Test-Path -LiteralPath $key -PathType Leaf) { Protect-KeyFile $key }

    Write-Host 'Step 4/5 - Run the repository orchestrator preflight'
    Write-Host ('Entry: ' + $entryPath)
    Write-Host ('Config: ' + $configOut)
    Write-Host ('Offline installer directory: ' + $installerDest)
    if (-not (Test-Path -LiteralPath $key -PathType Leaf)) {
        throw ('Missing private age key. Place deploy.key on the Desktop, then run THIS SAME script again. It will stage the file at ' + $key)
    }

    Push-Location $repo
    try {
        $arguments = @{
            ConfigPath = $configOut
            InstallerPath = $installerDest
            AgeIdentityPath = $key
        }
        $global:LASTEXITCODE = 0
        & $entryPath @arguments -DryRun
        if (-not $? -or $LASTEXITCODE -ne 0) {
            throw 'The underlying installer dry run failed. Check the message above for missing files, versions, hashes, or settings.'
        }
        Write-Host 'Dry run succeeded.' -ForegroundColor Green

        if ($DryRunOnly) {
            Write-Host 'DryRunOnly was selected. No application installation was started.' -ForegroundColor Green
            exit 0
        }
        if ($configCreatedFromTemplate -or $configIsTemplate) {
            throw ('The configuration is still identical to the example template: ' + $configOut + '. Supply verified client settings, installer versions and hashes; then rerun the SAME launcher.')
        }
        Write-Host 'Step 5/5 - Request approval for live installation'
        if (-not (Confirm-Installation $Role)) {
            Write-Host 'Live installation cancelled. Preparation is complete; rerun this launcher later.' -ForegroundColor Yellow
            exit 0
        }
        $global:LASTEXITCODE = 0
        if ($Resume) { & $entryPath @arguments -Resume }
        else { & $entryPath @arguments }
        if (-not $? -or $LASTEXITCODE -ne 0) {
            throw 'Installer did not return a clean success status. Review its logs before proceeding.'
        }
        Write-Host "`n$Role installation orchestrator finished. Review application validation before enabling live integrations." -ForegroundColor Green
        exit 0
    }
    finally { Pop-Location }
}
catch {
    Write-Host "`nTBMC preparation or deployment stopped safely:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host 'You can rerun this same script after resolving the issue; existing files are preserved.' -ForegroundColor Yellow
    exit 1
}
