# InfluxDB metadata status

VM 132 InfluxDB is running version 2.8.0 (commit `40a633239e`). Its health endpoint is healthy. The unauthenticated API correctly returns HTTP 401 for organizations, buckets, and tasks.

The service uses:

- Bolt metadata: `C:\\Users\\acrop_user\\.influxdbv2\\influxd.bolt`
- SQLite metadata: `C:\\Users\\acrop_user\\.influxdbv2\\influxd.sqlite`
- Engine: `C:\\Users\\acrop_user\\.influxdbv2\\engine`
- Service engine argument: `--engine-path "C:\\Users\\acrop_user\\.influxdbv2\\engine"`

Bucket, organization, retention, task, and authorization exports could not be retrieved without an approved InfluxDB token. No token was exposed or guessed. Historical measurements were not copied.
