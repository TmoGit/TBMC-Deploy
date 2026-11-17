# TBMC database continuation for development testing

## Run on the database host

Execute on `tp-cloud-ign02-`, commissioned address `10.1.0.132`. This is the DB-side companion to `03-TBMC-Development-Completion-Commission.md`. Finish local preparation and provide protected credentials so on-premises development can proceed without OPC or live equipment integration.

The user authorizes local database administration, dedicated integration credentials, the required private listener and narrowly scoped Windows firewall changes. Existing initialized data/configuration must be preserved. No source export or historical migration is needed.

## 1. Elevate once and inspect protected configuration

Read applicable AGENTS.md, `TBMC-InfluxDB-Readiness.md`, `TBMC-InfluxDB-Preparation-Runbook.md`, and current protected deployment reports.

The prior session was medium integrity with deny-only Administrators membership. Confirm effective elevation before accessing protected files or performing service/firewall changes. Use normal Run as administrator/UAC and resume after any unavoidable user interaction. Do not change ACLs simply to bypass protected storage or repeatedly retry unelevated commands.

Known state to reverify:

- InfluxDB `v2.8.0`, service `TBMCInfluxDB`, Automatic, LocalService and restart recovery.
- Healthy at `http://127.0.0.1:8086`.
- `/api/v2/setup` returns `allowed=false`: **already initialized**.
- Protected paths include `C:\ProgramData\TBMC\InfluxDB` and `C:\Program Files\TBMC\InfluxDB-2.8.0`.

Do not reinstall, reinitialize, reset credentials, or assume required org/bucket/retention exist without authenticated inspection. Retrieve established administrative credentials securely from protected storage. Verify actual `TBMC` organization, `TBMC-Sensor-Data` bucket, resource IDs, retention, authorization definitions and secret-store format. Preserve/report differences instead of overwriting. No token or password output to logs, command arguments, chat or Git.

## 2. Complete the private connection path

Known on-premises origin is `TP-IGN01`, `172.16.81.201/24`, gateway `172.16.81.254`. Confirm routing and any NAT/VPN translation rather than assuming the DB-observed source is unchanged. Check existing routes, Windows firewall and available connection evidence. If determining the source requires a coordinated TCP attempt from the gateway, state the exact test and keep completing independent work.

Back up actual wrapper/configuration and ACLs into restricted local storage; record original binding and recovery procedure. Avoid simple live database-file copies as backups.

Implement the established approved private listener or TLS proxy using the specific private interface. Preserve necessary local administration. Do not expose all interfaces blindly. Current Ethernet profile is Public; account for it without arbitrarily changing the profile. Restrict inbound Windows access to the confirmed on-premises source/NAT address, specific local endpoint and port. Use existing approved HTTPS/trust design where present. Do not invent certificates, bypass TLS, open unrestricted public access, or send tokens over public plaintext HTTP.

If a private HTTP connection is the established approved design, document the private/VPN boundary and use it within that approval; absence of a public DNS name alone must not block independent local credential/configuration work. Do not invent an approval where none exists. Identify only the actual remaining transport/security decision if undocumented.

Restart only when needed; confirm identity/startup/recovery and health afterward. If unhealthy, restore exact configuration and reverse only owned changes. Cloud routes/security groups/DNS and site routing remain TBMC-controlled prerequisites; do not claim changing the listener resolves ICMP or all network timeouts.

## 3. Produce the integration handoff

Verify installed Kymera integration requirements from the gateway-side evidence. Reuse a retrievable, valid dedicated bucket-scoped authorization or create one with the required read/write permissions on the actual production bucket and organization. Do not use the operator token in Ignition or revoke unrelated authorizations.

Store the authoritative integration token in the established protected store. Create the requested temporary Desktop file, after restricting access to current commissioning user, SYSTEM and Administrators:

`TBMC-InfluxDB-Handoff\Ignition-InfluxDB-Connection-TEMP.txt`

Include actual URL/private IP, protocol/port, version, org/bucket names and IDs, retention, dedicated token/scopes, creation time and TLS requirements. Exclude administrator credentials. For synchronized Desktop use restricted nonsynchronized storage and a shortcut. Report only the path, never contents. Do not automatically share/upload it. Remove the temporary copy after secure transfer and user handoff confirmation; retain the protected authoritative token.

## 4. Enable isolated historian development

Create a uniquely named disposable commissioning bucket with short retention and separate bucket-scoped credentials. Provide its protected connection details to the gateway commissioning session. Synthetic history must not enter `TBMC-Sensor-Data`.

Perform direct API write/query validation in that disposable bucket and preserve sanitized evidence. Leave the bucket/token available until the on-premises session completes actual Kymera module write/readback. Record the owner, names/IDs, creation time and explicit cleanup condition. Do not delete resources before the companion test consumes them. Then remove only owned temporary resources and verify cleanup.

Validate production token permission definitions with a nonmutating query; an empty result is not proof of ingestion. Do not stop the production DB to test buffering. Verify native backup capability using approved destination/policy if available; otherwise record the outstanding policy without blocking unrelated development.

## 5. Finish and hand back

Create sanitized `DB-DEVELOPMENT-READINESS.md` with actual state, applied changes, configuration verification, endpoint/source restrictions, local API results, protected handoff paths, temporary test resource lifecycle, rollback and outstanding external prerequisites.

The on-premises session must independently verify remote TCP/API access, update the intended existing historian connection and demonstrate gateway-originated writes/history retrieval. Do not claim this from localhost results.

Do not perform equipment ping campaigns or OPC integration. Do not reinstall InfluxDB or request `source-config.zip`. Complete all unblocked steps even if external route changes or the on-premises source confirmation remain pending.
