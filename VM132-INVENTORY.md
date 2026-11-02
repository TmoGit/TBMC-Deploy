# VM 132 database inventory

Collected through QEMU Guest Agent on the isolated VM.

- Hostname: `ACROP-DEVDB01`
- OS: Windows Server 2025 Datacenter Azure Edition
- Active services: InfluxDB, QuestDB, Grafana
- QuestDB data root: `C:\\QuestDB\\data`
- QuestDB service executable: `C:\\Program Files\\questdb\\bin\\questdb.exe`
- QuestDB service data argument: `-d C:\\QuestDB\\data`
- InfluxDB engine: `C:\\Users\\acrop_user\\.influxdbv2\\engine`
- InfluxDB Bolt metadata: `C:\\Users\\acrop_user\\.influxdbv2\\influxd.bolt`
- Existing Influx backup directory: `C:\\influxdb-backups\\2026-03-20_211519`

QuestDB tables observed: `mem`, `sparkplug_status`, `net`, `sensor`, `sparkplug_metric`, `sensor_new`, `win_services`, `tbmc_sensor_data`, `cpu`, `disk`, and `mqtt_clients`.

The live QuestDB table directories total approximately 35 GB. The encrypted `artifacts/vm132/questdb-schema.json.age` contains schema only and no historical measurements.

The full contextual database backup is not yet complete. A supported QuestDB checkpoint/filesystem backup is required before copying mutable database files. No database service was stopped or modified during discovery.
