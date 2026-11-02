# TBMC deployment readiness

## Architecture

- Windows Server A / VM 133: Ignition Gateway, projects/modules, MariaDB `ignition_config`.
- Windows Server B / VM 132: QuestDB and InfluxDB time-series services.

## Verified

- VM 133 encrypted Ignition artifacts, projects, modules, resources, CSV historian, and MariaDB logical dumps.
- VM 132 QuestDB schema-only artifact for all 11 observed tables.
- VM 132 service inventory: QuestDB, InfluxDB, Grafana.
- Latest published commit: `d12e901d60263d947108823048e6a071c15d5522` before this documentation update.

## Versions and dependencies

- MariaDB: 10.11 installation path on VM 133.
- InfluxDB: 2.8.0.
- QuestDB: installed from the `questdb-9.3.3-rt-windows-x86-64` package path; the wrapper executable does not expose a version flag, so exact runtime version remains to be confirmed from the installer/release metadata.
- Java runtime observed with QuestDB: 17.0.9.

## Restore order

1. Install MariaDB, restore the encrypted application dump, and review system privileges manually.
2. Install Ignition and restore its encrypted Gateway/project/module artifacts.
3. Install QuestDB and restore schema/configuration only.
4. Install InfluxDB and configure buckets/retention from destination-specific metadata.
5. Keep live PLC, MQTT, InfluxDB, and database connections disabled until cutover approval.

## Limitations

- MariaDB restore has not been tested in an isolated disposable instance.
- QuestDB/InfluxDB installation restore has not been end-to-end tested.
- No native Ignition `.gwbk` was available.
- External InfluxDB and excluded shared-disk dependencies require destination review.
- Installer binaries/licenses are not bundled; scripts require approved installers supplied at deployment time.
- VM 132 historical time-series data is intentionally excluded.
