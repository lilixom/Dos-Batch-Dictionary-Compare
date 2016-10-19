@echo off
rem define the params
rem appPool:string
rem appPath:app path, for example, "Default Web site/pb"


set appPool=%1
set appPath=%2
rem go to the path of appcmd.exe 
set appcmdPath=%windir%\system32\inetsrv\


rem whether exist the application and application pool
set appExist=0
set appPoolExist=0


set tmpApp=%appPath:"=%
set appNamesFile=appNames.txt
%appcmdPath%appcmd list app /text:app.name > %appNamesFile%
for /f "tokens=*" %%i in (%appNamesFile%)  do (
	if "%%i"=="%tmpApp%" (
		set /a appExist=1
	) 
)
del %appNamesFile%


set tmpPool=%appPool:"=%
set appPoolNamesFile=appPoolNames.txt
%appcmdPath%appcmd list apppool /text:apppool.name > %appPoolNamesFile%
for /f "tokens=*" %%i in (%appPoolNamesFile%)  do (
	if "%%i"=="%tmpPoolName%" (
		set /a appPoolExist=1
	) 
)
del %appPoolNamesFile%


if %appPoolExist%==0 ( echo app pool - %appPool% does not exist )
if %appExist%==0 ( echo app - %appPath% does not exist )
if %appPoolExist%==1 (
	if %appExist%==1 (
		echo -------------------------------------------
		echo Assigning the app pool:%appPool% to %appPath% ...
		%appcmdPath%appcmd set app /app.name:%appPath% /applicationpool:%appPool%
	)
) 




echo Assigning the  app pool:%appPool% to %appPath% finish...
echo -------------------------------------------