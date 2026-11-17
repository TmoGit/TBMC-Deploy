# TBMC InfluxDB credentials and private network preparation

## Execution location and objective

Run on the commissioned Windows InfluxDB server expected at **10.1.0.132**. Prepare the existing database for the main on-premises Ignition connection, including correct token permissions and a temporary restricted Desktop credential handoff. Execute all unblocked work.

This supports `01-TBMC-OnPrem-Equipment-and-Ignition-Commission.md`. Use its observed source address for firewall scoping, then resume that commission for remote and actual Ignition validation.

## 1. Confirm current state

Verify hostname and addresses. Confirm `10.1.0.132` belongs to this host or document the actual approved mapping. Inspect applicable AGENTS.md instructions and existing deployment reports.

Inspect:

- Existing `TBMCInfluxDB` service and InfluxDB version.
- Listener addresses, protocol, port, health, and initialization state.
- Protected local credentials and existing deployment configuration.
- Organization `TBMC`, bucket `TBMC-Sensor-Data`, and actual retention.

Preserve the installed service, data, identity, recovery settings, and working configuration. Do not reinstall or reset. Preserve the validation correction: API version may be returned as `v2.8.0`.

If still uninitialized, complete the previously requested fresh configuration:

- Organization: `TBMC`.
- Bucket: `TBMC-Sensor-Data`.
- Retention: unlimited.
- Fresh strong administrator credentials.

This is a **fresh setup, not source migration**. If initialized settings differ, preserve and report them instead of overwriting. Do not request `source-config.zip`, repeat migration discovery, or import historical data.

## 2. Prepare private connectivity

The service was previously bound to `127.0.0.1:8086`. Discover actual state and expose it through the approved private path needed by Ignition.

Prefer the appropriate specific private interface or an existing approved TLS reverse proxy. Preserve local administration where required. Inspect TLS certificates, VPN/private networking, firewall settings, and existing deployment documentation. Use HTTPS where established by the design. Do not invent hostnames or bypass certificate validation. Do not send production credentials over public plaintext HTTP.

Create or adjust the Windows firewall rule limited to the confirmed on-premises Ignition source IP or documented NAT/VPN source. Do not guess the source or allow unrestricted public access. Use the actual source reported by the on-premises assessment; request that address if it is unavailable while completing independent work.

Do not change external routes, cloud security groups, DNS, or TBMC infrastructure without applicable authorization. State outstanding prerequisites precisely.

Back up configuration before changes, restart only when needed, and verify health afterward. Do not mistake a local listener for remote connectivity.

## 3. Prepare integration credentials

Inspect official documentation for the installed/required Kymera InfluxDB integration and the on-premises handoff. Discover actual versions; do not assume the historical DDS module version is installed.

Generate a dedicated bucket-scoped token with read/write permissions required for historian ingestion and trend retrieval. Do not give Ignition an administrator/operator token. Use separate read/write credentials where supported and appropriate. Do not assume write-only access supports historical queries.

Reuse a valid dedicated token if securely retrievable. Otherwise create a clearly named new integration token and preserve unrelated authorizations. Keep administrative credentials separate in protected local storage.

Validate access and permission definitions. Use a temporary validation bucket/token for synthetic write/read testing; validate production token scope without writing synthetic data into production history. Confirm actual integration behavior again from the Ignition server.

## 4. Create the requested temporary Desktop handoff

Resolve the actual Windows Desktop, including OneDrive redirection. Create:

`TBMC-InfluxDB-Handoff\Ignition-InfluxDB-Connection-TEMP.txt`

Before writing secrets, restrict directory/file ACLs to the current commissioning user, SYSTEM, and Administrators. Check inherited access and synchronization. Do not place secrets in Git, logs, reports, or broadly shared folders.

The temporary text file must include:

- Destination hostname and private IP.
- Connection URL, protocol, and port.
- InfluxDB version.
- Organization name and ID.
- Bucket name and ID.
- Retention.
- Dedicated Ignition token and its permissions.
- Creation time.
- TLS trust/certificate requirements, where applicable.

Do not include administrator passwords or operator tokens. Do not print the token to terminal output or chat.

If Desktop is synchronized, store the secret file in a restricted nonsynchronized local folder and create a Desktop shortcut instead. Report the actual path. Do not email, upload, or automatically share the file.

Retain the authoritative credential in the established protected secret store. Document deletion of the temporary copy after secure transfer and successful Ignition validation; do not delete it before the user completes the handoff.

## 5. Deliver and verify

Create a separate sanitized Desktop readiness report containing:

- Service/version/health and initialization state.
- Listener and TLS configuration.
- Firewall source restriction.
- Organization, bucket, retention, and resource IDs.
- Token permission definitions without token values.
- Temporary credential handoff path.
- Exact remote validation steps and outstanding external prerequisites.

Provide a reusable preparation script/runbook, preserving unrelated services and configuration. Record changes and recovery instructions without credentials.

A local health check does not prove on-premises access. After local preparation, have the on-premises commission retry TCP/API tests, configure the actual Ignition historian connection, and verify gateway-originated writes and historical queries.

Complete all unblocked local preparation. If networking remains blocked, identify only the precise missing source address, route, firewall approval, or certificate requirement. Do not claim end-to-end readiness prematurely.

## Git handling

The commission is safe to commit as instructions, subject to the repository's normal confidentiality rules. Never commit generated token files, passwords, protected configuration, gateway backups, or secret-bearing logs. Place runtime credentials outside the repository and add appropriate exclusions if generating local handoff artifacts near it.
