Function Remove-MemberFromADGroup
{
#region help
<#
.SYNOPSIS

	This script will get either the members or a group, or the groups a user is member of, and then remove either the selected member or the selected group.

.DESCRIPTION
	This script will get either the members or a group, or the groups a user is member of, and then remove either the selected member or the selected group.

.PARAMETER Group
	This should be the group's SamID or Name.

.PARAMETER User
	This should be the user's SamID or Name.

.INPUTS
	None

.OUTPUTS
	Console

.NOTES
	Version:		0.1
	Author:			Lars Petersson
	Contact:		lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: LPetersson
	Creation Date:	2018.11.14
	Purpose/Change: Created script
	Other: 			Exists in the module for ADTools

.EXAMPLE


.LINK
	https://github.com/Panzerbjrn/PowerShell.Modules
#>
#endregion help
[CmdletBinding()]
Param
	(
	#Use Group if looking to remove a member from a group
	[Parameter(Mandatory=$False,ValueFrompipeline=$True)]
	[Parameter(ParameterSetName='Group')]
	[String]$Group,

	#Use User if you want to remove a user's group
	[Parameter(Mandatory=$False,ValueFrompipeline=$True)]
	[Parameter(ParameterSetName='User')]
	[String]$User
	)


}