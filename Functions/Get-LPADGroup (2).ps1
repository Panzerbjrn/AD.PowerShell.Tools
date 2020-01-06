Function Get-LPADGroup
{
[CmdletBinding()]
Param([Parameter(Mandatory=$True,ValueFrompipeline=$True)][string]$Group)
	IF (Get-ADGroup -Filter {NAME -like $Group})
	{
		$GRP = Get-ADGroup -Filter {NAME -like $Group} -Properties *
	}
	ELSE
	{
		$GRP = Get-ADGroup -Filter {SamAccountName -like $Group} -Properties *
	}

	IF (($GRP|Measure-Object).Count -GT 1)
		{
		$Menu = @{}
		for ($i=1;$i -le $GRP.count; $i++) {
		Write-Host "$i. $($GRP[$i-1].name), $($GRP[$i-1].SamAccountName)"
		$Menu.Add($i,($GRP[$i-1].SamAccountName))
		}
		[int]$ans = Read-Host 'Enter Selection'
		$Selection = $Menu.Item($ans)
		$GRP = $Selection
		Get-ADGroup -Filter {SamAccountName -like $GRP} -Properties * | Select-Object SamAccountName,Name,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,AccountExpirationDate,DistinguishedName,CanonicalName,GroupScope,GroupCategory
		}
	ELSEIF (($GRP|Measure-Object).Count -LT 1)
		{Write-Host "There aren't any groups by that name, please try again";Start-Sleep -S 2}
	ELSE {Get-ADGroup -Filter {SamAccountName -like $GRP.SamAccountName} -Properties * | Select-Object SamAccountName,Name,EmployeeID,Department,Description,Title,Manager,Office,PhysicalDeliveryOfficeName,Enabled,LockedOut,AccountExpirationDate,DistinguishedName,CanonicalName,GroupScope,GroupCategory}
}