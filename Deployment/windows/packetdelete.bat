@echo off
@rem #################################################
@rem
@rem Usuwa paczkę pod system operacjiny Windows 
@rem
@rem #################################################

set DIRNAME=%~dp0
set APP_BASE_NAME=%1
set AUTHOR=%2
set LANGUAGE=%3
set SYSTEMBINARY=%4

if exist %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY% goto EXISTDIR
if not exist %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY% echo Don't have such a folder: %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY%
goto NOTEXISTDIR
:EXISTDIR
rmdir /Q /s %DIRNAME%packages\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\data\win%SYSTEMBINARY%
:NOTEXISTDIR
pause