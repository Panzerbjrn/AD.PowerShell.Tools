Function Remove-LPADGroupMember
{

<#
	.SYNOPSIS
		Removes a member from a selected group.

	.DESCRIPTION
		Removes a member from a selected group.

	.PARAMETER GroupName
		This should be the name of the Group that has a member to remove.

	.INPUTS
		None

	.OUTPUTS
		None

	.NOTES
		Version:			1.1
		Author:				Lars Panzerbjørn
		Contact:			lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: LPetersson
		Creation Date:		2019.02.01
		Purpose/Change: 	Initial script development
		Update: 2019.02.03:	Updated function to include a help section and examples.
		
	.EXAMPLE
		Remove-LPADGroupMember -GroupName "Stale - Local Server Administrators - DU-SCCM-DP02"	

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>

	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$GroupName
	)
	$Group = Get-LPADGroup -Group $GroupName
	
	$Members = Get-ADGroupMember -Identity $Group.SamAccountName | Sort
	$menu = @{}
	for ($i=1;$i -le $Members.count; $i++) {
		Write-Host "$i. $($Members[$i-1].name)"
		$menu.Add($i,($Members[$i-1].name))
		}
	[int]$ans = Read-Host 'Enter selection'
	$Selection = $menu.Item($ans)
	$Member = $Null
	$Member += Get-ADUser -Filter {NAME -like $Selection}
	$Member += Get-ADGroup -Filter {NAME -like $Selection}
	$Member.SamAccountName
	Remove-ADGroupMember -Identity $Group.SamAccountName -Members ($Member).SamAccountName -Confirm:$False -Verbose
}