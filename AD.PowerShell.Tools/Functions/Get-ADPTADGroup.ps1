Function Get-ADPTADGroup
{
<#
	.SYNOPSIS
		This script aids in finding a Group and displays basic information

	.DESCRIPTION
		This script aids in finding a Group and displays basic information

	.PARAMETER Group
		This should be the display name or SamAccountName of a Group

	.INPUTS
		None

	.OUTPUTS
		This outputs basic information from AD

	.NOTES
		Author:				Lars Panzerbjørn
		Contact:			GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.11.01
		Purpose/Change:		Initial script development
		Change 2019.03.14:	Pre-fixed Function

	.EXAMPLE
		Get-ADPTADGroup -Group *Mongo*

	.EXAMPLE
		Get-ADPTADGroup -Group *Mongo*
		1. DEL-MongoDBAdmin, DEL-MongoDBAdmin
		2. IT Alerts MongoDB, IT Alerts MongoDB
		3. MONGO-DBAAdmins, MONGO-DBAAdmins
		4. MONGO-Infrastructure, MONGO-Infrastructure
		5. MONGO-ReadOnly, MONGO-ReadOnly
		6. MONGO-OPS-Admins, MONGO-OPS-Admins
		7. MONGO-OPS-ReadOnly, MONGO-OPS-ReadOnly
		Enter Selection: 7


		SamAccountName             : MONGO-OPS-ReadOnly
		Name                       : MONGO-OPS-ReadOnly
		Department                 :
		Description                :
		Title                      :
		Manager                    :
		Office                     : {}
		PhysicalDeliveryOfficeName :
		Enabled                    :
		LockedOut                  : {}
		AccountExpirationDate      : {}
		DistinguishedName          : CN=MONGO-OPS-ReadOnly,OU=All Applications,OU=DEV,OU=Applications,DC=CentralIndustrial,DC=intra
		CanonicalName              : CentralIndustrial.intra/Applications/DEV/All Applications/MONGO-OPS-ReadOnly
		GroupScope                 : Global
		GroupCategory              : Security


	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$True,ValueFrompipeline=$True)][string]$Group
	)
	IF (Get-ADGroup -Filter {NAME -like $Group})
	{
		$GRP = Get-ADGroup -Filter {NAME -like $Group} -Properties *
	}
	ELSE
	{
		$GRP = Get-ADGroup -Filter {SamAccountName -like $Group} -Properties *
	}

	IF (($GRP|measure).Count -GT 1)
		{
		$Menu = @{}
		for ($i=1;$i -le $GRP.count; $i++) {
		Write-Host "$i. $($GRP[$i-1].name), $($GRP[$i-1].SamAccountName)"
		$Menu.Add($i,($GRP[$i-1].SamAccountName))
		}
		[int]$ans = Read-Host 'Enter Selection'
		$Selection = $Menu.Item($ans)
		$GRP = $Selection
		Get-ADGroup -Filter {SamAccountName -like $GRP} -Properties * | Select SamAccountName,Name,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,AccountExpirationDate,DistinguishedName,CanonicalName,GroupScope,GroupCategory
		}
	ELSEIF (($GRP|measure).Count -LT 1)
		{Write-Host "There aren't any groups by that name, please try again";Start-Sleep -S 2}
	ELSE {Get-ADGroup -Filter {SamAccountName -like $GRP.SamAccountName} -Properties * | Select SamAccountName,Name,EmployeeID,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,AccountExpirationDate,DistinguishedName,CanonicalName,GroupScope,GroupCategory}
}