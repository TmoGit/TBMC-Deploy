# VM 133 resource inventory

Collected through QEMU Guest Agent. Ignition was not stopped or restarted.

## Projects

| Project | Files | Bytes |
|---|---:|---:|
| `.resources` | 1,050 | 21,389,220 |
| `samplequickstart` | 652 | 8,511,969 |
| `SCADA_Template_Project` | 466 | 5,155,149 |
| `TBMC` | 494 | 5,855,000 |
| `TBMC_CT_DEMO` | 764 | 12,011,686 |

## Runtime and modules

- Ignition Java runtime: `17.0.17`
- Custom module directory: `Ignition\\user-lib\\modules`
- Custom modules include MQTT Engine, MQTT Transmission, Historian, InfluxDB, MariaDB JDBC, MSSQL JDBC, PostgreSQL JDBC, OPC-UA, Perspective, Vision, SQL Bridge, SQL Historian, PLC drivers, reporting, SFC, Symbol Factory, and notification modules.
- JDBC modules are present as MariaDB, MSSQL, and PostgreSQL module packages. No separate user JDBC JARs were identified in `user-lib` by the inventory query.
- CSV historian configuration points to `C:\\Program Files\\Inductive Automation\\CSV_IN`; the directory contains one file totaling 164,944 bytes.

## Transfer status

The four project trees total approximately 52.9 MB, and custom modules total approximately 338 MB. A guest-side archive command was started through QGA but exceeded the synchronous command window and could not yet be accepted as a verified artifact. No plaintext project/module archive was published.

The encrypted metadata artifacts and their verified hashes remain unchanged from commit `296ae49`.
