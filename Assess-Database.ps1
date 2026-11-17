param([Parameter(Mandatory=$true)][string]$RunDirectory)
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Net.Http
$results=New-Object Collections.Generic.List[object]
$c=New-Object Net.Sockets.TcpClient
$now=(Get-Date).ToString('o')
try{$t=$c.ConnectAsync('10.1.0.132',8086);if(-not$t.Wait(4000)){throw [TimeoutException]::new('Connection deadline exceeded')};$t.GetAwaiter().GetResult();$results.Add([pscustomobject]@{Test='TCP 10.1.0.132:8086';Timestamp=$now;Status='Connected';Detail=$c.Client.LocalEndPoint.ToString()})}catch{$results.Add([pscustomobject]@{Test='TCP 10.1.0.132:8086';Timestamp=$now;Status='Failed';Detail=$_.Exception.GetType().Name+': '+$_.Exception.Message})}finally{$c.Dispose()}
$h=New-Object Net.Http.HttpClientHandler;$h.UseProxy=$false;$h.AllowAutoRedirect=$false
$http=New-Object Net.Http.HttpClient($h);$http.Timeout=[TimeSpan]::FromSeconds(5)
foreach($p in @('/health','/ready','/api/v2/setup')){
 try{$response=$http.GetAsync('http://10.1.0.132:8086'+$p).GetAwaiter().GetResult();$body=$response.Content.ReadAsStringAsync().GetAwaiter().GetResult();$results.Add([pscustomobject]@{Test=$p;Timestamp=(Get-Date).ToString('o');Status=[string][int]$response.StatusCode;Detail=$body});$response.Dispose()}
 catch{$results.Add([pscustomobject]@{Test=$p;Timestamp=(Get-Date).ToString('o');Status='Failed';Detail=$_.Exception.GetType().Name+': '+$_.Exception.Message})}
}
$http.Dispose();$h.Dispose()
$results|ConvertTo-Json -Depth 5|Set-Content (Join-Path $RunDirectory 'database-tests-direct.json') -Encoding UTF8
$results|Format-Table -Wrap
