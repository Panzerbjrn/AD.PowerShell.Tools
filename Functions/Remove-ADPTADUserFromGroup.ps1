Function Remove-ADPTADUserFromGroup
{
<#
	.SYNOPSIS
		This will remove a user from one of the groups the user is a member of.

	.DESCRIPTION
		This will remove a user from one of the groups the user is a member of.

	.PARAMETER User
		This should be the name or username of the user. Supports asterisk (*) as a wildcard character.

	.NOTES
		Author:				Lars Panzerbjørn
		Contact:			GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.11.01
		
	.EXAMPLE
		Remove-ADPTADUserFromGroup -User LPanzerbjørn
		
		This will gve a list of the user's groups, the user will then be removed from the chosen group.

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$User
	)
	$ADUser = Get-ADPTADUser -User $User
	
	$Groups = Get-ADPrincipalGroupMembership -Identity $ADUser.SamAccountName | Sort
	$menu = @{}
	for ($i=1;$i -le $Groups.count; $i++) {
		Write-Host "$i. $($Groups[$i-1].name)"
		$menu.Add($i,($Groups[$i-1].name))
		}
	[int]$ans = Read-Host 'Enter selection'
	$Selection = $menu.Item($ans)
	Remove-ADGroupMember -Identity $Selection -Members $ADUser.SamAccountName -Confirm:$False -Verbose
}