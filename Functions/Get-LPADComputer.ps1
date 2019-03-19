Function Get-LPADComputer
{
<#
	.SYNOPSIS
		This script aids in finding a Computer and displays basic information

	.DESCRIPTION
		This script aids in finding a Computer and displays basic information

	.PARAMETER Computer
		This should be the name or SamAccountName of a Computer

	.INPUTS
		None

	.OUTPUTS
		This outputs basic information from AD

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjørn
		Contact:			lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.11.01
		Purpose/Change:		Initial script development
		Change 2019.03.14:	Pre-fixed Function
		
	.EXAMPLE
		Get-LPADComputer -Computer Panzerbjørn*
	
	.EXAMPLE
		Get-LPADComputer -Computer mon0*
		1. MON01UK, MON01UK.CentralIndustrial.intra
		2. MON01LON, MON01LON.CentralIndustrial.intra
		Enter Selection: 1


		Name                       : MON01UK
		DNSHostName                : MON01UK.CentralIndustrial.intra
		DistinguishedName          : CN=MON01UK,OU=Severity 1,OU=Applications,OU=Servers,OU=Infrastructure,DC=CentralIndustrial,DC=intra
		CanonicalName              : CentralIndustrial.intra/Infrastructure/Servers/Applications/Severity 1/MON01UK
		Description                : Network Monitoring Server
		Enabled                    : True
		IPv4Address                :
		LockedOut                  : False
		OperatingSystem            : Windows Server 2012
		OperatingSystemServicePack : Service Pack 2
		OperatingSystemVersion     : 6.2 (3790)
		whenCreated                : 04/04/2014 10:31:38

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param(
		[parameter(Mandatory=$True,ValueFrompipeline=$True)][Alias("Host","CN","MachineName","ComputerName")][String]$Computer
	)
	IF (Get-ADComputer -Filter {Name -like $Computer})
	{
		$ADComp = Get-ADComputer -Filter {Name -like $Computer} -Properties *
	}
	ELSE
	{
		Write-Host "Nothing Found"
	}
	
	IF (($ADComp|measure).Count -GT 1)
		{
		$Menu = @{}
		for ($i=1;$i -le $ADComp.count; $i++) {
		Write-Host "$i. $($ADComp[$i-1].Name), $($ADComp[$i-1].DNSHostName)"
		$Menu.Add($i,($ADComp[$i-1].Name))
		}
		[int]$ans = Read-Host 'Enter Selection'
		$Selection = $Menu.Item($ans)
		$ADComp = $Selection
		Get-ADComputer -Filter {Name -like $ADComp} -Properties * | Select Name,DNSHostName,DistinguishedName,CanonicalName,Description,Enabled,IPv4Address,LockedOut,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,whenCreated
		}
	ELSEIF (($ADComp|measure).Count -LT 1)
		{Write-Host "There aren't any computers by that name, please try again";Start-Sleep -S 1}
	ELSE {Get-ADComputer -Filter {Name -like $ADComp.Name} -Properties * | Select Name,DNSHostName,DistinguishedName,CanonicalName,Description,Enabled,IPv4Address,LockedOut,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,whenCreated}
}