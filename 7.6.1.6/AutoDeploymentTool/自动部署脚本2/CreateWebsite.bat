@echo off
set appName=%1
set sitePath=%2
set sitePort=%3
set /a exist=0

rem go to the path of appcmd.exe
set appcmdPath=%windir%\system32\inetsrv\

set siteNamesFile=siteNames.txt
%appcmdPath%appcmd list site /text:site.name > %siteNamesFile%
for /f "tokens=*" %%i in (%siteNamesFile%)  do (
	echo  %%i  %appName%
	if "%%i"==%appName% (
		set /a exist=1
	) 
)

echo delete the tmp file...

%appcmdPath%appcmd delete site %appName%
 if %exist%==1 (
    echo Deleting the site:%appName%...
	%appcmdPath%appcmd delete site %appName%
 )	

echo Creating the site: %appName% ...
%appcmdPath%appcmd add site /name:%appName% /bindings:http/*:%sitePort%: /physicalPath:%sitePath%
%appcmdPath%appcmd set site %appName% -applicationDefaults.applicationPool:%appName%

echo Starting the site 
%appcmdPath%appcmd start site %appName%
