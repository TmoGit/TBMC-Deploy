# VM 132 database classification

No large backup was started. Services and schema were inspected through QEMU Guest Agent.

| Engine / table | Observed role | Approx. size | Required depth | Status |
|---|---|---:|---|---|
| QuestDB `cpu`, `disk`, `mem`, `net` | Host telemetry measurements | ~20 GB combined | Schema/configuration only | Schema encrypted and published |
| QuestDB `sparkplug_metric`, `sparkplug_status`, `mqtt_clients` | MQTT/Sparkplug telemetry and status history | ~26 GB combined | Schema/configuration only | Schema encrypted and published |
| QuestDB `sensor`, `sensor_new`, `tbmc_sensor_data` | Sensor measurements | ~3.5 MB | Schema/configuration only | Schema encrypted and published |
| QuestDB `win_services` | Time-stamped Windows service telemetry | ~14 GB | Schema/configuration only | Schema encrypted and published |
| QuestDB system tables | Engine metadata | small | Schema/configuration only | Schema encrypted and published |
| InfluxDB `~/.influxdbv2` | Time-series engine, WAL/TSM and Bolt/SQLite metadata | Not copied | Schema/configuration/metadata only | Inventory pending |
| Contextual relational database | No SQL Server/PostgreSQL/MariaDB/MySQL service found | — | Complete records required | Not identified |

QuestDB's observed tables are all timestamped telemetry/status tables; no contextual relational records were identified in them. The existing schema artifact is therefore appropriate for the time-series requirement, subject to restoring QuestDB configuration and validating table metadata.

The full contextual database remains unresolved. VM 132 has no attached secondary disk and no detected relational database service. InfluxDB is also time-series data, not the contextual database.
