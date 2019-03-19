Function Start-LPADReplication
{
<#
	.SYNOPSIS
		This will start AD Replication

	.DESCRIPTION
		This will start AD Replication

	.INPUTS
		None

	.OUTPUTS
		None

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjørn
		Contact:			lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2017.02.01
		Purpose/Change: 	Initial script development
		
	.EXAMPLE
		Start-BDADReplication

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	Get-ADDomainController -Filter * | Select Name | ForEach {Repadmin /syncall $_.Name /APed}
}