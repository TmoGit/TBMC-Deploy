param([string]$RunDirectory = (Get-Content C:\TBMC\Logs\TBMC-Current-Equipment-Run.txt),[int]$TimeoutMs=1200)
$ErrorActionPreference='Stop'
$ips=Get-Content (Join-Path $RunDirectory 'endpoints.json') -Raw|ConvertFrom-Json
foreach($ip in $ips){[Net.IPAddress]$parsed=$null;if(-not[Net.IPAddress]::TryParse([string]$ip,[ref]$parsed)){throw 'Invalid endpoint'};if($ip -ne '10.1.0.132' -and $ip -notmatch '^172\.16\.81\.\d+$'){throw 'Endpoint outside explicit commissioned range'}}
$all=New-Object Collections.Generic.List[object]
$targets=$ips
for($pass=1;$pass -le 2;$pass++){
 for($n=1;$n -le 4;$n++){
  $pending=@(foreach($ip in $targets){$p=New-Object Net.NetworkInformation.Ping;[pscustomobject]@{IP=$ip;Ping=$p;Task=$p.SendPingAsync($ip,$TimeoutMs);Timestamp=(Get-Date).ToString('o')}})
  foreach($item in $pending){try{$r=$item.Task.GetAwaiter().GetResult();$all.Add([pscustomobject]@{Timestamp=$item.Timestamp;IP=$item.IP;Pass=$pass;Request=$n;Status=$r.Status.ToString();ReplyAddress=[string]$r.Address;LatencyMs=if($r.Status -eq 'Success'){$r.RoundtripTime}else{$null};Error=''})}catch{$all.Add([pscustomobject]@{Timestamp=$item.Timestamp;IP=$item.IP;Pass=$pass;Request=$n;Status='TestError';ReplyAddress='';LatencyMs=$null;Error=$_.Exception.GetType().Name})}finally{$item.Ping.Dispose()}}
 }
 $targets=@($ips|Where-Object {$ip=$_;@($all|Where-Object {$_.IP -eq $ip -and $_.Status -eq 'Success'}).Count -eq 0})
 if($targets.Count -eq 0){break}
}
$all|Export-Csv (Join-Path $RunDirectory 'icmp-raw.csv') -NoTypeInformation -Encoding UTF8
$summary=@(foreach($ip in $ips){$a=@($all|Where-Object IP -eq $ip);$good=@($a|Where-Object Status -eq Success);$stats=$good|Measure-Object LatencyMs -Minimum -Average -Maximum;$state=if($good.Count -eq $a.Count){'responding'}elseif($good.Count){'intermittent response'}elseif(@($a|Where-Object Status -Match 'Unreachable').Count){'explicit unreachable response'}elseif(@($a|Where-Object Status -eq TestError).Count){'test error'}else{'no ICMP response'};[pscustomobject]@{IP=$ip;Status=$state;Requests=$a.Count;Replies=$good.Count;LossPercent=[math]::Round(100*(1-$good.Count/$a.Count),2);MinMs=$stats.Minimum;AvgMs=$stats.Average;MaxMs=$stats.Maximum;FailureCategories=(@($a.Status|Sort-Object -Unique)-join '; ')}})
$summary|Export-Csv (Join-Path $RunDirectory 'endpoint-results.csv') -NoTypeInformation -Encoding UTF8
$summary|Format-Table -AutoSize


