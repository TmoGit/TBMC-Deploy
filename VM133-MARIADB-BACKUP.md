# VM 133 MariaDB backup

MariaDB 10.11 was running on VM 133. A logical dump was created without changing source records:

- Application database: `ignition_config`
- Dump options: single transaction, quick mode, routines, events, triggers, hex blobs
- Guest source size: 60,934,812 bytes
- Guest source SHA-256: `0C0E7BE2BCDD260C01AA2CD9ADDF516D071E9C32E9CA20BDAD456E8E2AA94885`
- Transferred source SHA-256: `0C0E7BE2BCDD260C01AA2CD9ADDF516D071E9C32E9CA20BDAD456E8E2AA94885`
- System schema/privilege dump: `mysql`, 2,762,444 bytes
- System dump SHA-256: `91B94E7B1D32DF1E2AFC1114E44419F6BBA1D2C36D21545CA768037B18823F51`

Both dumps are encrypted with age before publication. The source database was not stopped or modified. Restoration has not yet been tested on an isolated MariaDB instance.
