SET utils_file="%~dp0%lib\utils.bat"
SET _error_handlers="%~dp0lib\err_handlers.bat"

@REM Temporarily prevents call to automated installation. SETX is too volatile and might corrupt user environvment variables
SET exception_msg="Unstable function. It its recommended to set the PVM path environment variable manually"
CALL %_error_handlers% ERR_NOT_IMPLEMENTED %exception_msg% & goto :eof

@REM SET is_installed=
@REM CALL %utils_file% B_PATH_HAS_STRING %CONF_DEF_INSTALL_PATH% is_installed

@REM @REM prompt for reinstall or just return
@REM if %is_installed% equ true ( echo PHP Version Manager already appears to be installed. & goto :eof )

@REM @REM Perform installation
@REM echo No current installation found for PVM.

@REM set /P confirmation="Install now?[y|n]: "

@REM if %confirmation% equ n ( goto :eof )

@REM @REM rewrites instalation message for better ux
@REM echo Installing program...
@REM xcopy /s /q %~dp0 %CONF_DEF_INSTALL_PATH%
@REM cls
@REM echo Installing program...

@REM @REM Appends default installation dir to PATH
@REM CALL SET updated_path=%PATH%;%CONF_DEF_INSTALL_PATH%

@REM @REM echo "PATH=%updated_path%"
@REM @REM SETX path "%updated_path%" /M
@REM SET "PATH=%updated_path%" 

@REM @REM Confirms installation
@REM set has_installed=
@REM CALL %utils_file% B_PATH_HAS_STRING %CONF_DEF_INSTALL_PATH% has_installed
@REM if %has_installed% equ true (
@REM   echo ____________________________________
@REM   echo PHP Version Manager installed succesfully.
@REM   echo ____________________________________

@REM   CALL :DRAW_PVM_LOGO

@REM   echo You can check the available commands with "pvm --help". & goto :eof
@REM )

@REM echo Process ended. 
@REM echo Could not identify PHP Version Manager instalation in environment. Please restart your machine and confirm the installation with "pvm -v" & goto :eof

@REM EXIT /b 0

@REM :DRAW_PVM_LOGO
@REM   type assets/pvm_logo.txt
@REM exit /b 0