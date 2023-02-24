#Keep a Windows device upto date with Chocolatey.Preregs are install Chocolately and install all apps with Chocolatey. Also install the Chocolatey Windows Ppdate script so we can install Windows Updates. This could be run as a scheduled task.
Write-Host "Let's get Windows updates installing"
Write-Host "Might want to grab a brew"
Get-WindowsUpdate -NotCategory "Drivers" -NotTitle "OneDrive" -Install -AcceptAll -AutoReboot -Verbose
Write-Host "Windows updates finished, lets check Chocolatey for App upgrades"
Choco upgrade all -y
Write-Host "Almost there, lets check Office 365. This script will exit but the 365 click to run client will tell you when finished"
cd "C:\Program Files\Common Files\microsoft shared\ClickToRun\"
Start-Process -Wait -FilePath "OfficeC2RClient.exe" -Argumentlist "/update user forceappshutdown=true"
