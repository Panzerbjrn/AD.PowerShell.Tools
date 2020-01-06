Function Start-LPADReplication
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
		Start-BDADReplication
#>
	Get-ADComputer -Filter {NAME -like "*"} -SearchBase "OU=Domain Controllers,DC=Gazpromuk,DC=intra" | Select-Object Name | ForEach-Object {Repadmin /syncall $_.Name /APed}
}