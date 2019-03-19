Function Get-LPADComputers {
Param
	(
		[Parameter(Mandatory=$True)][int]$DaysAgo,
		[Parameter(Mandatory=$False)][string]$Department
	)
	$ReallyDaysAgo = 0 - $DaysAgo
	$Recently = [DateTime]::Today.AddDays($ReallyDaysAgo)
	Get-ADComputer -Filter 'WhenCreated -ge $Recently' -Properties whenCreated | Format-Table Name,whenCreated,distinguishedName -Autosize -Wrap
}
