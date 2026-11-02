# Database deployment scope

QuestDB and InfluxDB are time-series systems. The encrypted QuestDB schema artifact is intended to restore table structure and metadata without historical measurements.

The contextual application database is MariaDB `ignition_config` referenced by Ignition connection `ignitionDB`. Its records are not included until a consistent source backup is obtained from VM 133 or its original storage.

Restores must require explicit destination-specific credentials and must not reconnect to live endpoints automatically.
