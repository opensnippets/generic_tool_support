@echo off
rem ---------------------------------------------------------------------------------
rem This batch sets virtualbox permission to enable the softlink of the windows share
rem written by: [i]carreno
rem ---------------------------------------------------------------------------------
set batchname=%~nx0
set vboxpath=%1
set vmname=%2
set sharename=%3
shift
shift
shift
shift
echo Virtual Box Path = %vboxpath%
echo Virtual Guest Name = %vmname%
echo Virtual Share = %sharename%
IF [%vboxpath%] == [] GOTO NoVboxPath
IF [%vmname%] == [] GOTO NoVMName
IF [%sharename%] == [] GOTO NoSharename

rem echo %vboxpath%\xyz.exe %sharename% %*
if exist %vboxpath:~0,-1%\VBoxManage.exe" (
	rem echo %vboxpath:~0,-1%\VBoxManage.exe" is exist
	%vboxpath:~0,-1%\VBoxManage.exe" setextradata %vmname% VBoxInternal2/SharedFoldersEnableSymlinksCreate/%sharename% 1
	IF %ERRORLEVEL% NEQ 0 ( 
		echo Error Return  %ERRORLEVEL%
	) else (
		echo Success
	)
) else (
	echo "%vboxpath%\vboxmanage is not exist"
)

rem VBoxManage.exe setextradata VM_NAME VBoxInternal2/SharedFoldersEnableSymlinksCreate/SHARE_NAME 1
GOTO END
:: Subroutine for no vboxfilepath
:NoVboxPath
echo "No Path for Virtualbox Execution provided"
GOTO USAGE_SYNTAX

:: Subroutine for no sharename
:NoSharename
echo "No Share Name provided"
GOTO USAGE_SYNTAX

:: Subroutine for no vmname
:NoVMName
echo "No VMname provided"

:USAGE_SYNTAX
echo "%batchname% <Path_to_Oracle_VM_executables> <VMNAME> <Share_without_sf_>"
echo ""
echo example: share folder is sf_shared
echo Path_to_Oracle_VM_executables = C:\Program Files\Oracle
echo VMNAME = Ubuntu18_x64_Guest
echo Share_without_sf_ = shared
echo ""
echo %batchname% "C:\Program Files\Oracle" Ubuntu18_x64_Guest shared


:END
