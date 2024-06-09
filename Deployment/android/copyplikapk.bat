@echo off
@rem #################################################
@rem
@rem Kopuje pliki instalacyjny aplikacji apk do innego folderu 
@rem
@rem #################################################

set DIRNAME=%~dp0
set APP_BASE_NAME=%1
set AUTHOR=%2
set LANGUAGE=%3
set SYSTEMBINARY=%4

if exist %DIRNAME%..\..\build\Android_Qt_6_7_0_Clang_%SYSTEMBINARY%-Release\android-build\build\outputs\apk goto EXISTDIR
if not exist %DIRNAME%..\..\build\Android_Qt_6_7_0_Clang_%SYSTEMBINARY%-Release\android-build\build\outputs\apk goto NOTEXISTDIR
:EXISTDIR
@xcopy %DIRNAME%..\..\build\Android_Qt_6_7_0_Clang_%SYSTEMBINARY%-Release\android-build\build\outputs\apk\release %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\* /E /Y
@copy %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\android-build-release-signed.apk %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\%APP_BASE_NAME%.apk
@del %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\android-build-release-signed.apk
if exist %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\android-build-release-signed.apk.idsig goto EXISTIDSIG
if not exist %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\android-build-release-signed.apk.idsig goto NOTEXISTIDSIG
:EXISTIDSIG
@copy %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\android-build-release-signed.apk.idsig %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\%APP_BASE_NAME%.apk.idsig
@del %DIRNAME%\apk\%LANGUAGE%.%AUTHOR%.%APP_BASE_NAME%x%SYSTEMBINARY%\android-build-release-signed.apk.idsig
:NOTEXISTIDSIG
:NOTEXISTDIR