Function Create-FolderAccessGroups
{
#region help
<#
.SYNOPSIS

	This script will create AD Security Groups based on folders in a target directory.

.DESCRIPTION
	This script will create AD Security Groups based on folders in a target directory.

.PARAMETER Path
	This should be the full path to Folder you want to base the groups on.

.PARAMETER Parent
	Include this if you want the parent folder to also be in the name.

.OUTPUTS
	Only to console.

.NOTES
	Version:		0.1
	Author:			Lars Petersson
	Contact:		lars@panzerbjrn.eu / GitHub: Panzerbjrn / Twitter: LPetersson
	Creation Date:	2018.11.14
	Purpose/Change: Created
	Other: 			Exists in the module for ADTools

.EXAMPLE


.LINK
	https://github.com/Panzerbjrn/PowerShell.Modules
#>
#endregion help
Param
	(
		[Parameter(Mandatory=$True,ValueFrompipeline=$True)][string]$Path
		[Parameter(Mandatory=$False)][string]$Parent
	)

	$Dirs = Get-ChildItem $Path -Directory
	#$Server = $Path.Replace('\\','').Split('$')[0].Replace('\','_')
	$Server = $Path.Replace('\\','').Replace('$\','_').Replace('\','_')

	ForEach ($Dir in $Dirs)
	{
		$ADGroupROParamSplat @ {
			$DisplayName	=	"FS_$Server_$($Dir.Name.Replace(' ',''))_RO"
			$Name			=	"FS_$Server_$($Dir.Name.Replace(' ',''))_RO"
			$Description	=	$($Dir.Fullname)
			$GroupCategory	=	"Security"
			$GroupScope		=	"DomainLocal"
			$WhatIf			=	"-Whatif"

		}
		$ADGroupRWParamSplat @ {
			$DisplayName	=	"FS_$Server_$($Dir.Name.Replace(' ',''))_RW"
			$Name			=	"FS_$Server_$($Dir.Name.Replace(' ',''))_RW"
			$Description	=	$($Dir.Fullname)
			$GroupCategory	=	"Security"
			$GroupScope		=	"DomainLocal"
			$WhatIf			=	"-Whatif"

		}
		$ADGroupModParamSplat @ {
			$DisplayName	=	"FS_$Server_$($Dir.Name.Replace(' ',''))_Mod"
			$Name			=	"FS_$Server_$($Dir.Name.Replace(' ',''))_Mod"
			$Description	=	$($Dir.Fullname)
			$GroupCategory	=	"Security"
			$GroupScope		=	"DomainLocal"
			$WhatIf			=	"-Whatif"

		}

		New-ADGroup @ADGroupROParamSplat
		New-ADGroup @ADGroupRWParamSplat
		New-ADGroup @ADGroupModParamSplat
	}
	#(Get-ChildItem $Path -Directory).Name | New-ADGroup -DisplayName "FS_PRD-SCOM_$_" -WhatIf
	#(Get-ChildItem '\\PRD-SCOM\Z$\Scripts\' -Directory).FullName | ForEach-Object { Get-BDDirectoryACLs "$_"| Where-Object {$_.Filesystemrights -like "*modify*"} }
}