Function Reset-LPADUserPasswordTopassw0rd
{
<#
	.SYNOPSIS
		This will reset a user's password to Passw0rd and unlock the account.

	.DESCRIPTION
		This will reset a user's password to Passw0rd and unlock the account.

	.PARAMETER User
		This should be the name or username of the user. Supports asterisk (*) as a wildcard character.

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjørn
		Contact:			lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.05.01
		Purpose/Change: 	Initial script development
		Change 2019.03.14:	Pre-fixed Function
		
	.EXAMPLE
		Reset-LPADUserPasswordTopassw0rd -User LPanzerbjørn
		
	.EXAMPLE
		Reset-LPADUserPasswordTopassw0rd -User Panzer*
		
		This will provide a list of users whose name or surname starts with "Peter".
		
	.EXAMPLE
		Reset-LPADUserPasswordTopassw0rd -User *Peter
		
		This will provide a list of users whose name or surname ends with "Peter".

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$User
	)
		$USR = Get-LPADUser $User
		Set-ADAccountPassword -Identity $USR.SamAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Passw0rd" -Force) -PassThru | Set-ADuser -ChangePasswordAtLogon $True
		Unlock-ADAccount -Identity $USR.SamAccountName
}