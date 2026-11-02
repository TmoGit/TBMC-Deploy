# VM 133 completion status

## Captured and encrypted

The gateway configuration metadata, module inventory, commissioning metadata, and Java service configuration were transferred through QEMU Guest Agent and encrypted with age. See `artifacts/vm133/TRANSFER-MANIFEST.md`.

## Dependencies identified

- Ignition projects: `TBMC`, `TBMC_CT_DEMO`, `SCADA_Template_Project`, and `samplequickstart`.
- Custom module directory: `Ignition\\user-lib\\modules`; it contains MQTT Engine/Transmission, Historian, InfluxDB, JDBC, OPC-UA, Perspective, Vision, PLC-driver, and other modules.
- CSV historian path: `C:\\Program Files\\Inductive Automation\\CSV_IN`; current guest inventory measured one file totaling 164,944 bytes.
- External historian: InfluxDB at `http://4.246.231.26:8086`, bucket `TBMC-Sensor-Data`, organization `TBMC`. The live endpoint must not be enabled automatically during restore.

## Not yet complete

The native Gateway backup (`.gwbk`), project exports, custom module binaries, JDBC drivers, CSV historian file, and a non-live InfluxDB schema/retention description still require capture. The guest contains approximately 338 MB of custom module files and approximately 2.0 GB under Ignition `data`; these should be transferred as separately encrypted, integrity-checked artifacts rather than committed as ordinary Git blobs. VM 133 is therefore not declared complete and VM 132 has not started.

The Proxmox configuration confirms only the OS disk is attached; the VM description states that a shared data disk was intentionally excluded. The CSV historian is on the Windows OS volume, while InfluxDB is external; the excluded disk's contents cannot be ruled out as an external dependency until the original source/storage inventory is checked.
