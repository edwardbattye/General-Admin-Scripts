$horizon = "C:\Program Files (x86)\VMware\VMware Horizon View Client\vmware-view.exe"
##kill horizon client command
$action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument 'Stop-Process -Name "vmware-view" -Force
$horizon'
$prinicipal =New-ScheduledTaskPrincipal -UserId "System" -LogonType S4U

##generate a trigger based on unlocking PC
$stateChangeTrigger = Get-CimClass `
    -Namespace ROOT\Microsoft\Windows\TaskScheduler `
    -ClassName MSFT_TaskSessionStateChangeTrigger

$trigger = New-CimInstance `
    -CimClass $stateChangeTrigger `
    -Property @{
        StateChange = 8  # TASK_SESSION_STATE_CHANGE_TYPE.TASK_SESSION_UNLOCK (taskschd.h)
    } `
    -ClientOnly
$trigger2 = New-CimInstance `
    -CimClass $stateChangeTrigger `
    -Property @{
        StateChange = 7  # TASK_SESSION_STATE_CHANGE_TYPE.TASK_SESSION_UNLOCK (taskschd.h)
    } `
    -ClientOnly

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$task = New-ScheduledTask -Action $action -Trigger $trigger,$trigger2 -Settings $settings -Principal $prinicipal
Register-ScheduledTask Close_Horizon -InputObject $task


