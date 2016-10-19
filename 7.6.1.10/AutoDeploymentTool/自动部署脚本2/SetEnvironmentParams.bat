@echo off
title 环境变量设置工具
color 0a
@set Path_=D:\Study\bat\IIS7Web
for /f "tokens=1,2,*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment" /v Path') do (
	@set PathAll_=%%c
)
echo %PathAll_%|find /i "%Path_%" && set Exist=true || set Exist=false

if not %Exist%==true (
      reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%PathAll_%;%Path_%" /f
)

pause
