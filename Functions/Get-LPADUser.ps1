Function Get-LPADUser
{
<#
	.SYNOPSIS
		This script aids in finding a user and displays basic information

	.DESCRIPTION
		This script aids in finding a user and displays basic information

	.PARAMETER User
		This should be the name or SamAccountName of a user

	.INPUTS
		None

	.OUTPUTS
		This outputs basic information from AD

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjørn
		Contact:			lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: LPanzerbjørn
		Creation Date:		2018.11.01
		Purpose/Change:		Initial script development
		Change 2019.03.14:	Pre-fixed Function
		
	.EXAMPLE
		Get-LPADUser -User Panzerbjørn*
	
	.EXAMPLE
		Get-LPADUser -User *Panzer*
		1. Marie Panzer, mPanzer
		2. lPanzerb, lPanzerb
		3. Lars Panzerbjørn ADM, lPanzerb_admin
		Enter Selection: 3


		SamAccountName             : lPanzerb_admin
		Name                       : Lars Panzerbjørn ADM
		Department                 :
		Description                :
		Title                      :
		Manager                    :
		Office                     :
		PhysicalDeliveryOfficeName :
		Enabled                    : True
		LockedOut                  : False
		PasswordNeverExpires       : False
		AccountExpirationDate      :
		DistinguishedName          : CN=Lars Panzerbjørn ADM,OU=Admins,DC=CentralIndustrial,DC=intra
		CanonicalName              : CentralIndustrial.intra/Admins/Lars Panzerbjørn ADM


	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True,ValueFrompipeline=$True)][string]$User
	)
	IF (Get-ADUser -Filter {NAME -like $User})
	{
		$USR = Get-ADUser -Filter {NAME -like $User} -Properties *
	}
	ELSE
	{
		$USR = Get-ADUser -Filter {SamAccountName -like $User} -Properties *
	}
	
	IF (($USR|measure).Count -GT 1)
		{
		$Menu = @{}
		for ($i=1;$i -le $USR.count; $i++) {
		Write-Host "$i. $($USR[$i-1].name), $($USR[$i-1].SamAccountName)"
		$Menu.Add($i,($USR[$i-1].SamAccountName))
		}
		[int]$ans = Read-Host 'Enter Selection'
		$Selection = $Menu.Item($ans)
		$USR = $Selection
		Get-ADUser -Filter {SamAccountName -like $USR} -Properties * | Select SamAccountName,Name,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,PasswordNeverExpires,AccountExpirationDate,DistinguishedName,CanonicalName
		}
	ELSEIF (($USR|measure).Count -LT 1)
		{Write-Host "There aren't any users by that name, please try again";Start-Sleep -S 2}
	ELSE {Get-ADUser -Filter {SamAccountName -like $USR.SamAccountName} -Properties * | Select SamAccountName,Name,EmployeeID,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,PasswordNeverExpires,AccountExpirationDate,DistinguishedName,CanonicalName}
}