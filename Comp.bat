REM  格式： Comp.bat SourcePath DestinationPath  UpdatePath
REM  例子 ：Comp.bat "c:\test\" "c:\testcopy\"  "c:\update\"
REM "目录路径必须以\结尾"
@echo off
SET src_path=%~1
	IF "%src_path:~-1%"=="\" (
		SET src_path=%src_path:~0,-1%
	)
IF NOT EXIST "%src_path%" (
	ECHO. 源目录不存在
	PAUSE
	GOTO :EOF
)
echo. "%~dp0%src_path%"
IF EXIST  "%~dp0%src_path%" (
	SET src_path=%~dp0%src_path%
)
SET des_path=%~2

IF "%des_path:~-1%"=="\" (
	SET des_path=%des_path:~0,-1%
)

IF NOT EXIST "%des_path%" (
	ECHO. 目标目录不存在
	PAUSE
	GOTO :EOF
)

IF EXIST  "%~dp0%des_path%" (
	SET  "des_path=%~dp0%des_path%"
)
IF "%~3"=="" (
	SET %~3=
)
CALL :fullPath %~3 udt_path

SET upd_del_file=%udt_path%\del.txt

CALL :strlen %src_path% len
SET /A pos=len+3

setlocal EnableDelayedExpansion
FOR %%K IN (%src_path%\*) DO (
	SET src_file=%%K
	SET file=!src_file:~%pos%!
	SET des_file=%des_path%\!file!
	SET udt_file=%udt_path%\!file!
	
	IF NOT EXIST "!des_file!" (
		FOR %%5 IN (!udt_file!) DO (
			SET upd_dir=%%~dp5
			xcopy /F !src_file! !upd_dir!
		)
	)

	IF EXIST "!des_file!" (
		CALL :isSame !src_file! !des_file! res
		if "!res!" neq "1" (
			for %%5 in (!udt_file!) do (
						set upd_dir=%%~dp5
						xcopy /F !src_file! !upd_dir!
					)
		)
	)
)

FOR /R "%src_path%" /D %%I IN (*) DO (
  SET temp=%%I
  echo. !temp!
  FOR %%J IN (%%I\*) DO (
    SET src_file=%%J
	SET file=!src_file:~%pos%!
	SET des_file=%des_path%\!file!
	SET udt_file=%udt_path%\!file!
	IF NOT EXIST "!des_file!" (
		for %%5 in (!udt_file!) do (
			set upd_dir=%%~dp5
			xcopy /F !src_file! !upd_dir!
		)
	)
	IF EXIST "!des_file!" (
		CALL :isSame !src_file! !des_file! res
		if "!res!" neq "1" (
			for %%5 in (!udt_file!) do (
						set upd_dir=%%~dp5
						xcopy /F !src_file! !upd_dir!
					)
		)
	)

  )
)

CALL :strlen %des_path% len
SET /A pos=len+3

::create delete file
FOR %%g IN (%des_path%\*) DO (
	SET des_file=%%g
	SET file=!des_file:~%pos%!
	SET src_file=%src_path%\!file!
	IF NOT EXIST "!src_file!" (
		ECHO. !src_file!>>%upd_del_file%
	)
)
FOR /R "%des_path%" /D %%l IN (*) DO (
  FOR %%m IN (%%l\*) DO (
    SET des_file=%%m
    SET file=!des_file:~%pos%!
	SET src_file=%src_path%\!file!
	IF NOT EXIST "!src_file!" (
		ECHO. !src_file!>>%upd_del_file%
	)
  )
)
endlocal

EXIT /B %ERRORLEVEL%

:strlen <stringVarName> [retvar] 
setlocal enabledelayedexpansion
set "$=!%1!#"
set N=&for %%a in (4096 2048 1024 512 256 128 64 32 16)do if !$:~%%a!. NEQ . set/aN+=%%a&set $=!$:~%%a!
set $=!$!fedcba9876543210&set/aN+=0x!$:~16,1!
endlocal&If %2. neq . (set/a%2=%N%)else echo %N%
EXIT /B 0

:fullPath [%1 - path ; %2 - fullPath ]
setlocal EnableDelayedExpansion
SET "udt_path=%~1"
IF "%udt_path:~-1%"=="\" (
	SET udt_path=%udt_path:~0,-1%
)
FOR %%5 IN (%udt_path%\) DO (
	SET dir=%%~dp5
	set udt_path=!dir:~0,-1!
)
endlocal & if "%~2" neq "" (set %~2=%udt_path%) else echo %udt_path%

EXIT /B 0

:isSame [%1 - src_file ; %2 - des_file ； %3 - retvar ]
setlocal EnableDelayedExpansion
SET CNT=0
FOR /F "tokens=*" %%a IN ('FC /b %~1 %~2 ^|FINDSTR /RC:"FC: 找不到差异" ') DO (
	SET CNT=1
)
endlocal & if "%~3" neq "" (set %~3=%CNT%) else echo %CNT%

EXIT /B 0