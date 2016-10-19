@echo off
rem define the params
rem apppoolName: string
rem runtimeVersion: v2.0 | v4.0
rem autoStart: true | false
rem managedPipelineMode: Classic|Integrated, Integrated as the default


set apppoolName=%1
set runtimeVersion=%2
set managedPipelineMode=%3
set autoStart=%4


rem go to the path of appcmd.exe 
set appcmdPath=%windir%\system32\inetsrv\


rem whether exist the app pool 
rem remove the quotes from the string 
set /a exist=0
set tmpPoolName=%apppoolName:"=%
set appPoolNamesFile=appPoolNames.txt
%appcmdPath%appcmd list apppool /text:apppool.name > %appPoolNamesFile%
for /f "tokens=*" %%i in (%appPoolNamesFile%)  do (
	if "%%i"=="%tmpPoolName%" (
		set /a exist=1
	) 
)
rem delete the tmp file
del %appPoolNamesFile%


echo -------------------------------------------
rem if it exists the app pool, delete the app pool
if %exist%==1 (
	echo Deleting the app pool:%apppoolName% ...
	%appcmdPath%appcmd delete apppool /apppool.name:%apppoolName%
)


echo Creating the app pool:%apppoolName% ...
%appcmdPath%appcmd add apppool /name:%apppoolName%


if "%managedPipelineMode%" neq "" (
	echo setting managed Pipeline Mode:%managedPipelineMode%
	%appcmdPath%appcmd set apppool /apppool.name:%apppoolName% /managedPipelineMode:%managedPipelineMode%
)


if "%autoStart%" neq "" (
	echo setting autoStart:%autoStart% ...
	%appcmdPath%appcmd set apppool /apppool.name:%apppoolName% /autoStart:%autoStart%
)


if "%runtimeVersion%" neq "" (
	echo setting managedRuntimeVersion:%runtimeVersion% ...
	%appcmdPath%appcmd set apppool /apppool.name:%apppoolName% /managedRuntimeVersion:%runtimeVersion%
)


echo Creating the app pool %apppoolName% finish...
echo -------------------------------------------