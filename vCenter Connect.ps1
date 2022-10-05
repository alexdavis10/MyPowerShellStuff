### Script to connec to both vcenter's

$vCenterCred = Get-Credential

$vCenterHost = Read-Host "vCenter(s) you wish to connect to: "

Connect-VIServer $vCenterHost -credential $vCenterCred
