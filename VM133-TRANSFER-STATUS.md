# VM 133 transfer status

The temporary host-only SFTP channel used `vmbr1` and Windows OpenSSH. The guest remained isolated from the management network and internet.

Verified project file transfers:

- `.resources`: 1,050 files, zero SHA-256 mismatches
- `samplequickstart`: 652 files, zero SHA-256 mismatches
- `TBMC`: 494 files, zero SHA-256 mismatches
- `TBMC_CT_DEMO`: 764 files, zero SHA-256 mismatches
- `SCADA_Template_Project`: 466 files, zero SHA-256 mismatches

Verified module transfer:

- 33 `.modl` module packages, zero SHA-256 mismatches
- Includes MQTT Engine/Transmission, Historian, InfluxDB, JDBC, OPC-UA, Perspective, Vision, driver, reporting, SQL, and notification modules
- Active H2 `.mv.db` files were excluded as mutable runtime databases

Encrypted archives are split below GitHub's per-file limit:

- `projects.tar.gz.age`
- `modules.part.000.age` through `modules.part.006.age`
- `gateway-resources.tar.gz.age`
- `csv-historian.tar.gz.age`

The native `.gwbk` backup was not available on the guest. The package therefore distinguishes filesystem/project/module recovery from a native Gateway backup. Live InfluxDB remains an external dependency and is not enabled automatically.
