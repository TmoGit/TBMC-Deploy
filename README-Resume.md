# TBMC commissioning evidence and resumption

Assessment completed on TP-IGN01, Asia/Taipei (UTC+08:00). Open TBMC-Commission-Report.html or TBMC-Commission-Results.xlsx first. Production commissioning remains BLOCKED; see summary.json for dependencies and ownership.

## Findings

- Workbook: 31 rows, 22 populated IPs and 9 blanks, matching baseline. All worksheets/hidden rows read.
- Unique equipment endpoints: 28 tested, 6 responding and 22 nonresponding. Initially unsuccessful targets received a second four-request pass.
- Workbook rows: 6 responding, 22 nonresponding at matched/reference-candidate addresses, 3 inconclusive identity/address mappings. Candidates are explicitly labeled and do not fill original cells.
- Four additional reference inventory records retained; BRX5 may overlap workbook equipment 3. Do not interpret 35 register rows as 35 confirmed physical devices.
- Database 10.1.0.132: eight ICMP timeouts, TCP 8086 timeout, HTTP health/readiness/setup timeouts on initial and direct no-proxy tests. No credentials sent. Actual version, initialization, token permissions and bucket state remain unknown.
- Live authenticated Ignition: 8.3.4; Kymera 2.83.2 (b2), ACTIVE, Trial; Trial Expired and no licenses activated. Existing InfluxDB v1/v2 historian is DISABLED and points to the legacy public URL. No gateway settings or process states changed.
- Actual module connection/write/readback remains NOT PERFORMED. No temporary bucket/tag/provider created and no cleanup required for those resources.

## Exact prerequisites

1. TBMC/site and DB operator: establish/verify the approved private route to 10.1.0.132 and its listener. Current Ignition source is 172.16.81.201/24 via default gateway 172.16.81.254. Confirm actual DB-side source/NAT/VPN before restricting a firewall rule. Timeout alone cannot identify which intermediate component failed. This session has no supplied remote DB administration access; commission 02 must run on that server, preserving its existing service/data/configuration.
2. DB operator (ownership unconfirmed): prepare the protected connection handoff containing verified URL/protocol/port/TLS trust, organization and bucket IDs, retention, version, and dedicated read/write integration token. Keep secrets out of chat, Git and this report folder. No handoff was found in the supplied Desktop/package, Incoming or established Secure folders.
3. Acropolis: resolve gateway and Kymera production entitlements using supported licensing controls. Do not substitute trial reset for production licensing or silently upgrade the installed module.
4. TBMC/vendor: approve identity/address mappings for workbook equipment 3, 22 and 27; blank-IP candidates; placeholder/reference-only inventory; capacity/model/classification discrepancies. Supply actual vendor application endpoint URLs. NanoScaler is CSV ONLY.

## Resume assessment without overwriting evidence

Use Windows PowerShell. These scripts only contact the explicit endpoints in endpoints.json; no subnet or port sweep occurs. Preserve this folder as an immutable original run.

```powershell
$prior = $PSScriptRoot # If using interactively, set to this results folder's full path.
$next = Join-Path ([Environment]::GetFolderPath('Desktop')) ('TBMC-Reassessment-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $next | Out-Null
Copy-Item (Join-Path $prior 'endpoints.json') $next
& (Join-Path $prior 'Assess-Equipment.ps1') -RunDirectory $next
& (Join-Path $prior 'Assess-Database.ps1') -RunDirectory $next
```

Assess-Database.ps1 defaults to the initially documented private HTTP/8086 listener and sends no authentication. If the verified handoff specifies a different port/protocol/approved TLS hostname, update a copied script to that exact approved endpoint, preserve normal certificate validation, and record the handoff provenance before rerunning. Do not test arbitrary alternatives. Never pass a production token to the public historical URL.

Gateway evidence in this folder is a point-in-time authenticated UI observation from the original run. Reassess the live gateway separately after network/credential/licensing prerequisites change; network-only reruns cannot establish module readiness.

## Resume historian configuration and end-to-end verification

- Capture a fresh native gateway/configuration backup in restricted, nonsynchronized local storage before any changes. Previous sanitized settings are in historian-previous-sanitized.json; do not export embedded secrets into the evidence folder.
- Use Services > Historians > InfluxDB > Edit (Kymera InfluxDB v1/v2 historian), using the verified private URL and protected dedicated token, organization TBMC, bucket TBMC-Sensor-Data. Preserve unrelated settings and existing production tag history mappings.
- Confirm actual gateway connection status. Use an isolated commissioning provider/tag and temporary bucket where supported; validate gateway-originated historian writes and historical query/readback. A direct API test alone is insufficient.
- Preserve synthetic-data isolation. Remove only temporary resources created by the commissioning test after evidence capture. Record remaining live-tag acceptance if safe isolated validation is unavailable.
- ProductionReady stays false until actual module connection/write/readback and required owner acceptance are evidenced.

## Evidence notes

icmp-raw.csv retains each timestamp, pass, request number, status and reply address. endpoint-results.csv aggregates all attempts, losses and successful latency statistics; unsuccessful latency is blank, not zero. neighbors-after-tests.csv supplies adjacent ARP state, not an independent proof of device health. Explicit unreachable ICMP responses preserve the reported responder in raw evidence.

DDS-equipment-accepted.json removes tracked-deletion/move-from containers in memory and reads current text; DDS-tables.json retains the initial raw extraction including deleted text. The accepted table, not the concatenated raw revision table, drives the register. Architecture page 1 was rendered and visually reviewed to confirm room/label associations. Source originals were never edited. The responsibility matrix was not found; ownership comes from the commission and unconfirmed DB/commercial ownership is marked.

The report generator uses isolated Python 3.12.8 at C:\TBMC\Tools\commission-python with openpyxl 3.1.5 and PyMuPDF 1.24.14. It does not change the system Python or PATH. The reusable network scripts use built-in Windows PowerShell/.NET only. Reports can be rebuilt from this run's saved evidence with:

```powershell
& C:\TBMC\Tools\commission-python\python.exe (Join-Path $prior 'build-commission-report.py') $prior
```

This rebuild reflects saved evidence, not a fresh commissioning run. Do not mix fresh network results with old gateway observations and label them current.

No gateway backup or credential file is included. The private diagnostic Edge instance was closed after inspection; browser authentication did not reset passwords or trials.
