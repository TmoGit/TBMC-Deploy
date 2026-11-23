# Acropolis TBMC SAT execution and deficiency report commission

Revision 02 | 17 November 2026 | Consolidated MFCS and UNICORN instructions

## Objective and authority

Execute the available tests in `TBMC_SAT_Protocol_Rev02.docx` on the actual on-premises Ignition server. This Acropolis-branded Word protocol is the controlled source for all 33 test IDs and 99 numbered steps. Extract paragraphs and tables in document order with a DOCX-aware parser; visually inspect tables where interpretation is uncertain. Record its revision and hash. The protocol follows the FAT layout: Test Step Name, Test Purpose, Preliminary Conditions, then a five-column TC/AC table and Notes. Map TC1/AC1 to step 1, TC2/AC2 to step 2 and TC3/AC3 to step 3 within each SAT test. Blank result/signature cells mean NOT RUN. Keep human signature cells blank; record automated actual observations and evidence in the result sheets. The source-information section and traceability matrix have been removed from the protocol. No separate Markdown protocol or addendum is required. This is a test execution and deficiency-report assignment, not permission to sign customer acceptance or rewrite criteria to obtain passes.

Use an effective Windows administrator session where authorized administration is required, and actual gateway administrator access separately. Do not repeat unelevated access failures. Use existing protected credentials; never request secrets in chat. If UAC or sign-in requires user interaction, state the exact action once and resume independent work.

The user permits supported development trial resets for Ignition and Kymera, isolated application test resources and targeted OPC discovery. Do not install trial bypasses or treat development trial operation as permanent production licensing.

**Current live boundary:** TBMC is fixing offline shop-floor devices. Do not perform OPC integration, create live equipment connections, subscribe to real process tags, map sources, perform live cutover, change devices, or repeat the offline-device campaign. Phase D read-only discovery below is the explicit exception. Phase B remains DEFERRED until TBMC releases it. Phase C may be inspected but cannot pass unavailable final gates.

## 1. Load controlled sources and establish a run

Read applicable AGENTS.md and:

- `TBMC_SAT_Protocol_Rev02.docx` (Acropolis-branded consolidated protocol).
- Supplied FAT `FAT-25010-2_TBMC_CO1-8_13_26 Final.docx` and responsibility matrix `TBMC_Final_Phase_Responsibility_Matrix _GigiRev1(1).docx`.
- Approved DDS, architecture, inventory/tag/UDT exports, alarm/security lists, approved changes and FAT addendum where available.
- Current deployment reports, previous commissioning evidence and protected DB handoff.

Read accepted DOCX revisions; retain source identity and hashes. Do not infer that prior FAT PASS means present SAT PASS. FAT-001 TC1 is marked FAIL; track its disposition explicitly. Missing approved business rules or references are dependency/requirement gaps; do not invent them. Do not reuse historical observations as new results.

Generate a timestamped run folder on the actual Desktop, `TBMC-SAT-<timestamp>`. Resolve OneDrive redirection. Store credential-bearing backups/exports in separate protected nonsynchronized storage outside Git. Record run ID, mode, protocol revision/hash, host, source IP/routes, gateway URL/project/version, DB endpoint, timezone and source document revisions.

Create an execution plan covering **all 33 tests and 99 steps** before starting. Initial status is NOT RUN. Select development mode now unless formal protocol approval and qualified tester/verifier arrangements are actually available. Do not fabricate witness names, signatures or formal authorization.

## 2. Execute independently rather than stop at the first blocker

Run phase A tests in dependency order. Verify trials are valid before functional test groups; reset only through installed supported controls and verify actual module state. Reuse the trial helper if already installed rather than creating duplicate workers.

Take a fresh supported protected gateway backup before mutations. Verify safe isolation before synthetic activity. Use dedicated memory tags, disposable InfluxDB bucket/token, synthetic equipment identities and commissioning batches; trace actions to ensure no physical equipment writeback or real active claim conflicts. Do not blindly clone projects with startup/scheduled side effects enabled.

Test actual UI and backend behavior through supported interfaces, not just code inspection. A missing UI automation capability is an execution limitation, not a passing UI test. Record API-only verification scope. For the 15-minute inactivity test, wait actual elapsed time without sending activity events; do independent work elsewhere without resetting the tested session. Do not shorten the configured timeout to claim equivalence.

Capture screenshots, sanitized query outputs and timestamped observations for each criterion. Validate PDFs visually. Keep synthetic history out of `TBMC-Sensor-Data`; direct API writes are not evidence of Kymera gateway-originated historian behavior. Never type secrets into commands/transcripts or include them in evidence.

For phase B, create explicit DEFERRED rows with the site-release dependency and responsible owner. Do not delete those tests from the report. Execute phase C observations where possible, recording missing entitlements/acceptance accurately. Joint acceptance and independent verification remain pending human action.

## 3. MFCS tunnel and UNICORN UA discovery

Execute SAT-033 under the following consolidated instructions. They replace the previous generic port scan and incorporate addendum 06.

## Intended paths

The user clarified the intended design as MFCS through an OPC DA tunnel and UNICORN servers through OPC UA. Treat this as the design direction to verify against installed configuration, not evidence that either path is deployed.

| Equipment family | Intended source and path | Discovery focus |
|---|---|---|
| Sartorius managed by MFCS | MFCS OPC DA server → selected tunnel/bridge → supported Ignition client interface | MFCS DA registration, tunnel components and actual configured network port, Ignition-facing protocol |
| Cytiva managed by UNICORN | UNICORN OPC UA server → Ignition OPC UA client | Actual UNICORN server host, installed OPC server version, enabled UA service and configured endpoint |

Network Architecture RevC identifies MFCS hosts 172.16.81.10 (Room 801) and 172.16.81.65 (Room 815). Equipment addresses are not automatically OPC server addresses. The reviewed architecture text identifies host/equipment addresses but does not independently establish the tunnel product or UNICORN endpoint details. Do not invent either.

## Execute now: inventory and read-only discovery

1. Read existing deployment files, gateway connection metadata, installed application/service inventories and available vendor documentation. Identify the selected MFCS tunnel product, both endpoint locations, service identities, versions, licenses/trial state, and configured transport ports. A DA tunnel is not necessarily a DA-to-UA bridge: establish whether Ignition receives local DA through a compatible installed interface or UA through a bridge. Record missing components without installing them during this discovery pass.
2. Preserve the existing six-host scan boundary: 172.16.81.10, .13, .14, .20, .37 and .68. Refresh their ping results. Associate each with its authoritative equipment/server role. Do not require DA or UA listeners on the .13/.14 controller addresses if MFCS is their designed interface. Do not assume .20/.37/.68 are UNICORN PCs merely because the instruments respond.
3. For the responsive MFCS host .10, test only the documented tunnel listener ports relevant to the on-prem gateway. Inspect locally available tunnel configuration and logs. Do not make remote DCOM/OPCEnum over port 135 a required acceptance criterion when the intended route is the tunnel. Local DA enumeration on the MFCS host is a separate read-only task for an authorized session there; absence of that access is BLOCKED, not proof of absent OPC DA.
4. Record .65 and any newly identified UNICORN host as pending discovery targets if outside the six-host boundary. Produce a precise supplemental host/port list for the next authorized pass; do not silently expand the scan. Record the equipment-to-server mapping and its source even when the source server is not yet testable.
5. For a confirmed UNICORN UA host within the six-host boundary, obtain the actual endpoint from configuration or version-matched vendor documentation. Verify service/version and OPC entitlement evidence where accessible. Test its configured TCP port, then use a UA-capable client for FindServers/GetEndpoints metadata only. Capture URL, application URI, certificate thumbprint, security modes/policies and supported identity types. Never assume 4840 or 62541 is correct. If endpoint configuration is unavailable, record UNKNOWN/BLOCKED rather than sweeping ports or declaring OPC absent.
6. Identify the installed “Makitron” tool precisely. Matrikon OPC Explorer Classic is a DA/A&E tool; its Neighborhood view is not a UA endpoint inventory. Use its supported capabilities only. Verify any CLI against the installed product help; otherwise use the GUI or document a manual step. Use a UA-capable tool for UNICORN discovery. Do not infer a network failure from an incompatible tool or empty Neighborhood.
7. Retain the low-rate limits from commission 05: at most two simultaneous TCP checks, two-second timeout, one retry. No device writes, process subscriptions, source mapping, certificate trust changes, firewall/DCOM changes, tunnel installation or new Ignition equipment connections. Continue independent SAT tests while live integration is deferred.

## Reporting and SAT acceptance

Extend OPC-DISCOVERY.csv and the deficiency report with: equipment ID/IP, actual OPC host, intended protocol, tunnel product, source-side protocol, Ignition-facing protocol, configured port/endpoint, configuration provenance, installed/unknown state, reachability, discovery result, evidence, owner and next action.

Separate missing tunnel deployment, unknown server mapping, missing/disabled UA service, incompatible scanner, network reachability, credentials/certificates and vendor licensing. Assign ownership from the responsibility matrix; unresolved ownership stays proposed. Do not mark an instrument as failed merely because it does not expose OPC directly.

SAT-033 may pass only the discovery checks actually evidenced. Endpoint discovery does not pass live integration. After TBMC releases Phase B, SAT-027 must prove the selected MFCS tunnel path and UNICORN UA path separately. SAT-028 through SAT-030 must then verify approved tag mappings, quality/timestamps, historian flow and alarms over those actual paths. Preserve all original results and append retests.

## 4. Preserve results and compile deficiencies

Use one result row for every numbered step and separate attempt rows for retests. Required fields:

`RunID, Mode, ProtocolRevision, TestID, StepID, Attempt, SourceReference, Stage, ExpectedResult, ActualResult, TechnicalOutcome, ReviewState, Executor, UTC, LocalTime, EvidenceIDs, Dependency, Owner, DeficiencyIDs, RetestOf`

Technical outcomes: PASS, FAIL, BLOCKED, DEFERRED, NOT RUN, N/A PROPOSED, N/A APPROVED only with recorded TBMC approval. A pass requires the actual criterion evidenced. Never convert a blocked dependency or test harness error into application failure or success. Human review state is separate; missing verifier means PENDING. Keep per-step mixed outcomes even if overall test is incomplete.

Every failed step and every unresolved dependency/deferral/requirement gap must appear in an outstanding-items register. Use DEF-nnn IDs and distinguish `Type`: application defect, infrastructure dependency, requirement gap, execution limitation, deferred live verification, or acceptance item. Include linked test/steps, expected/observed, evidence, severity/impact, owner, suggested corrective action, dependency, due date if agreed, retest plan and closure authority. Severity is provisional until human review. Do not assign arbitrary due dates or claim owner acceptance.

Ownership follows the matrix: TBMC infrastructure/site/vendor/access/approved process data; Acropolis application and integration configuration after prerequisites; joint live verification; TBMC acceptance. Split mixed issues into concrete owner actions. The already-shared offline-device report is a dependency reference, not a new Acropolis application defect.

Do not repair application code, import missing tag structures, change approved business rules, modify schema or close findings as part of baseline testing. Record the failure first and provide a concrete remediation plan. Configuration necessary for expressly authorized isolated tests is permitted with backup and restoration. If a separate existing commission already authorizes a repair, record that change scope and preserve baseline failure and new retest attempts. Never silently modify tests to match broken behavior.

## 5. Deliverables and closeout

Create:

- `SAT-EXECUTION-REPORT.md` and readable HTML report: scope/mode, environment, technical outcomes by stage/test, deficiencies by severity/owner, completed evidence, limits and prioritized next steps.
- `SAT-STEP-RESULTS.csv`: all 99 original step rows plus subsequent attempt rows; no omitted/deleted steps.
- `SAT-DEFICIENCIES.csv`: every failed or outstanding item, with linked evidence and retest criteria.
- `SAT-COVERAGE.csv`: all source FAT-001 through FAT-008 criteria and RM areas mapped to relevant SAT IDs, with inherited FAT-001 failure explicitly tracked.
- `OPC-DISCOVERY.csv` and `OPC-DISCOVERY.md` as above.
- `EVIDENCE-INDEX.csv`: evidence ID, run/attempt, file path, timestamp, SHA-256, sanitizer/provenance and description; hash actual files.
- `CLEANUP-AND-RESUME.md`: owned test resources, restored state, retained audit records, any cleanup failures, protected backup references and exact next steps.
- An executed copy of the protocol or separate human-verifiable result sheets linked to original unchanged protocol hash. Preserve tester/verifier signature fields for humans.

The report must be compiled from observed result records, not hard-coded pass counts. Separate original attempts from latest outcomes and technical PASS from reviewed/accepted status. Reconcile 33 tests/99 baseline steps and report A/B/C/D totals, including all deferred live work and production gates. A partial run must still produce a useful deficiencies report. Do not issue a fictional pre-execution deficiencies report as if tests ran.

Ensure credentials, session cookies, protected exports, private keys and gateway backups are absent from publishable files. Keep source documents and screenshots subject to project confidentiality; do not push to GitHub or send anything externally without separate authorization.

Do not mark the system accepted or production ready. Finish all available work, identify the narrow remaining inputs, and leave evidence ready for Acropolis review and TBMC witness/acceptance.
