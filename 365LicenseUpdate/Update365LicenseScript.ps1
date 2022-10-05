Import-Module MSOnline
Connect-MsolService

$CSVPath = Read-Host "Location of CSV file: "

$users = import-csv $CSVPath -Delimiter ","
foreach ($user in $users)
{
    $upn=$user.UserPrincipalName
    $usagelocation=$user.usagelocation
    $SKU=$user.SKU
    Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
}
