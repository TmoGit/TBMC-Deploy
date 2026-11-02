# TBMC deployment runbook

## Server A — Ignition and MariaDB

1. Use a supported Windows Server version with administrator access, at least 4 GB RAM and 10 GB free disk for Ignition; size MariaDB storage for the encrypted dump plus working space.
2. Obtain and hash-verify the approved Ignition and MariaDB 10.11 installers.
3. Install MariaDB and restore `artifacts/vm133/mariadb-ignition_config.sql.age` using an externally supplied age identity.
4. Review `mariadb-mysql.sql.age` manually; do not overwrite destination administrator accounts or global privileges blindly.
5. Install Ignition, decrypt and restore the Gateway/projects/modules/resources, then validate `ignitionDB` locally.
6. Keep PLC, MQTT, historian, and external InfluxDB connections disabled until cutover approval.

## Server B — QuestDB and InfluxDB

1. Obtain and hash-verify QuestDB 9.3.3 and InfluxDB 2.8.0 installers.
2. Install the services without importing historical measurements.
3. Restore the encrypted QuestDB schema artifact and recreate InfluxDB metadata only after authenticated exports are supplied.
4. Apply destination-specific endpoints, credentials, retention policies, and service settings.

## Validation and rollback

Run the `Test-*` scripts, verify service status, compare artifact checksums, and retain the original servers until a functional application test succeeds. Restore into disposable instances first; no end-to-end restore test has yet been performed.
