##Sets variables
$Testfile = "$env:appdata\MicroSIP\check.txt"
$Username = "$env:USERNAME"
$Share = "\\server_name_here\Softphone$"
$shortcutfolder = "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup"
$progfiles = "C:\Program Files (x86)"
##Looks for check file to see if the script has succesfully run before, if it has it immediately quits
If (Test-Path $Testfile -PathType leaf) {
    Exit
}Else {
##If script hasn't run before finds the users IP phone extension, if they don't have one it quits
##checks if the ini file on the the phone server exists if not then quits. If the file exists then it copys over to user appdata and creates the check file
    $phoneconfig = "$Share\$Username.ini"
    $testphoneconfig = Test-Path $phoneconfig -PathType leaf
    If($testphoneconfig -eq $False){
        Write-Host "No phone config on phone server, exiting"
        Exit
    }Else{
        $applicationfiles = "$Share\Softphone"
        $teststartup = Test-Path -Path $shortcutfolder
        Copy-Item -Path "$applicationfiles" -Destination "$progfiles\MicroSIP" -Recurse
        If($teststartup -eq $False){
            New-Item -Path "$env:appdata\Microsoft\Windows\Start Menu\Programs\" -Name "Startup" -ItemType "directory"
            }
        Copy-Item -Path "$progfiles\MicroSIP\MicroSIP.lnk" -Destination $shortcutfolder
        Copy-Item "$phoneconfig" -Destination "$env:appdata\MicroSIP\MicroSIP.ini"
        Copy-Item -Path "$progfiles\MicroSIP\MicroSIP.lnk" -Destination "User_Desktop_path_here"
        New-Item "$env:appdata\MicroSIP\Check.txt"
        }
}
