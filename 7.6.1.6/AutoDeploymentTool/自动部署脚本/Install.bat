@echo off
setlocal

set websitename=%1
set appPoolName=%1
set rootDir=%2
set sitePort=%3
set fullPath=%~dp0
set appPoolVer=v4.0
set managedPipelineMode=Integrated
set autoStart=true

REM cd /d %rootDir%

cd /d "%~dp0"

echo Creating app pool...
call %fullPath%CreateAppPool_IIS7.bat %appPoolName% %appPoolVer% %managedPipelineMode% %autoStart%

echo Creating site...
call %fullPath%CreateWebsite.bat %websitename% %rootDir%\Web %sitePort%

for /f "tokens=1,2 delims=," %%a in (TAP.AppNames.txt) do (
	echo Creating app...
	call %fullPath%CreateApp_IIS7.bat %websitename% %%a %rootDir%\%%b  

	echo Assigning app pool...
	call %fullPath%AssignAppPool_IIS7.bat %appPoolName% %websitename%/%%a
)
endlocal