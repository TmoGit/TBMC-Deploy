function Test-TbmcPrerequisites {
 [CmdletBinding()] param([string]$Role,[switch]$DryRun)
 $p=[Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
 if(-not $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'Run PowerShell as Administrator.'}
 $os=Get-CimInstance Win32_OperatingSystem; if([int]$os.BuildNumber -lt 17763){throw "Unsupported Windows build: $($os.BuildNumber)"}
 $free=(Get-PSDrive -Name ($env:SystemDrive.TrimEnd(':'))).Free; if($free -lt 10GB){throw 'Less than 10 GB free on system drive.'}
 [pscustomobject]@{Role=$Role;Computer=$env:COMPUTERNAME;OS=$os.Caption;Build=$os.BuildNumber;FreeBytes=$free;DryRun=$DryRun.IsPresent}
}
