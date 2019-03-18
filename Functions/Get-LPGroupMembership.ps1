Function Get-LPGroupMembership
{

<#
	.SYNOPSIS
		This script will get the members, and recursive members 1 level down for an AD group.

	.DESCRIPTION
		This script will get the members, and recursive members 1 level down for an AD group.

	.PARAMETER Group
		This should be the group's SamID.

	.PARAMETER Path
		This should be the full path to the csv file you would like to output to.

	.INPUTS
		None

	.OUTPUTS
		This command exports to CSV, to the location specified in $Path

	.NOTES
		Version:		1.0
		Author:			Lars Panzerbjørn
		Contact:		lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: LPetersson
		Creation Date:	2018.05.30
		Purpose/Change: Report on Group memberships
		
	.EXAMPLE
		Get-GroupMembership -Group "LondonExchAdmins" -Path \\Files\Share01\Powershell\LonExch.csv

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True,ValueFrompipeline=$True)][string]$Group,
		[Parameter(Mandatory=$True)][string]$Path
	)
	Write-Verbose "Checking $Group"
	$ADGroup = Get-ADGRoup -Filter {NAME -like $Group} -Properties *
	$ADGroupMembers = Get-ADGRoupMember -Identity $Group
	$ADGroupName = $ADGroup.Name
	$ADGroupCanonicalName = $ADGroup.CanonicalName
	$ADGroupSamAccountName = $ADGroup.SamAccountName
	ForEach ($Member in $ADGroupMembers){
		IF ($Member.ObjectClass -eq "Group"){
			$CatchMembers = Get-ADGroupMember $Member -ErrorAction Stop
			ForEach ($Member in $CatchMembers){
				IF ($Member.ObjectClass -eq "Group"){Write-Error "Too Many Nests"}
				ELSE {
					$ADUser = Get-ADUser $Member -Properties * -ErrorAction SilentlyContinue
					$ADUserDisplayName = $ADUser.DisplayName
					$ADUserCN = $ADUser.CN
					$ADUserSamAccountName = $ADUser.SamAccountName
					$ADUserCanonicalName = $ADUser.CanonicalName
					$ADUserTitle = $ADUser.Title
					$ADUserDepartment = $ADUser.Department
					$ADUserOffice = $ADUser.Office
					$ADUserEnabled = $ADUser.Enabled
					
					$Hash = @(
					[pscustomobject]@{
						GroupName = $Group
						GroupCN = $ADGroupCanonicalName
						GroupSamID = $ADGroupSamAccountName
						UserDisplayName = $ADUserDisplayName
						UserSamID = $ADUserSamAccountName
						CanonicalName = $ADUserCanonicalName
						JobTitle = $ADUserTitle
						Department = $ADUserDepartment
						Office = $ADUserOffice
						Enabled = $ADUserEnabled
					})
				}
			$Hash | Export-CSV -Path $Path -Append -NoTypeInformation
			}
		}
		ELSEIF ($Member.ObjectClass -eq "User"){
			$ADUser = Get-ADUser $Member -Properties * -ErrorAction SilentlyContinue
			$ADUserDisplayName = $ADUser.DisplayName
			$ADUserCN = $ADUser.CN
			$ADUserSamAccountName = $ADUser.SamAccountName
			$ADUserCanonicalName = $ADUser.CanonicalName
			$ADUserTitle = $ADUser.Title
			$ADUserDepartment = $ADUser.Department
			$ADUserOffice = $ADUser.Office
			$ADUserEnabled = $ADUser.Enabled
			
			$Hash = @(
			[pscustomobject]@{
				GroupName = $Group
				GroupCN = $ADGroupCanonicalName
				GroupSamID = $ADGroupSamAccountName
				UserDisplayName = $ADUserDisplayName
				UserSamID = $ADUserSamAccountName
				CanonicalName = $ADUserCanonicalName
				JobTitle = $ADUserTitle
				Department = $ADUserDepartment
				Office = $ADUserOffice
				Enabled = $ADUserEnabled
			})
		$Hash | Export-CSV -Path $Path -Append -NoTypeInformation
		}
		ELSE	{Write-Verbose "DISAPPPOINTED"}
	}
}
