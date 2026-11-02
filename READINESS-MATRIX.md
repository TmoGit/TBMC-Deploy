# Deployment readiness matrix

| Component | Status | Evidence / remaining action |
|---|---|---|
| Ignition projects/modules/resources | Complete, transfer-verified | Encrypted artifacts and per-file source hashes published |
| MariaDB `ignition_config` | Backup complete, restore untested | Encrypted 10.11 logical dump; isolated restore still required |
| QuestDB schema | Complete, restore untested | 11-table encrypted schema artifact; no historical data |
| InfluxDB metadata | Blocked on authentication | VM API returns 401 for organizations/buckets/tasks; provide approved token or export |
| Ignition exact runtime | Unresolved | Existing artifacts do not expose a definitive Gateway version; no VM 133 restart performed |
| Native `.gwbk` | Unavailable | `gwcmd` not present in transferred artifacts; generating one requires source access/approval |
| Installer binaries | Incomplete | Official acquisition sources documented; proprietary/licensed files must be supplied and hashed |
| PowerShell entry points | Static checks passed | Runtime restoration remains untested |
