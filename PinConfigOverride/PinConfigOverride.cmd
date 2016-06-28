::----------------------------------------------------------------------
:: Script Name  : PinConfigOverride.cmd
:: Author       : Grisno
:: Created on   : 07/09/2014
:: Created on   : 07/09/2014
:: Purpose      : Exports PinConfigOverride From The Windows Registry
::                And Converts HDA Verbs With PinConfigOverride.vbs
:: Version      : 1.10
::----------------------------------------------------------------------

@echo off

cls

Setlocal EnableDelayedExpansion

set _int=0
set _pwd=%cd%

for /f "tokens=*" %%a in ('"REG QUERY HKLM\SYSTEM /s /f PinConfigOverrideVerbs /k | findstr /v /c:""Fin"" | findstr /v /c:""End"" "') do (
	rem echo.
	rem echo. %%a
	rem echo.
	rem reg query %%a
	set /a _int=!_int!+1
	rem echo. %%a PinConfigOverride00!_int!.reg
	del /f /q "!_pwd!\PinConfigOverride00!_int!.reg" > nul 2>&1
	reg export "%%a" "!_pwd!\PinConfigOverride00!_int!.reg" /y > nul 2>&1
	rem type "!_pwd!\PinConfigOverride00!_int!.reg" > "!_pwd!\PinConfigOverride00!_int!.tmp"
	rem type "!_pwd!\PinConfigOverride00!_int!.tmp" > "!_pwd!\PinConfigOverride00!_int!.reg"
	rem del /f /q "!_pwd!\PinConfigOverride00!_int!.tmp" > nul 2>&1
	cscript //nologo "PinConfigOverride.vbs" /input:"PinConfigOverride00!_int!.reg" > "!_pwd!\PinConfigOverride00!_int!.txt"
	)

pause