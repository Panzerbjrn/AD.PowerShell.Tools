Function Reset-ADPTADUserPasswordTopassw0rd
{
<#
	.SYNOPSIS
		This will reset a user's password to Passw0rd and unlock the account.

	.DESCRIPTION
		This will reset a user's password to Passw0rd and unlock the account.

	.PARAMETER User
		This should be the name or username of the user. Supports asterisk (*) as a wildcard character.

	.NOTES
		Author:				Lars Panzerbjørn
		Contact:			GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.05.01

	.EXAMPLE
		Reset-ADPTADUserPasswordTopassw0rd -User LPanzerbjørn

	.EXAMPLE
		Reset-ADPTADUserPasswordTopassw0rd -User Panzer*

		This will provide a list of users whose name or surname starts with "Panzer".

	.EXAMPLE
		Reset-ADPTADUserPasswordTopassw0rd -User *Peter

		This will provide a list of users whose name or surname ends with "Peter".

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$User
	)
		$USR = Get-ADPTADUser $User
		Set-ADAccountPassword -Identity $USR.SamAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Passw0rd" -Force) -PassThru | Set-ADuser -ChangePasswordAtLogon $True
		Unlock-ADAccount -Identity $USR.SamAccountName
}