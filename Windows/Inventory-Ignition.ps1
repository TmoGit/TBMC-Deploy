$ErrorActionPreference = 'Stop'
$root = 'C:\Program Files\Inductive Automation\Ignition'
[pscustomobject]@{
    ComputerName = $env:COMPUTERNAME
    OS = (Get-CimInstance Win32_OperatingSystem).Caption
    IgnitionService = (Get-Service Ignition -ErrorAction SilentlyContinue).Status
    IgnitionRoot = $root
    GatewayXml = Test-Path "$root\data\gateway.xml"
    ModulesJson = Test-Path "$root\data\modules.json"
    Projects = @(Get-ChildItem "$root\data\projects" -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name)
} | ConvertTo-Json -Depth 4
