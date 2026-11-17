# TBMC InfluxDB readiness — incomplete, blocked

Assessment date: 2026-11-17 UTC. No end-to-end readiness claim.

## Verified state

- Host: `tp-cloud-ign02-`; Ethernet: `10.1.0.132/26`; next hop: `10.1.0.129`.
- Commissioning identity: `tp-cloud-ign02-\tpignclouduser`. Medium integrity; Administrators membership is deny-only. Process is not elevated.
- `TBMCInfluxDB` is running, automatic startup, identity `NT AUTHORITY\LocalService`.
- Service binary: `C:\Program Files\TBMC\InfluxDB-2.8.0\TBMCInfluxDB.exe`.
- Recovery: restart after 10 seconds, then 30 seconds; failure counter reset after 3600 seconds.
- `http://127.0.0.1:8086/health`: pass, ready for queries and writes, version `v2.8.0`, commit `40a633239e`.
- `/api/v2/setup`: `allowed=false`; already initialized. Do not rerun setup or reset.
- `/api/v2/orgs` without authentication: HTTP 401.
- Only InfluxDB listener: `127.0.0.1:8086`, plaintext HTTP for local use. No listener on 80 or 443 observed.
- Ethernet firewall profile: Public. No firewall rule matching display name `TBMC` or `influx`; other rules and effective reachability are not established by this name search.
- One LocalMachine personal certificate found: `DC=Windows Azure CRP Certificate Generator`, no DNS names, expiry 2027-10-01. No approved InfluxDB TLS identity established.
- Deployment and protected credential directories deny access: `C:\ProgramData\TBMC\InfluxDB` and `C:\Program Files\TBMC\InfluxDB-2.8.0`.
- No applicable AGENTS.md found at checked ancestors of Documents/Downloads. No companion on-premises commission or reports found in accessible Documents, Downloads, Desktop, or C:\Temp. Protected deployment reports remain uninspected.
- Organization, bucket, IDs, retention, existing authorization definitions and retrievability: UNVERIFIED because administrative credentials are inaccessible. Expected names are TBMC and TBMC-Sensor-Data; these are requirements, not observations.
- No local Ignition service found. Actual gateway and Kymera module versions remain unknown.

## Changes completed

Created `C:\Users\tpignclouduser\Desktop\TBMC-InfluxDB-Handoff` with inheritance disabled and FullControl only for current commissioning user, SYSTEM and Administrators. ACL was read back and verified. Desktop resolves to local `C:\Users\tpignclouduser\Desktop`, no reparse target or OneDrive environment variables observed; no synchronization configuration was established.

No token created or revealed. `Ignition-InfluxDB-Connection-TEMP.txt` does not exist yet. No service, database, listener, firewall, route, DNS, recovery setting or existing credential changed. No restart performed.

## Precise blockers and prerequisites

1. Resume in an elevated commissioning session on this host to inspect deployment configuration and its established protected secret store. This session cannot read the protected directories or perform service/firewall administration. Do not reset credentials or bypass their ACLs.
2. Obtain the observed source IP/NAT/VPN address from `01-TBMC-OnPrem-Equipment-and-Ignition-Commission.md` or its actual assessment output. No source is available here; no firewall source was guessed.
3. Inspect the protected design for the approved private transport, TLS endpoint and trust requirements. No approved HTTPS hostname/certificate is established by accessible evidence. External routes/security-group changes require their applicable authorization and must be assessed from the actual on-premises gateway.
4. Resume the on-premises commission with access to the actual Ignition gateway to establish installed versions and perform remote API, historian write and historical query validation.

## Credential preparation still required

Preserve initialized settings even if they differ from expected. Retrieve a valid dedicated integration authorization if safely available, otherwise create one with exactly `read` and `write` on resource type `buckets`, actual production bucket ID, actual organization ID. Do not supply the operator token to Ignition. Validate the exact permission definitions without production synthetic writes. Use a disposable validation bucket and its own bucket-scoped token for write/read testing, then remove only those disposable resources.

Store the authoritative integration token in the existing protected secret store. Before writing the temporary Desktop file, recheck synchronization and ACLs; use a restricted nonsynchronized folder and Desktop shortcut if necessary. Include host/private IP, approved URL/protocol/port, version, organization/bucket names and IDs, actual retention, dedicated token and permissions, UTC creation time, and TLS trust requirements. Exclude admin credentials. Delete the temporary copy only after the user completes secure transfer and successful Ignition validation.

## Remote validation and recovery

Follow `TBMC-InfluxDB-Preparation-Runbook.md` alongside this report. Local health is not proof of remote access. No configuration rollback is currently necessary because deployment configuration was unchanged. Preserve the existing service identity, startup and recovery settings during continuation.

Official references consulted: [Kymera module and compatibility information](https://www.kymerasystems.com/kymera-influxdb-module/), [Kymera release listing](https://www.kymerasystems.com/modules/module-downloads/), [InfluxDB token creation](https://docs.influxdata.com/influxdb/v2/admin/tokens/create-token/), [InfluxDB API quick start](https://docs.influxdata.com/influxdb/v2/api/quick-start/). Kymera documents historian storage and history querying; match documentation bundled with the actually installed module. No current release was assumed installed.
