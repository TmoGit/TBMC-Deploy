# TBMC equipment reachability and Ignition historian commissioning

## Execution location and objective

Execute from the main on-premises Windows Ignition server. Complete the equipment network assessment, reconcile the supplied documents, and establish the production InfluxDB connection inside Ignition when prerequisites are available. Execute the work and produce actual evidence, not just a plan.

Run this commission first. If database preparation is required, run `02-TBMC-InfluxDB-Server-Preparation-Commission.md` on the DB server, securely transfer the connection handoff, and resume this commission without repeating completed work.

## Sources and boundaries

Locate these files in the supplied project folders, Desktop, or deployment package:

- `TBMC PAD Ignition Equipment list.xlsx`
- `TBMC Network Architecture RevC_8_13_26 Final.pdf`
- `Digital Design Specification_TBMC_CO1 8_13_26 Final.docx`
- `TBMC_Final_Phase_Responsibility_Matrix _GigiRev1.docx`

Resolve the actual Windows Desktop, including OneDrive redirection. Preserve originals. If a reference is unavailable, continue testing available equipment records and identify the missing comparison source. Inspect applicable AGENTS.md instructions.

The commissioned database target is **10.1.0.132**. The DDS endpoint `4.246.231.26:8086` is an older reference discrepancy, not the target for this work. Do not sweep subnets, operate equipment, change routes/VLANs/firewalls, or change physical process states.

## 1. Establish the test origin

Record hostname, timestamp with timezone, Windows version, source IPs, subnet masks, active interfaces, relevant routes, DNS, and Ignition gateway version. Identify the source interface/address used for the database and equipment networks. Record a run ID and tool versions.

## 2. Build a reconciled equipment register

Read every worksheet, including hidden rows. Preserve worksheet name, Excel row, equipment number, room, group, server name, vendor, model, description, CPP field, and original IP text.

The supplied baseline has **31 equipment rows, 22 populated IPs, and 9 blank IPs**. Recalculate from the actual file and report differences.

Extract equipment and addresses from the DDS and architecture. Reconcile by room, identity, vendor, model, and identifier—not only IP. Verify PDF label/address association visually when text extraction is ambiguous.

For each equipment record retain:

- Original workbook IP, DDS IP/location, architecture IP/location.
- Match confidence, discrepancy, tested address, and source of tested address.
- Whether the address is a device or shared vendor/MFCS endpoint.

Do not silently fill blanks or resolve conflicts. Test valid addresses from other references as clearly labeled candidates. Test conflicting documented addresses separately. Flag placeholders, invalid IPs, duplicate assignments, ambiguous matches, room/group conflicts, and source-only equipment. Preserve all equipment rows even where devices share an endpoint. Do not interpret `CPP #` as an approved selection of three Key CPPs.

Check these known discrepancies:

- Room 801 Sartorius `.12/.13/.14` and Avant 150 `.15` missing from workbook IP cells.
- Workbook AKTA Pilot `.22` versus unspecified reference addresses.
- Architecture room 815 Sartorius `.66/.67` versus workbook blanks.
- Workbook room 815 Plasmid and room 816 Gene therapy classifications.
- KNAUER NanoScaler is documented as **CSV ONLY**; ping does not establish OPC support.

## 3. Test equipment reachability

Test only explicit equipment/reference addresses and the commissioned database.

For each unique valid address:

1. Send four ICMP requests with bounded timeouts.
2. Record replies, packet loss, minimum/average/maximum latency, and actual failure category.
3. Retry initially unsuccessful targets once after the first pass.
4. Save raw timestamped evidence.

Share endpoint results across matching rows without losing equipment-level records. Classify: responding, intermittent response, no ICMP response, explicit unreachable response, missing/invalid address—not tested, or test error. Do not call equipment powered off solely because ping fails.

Where documents or actual configuration identify an application endpoint, perform targeted TCP/service tests. Separate device reachability from shared MFCS/OPC availability. Do not guess OPC ports or scan broad port ranges.

## 4. Test the production database

Ping `10.1.0.132`. Regardless of ping outcome, perform a bounded TCP test to the documented listener, initially TCP 8086 unless the DB handoff specifies otherwise. ICMP failure must not block TCP/API tests; ICMP success is insufficient proof.

Verify health, readiness, version, and initialization using the configured protocol. Validate TLS normally. Do not send credentials over public plaintext HTTP or bypass certificate validation.

Distinguish network failure, inaccessible listener, healthy/uninitialized server, authentication failure, insufficient permissions, and database ready for integration. If bound only to `127.0.0.1`, request the DB-side listener preparation rather than reinstalling.

## 5. Configure the actual Ignition historian connection

Inspect live gateway configuration and existing historian connections. The DDS identifies Kymera InfluxDB historically at `2.83.2 (b2)` with Ignition `8.3.4`; discover installed versions and consult official vendor documentation for their configuration and permission requirements.

Use the installed InfluxDB historian integration, **not a generic JDBC/SQL connection**. Create or update the intended production connection using:

- Host: `10.1.0.132` or its approved TLS hostname.
- Organization: `TBMC`.
- Bucket: `TBMC-Sensor-Data`.
- Protocol/port: verified DB-side handoff.
- Dedicated integration token: protected local file.

Use supported gateway UI/administration or documented APIs. Do not edit internal Ignition databases or undocumented files. Back up the gateway/configuration first and record previous settings without secrets. Preserve unrelated projects, tags, connections, SQL databases, and OPC settings. Do not bulk-repoint production historization during connection testing.

If credentials are missing, finish the assessment/report and identify the precise DB-side prerequisite; do not ask for secrets in chat. If the module is absent or unlicensed, document the exact supported remedy without silently upgrading or installing unrelated modules.

## 6. Validate through Ignition

Verify connection status inside Ignition. Where supported, use an isolated commissioning tag/provider and temporary bucket to test gateway-originated writes and historical readback. Keep synthetic data out of production equipment history. Record and remove only temporary resources created for this test after evidence capture.

A PowerShell API test is not proof the Ignition module works. If safe isolated testing is unavailable, report the remaining live-tag test explicitly. Do not operate equipment, modify alarms, or replace simulated equipment sources in this commission.

## 7. Deliverables and completion

Create a timestamped results folder on the actual Desktop containing:

- Excel report: Summary, Equipment Results, Source Reconciliation, Database-Ignition Results.
- CSV equipment results and discrepancy exports.
- Concise HTML or PDF report.
- Raw timestamped network/service evidence.
- Reusable PowerShell assessment script and rerun/resume instructions.

Equipment columns must include source row, identity, room/group, all documented IPs, tested IP/source, ICMP status, loss/latency, targeted service results, discrepancy, next action, and responsible party. Distinguish equipment rows from unique endpoint counts; retain missing-IP and reference-only equipment.

Assign physical/site-network/routing/cabling/equipment/vendor/firewall corrections to TBMC. Assign Ignition/module/configuration issues to Acropolis. Mark uncertain ownership explicitly.

The final report must state equipment responding/nonresponding/not testable, unresolved source discrepancies, database ICMP/TCP/API results, actual Ignition connection/write/readback evidence, and remaining dependencies. Do not claim production handoff from ping success alone. Complete all unblocked work and preserve results for resumption.

Keep tokens, passwords, gateway backups, and credential-bearing evidence out of Git. The Markdown commission itself contains no credentials.
