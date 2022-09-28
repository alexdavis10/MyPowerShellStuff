Add-Type -AssemblyName System.Web
Import-Csv -Path C:\New_Hire.csv | foreach {
    
	$userName = $_.FirstName + " " + $_.LastName
	$NewUserParameters = @{
		GivenName = $_.FirstName
		Surname = $_.LastName
		sAMAccountName = $_.UserName
        mail = $_.EmailAddress
        title = $_.Title
        descriptin = $_.Title
        department = $_.Department
        proxyAddresses = "SMTP:$_.EmailAddress"
        targetAddress = $_.UserName + "@acomedu.mail.onmicrosoft.com"
        AccountPassword = $secPw
	}
	New-AdUser @NewUserParameters

    $groups =  Get-ADgroup -Filter * | Select-Object -Property Name| Out-GridView -PassThru -Title "Select the Groups you want to add the users" | Select-Object -ExpandProperty Name

    foreach($group in $groups){
        Add-ADGroupMember -Identity $group -Members $$_.UserName
    }
}