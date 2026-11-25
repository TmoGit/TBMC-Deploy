Get-NetTCPConnection -State Listen |
Where-Object {
    $_.LocalPort -in @(443,60409,60433)
} |
Format-Table LocalAddress,LocalPort,OwningProcess
