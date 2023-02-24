##list servers and services
$server1 = Get-Service -ComputerName 'server1' -Name 'service_name_here'
$server2 = Get-Service -ComputerName 'server2' -Name 'service_name_here'
##Loop over services and ask to start or stop
$servers = $server1,$server2 
Foreach ($server in $servers) {
    $server | Select-Object Name,Status,MachineName | Format-Table -AutoSize
    }

$input = Read-Host -Prompt Would you like to start or stop the services?
If ($input -eq 'start'){
    Foreach($server in $servers){
        Write-Host Starting $server.Name 
        $server|Start-Service
        }
    Elseif($input -eq 'stop'){
        Foreach($server in $servers){
        Write-Host Stoping $server.Name 
        $server|Stop-Service
        }

Foreach ($server in $servers) {
    $server | Select-Object Name,Status,MachineName | Format-Table -AutoSize
    }