# VM 133 inventory

Collected through Proxmox QEMU Guest Agent on 2026-11-02.

- Hostname: `ACROP-DEVIGN-TB`
- OS: Windows Server 2025 Datacenter Azure Edition
- Ignition service: installed and running
- Ignition root: `C:\\Program Files\\Inductive Automation\\Ignition`
- Gateway configuration: `data/gateway.xml` (1,312 bytes)
- Module inventory: `data/modules.json` (8,706 bytes)
- Commissioning metadata: `data/commissioning.json` (139 bytes)
- Projects: `samplequickstart`, `SCADA_Template_Project`, `TBMC`, `TBMC_CT_DEMO`
- Existing project archive: `data/var/ignition/quick-start/projects/samplequickstart.zip` (6,909,122 bytes)
- Existing gateway backup files: `.gateway.xml.bak`, `.redundancy.xml.bak`, `init.properties.bak`

The actual gateway export, project exports, license material, and database backups are not committed here. They must be exported from the guest, encrypted, and added under `artifacts/` before VM 133 can be considered complete.
