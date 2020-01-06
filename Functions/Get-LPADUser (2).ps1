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
	  this outputs basic information from AD

	.NOTES
	  Version:			1.0
	  Author:			Lars Petersson
	  Creation Date:	2018.11.01
	  Purpose/Change:	Initial script development

	.EXAMPLE
		Get-BDADUser -User Petersson*

	.EXAMPLE
	  Get-BDADUser -User *Petersson*
	#>
	[CmdletBinding()]
	Param([Parameter(Mandatory=$True,ValueFrompipeline=$True)][string]$User)
	IF (Get-Aduser -Filter {NAME -like $User})
	{
		$USR = Get-Aduser -Filter {NAME -like $User} -Properties *
	}
	ELSE
	{
		$USR = Get-Aduser -Filter {SamAccountName -like $User} -Properties *
	}

	IF (($USR|Measure-Object).Count -GT 1)
		{
		$Menu = @{}
		for ($i=1;$i -le $USR.count; $i++) {
		Write-Host "$i. $($USR[$i-1].name), $($USR[$i-1].SamAccountName)"
		$Menu.Add($i,($USR[$i-1].SamAccountName))
		}
		[int]$ans = Read-Host 'Enter Selection'
		$Selection = $Menu.Item($ans)
		$USR = $Selection
		Get-Aduser -Filter {SamAccountName -like $USR} -Properties * | Select-Object SamAccountName,Name,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,PasswordNeverExpires,AccountExpirationDate,DistinguishedName,CanonicalName
		}
	ELSEIF (($USR|Measure-Object).Count -LT 1)
		{Write-Host "There aren't any users by that name, please try again";Start-Sleep -S 2}
	ELSE {Get-Aduser -Filter {SamAccountName -like $USR.SamAccountName} -Properties * | Select-Object SamAccountName,Name,EmployeeID,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,PasswordNeverExpires,AccountExpirationDate,DistinguishedName,CanonicalName}
}