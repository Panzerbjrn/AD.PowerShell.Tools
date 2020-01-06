Function Get-LPADComputer
{
[CmdletBinding()]
Param(
	[parameter(Mandatory=$true,ValueFrompipeline=$True)][Alias("Host","CN","MachineName","ComputerName")][String]$Computer
	)
	IF (Get-ADComputer -Filter {Name -like $Computer})
	{
		$ADComp = Get-ADComputer -Filter {Name -like $Computer} -Properties *
	}
	ELSE
	{
		Write-Host "Nothing Found"
	}

	IF (($ADComp|Measure-Object).Count -GT 1)
		{
		$Menu = @{}
		for ($i=1;$i -le $ADComp.count; $i++) {
		Write-Host "$i. $($ADComp[$i-1].Name), $($ADComp[$i-1].DNSHostName)"
		$Menu.Add($i,($ADComp[$i-1].Name))
		}
		[int]$ans = Read-Host 'Enter Selection'
		$Selection = $Menu.Item($ans)
		$ADComp = $Selection
		Get-ADComputer -Filter {Name -like $ADComp} -Properties * | Select-Object Name,DNSHostName,DistinguishedName,CanonicalName,Description,Enabled,IPv4Address,LockedOut,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,whenCreated
		}
	ELSEIF (($ADComp|Measure-Object).Count -LT 1)
		{Write-Host "There aren't any computers by that name, please try again";Start-Sleep -S 1}
	ELSE {Get-ADComputer -Filter {Name -like $ADComp.Name} -Properties * | Select-Object Name,DNSHostName,DistinguishedName,CanonicalName,Description,Enabled,IPv4Address,LockedOut,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,whenCreated}
}