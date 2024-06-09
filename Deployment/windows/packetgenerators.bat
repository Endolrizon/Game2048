@echo off
@rem #################################################
@rem
@rem Torzy paczkę pod system operacjiny Windows 
@rem
@rem #################################################

set DIRNAME=%~dp0
set APP_BASE_NAME=%1
set AUTHOR=%2
set LANGUAGE=%3
set SYSTEMBINARY=%4

if exist %DIRNAME%..\..\build\Desktop_Qt_6_7_0_MinGW_%SYSTEMBINARY%_bit-Release\%APP_BASE_NAME%.exe goto EXISTEXE
if not exist %DIRNAME%..\..\build\Desktop_Qt_6_7_0_MinGW_%SYSTEMBINARY%_bit-Release\%APP_BASE_NAME%.exe goto NOTEXISTEXE
:EXISTEXE
if exist %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY% goto EXISTDIR
mkdir %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY%
if exist %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY% goto EXISTDIR
if not exist %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY% echo Don't have such a folder: %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY%
goto NOTEXISTEXE
:EXISTDIR
@cd %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY%\
@copy %DIRNAME%..\..\build\Desktop_Qt_6_7_0_MinGW_%SYSTEMBINARY%_bit-Release\%APP_BASE_NAME%.exe %APP_BASE_NAME%.exe
@C:\Qt\6.7.0\mingw_%SYSTEMBINARY%\bin\windeployqt6.exe %APP_BASE_NAME%.exe -qmldir %DIRNAME%..\..\ -compiler-runtime
:NOTEXISTEXE
pause