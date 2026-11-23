# TBMC Site Acceptance Test

**Protocol:** SAT-TBMC-001 | **Revision:** 00 | **Date:** 17 November 2026 | **Status:** Draft for review and approval; unexecuted.

## Purpose and scope

Verify that the TBMC Equipment Monitoring System migrated correctly and meets its approved site functions. Repeat FAT software, architecture, UDT, capture, alarms, reports, UI and security checks; add explicit migration, batch, infrastructure and closeout verification from the final-phase responsibility matrix. The system monitors and historizes data and manages application batch workflow. It does not directly control physical equipment.

## Source basis and limitations

S1: FAT-25010-2_TBMC_CO1-8_13_26 Final.docx. Its cover identifies document RPT-25010-2, Unwitnessed FAT. FAT-001 TC1 is marked FAIL; FAT-002 through FAT-008 functional criteria are marked Pass/PASS. Those are source-record observations, not independent verification of completed FAT or evidence of SAT performance. Do not copy historical results, initials or signatures. The FAT procedure requires a tester and second-person verifier despite its unwitnessed title.

S2: TBMC_Final_Phase_Responsibility_Matrix _GigiRev1(1).docx, internal Rev. 0 dated 21 August 2026. This governs ownership: TBMC supplies infrastructure, vendor interfaces, site personnel and acceptance; Acropolis supplies remote application/configuration and technical verification; integrated live tests are joint. References labeled RM below identify its work-area rows or sections.

S3: Approved DDS, architecture, tag/UDT exports, equipment register, alarm/security lists, approved changes and FAT addendum are execution prerequisites where referenced. They are not all attached to this issue. Verify exact revisions at execution. Additional batch tests derive from RM responsibilities, not claimed FAT test IDs; reconcile detailed business rules against approved DDS/addendum before execution. Missing rules are requirement gaps, not invented expected behavior.

## Staged execution

A: Migration and isolated application verification can proceed now with supported development trials. Synthetic tests are commissioning evidence; formal SAT credit requires approved representative method and human review. B: Live OPC/equipment integration is deferred until TBMC releases site readiness. No OPC integration or device ping campaign occurs now. C: Production and acceptance gates require permanent licenses, completed site work and authorized human review. D: The newly authorized exception allows targeted read-only OPC discovery on the six previously responding hosts; discovery is not integration or live acceptance.

Use supported trial resets during development and record timer/state. Do not treat trial operation as production licensing compliance. Safe independent tests continue even if a dependent service or shop-floor item is unavailable.

## Execution control and safety

Approve this protocol, baseline and execution window before formal SAT. Before development execution document user authorization and mark evidence as development. Record actual gateway/project/host, database endpoint, version, timestamp/timezone and run ID. Take supported protected backups before mutations. Use isolated tags/buckets/batches/equipment identities and verify no physical writeback or live claim conflicts. No production synthetic history, broad device scans, external notifications, weakened security or unapproved infrastructure changes. Do not reproduce the FAT instruction to manually write real OPC tags; use isolated memory tags or on-site approved safe conditions.

Record actual results immediately for each numbered step. Paper records use permanent blue ink; corrections preserve original text with initials/date. Electronic records must preserve append-only history, attribution and evidence hashes under the approved site procedure; no implication of validated electronic signatures. Screenshots must be sanitized. Keep secrets and backups outside Git. Restore only owned test settings and record cleanup; retain required audit records. Stop a test if process impact, loss of isolation or unauthorized access risk appears.

## Results and deficiencies

Step outcomes: PASS, FAIL, BLOCKED, DEFERRED, NOT RUN, or N/A PROPOSED. PASS requires every applicable expected result evidenced. FAIL requires an attempted criterion not met; blocked/deferred is not an executed failure but must appear in the outstanding-items report. N/A needs documented TBMC approval before becoming N/A APPROVED. Any failure makes the test failed; otherwise unresolved steps keep it incomplete. Preserve step outcomes and report all counts separately. Missing independent verifier leaves review PENDING even when technical steps pass.

Each result records run/attempt, test/step ID, mode (development/formal), actual result, UTC and local timestamps, actor, evidence ID/path/hash, dependency and incident ID. A tool is not a human witness. Never prepopulate signatures or declare acceptance automatically.

Every open item receives DEF-nnn, linked steps, observed/expected behavior, owner, severity, impact, evidence and required action. High: integrity/security/claim loss or major unavailable function; Medium: material function impaired with controlled workaround; Low: minor documentation/presentation issue. Provisional severity is reviewed by people. TBMC owns site/vendor/network/access; Acropolis owns application/tag/database integration after connectivity; mixed issues retain separate actions. Retests create new attempts linked to original failures, preserve evidence, and include affected regression tests. Do not auto-close accepted risk or waive failures.

## Execution and approval record

Execution mode: __________  Run ID: __________  Approved revision: __________
Gateway and project: __________  DB endpoint: __________  Timezone: __________
Tester name and qualification: __________  Date: __________
Independent verifier: __________  Date: __________
TBMC coordinator and live release: __________  Change window: __________
Baseline approvals and backup references: __________

## Test index

| ID | Test | Stage | Source |
|---|---|---|---|
| SAT-001 | Controlled baseline and readiness | A | FAT procedure; RM sections 4 and 6 |
| SAT-002 | Software versions and registrations | A | FAT-001 TC1; RM Ignition deployment and licensing |
| SAT-003 | Server architecture and approved paths | A | FAT-002 TC1; RM Production server and Site networking |
| SAT-004 | Gateway administrator access and recovery | A | RM Remote access and Security and audit; migration extension |
| SAT-005 | Tag providers and UDT migration | A | FAT-003 TC1; RM Ignition deployment |
| SAT-006 | Equipment visibility and inventory reconciliation | A | FAT-003 TC1 and FAT-007 TC1; RM Equipment inventory |
| SAT-007 | Metadata and CPP configuration | A | FAT-003 TC1; RM CPP and process data |
| SAT-008 | Database initialization and authorization | A | FAT-004 TC1; RM InfluxDB historian |
| SAT-009 | Ignition historian connection | A | FAT-004 TC1; RM InfluxDB historian |
| SAT-010 | Isolated historian write and retrieval | A | FAT-004 TC1; RM historian and live cutover |
| SAT-011 | Historian recovery and timestamps | A | FAT-004 TC1; RM Time synchronization |
| SAT-012 | Relational SQL connections and schema | A | RM Relational SQL; FAT-006 extension |
| SAT-013 | Save load and distinct runtime instances | A | RM Batch workflow; CO migration extension |
| SAT-014 | Equipment claims and competing starts | A | RM Batch workflow; CO migration extension |
| SAT-015 | Hold resume and terminal transitions | A | RM Batch workflow; CO migration extension |
| SAT-016 | State persistence and reconnect | A | RM Batch workflow and Issues; migration extension |
| SAT-017 | Alarm configuration migration | A | FAT-005 TC1; RM Alarm testing |
| SAT-018 | Alarm activation acknowledgement and journal | A | FAT-005 TC2; RM Alarm testing |
| SAT-019 | Report definition and PDF export | A | FAT-006 TC1; RM reporting and SQL |
| SAT-020 | Report run separation and input validation | A | FAT-006 TC1 extension; RM Batch workflow |
| SAT-021 | Operator navigation and equipment detail | A | FAT-007 TC1; RM Ignition deployment |
| SAT-022 | Identity integration and login logout | A | FAT-007 TC2; RM Identity and users |
| SAT-023 | Inactivity timeout | A | FAT-007 TC3 |
| SAT-024 | Public User and Supervisor permissions | A | FAT-008 TC1 and TC2; RM Security and audit |
| SAT-025 | Audit trail completeness | A | FAT-008 extension; RM Security and audit |
| SAT-026 | Backup recovery and final configuration record | A | RM Cloud resources Production server Final acceptance |
| SAT-027 | Approved OPC endpoints and namespace | B | FAT-002 and FAT-004 extension; RM Vendor and OPC access |
| SAT-028 | Live tag quality and three CPPs | B | FAT-003 and FAT-004; RM Live-tag cutover |
| SAT-029 | Live history trends and reports | B | FAT-004 and FAT-006; RM InfluxDB historian |
| SAT-030 | Joint live alarm and operational verification | B | FAT-005; RM Alarm testing and SAT execution |
| SAT-031 | Production licensing and operational readiness | C | FAT-001 TC1 retest; RM entry criteria and licensing |
| SAT-032 | Deviation retest and customer acceptance | C | FAT procedure; RM Issues and Final acceptance |
| SAT-033 | Targeted OPC discovery on responding hosts | D | RM Local network tests and Vendor and OPC access; authorized discovery extension |

## Test procedures

### SAT-001 Controlled baseline and readiness

Source: FAT procedure; RM sections 4 and 6. Work area: Server readiness. Stage: A. Owner: Joint.

Prerequisite: Approved protocol revision, execution window and available source documents.

1. **Action:** Record gateway/project/build, host IPs, database endpoint, source document revisions and run ID. **Expected:** Baseline is uniquely identified; missing references are logged, not guessed.

2. **Action:** Review applicable readiness items and assign each unavailable prerequisite to its owner. **Expected:** Only dependent tests are blocked; independent tests may proceed under the approved staged plan.

3. **Action:** Record qualified tester, independent verifier and TBMC witness arrangements. **Expected:** No automated signature or acceptance is substituted for named human verification.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-002 Software versions and registrations

Source: FAT-001 TC1; RM Ignition deployment and licensing. Work area: Software. Stage: A. Owner: Acropolis; TBMC supplies entitlements.

Prerequisite: Approved software baseline and gateway administration.

1. **Action:** Compare installed gateway, required modules and drivers with approved revisions or authorized changes. **Expected:** Each required component is present and compatible; deviations are itemized.

2. **Action:** Record license or trial status and reset through supported controls if required for development. **Expected:** Development timer and required modules operate; paid production licensing remains independently tracked.

3. **Action:** Reconcile the source FAT-001 FAIL with purchase/activation evidence and current findings. **Expected:** Prior failure is explicitly dispositioned; not silently inherited as passed or closed by a trial reset.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-003 Server architecture and approved paths

Source: FAT-002 TC1; RM Production server and Site networking. Work area: Infrastructure. Stage: A. Owner: Joint.

Prerequisite: Approved architecture/build sheet and remote access.

1. **Action:** Compare production server, database, identity and network roles to approved architecture. **Expected:** Actual hosts/addresses and approved changes are recorded, including 10.1.0.132 versus legacy historian address.

2. **Action:** Verify required paths from the actual gateway using bounded port/service tests. **Expected:** Each required service is verified or blocked with evidence; ping alone is not application proof.

3. **Action:** Record DNS, source interface, route and remote access without changing infrastructure. **Expected:** Observed route/source and infrastructure discrepancies have TBMC ownership.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-004 Gateway administrator access and recovery

Source: RM Remote access and Security and audit; migration extension. Work area: Administration. Stage: A. Owner: Acropolis.

Prerequisite: Authorized administrator and protected credentials.

1. **Action:** Log in through the intended gateway URL with the designated human administrator. **Expected:** Fresh login succeeds with actual gateway Access/Read/Write privileges.

2. **Action:** Verify supported backup/export access and a protected current pretest gateway backup. **Expected:** Recoverable backup path, timestamp and hash recorded without credentials in evidence.

3. **Action:** Confirm user credential handoff and second-session access without revealing secrets. **Expected:** User can administer the gateway; recovery/default access is not left enabled.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-005 Tag providers and UDT migration

Source: FAT-003 TC1; RM Ignition deployment. Work area: Tag migration. Stage: A. Owner: Acropolis.

Prerequisite: Authoritative source tag export or approved gateway backup.

1. **Action:** Inventory enabled providers, UDT definitions/instances, counts and fully qualified paths. **Expected:** Destination structure is enumerated; missing baseline prevents a completeness claim.

2. **Action:** Compare source to destination definitions, instance parameters, inheritance and required metadata. **Expected:** No unexplained missing or mismatched required objects; all differences itemized.

3. **Action:** Distinguish absent tags from disabled providers, bad quality and unavailable sources. **Expected:** Migration defects are separated from site connectivity; no OPC enabling occurs in phase A.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-006 Equipment visibility and inventory reconciliation

Source: FAT-003 TC1 and FAT-007 TC1; RM Equipment inventory. Work area: Equipment display. Stage: A. Owner: Acropolis; TBMC confirms inventory.

Prerequisite: Equipment workbook and approved equipment/tag register.

1. **Action:** Reconcile every equipment identity with tag instance, screen entry and batch selection entry. **Expected:** Each in-scope item appears consistently or has an explicit exception; no guessed room/twin mapping.

2. **Action:** Trace discovery queries, bindings and filters causing missing equipment. **Expected:** Required equipment is not silently hidden by missing provider paths or unintended quality filters.

3. **Action:** Inspect unavailable equipment display without substituting good simulated values. **Expected:** Offline status is distinguishable from missing configuration and shown per approved UI behavior.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-007 Metadata and CPP configuration

Source: FAT-003 TC1; RM CPP and process data. Work area: CPP configuration. Stage: A. Owner: Acropolis; TBMC approves CPPs.

Prerequisite: Approved identities, three Key CPPs, units/ranges and alarm expectations.

1. **Action:** Compare equipment names, room/group/path and enabled metadata across application resources. **Expected:** Tags, screens, claims, audit and reports use consistent approved identities.

2. **Action:** Compare each applicable device’s approved three Key CPPs with assignments and data types. **Expected:** Selections, units, ranges and bindings match; workbook CPP counts are not treated as three selections.

3. **Action:** Record missing process approvals and configuration completeness per device. **Expected:** Unapproved mappings remain blocked rather than invented; independent verified metadata stays recorded.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-008 Database initialization and authorization

Source: FAT-004 TC1; RM InfluxDB historian. Work area: Database. Stage: A. Owner: Acropolis; DB operator supports.

Prerequisite: DB-side protected credential handoff and approved access.

1. **Action:** Verify health/version and existing initialization at the commissioned endpoint. **Expected:** Healthy initialized service observed; no reinitialization/reset or historical migration.

2. **Action:** Authenticate and record organization/bucket IDs, retention and authorization definitions. **Expected:** Actual approved configuration and least-privilege integration scopes verified; secrets excluded.

3. **Action:** Compare endpoint/security and retention with approved deployment decisions. **Expected:** Changes are traceable; unavailable approvals are deficiencies, not silent defaults.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-009 Ignition historian connection

Source: FAT-004 TC1; RM InfluxDB historian. Work area: Historian connection. Stage: A. Owner: Acropolis.

Prerequisite: DB reachable, supported module operational and token available.

1. **Action:** Inspect intended existing Kymera historian and configuration against DB handoff. **Expected:** Correct URL/org/bucket and enabled status; legacy public URL is not used for new credentials.

2. **Action:** Verify connection state and diagnostics inside the actual gateway. **Expected:** Gateway reports usable connection without authentication/module errors.

3. **Action:** Check history provider resolution and intended tag mappings without bulk changes. **Expected:** Production paths resolve correctly; existing unrelated mappings remain unchanged.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-010 Isolated historian write and retrieval

Source: FAT-004 TC1; RM historian and live cutover. Work area: Historian functional. Stage: A. Owner: Acropolis.

Prerequisite: Disposable bucket/token and isolated memory tags with no equipment writeback.

1. **Action:** Historize three known numeric values from an isolated gateway tag with recorded times. **Expected:** Actual Kymera-originated samples are accepted in disposable storage only.

2. **Action:** Query the interval through Ignition and display the same data in a chart. **Expected:** Values/order/quality/time agree with recorded input at configured sampling behavior.

3. **Action:** Save evidence and remove only owned disposable resources after all dependent tests. **Expected:** No synthetic production history; cleanup and any retained resources are recorded.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-011 Historian recovery and timestamps

Source: FAT-004 TC1; RM Time synchronization. Work area: Historian continuity. Stage: A. Owner: Acropolis; TBMC supplies time source.

Prerequisite: Isolated historian connection and approved timestamp tolerance.

1. **Action:** Compare Windows, database, gateway, historian and displayed report/audit time conventions. **Expected:** Offsets/timezones and measured skew meet approved tolerance; absent tolerance blocks quantitative pass.

2. **Action:** Temporarily interrupt only the isolated test connection and generate known samples. **Expected:** Buffering/diagnostics follow installed module settings without affecting production paths.

3. **Action:** Restore only the test connection and query the recovered interval. **Expected:** Expected samples recovered or documented designed loss; no unexplained duplicates/quarantine.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-012 Relational SQL connections and schema

Source: RM Relational SQL; FAT-006 extension. Work area: SQL. Stage: A. Owner: Acropolis; TBMC provides SQL infrastructure.

Prerequisite: Approved SQL host/schema and protected credentials.

1. **Action:** Verify actual named connections and expected schema objects through supported interfaces. **Expected:** Batch, claims, audit and reporting-cache objects/permissions match approved application needs.

2. **Action:** Read representative records and verify application query paths. **Expected:** Queries resolve to intended database; no unexpected legacy host/schema references.

3. **Action:** Verify isolated synthetic record creation/persistence where safe separation exists. **Expected:** Application transactions persist correctly; no unrelated records modified.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-013 Save load and distinct runtime instances

Source: RM Batch workflow; CO migration extension. Work area: Batch. Stage: A. Owner: Acropolis; TBMC witness for formal SAT.

Prerequisite: Isolated application records and approved batch requirements.

1. **Action:** Save a commissioning setup, edit it as allowed, then load the same setup twice. **Expected:** Reusable setup persists and two distinguishable runtime instances are created.

2. **Action:** Inspect batch_uid, batch_run_uid and displayed run instance ID in UI/SQL. **Expected:** Setup identity is retained; each execution has a unique run identity.

3. **Action:** Select each runtime instance for reports and audit review. **Expected:** Records and selection distinguish executions sharing one saved batch name.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-014 Equipment claims and competing starts

Source: RM Batch workflow; CO migration extension. Work area: Batch claims. Stage: A. Owner: Acropolis.

Prerequisite: Synthetic equipment identities not claimed by client batches.

1. **Action:** Load two commissioning batches selecting the same synthetic equipment. **Expected:** Loaded association follows approved LOADED behavior; no premature physical command.

2. **Action:** Start the first instance, then attempt competing claim/start from the second. **Expected:** First-start claim ownership and approved conflict safeguards prevent double acquisition.

3. **Action:** Repeat action or refresh from a second session and inspect persisted claims. **Expected:** No duplicate/stale claim ownership; UI and SQL agree.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-015 Hold resume and terminal transitions

Source: RM Batch workflow; CO migration extension. Work area: Batch lifecycle. Stage: A. Owner: Acropolis.

Prerequisite: Approved transition matrix and isolated runtime instances.

1. **Action:** Exercise Start/Hold and resume only where specified. **Expected:** Only permitted transitions occur with correct actor, state and timestamps.

2. **Action:** Exercise Complete, Abort and Archive using separate instances where required. **Expected:** Terminal state and equipment release match approved rules.

3. **Action:** Attempt disallowed transitions and duplicate terminal actions. **Expected:** Invalid actions are rejected without orphan claims or corrupt reports/audit.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-016 State persistence and reconnect

Source: RM Batch workflow and Issues; migration extension. Work area: Batch persistence. Stage: A. Owner: Acropolis.

Prerequisite: Isolated records; no disruptive shared service restart.

1. **Action:** Refresh/reopen a client during a commissioning batch and inspect persisted state. **Expected:** Runtime identities, states, claims and timestamps survive client refresh.

2. **Action:** Compare separate sessions observing the same record after a safe state change. **Expected:** Views converge to persisted authoritative state; no stale action acceptance.

3. **Action:** Inspect error handling for unavailable test dependencies using isolated failure injection. **Expected:** User gets actionable feedback; transactions do not leave partial claims/records.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-017 Alarm configuration migration

Source: FAT-005 TC1; RM Alarm testing. Work area: Alarms. Stage: A. Owner: Acropolis; TBMC approves limits.

Prerequisite: Approved alarm list and isolated representative tags.

1. **Action:** Compare alarm definitions, limits, enable flags and journal bindings with approved baseline. **Expected:** Required settings migrated; missing approved limits are explicit blockers.

2. **Action:** Prepare isolated high/low tests corresponding to FAT room/parameter coverage. **Expected:** Coverage includes S801 Pressure, S815 Temp, S805 Temp and S814 Baset with confirmed identities.

3. **Action:** Record FAT example limits HIGH 10/LOW 0 separately from production limits. **Expected:** Example values are used only in isolated tests; no real setpoint is overwritten.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-018 Alarm activation acknowledgement and journal

Source: FAT-005 TC2; RM Alarm testing. Work area: Alarm functional. Stage: A. Owner: Acropolis.

Prerequisite: Isolated alarm tags/pipeline and roles; external notifications isolated.

1. **Action:** Drive isolated values across approved test thresholds, then return to normal. **Expected:** Expected active/clear sequence appears with correct source/time/priority.

2. **Action:** Acknowledge using authorized and unauthorized roles. **Expected:** Authorized acknowledgement works; denied action cannot bypass UI restrictions.

3. **Action:** Query journal and required audit entries, then restore owned test configuration. **Expected:** Event/actor/state history is traceable; production alarms/notifications unchanged.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-019 Report definition and PDF export

Source: FAT-006 TC1; RM reporting and SQL. Work area: Reports. Stage: A. Owner: Acropolis.

Prerequisite: Isolated batch/history data and approved report specification.

1. **Action:** Run a commissioning batch report and any required equipment status report. **Expected:** Correct report definition selected; source FAT wording mismatch is reconciled to approved specification.

2. **Action:** Verify sections, selected equipment/CPPs, run identity, interval and data against source records. **Expected:** Values, labels and timestamps agree; empty/missing sections are deficiencies.

3. **Action:** Export PDF and inspect every page. **Expected:** Readable complete output, authorized export, no clipping; trial watermark recorded as trial limitation.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-020 Report run separation and input validation

Source: FAT-006 TC1 extension; RM Batch workflow. Work area: Report integrity. Stage: A. Owner: Acropolis.

Prerequisite: Two same-name runs with distinguishable synthetic values.

1. **Action:** Generate reports independently for both same-name runtime instances. **Expected:** Each report uses its own run ID, interval, equipment and history.

2. **Action:** Test empty/invalid interval and missing-data inputs within approved behavior. **Expected:** No misleading reuse of prior data, cross-run leakage or unhandled error.

3. **Action:** Compare report cache/SQL records and repeat export under authorized roles. **Expected:** Cache identity and access follow approved rules; repeat results are consistent.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-021 Operator navigation and equipment detail

Source: FAT-007 TC1; RM Ignition deployment. Work area: Operator UI. Stage: A. Owner: Acropolis.

Prerequisite: Correct Perspective project/session and representative roles.

1. **Action:** Navigate every required overview, room, detail, trends, alarms, batch and report screen. **Expected:** Required screens load with correct routes and no unexplained binding/script errors.

2. **Action:** Compare names, three CPP presentation, units and equipment selection with approved inventory. **Expected:** Consistent metadata; unresolved identity is flagged, not hidden or guessed.

3. **Action:** Review unavailable-source behavior and gateway/session logs. **Expected:** Offline sources do not produce false healthy data or obscure migration errors.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-022 Identity integration and login logout

Source: FAT-007 TC2; RM Identity and users. Work area: Identity. Stage: A. Owner: Joint.

Prerequisite: Approved identity provider and representative TBMC accounts.

1. **Action:** Log in with actual Microsoft/approved identity provider test users. **Expected:** Authentication and group/role mapping match approved design.

2. **Action:** Log out and attempt previously protected navigation/actions. **Expected:** Session authority is removed; protected functions require valid authentication.

3. **Action:** Test invalid/unauthorized user through normal controls without brute force. **Expected:** Access denied appropriately; local simulation does not prove Entra integration.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-023 Inactivity timeout

Source: FAT-007 TC3. Work area: Session security. Stage: A. Owner: Acropolis; TBMC verifier.

Prerequisite: Representative logged-in user and visible synchronized clock.

1. **Action:** Record login/activity time then leave the session genuinely idle for 15 minutes. **Expected:** Automatic logout follows the FAT 15-minute criterion; record observed delay and any approved tolerance.

2. **Action:** Ensure automation polling or mouse events do not reset activity during the wait. **Expected:** Evidence reflects true idle behavior; no accelerated timeout configuration substituted.

3. **Action:** Attempt a protected action after timeout and sign in again. **Expected:** Expired session is denied and normal reauthentication succeeds.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-024 Public User and Supervisor permissions

Source: FAT-008 TC1 and TC2; RM Security and audit. Work area: Authorization. Stage: A. Owner: Acropolis; TBMC supplies users/policy.

Prerequisite: Approved security matrix with each role represented.

1. **Action:** Execute allowed/denied screen and operation cases for Public, User and Supervisor. **Expected:** Each case matches approved matrix; results recorded per role/action.

2. **Action:** Attempt restricted alarm edits, Audit Trail access, Abort/Archive and report export as applicable. **Expected:** Backend enforcement matches policy, not merely hidden buttons.

3. **Action:** Separate gateway administrator permissions from application roles. **Expected:** User access does not unintentionally grant gateway administration; all policy gaps are logged.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-025 Audit trail completeness

Source: FAT-008 extension; RM Security and audit. Work area: Audit. Stage: A. Owner: Acropolis.

Prerequisite: Approved event list, configured audit destination and isolated actions.

1. **Action:** Perform representative login/workflow/configuration actions authorized for the test. **Expected:** Required audit entries capture actor, action, target/run ID and time.

2. **Action:** Trace successful and rejected events required by the approved event policy. **Expected:** Entries match real actions and do not disclose passwords/tokens.

3. **Action:** Verify audit viewing permissions and evidence retention. **Expected:** Authorized review works; test records are retained and not deleted to conceal activity.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-026 Backup recovery and final configuration record

Source: RM Cloud resources Production server Final acceptance. Work area: Recovery. Stage: A. Owner: Joint.

Prerequisite: Approved backup procedure/destination; isolated restore environment if available.

1. **Action:** Verify current supported gateway/database backups and recovery instructions. **Expected:** Artifacts, hashes, protected location and owner recorded; live DB files are not copied as a substitute.

2. **Action:** Restore only in an isolated approved environment with background integrations disabled. **Expected:** Restored configuration opens and critical objects reconcile; without environment mark restore test blocked.

3. **Action:** Record final versions/paths, backup schedule, monitoring and technical punch list. **Expected:** Acropolis records are complete; TBMC infrastructure gaps retain TBMC ownership.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-027 Approved OPC endpoints and namespace

Source: FAT-002 and FAT-004 extension; RM Vendor and OPC access. Work area: Live OPC. Stage: B. Owner: Joint.

Prerequisite: TBMC releases live work; endpoints/interfaces and site personnel ready.

1. **Action:** After explicit release, verify approved vendor endpoint and security/trust settings. **Expected:** Correct interface/version/host identity; discovery alone is not integration proof.

2. **Action:** Browse namespace read-only and export approved available items. **Expected:** Approved source paths/types are traceable to equipment and vendor evidence.

3. **Action:** Reconcile mapped items without issuing writes to equipment. **Expected:** Only approved sources mapped; no process-control commands or guessed addresses.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-028 Live tag quality and three CPPs

Source: FAT-003 and FAT-004; RM Live-tag cutover. Work area: Live equipment. Stage: B. Owner: Joint.

Prerequisite: Approved per-device source/CPP register and on-site SME.

1. **Action:** For every in-scope device/approved CPP compare displayed value/type/units to local SME reference. **Expected:** All required items verified or explicitly excepted; sampling only with approved rationale.

2. **Action:** Observe source changes and timestamps/update behavior in a safe equipment state. **Expected:** Good quality and expected updates; simulator paths removed only after approved live cutover.

3. **Action:** Capture source identity, expected range and evidence per equipment/tag. **Expected:** No synthetic observation is counted as a live pass; discrepancies assigned accurately.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-029 Live history trends and reports

Source: FAT-004 and FAT-006; RM InfluxDB historian. Work area: Live historian. Stage: B. Owner: Joint.

Prerequisite: SAT-027/028 and live historian connection available.

1. **Action:** Observe real gateway-originated samples from approved live sources. **Expected:** Actual equipment data stored at approved rate without unexplained quality/errors.

2. **Action:** Query same interval through trends and corresponding report. **Expected:** Values, units, time and equipment/run identity agree across sources.

3. **Action:** Review all active required tags and record coverage/exceptions. **Expected:** Full intended live coverage or approved sampling documented; no blanket pass from one tag.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-030 Joint live alarm and operational verification

Source: FAT-005; RM Alarm testing and SAT execution. Work area: Live alarms. Stage: B. Owner: Joint.

Prerequisite: TBMC-approved safe representative conditions and on-site personnel.

1. **Action:** Agree local safe conditions or approved vendor simulation for representative alarm cases. **Expected:** Named TBMC person performs local actions; Acropolis never commands equipment.

2. **Action:** Verify actual alarm activation/clear/acknowledgement/journal and permissions. **Expected:** Expected events correlate to observed condition and approved limits.

3. **Action:** Record remaining equipment-specific gaps and restore normal test conditions. **Expected:** On-site witness confirms restoration; unresolved cases remain open.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-031 Production licensing and operational readiness

Source: FAT-001 TC1 retest; RM entry criteria and licensing. Work area: Production gate. Stage: C. Owner: Joint.

Prerequisite: Production entitlements and TBMC infrastructure records supplied.

1. **Action:** Verify required Ignition and third-party production licenses activated. **Expected:** Required modules are operational beyond trial expiry; repeated development resets do not satisfy this gate.

2. **Action:** Review site hardening, backups, recovery, monitoring, time source and operational owner records. **Expected:** Each mandatory prerequisite complete or approved disposition; no absent record inferred passed.

3. **Action:** Confirm technical support/runbook and outstanding Acropolis/TBMC responsibilities. **Expected:** Named owners and accepted remaining actions are documented.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-032 Deviation retest and customer acceptance

Source: FAT procedure; RM Issues and Final acceptance. Work area: Acceptance. Stage: C. Owner: TBMC approves; Acropolis provides evidence.

Prerequisite: All results, deficiencies and retests available for human review.

1. **Action:** Reconcile every step to current result, evidence and deviation/retest chain. **Expected:** No missing tests, orphan incidents or overwritten failures; blocked/deferred items visible.

2. **Action:** Review residual risk and proposed waivers/conditional acceptance with TBMC. **Expected:** Only authorized TBMC signatories approve disposition; automation cannot waive tests.

3. **Action:** Obtain named executor/verifier review and acceptance signatures/dates. **Expected:** Acceptance signed or explicitly pending; no copied FAT signatures or automated approval.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

### SAT-033 Targeted OPC discovery on responding hosts

Source: RM Local network tests and Vendor and OPC access; authorized discovery extension. Work area: OPC discovery. Stage: D. Owner: Acropolis discovers; TBMC/vendor resolves access.

Prerequisite: Read-only discovery authorization; no production integration.

1. **Action:** Identify installed Matrikon product/version/protocol/CLI capability; directly target six previously responding hosts. **Expected:** Product capabilities verified; no assumption Neighborhood supports UA or lists every server.

2. **Action:** Use bounded candidate-port tests and read-only UA/Classic discovery as specified in the companion commission. **Expected:** Port state separated from protocol proof; endpoint URLs/security or precise discovery errors retained.

3. **Action:** Compile per-host readiness and vendor follow-up without creating Ignition connections. **Expected:** No endpoint found is not proof of absence; equipment/site settings remain unchanged.

Actual results per step: NOT RUN. Evidence: __________. Incident: __________.

Tester/date: __________. Verifier/date: __________. Review: PENDING.

## Final disposition

Total tests: 33. Total numbered steps: 99. All are unexecuted at issue. Record per-step outcome and human review separately.

Final result: NOT EXECUTED / INCOMPLETE / NOT ACCEPTED / CONDITIONAL ACCEPTANCE / ACCEPTED (select only by authorized reviewers).

Open high/medium/low deficiencies: ____ / ____ / ____. Blocked: ____. Deferred: ____. Approved exceptions: ____.

Acropolis technical completion review and date: ____________________
Independent verification review and date: ____________________
TBMC acceptance decision, conditions, authorized signature and date: ____________________

No final acceptance with unresolved mandatory tests unless TBMC explicitly approves a documented conditional disposition. Development evidence does not by itself close live equipment, production licensing or customer acceptance gates.
