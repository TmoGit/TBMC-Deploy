TBMC Deployment - Desktop launchers
=================================

1. Unzip TBMC-Deploy-main onto the Windows Desktop.
2. Put these four files in the TBMC-Deploy-main folder, replacing
   the previous Deploy-TBMC-Database.ps1 and Deploy-TBMC-Ignition.ps1.
3. On the Ignition server, double-click Run-TBMC-Ignition.cmd.
   On the time-series database server, double-click Run-TBMC-Database.cmd.
4. Approve the Windows administrator prompt (UAC).
5. The scripts find the extracted repo and stage it in C:\TBMC\TBMC-Deploy.
6. If supplied, they copy Desktop\client.json into the repo,
   Desktop\deploy.key into C:\TBMC\Secure (with restricted permissions),
   and Desktop\TBMC-Installers into C:\TBMC\Installers.
7. They run the appropriate underlying installer with -DryRun first.
8. If all prerequisites are present, a Yes/No popup asks whether to
   proceed with live application installation. No is the default.

Missing version/hash/configuration/key/installer information cannot
be guessed. A new example client.json is not a valid live config.
If anything is missing, resolve it and launch the same .cmd again.
No VM or Proxmox dependency is required on the client host.

Do not put the private deploy.key in a public or shared repository.
Do not enable external live Ignition/PLC/MQTT connections until validated.
