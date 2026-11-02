# VM 133 encrypted transfer manifest

Artifacts were read through QEMU Guest Agent and encrypted in the Proxmox host pipeline with the age recipient derived from the authorized deployment key. Plaintext guest files were not retained in the deployment directory.

| Guest source | Guest SHA-256 | Encrypted artifact |
|---|---|---|
| `C:\\Program Files\\Inductive Automation\\Ignition\\data\\gateway.xml` | `61F9D90E11356CD1D953E981DD40C29C0774F6A38320DD68BC0C4AC0A80EFA97` | `gateway.xml.age` |
| `C:\\Program Files\\Inductive Automation\\Ignition\\data\\modules.json` | `C68F85C398D78BE00F8DB181DC8B490F33DD32C45B5FA8DEE5B7E33327882E8A` | `modules.json.age` |
| `C:\\Program Files\\Inductive Automation\\Ignition\\data\\commissioning.json` | `6D94B881773FFA27E0297F8797415711380A948F5BF0D1ACC24531E69B76BF01` | `commissioning.json.age` |
| `C:\\Program Files\\Inductive Automation\\Ignition\\data\\ignition.conf` | `3208996C5EBD30CE1D1436BFB86D701E6F02453CF344F336736D228E9B5D3ADC` | `ignition.conf.age` |

Restore order: install the matching Ignition release, stop the service, decrypt these files to their corresponding `data` paths, restore the project/module/configuration archives, then start Ignition and validate the gateway.

The encrypted artifact checksums are in `ENCRYPTED-SHA256SUMS`.
