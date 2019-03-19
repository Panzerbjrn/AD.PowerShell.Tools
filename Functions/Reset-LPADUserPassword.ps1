Function Reset-LPADUserPassword
{
<#
	.SYNOPSIS
		This will reset a user's password and unlock the account.

	.DESCRIPTION
		This will reset a user's password and unlock the account.

	.PARAMETER User
		This should be the name or username of the user. Supports asterisk (*) as a wildcard character.

	.PARAMETER Password
		This should be the new password

	.PARAMETER ChangePasswordAtLogon
		Use this switch to force the user to change password at next logon.

	.NOTES
		Version:			1.0
		Author:				Lars Panzerbjørn
		Contact:			lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: Panzerbjrn
		Creation Date:		2018.05.01
		Purpose/Change: 	Initial script development
		Change 2019.03.14:	Pre-fixed Function
		
	.EXAMPLE
		Reset-LPADUserPassword -User LPanzerbjørn -Password "P4$$vv0rd!"
		
		This will reset the user's password, and not force the user to change the password
		
	.EXAMPLE
		Reset-LPADUserPassword -User Peter* -Password "P4$$vv0rd!" -ChangePasswordAtLogon
		
		This will reset the user's password, and force the user to change the password

	.LINK
		https://github.com/Panzerbjrn/ADtoolsModule
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$True)][string]$User,
		[Parameter(Mandatory=$True)][string]$Password,
		[Parameter(Mandatory=$False)][switch]$ChangePasswordAtLogon
	)
	$USR = Get-LPADUser $User
	IF($ChangePasswordAtLogon){
	Set-ADAccountPassword -Identity $USR.SamAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -PassThru | Set-ADuser -ChangePasswordAtLogon $True
	}
	IF(!($ChangePasswordAtLogon)){
	Set-ADAccountPassword -Identity $USR.SamAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -PassThru | Set-ADuser -ChangePasswordAtLogon $False
	}
	Unlock-ADAccount -Identity $USR.SamAccountName
}