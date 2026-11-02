# Contextual database finding

The focused review of the transferred VM 133 Ignition Gateway resources and project files identified a real contextual database dependency:

- Engine: MariaDB
- Endpoint: `localhost:3306` relative to VM 133
- Database: `ignition_config`
- Ignition connection name: `ignitionDB`
- Username: `ignition`
- Password: stored in Ignition configuration and not published in plaintext

Named Queries and project scripts reference the `ignitionDB` connection for batch, equipment, audit, setup, and operational metadata. This is distinct from QuestDB and InfluxDB time-series telemetry.

The MariaDB service and records were not found on VM 132. VM 133 is currently shut down, so a complete MariaDB backup has not been attempted. The encrypted Gateway resource archive contains the connection definition, but it does not contain the MariaDB data records.

Required follow-up: obtain authorization to start VM 133 or provide access to the original MariaDB storage, then create a consistent full MariaDB backup including all records, encrypt it with the deployment age recipient, and add it to the deployment package. Do not enable the live endpoint automatically on restore.
