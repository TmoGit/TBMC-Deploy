# Client deployment runbook

This package targets existing Windows Server machines. It does not require Proxmox, QEMU Guest Agent, or access to the source VMs.

1. Prepare two supported Windows Server hosts with administrator access, current updates, adequate disk space, and a change/rollback window.
2. Obtain the repository and approved installer files into the configured offline installer directory, or use the documented official download sources.
3. Copy encrypted artifacts and provision the age identity key through the client’s secure secret-handling process. Never place the key in Git.
4. On Server A, run the database preflight, install MariaDB 10.11, restore `ignition_config`, review system privileges manually, then install Ignition and restore Gateway/projects/modules.
5. On Server B, install QuestDB 9.3.3 and InfluxDB 2.8.0. Restore schema/configuration metadata only; do not import historical measurements.
6. Edit a local deployment configuration for destination paths, hostnames, ports, service accounts, and endpoints. External PLC, MQTT, historian, and production database connections remain disabled.
7. Run the database and Ignition `Test-*` scripts. Confirm services, ports, artifact hashes, project presence, and database connectivity to local test targets.
8. Obtain explicit cutover approval before enabling external integrations.

## Rollback

Do not overwrite detected installations or databases. Stop the deployment, preserve logs, and restore the destination from its pre-change backup. Keep the source systems and original encrypted artifacts unchanged until functional acceptance.

## Acceptance criteria

All required services start; MariaDB records and schema validate; QuestDB tables exist; InfluxDB metadata is recreated; Ignition projects and modules load; no unintended external connections occur; and a controlled application test succeeds.
