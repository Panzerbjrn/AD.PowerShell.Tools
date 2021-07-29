Function Remove-ADPTADGroupMember
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
		Author:				Lars Panzerbj�rn
		Contact:			GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2019.02.01
		
	.EXAMPLE
		Remove-ADPTADGroupMember -GroupName "Domain Admin"
		
		1. mPanzer_adm
		2. LPanzer_adm
		Enter selection: 2

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$GroupName
	)
	$Group = Get-ADPTADGroup -Group $GroupName
	
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