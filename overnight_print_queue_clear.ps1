Get-Printer | Get-PrintJob | Remove-PrintJob
Remove-Item C:\Windows\system32\spool\printers\* -Recurse
Restart-Service -Name Spooler