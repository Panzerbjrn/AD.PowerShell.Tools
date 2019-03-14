Function Add-LPAddADGroupMember
{
#region help
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
		Version:			1.1
		Author: 			Lars Panzerbjørn
		Contact:		lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: LPetersson
		Creation Date:		2018.11.01
		Purpose/Change:		Initial script development
		Change 2019.03.14:	Pre-fixed Function
		
	.EXAMPLE
		Add-LPADGroupMember	 -Group "Local Server Administrators - PROD841*" -User Panzerb*
	
	.EXAMPLE
		Add-LPADGroupMember	 -Group "Local Server Administrators - PROD841*" -User LPanzerb*

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
#endregion help
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$Group,
		[Parameter(Mandatory=$True)][string]$User
	)
	$USR = Get-LPADUser -User $User
	$GRP = Get-LPADGroup -Group $Group
	Add-ADGroupMember -Identity $GRP.DistinguishedName -Members $USR.SamAccountName -Verbose
}