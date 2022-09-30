Add-Type -AssemblyName System.Web

# Parameters to extract from New_Hire.csv file
Import-Csv -Path $CSVPath | foreach {
   
	$NewUserParameters = @{
		GivenName = $_.FirstName
		Surname = $_.LastName
		sAMAccountName = $_.UserName
        userPrincipalName = $_.EmailAddress
        EmailAddress = $_.EmailAddress
        Title = $_.Title
        Description = $_.Title
        Department = $_.Department
        employeeNumber = $_.EmployeeNumber        
	}

    # Enter location of New_Hire.csv file where new hire info is entered.
    $CSVPath = Read-Host "Location of New_Hire.csv: "

    #Path to OU
    $OUPath = Read-Host "Path to OU. Example (OU=Faculty,DC=acom,DC=edu)"

    # Creating and setting attributes for new user.
	New-ADUser @NewUserParameters -Name "$($_.FirstName + " " + $_.LastName)" -Path $OUPath -Enabled $true -AccountPassword (Read-Host -AsSecureString "Input User Passowrd")
    Set-ADUser -Identity $_.UserName -Add @{targetAddress = $_.UserName + "@acomedu.mail.onmicrosoft.com";ProxyAddresses = "SMTP:" + $_.EmailAddress}

    # Retrieving all available groups to add user to.
    $groups =  Get-ADgroup -Filter * | Select-Object -Property Name| Out-GridView -PassThru -Title "Select the Groups you want to add the users" | Select-Object -ExpandProperty Name

    # Add user to selected groups.
    foreach($group in $groups){
        Add-ADGroupMember -Identity $group -Members $_.UserName
    }
}