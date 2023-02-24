#Use this script as a recovery action on a windows service
$svc = Get-Service -Servicename 'Service_name_here'

$svc | Set-Service -Status Running
$svc.WaitForStatus('Running','00:01:00')

#If services need restarting on other services you can do this here

#Invoke-Command -ComputerName 'Computer_name_here' -ScriptBlock {Restart-Service 'Service_name_here'}  

$mailProps = @{
    To = ''
    From = ''
    Subject = ''
    Body = -join  '' | Out-String
    SmtpServer = ''
}

Send-MailMessage @mailProps
