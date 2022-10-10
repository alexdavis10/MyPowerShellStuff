## Script to check lockout status and last password set date.

$Username = Read-Host "Username to check: "

Get-ADUser -Identity $Username -Properties * | ft name,passwordlastset,lockedout,passwordexpired,passwordneverexpires