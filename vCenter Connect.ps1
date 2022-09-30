### Script to connec to both vcenter's

$vCenterCred = Get-Credential

Connect-VIServer omprodvc01,omvdivc01 -credential $vCenterCred