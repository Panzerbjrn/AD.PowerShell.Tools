Function Add-LPAddADGroupMember
{
	<#
	.SYNOPSIS
	  This script aids in adding a user to a group

	.DESCRIPTION
	  This script aids in adding a user to a group

	.PARAMETER Group
		This should be the name or SamAccountName of a group

	.PARAMETER User
		This should be the name or SamAccountName of a user

	.INPUTS
	  None

	.OUTPUTS
	  None

	.NOTES
	  Version:			1.0
	  Author:			Lars Petersson
	  Creation Date:	2018.11.01
	  Purpose/Change:	Initial script development

	.EXAMPLE
	  Add-BDADGroupMember -Group "Local Server Administrators - PRD-AP5841*" -User Petersson*

	.EXAMPLE
	  Add-BDADGroupMember -Group "Local Server Administrators - PRD-AP5841*" -User *Petersson*
	#>
	Param
	(
		[Parameter(Mandatory=$True)][string]$Group,
		[Parameter(Mandatory=$True)][string]$User
	)
	$USR = Get-BDADUser -User $User
	$GRP = Get-BDADGroup -Group $Group
	Add-ADGroupMember -Identity $GRP.DistinguishedName -Members $USR.SamAccountName -Verbose
}