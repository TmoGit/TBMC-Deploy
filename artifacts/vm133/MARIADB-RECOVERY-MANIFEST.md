# VM 133 replacement MariaDB artifact

| Item | Value |
|---|---|
| Source database | `ignition_config` |
| Source version | MariaDB 10.11.16 |
| Tables | 20, all InnoDB |
| Views / routines / triggers / events | 0 / 0 / 0 / 0 |
| Plaintext SQL size | 1,313,012,605 bytes |
| Plaintext SHA-256 | `8a8911bf5672b269c067221ec2407df41965d3520024e42e872551bca8d14b5a` |
| Encrypted artifact | `mariadb-ignition_config-full-2026-11-04.sql.age.part.000` through `.013` (reassemble in lexical order) |
| Encrypted size | 1,313,333,349 bytes |
| Encrypted SHA-256 | `d045ecbd94114fd9b90d2a53d586026b7a40886e00221e44244abf95d3f3b44f` |
| Validation | SQL terminates with `-- Dump completed`; isolated MariaDB 10.11.16 restore completed; 20 tables present |

The prior `mariadb-ignition_config.sql.age` remains unchanged and is defective/unusable. Do not restore it.

GitHub’s 100 MiB per-file limit requires the replacement encrypted artifact to be stored as 14 binary parts. `database/Restore-MariaDB.ps1` reassembles the parts before age decryption; no plaintext SQL is stored in Git.
