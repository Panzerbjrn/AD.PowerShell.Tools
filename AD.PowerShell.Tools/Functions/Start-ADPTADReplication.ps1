Function Start-ADPTADReplication
{
<#
	.SYNOPSIS
		This will start AD Replication

	.DESCRIPTION
		This will start AD Replication

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjrn
		Creation Date:		2017.02.01
		Purpose/Change: 	Initial script development

	.EXAMPLE
		Start-ADPTADReplication
#>
	Get-ADDomainController -Filter * | Select Name | ForEach {Repadmin /syncall $_.Name /APed}
}