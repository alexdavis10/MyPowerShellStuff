Import-Module MSOnline
Connect-MsolService

$users = import-csv "C:\Users\adavis\OneDrive - Alabama College of Osteopathic Medicine\Desktop\MyPowerShellScripts\365LicenseUpdater.csv" -Delimiter ","
foreach ($user in $users)
{
    $upn=$user.UserPrincipalName
    $usagelocation=$user.usagelocation
    $SKU=$user.SKU
    Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
}