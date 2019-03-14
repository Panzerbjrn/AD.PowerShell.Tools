#region Script Header
#	Thought for the day: The more renowned woman often has fewer rings. - Viking saying
#	NAME: ADToolsModule.psm1
#	AUTHOR: Lars Panzerbjørn
#	CONTACT: lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: lpetersson
#	DATE: 2019.03.13
#	VERSION: 0.1 - 2019.03.13 - Module Created with Create-NewModuleStructure by Lars Panzerbjørn
#
#	SYNOPSIS:
#	#	Basic but useful tools for Server, Desktop and Helldesk teams.
#
#	DESCRIPTION:
#	Basic but useful tools for Server, Desktop and Helldesk teams.
#	Intended to be run from a console, hence the regular use of write host.
#
#	REQUIREMENTS:
#
#endregion Script Header

#Requires -Version 4.0

[CmdletBinding(PositionalBinding=False)]
param()

Write-Verbose $PSScriptRoot

#Get Functions and Helpers function definition files.
$Functions	= @( Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue )
$Helpers = @( Get-ChildItem -Path $PSScriptRoot\Helpers\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
ForEach ($Import in @($Functions + $Helpers))
{
	Try
	{
		. $Import.Fullname
	}
	Catch
	{
		Write-Error -Message "Failed to Import function $($Import.Fullname): $_"
	}
}

Export-ModuleMember -Function $Functions.Basename

