Function Add-ADPTAddADGroupMember
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
		Author:				Lars Panzerbjørn
		Contact:			GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.11.01
		
	.EXAMPLE
		Add-ADPTAddADGroupMember -Group "Local Administrators*" -User Panzerb*
	
	.EXAMPLE
		Add-ADPTAddADGroupMember -Group "Local Administrators*" -User LPanzerb*

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$Group,
		[Parameter(Mandatory=$True)][string]$User
	)
	$USR = Get-ADPTADUser -User $User
	$GRP = Get-ADPTADGroup -Group $Group
	Add-ADGroupMember -Identity $GRP.DistinguishedName -Members $USR.SamAccountName -Verbose
}