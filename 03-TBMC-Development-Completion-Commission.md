# TBMC development completion: gateway administration, trials and application verification

## Execute and continue

Run on the main on-premises Windows Ignition server, `TP-IGN01`, observed at `172.16.81.201/24`. Execute the work, correct in-scope defects, verify fixes, and record evidence. Do not stop at a plan or repeat completed discovery.

The user authorizes gateway administration/access provisioning, vendor-supported development trial resets, backups, historian configuration, isolated application testing, and reversible application fixes needed to advance Acropolis responsibilities. Development trials are acceptable during this phase. Paid licensing is a final production handoff dependency, not a blocker to development tests that work under valid trials.

TBMC has received the offline-device report and is resolving shop-floor connectivity. **Do not attempt OPC integration, vendor namespace browsing, equipment source mapping, live-tag cutover, device configuration, or another equipment ping campaign in this commission.** Do not wait for shop-floor corrections to complete independent application work. Do not operate physical equipment.

## 1. Read the current baseline

Inspect applicable AGENTS.md and the current package. Read the evidence from these commits and any later updates before acting:

- `303c966bd210ffdab0e75e9befb59b0c2ad34215`: on-premises equipment/database assessment and gateway observations.
- `fcdeeafe66a5c56945979ad09fef7d5bb78ee5fc`: DB readiness and continuation runbook.

Key files include `README-Resume.md`, `summary.json`, `database-ignition-results.csv`, `historian-previous-sanitized.json`, `TBMC-InfluxDB-Readiness.md`, and `TBMC-InfluxDB-Preparation-Runbook.md`.

Read the approved project sources, including accepted DOCX revisions rather than concatenating tracked deletions:

- `Digital Design Specification_TBMC_CO1 8_13_26 Final.docx`
- `TBMC_Final_Phase_Responsibility_Matrix _GigiRev1.docx`
- Network architecture and equipment workbook for reference only; do not repeat the shop-floor assessment.
- Existing FAT, CO FAT addendum, SAT protocol and current project implementation where available.

Baseline observations, to refresh rather than assume:

- Ignition 8.3.4; Kymera InfluxDB 2.83.2 (b2) installed.
- Gateway trials expired; existing InfluxDB historian disabled and configured to the old public endpoint.
- Commissioned DB is `10.1.0.132`, healthy locally and **already initialized**, but last observed listener was `127.0.0.1:8086`.
- Organization/bucket names expected: `TBMC` / `TBMC-Sensor-Data`; actual IDs/retention need authenticated DB verification.
- Last Ignition-to-DB TCP/API tests timed out. DB-side source after any NAT/VPN is not confirmed.

Do not reset/reinitialize/reinstall either system. Record current state and preserve existing data.

## 2. Verify elevation and make recovery concrete

Distinguish Windows administrator elevation from gateway administrator permissions. Confirm effective elevated token before protected Windows administration. If needed, launch the normal elevated session and request only the unavoidable UAC interaction, then resume. Do not spend a session repeating medium-integrity permission failures or change ACLs merely to bypass them.

Locate existing protected gateway credentials, including paths referenced by the prior authenticated assessment, without printing values. Reuse working credentials before considering recovery.

Take a fresh native gateway backup and supported exports before configuration changes. Store backups in restricted nonsynchronized local storage outside Git. Record restore steps, service identities and configuration paths. Preserve a working administrative session while verifying a second login.

## 3. Provide the user with working gateway administrator access

The prior assessment authenticated as `tbmc_admin`; determine whether that account can serve as the user's commissioning administrator and whether credentials are securely retrievable. Verify actual gateway Access/Read/Write permissions, not just successful login or an application Supervisor role.

Use a supported existing administrator identity or create a clearly identified dedicated human commissioning administrator using the actual configured gateway identity/user source. Grant the required gateway administration permissions through supported controls. Do not disable MFA, replace the identity provider, weaken site-wide security, or delete/disable other administrators.

If no working administrator credential is available, the user authorizes documented local Ignition 8.3 administrative password recovery using the installed `gwcmd` utility. Read installed help and official documentation first; capture a supported recoverable backup, record anticipated restart impact, perform only required recovery/restart, immediately set a strong nondefault credential, and verify health. Do not edit internal account tables or leave recovery/default access enabled. If a recoverable backup cannot be obtained, finish independent work and report that precise prerequisite before disruptive recovery.

Verify a fresh login through the actual intended user-accessible gateway URL. Confirm gateway administration and required backup/configuration privileges without unrelated destructive changes. Create a Desktop shortcut to the approved gateway URL and verify it resolves correctly from the intended workstation/network when available. Do not expose gateway administration to the Internet or claim remote-user access solely from localhost testing.

Provide a temporary user credential handoff at the actual Desktop:

`TBMC-Gateway-Admin-Handoff\Gateway-Admin-Access-TEMP.txt`

Restrict ACLs before writing to the current commissioning user, SYSTEM and Administrators. Include gateway URL, username/identity source, temporary credential when applicable, permissions, and any normal MFA/password-change instructions. Do not place secrets in reports, command arguments, transcripts, chat or Git. For synchronized Desktop, use restricted nonsynchronized storage and a Desktop shortcut. If identity-based access requires no password, provide the correct login instructions without inventing one. Keep an authoritative protected credential record; remove the temporary copy after user handoff is confirmed.

## 4. Check and reset supported development trials

Use the supported authenticated gateway Reset Trial control when expired or necessary for active testing. Verify the fresh timer and actual module operation after reset. Record reset time, remaining time, module state and trial limitations.

Check Ignition and Kymera independently: determine whether Kymera follows the gateway timer or exposes a separate vendor-supported trial action for the installed version. Perform the applicable supported reset and verify the historian module is functional. Do not assume ACTIVE means licensed or trial-operational. If Kymera requires a vendor-issued evaluation entitlement, identify that specific dependency and continue unrelated tasks.

Recheck trial validity before each functional test group and reset through supported controls when needed during the active session. Do not install unattended reset services, alter clocks/license files, fabricate keys, reverse-engineer licensing, or replace modules to evade trial behavior. Do not upgrade installed versions without a demonstrated compatibility need and separate documented change scope.

Do not purchase licenses or contact vendors on the user's behalf. Record production entitlements as outstanding handoff items while continuing development.

## 5. Finish the historian path without OPC

Use companion `04-TBMC-DB-Continuation-for-Development.md` on the DB host if preparation is incomplete. This on-premises commission does not confer remote access to that host: use an existing authorized connection or provide the exact companion command/handoff and keep working locally.

Retry only the commissioned DB TCP/API path, not equipment IPs. ICMP is diagnostic, not a gate. Use the verified private URL/protocol/port/TLS trust and a protected dedicated integration token. Do not send tokens to the legacy public endpoint or bypass TLS checks.

After a fresh gateway backup, update and enable the intended existing Kymera InfluxDB historian with verified DB settings. Preserve production tag mappings. For synthetic tests use a separate temporary historian connection targeting a disposable commissioning bucket, with its own restricted token, instead of sending synthetic points to `TBMC-Sensor-Data`.

Use isolated memory tags in a dedicated commissioning provider/folder with verified no binding/OPC/writeback relationship to physical equipment. Configure their history through the installed module, change known values with timestamps, and retrieve them through Ignition's historical query path. Check quality, units, timestamps, trend rendering and store-and-forward diagnostics. Direct API writes alone are insufficient.

If isolated buffering/recovery can be tested without affecting production, exercise only the temporary connection and verify queued samples recover. Do not stop the shared DB, disconnect production networking, or purge shared queues.

Capture real results, then remove only disposable resources created by the test. If DB networking remains blocked, continue sections 6–10 and label historian-dependent assertions pending rather than fail the whole commission.

## 6. Inspect and verify SQL integration

Identify the actual approved relational database, named connections, schema/version, and application queries. Distinguish MariaDB batch/audit/reporting functions from InfluxDB history. Verify connection status, expected tables, permissions and representative nonmutating reads. Do not reset SQL, replay a destructive restore, or modify unrelated records.

Inspect batch setup/runtime IDs, claims, audit and reporting-cache relationships against the approved DDS/FAT. Use a dedicated commissioning/test namespace, isolated schema/project copy, or clearly marked synthetic records with verified safe separation from client work. Do not clone/enable gateway startup scripts, scheduled reports, notification pipelines or other background side effects blindly. If isolation cannot be established, complete read-only inspection and prepare executable tests for that dependency.

Apply reversible, backed-up application fixes when supported by requirements. Avoid unapproved schema redesign. Record before/after evidence and targeted regression tests.

## 7. Execute isolated batch and UI functional tests

First trace each action to confirm it affects application workflow only. Never issue physical equipment commands. Use dedicated synthetic equipment identities and commissioning batch names/run IDs, with no claims on real active equipment.

Test against approved behavior:

- Save/update/load batch setup; repeated loads of one saved name create distinct runtime instances.
- Separation of `batch_uid`, `batch_run_uid`, displayed run instance ID and report selection.
- Loaded versus started/claimed equipment state; overlapping batch contention; first-start ownership and locking safeguards.
- Start, Hold, resume if specified, Abort, Complete, Archive and allowed/denied transitions.
- Release behavior and protection against double claims, duplicate actions, stale UI state and refresh/reconnect where safe.
- Persistence and accurate display of runtime state, user, timestamps and SQL records.
- Batch setup, Level 2/detail views, batch cards, equipment selection, alarms, audit views and reports remain consistent.

Do not invent business rules missing from the approved sources. Record ambiguous requirements separately and complete tests with defined expected results. Fix evidenced Acropolis application defects and rerun affected tests. Preserve audit evidence; do not delete audit records to hide synthetic activity. Record the final disposition of all test records and resources.

## 8. Verify security and user access

Inventory gateway administration separately from application Public/User/Supervisor permissions. Inspect existing Entra/identity integration and group mappings. Use provided representative accounts or isolated supported test accounts without modifying client directory groups or disabling security.

Test allowed and denied navigation/actions, login/logout, inactivity timeout, alarm-setpoint permissions, batch actions, audit access and report export against the approved security matrix. Verify forbidden actions cannot be performed by direct navigation/action invocation, not only that buttons are hidden.

Do not treat a local test user as proof Entra end-to-end integration works. Mark missing TBMC identity/group/test-user inputs as dependencies and proceed with verifiable local logic.

## 9. Verify alarms, audit, reports and time

Use isolated memory tags/alarms and development reporting inputs. Suppress external notifications by using isolated test pipelines rather than modifying production notifications. Do not change real alarm setpoints or journal/audit records.

Verify activation, status, acknowledgement, journal, roles and audit attribution. Verify workflow/security/configuration events required by the approved sources appear with correct actor, action, target/run ID and timestamps. Check application, Windows, database, historian, report and audit timezone/clock consistency; report deviations without changing NTP infrastructure.

Test batch/equipment reports, run-instance selection, parameter handling, PDF/export rendering, permissions and synthetic history plots when InfluxDB is available. With history blocked, verify layout and independent SQL data paths, explicitly marking history portions untested. Preserve trial watermarks/limitations in evidence rather than misclassifying them as application defects or production acceptance.

## 10. Close application defects and prepare handoff evidence

Maintain a requirement/test/evidence matrix with these exact status distinctions: passed in development, failed, blocked, deferred live-equipment verification, not tested. Every pass needs actual observation and timestamp. Do not count code inspection or synthetic data as a live commissioning/SAT pass.

Produce under a new timestamped Desktop results folder:

- `DEVELOPMENT-STATUS.md`: completed actions, actual admin access verification without secrets, module/trial results, DB/historian/SQL state, fixes and remaining dependencies.
- `ACROPOLIS-COMPLETION-MATRIX.csv`: requirement/source section, owner, test/expected/actual result, status, timestamp, evidence and next action.
- `DEVELOPMENT-TEST-RESULTS.csv`, sanitized logs/screenshots and report samples.
- `CHANGES-AND-RECOVERY.md`: backups, changes, rollback and regression evidence.
- `NEXT-SESSION.md`: exact resume instructions, protected handoff file locations without values, deferred OPC/live-tag/SAT work, and concise TBMC inputs still needed.

Keep backups, credentials, cookies, tokens, browser profiles and secret-bearing exports outside Git. Before preparing a commit, scan tracked/staged text and generated artifacts for secrets and unintended sensitive data. Do not publish/commit automatically unless separately authorized. Source-document publishing must respect the repository's confidentiality.

Update reusable scripts so metrics derive from the current run's data. Do not hard-code prior pass counts or reuse old gateway observations as fresh evidence. Preserve prior assessment as an immutable point-in-time run.

Finish with a concise completed/blocked/deferred summary and exact artifacts. The user has already sent the device report: do not send client messages or repeat it as an outstanding task. Do not mark production ready: paid licenses, real equipment integration, joint SAT and customer acceptance remain separate final gates.

## Official references

- https://docs.inductiveautomation.com/docs/8.3/platform/licensing-and-activation
- https://www.docs.inductiveautomation.com/docs/8.3/platform/gateway/gateway-command-line-utility-gwcmd
- https://www.kymerasystems.com/kymera-influxdb-module/

Use documentation matching installed versions; verify Kymera-specific trial behavior instead of assuming it.
