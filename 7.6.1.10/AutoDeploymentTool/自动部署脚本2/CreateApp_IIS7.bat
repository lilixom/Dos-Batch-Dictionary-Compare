@echo off
rem define the params
rem appName:string, "Default Web Site" as default
rem path:vdir path, for example, "pb"
rem physicalPath: physical path


set appName=%1
set path=%2
set physicalPath=%3

rem go to the path of appcmd.exe
set appcmdPath=%windir%\system32\inetsrv\


rem whether exist the app
rem remove the quotes from the string 
set /a exist=0
set tmpApp=%appName:"=%

set appNamesFile=appNames.txt
%appcmdPath%appcmd list app /text:app.name > %appNamesFile%
for /f "tokens=*" %%i in (%appNamesFile%)  do (
	if "%%i"=="%tmpApp%/%path%" (
		set /a exist=1
	) 
)

rem delete the tmp file
del %appNamesFile%

echo -------------------------------------------
rem if it exist the application, delete the dir
if %exist%==1 (
	echo Deleting the application:%appName%/%path% ...
	%appcmdPath%appcmd delete app /app.name:%appName%/%path%
)


echo Creating the application: %path% ...
%appcmdPath%appcmd add app /site.name:%appname% /path:/%path% /physicalpath:%physicalPath%


echo Creating the application %appname%/%path% finish...
echo -------------------------------------------