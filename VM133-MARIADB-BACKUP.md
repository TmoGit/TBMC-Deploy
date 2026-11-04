# VM 133 MariaDB backup and recovery

The original published dump was defective: its valid checksum covered only a truncated `alarm_event_data` export. It is preserved as forensic reference and must not be restored. After explicit authorization, VM 133 was started with its original disk intact and remained isolated on `vmbr1`; VM 132 remained stopped.

MariaDB 10.11 was running on VM 133. A replacement logical dump was created without stopping MariaDB or Ignition:

- Application database: `ignition_config`
- Dump options: single transaction, routines, events, triggers, hex blobs; all source tables were InnoDB, so no nontransactional-table exception applied.
- Source inventory: MariaDB 10.11.16, data directory `C:\\Program Files\\MariaDB 10.11\\data\\`, 20 `ignition_config` tables, 0 views, 0 routines, 0 triggers, 0 events.
- Guest source size: 1,313,012,605 bytes
- Guest/source SHA-256: `8A8911BF5672B269C067221EC2407DF41965D3520024E42E872551BCA8D14B5A`
- Transferred host SHA-256: `8A8911BF5672B269C067221EC2407DF41965D3520024E42E872551BCA8D14B5A`
- Encrypted artifact: `mariadb-ignition_config-full-2026-11-04.sql.age`
- Encrypted SHA-256: `D045ECBD94114FD9B90D2A53D586026B7A40886E00221E44244ABF95D3F3B44F`
- Isolated restore: MariaDB 10.11.16 on port 3307, separate datadir; import exited, 20 tables restored, 0 views/routines/triggers/events.

The SQL ended with `-- Dump completed`. Exact source row counts for the two multi-million-row tables were not accepted from `INFORMATION_SCHEMA.TABLE_ROWS`; those values are estimates and changed while Ignition remained active. The live source remained isolated throughout. No client live restore was initiated.
