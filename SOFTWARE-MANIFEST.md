# Software acquisition manifest

Installers are intentionally not bundled unless redistribution is permitted. Supply approved files through an offline installer directory and verify their SHA-256 before use.

| Component | Required version | Official source | Hash/status |
|---|---|---|---|
| Ignition Gateway | Match source installation; exact native version unresolved | https://inductiveautomation.com/downloads/ignition/ | Proprietary download/licensing; acquire and record SHA-256 |
| MariaDB Server | 10.11 | https://mariadb.org/download/ | Acquire exact 10.11 Windows MSI and record SHA-256 |
| QuestDB | 9.3.3 package path observed | https://questdb.com/download/ | Acquire exact Windows package and record SHA-256 |
| InfluxDB | 2.8.0 | https://www.influxdata.com/downloads/ | Acquire exact Windows package and record SHA-256 |
| Java | 17.0.9 for QuestDB; Ignition runtime previously observed as 17.0.17 | Approved Temurin/Corretto or vendor-bundled runtime | Verify separately; do not substitute silently |
| age | Current approved Windows build | https://github.com/FiloSottile/age/releases | Verify SHA-256 before deployment |

No license keys or activation credentials are included. Current scripts support local installer paths and fail when required installers are absent.
