# Software installation matrix

| Product | Required version | Server | Orchestrator function | Source/checksum | Service/validation |
|---|---|---|---|---|---|
| MariaDB | 10.11 | Ignition | `ignition/Install-Ignition.ps1` → `Get-TbmcVerifiedInstaller` / `Invoke-TbmcInstaller` | Client config; SHA-256 required | `MariaDB`; `Test-Database.ps1` |
| Ignition Gateway | Exact source version required | Ignition | `ignition/Install-Ignition.ps1` | Client config; refuses blank version/hash | `Ignition`; `Test-Ignition.ps1` |
| QuestDB | 9.3.3 | Time-series | `database/Install-Database.ps1` → shared helpers | Client config; SHA-256 required | `QuestDB`; `Test-Database.ps1` |
| InfluxDB | 2.8.0 | Time-series | `database/Install-Database.ps1` → shared helpers | Client config; SHA-256 required | `InfluxDB`; health/API validation pending auth |
| Java | Distribution-dependent | As required by package | Installer-specific | Must be supplied/hash-verified | Version checked by target installer |
| age | Approved Windows build | Both | External prerequisite | Must be supplied/hash-verified | `age --version` |

No component is silently replaced with a newer version. Empty URLs or hashes fail online installation and require an offline verified installer.
