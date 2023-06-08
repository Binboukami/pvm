@echo off

set CONF_PKG_VER=1.0.0
set CONF_DEF_INSTALL_PATH=C:\pvm\

@REM if[%~1]==[list] ( rem list available php versions )
@REM help commmand for general commands. todo: Add indepth descriptions for commands and subcommands
set CONF_SUPPORTED_ARGS=-v --version --help use --install --uninstall

SET _err_handlers="%~dp0lib/err_handlers.bat"
SET _install="%~dp0%install.bat"
SET _uninstall="%~dp0%uninstall.bat"


if not [%~1]==[] (goto :PARSE_ARGS) else (goto :ERR_INVALID_ARG) 

@REM todo: refactor into cli parser file so pvm functionally can be decoupled from installation depedencies

:PARSE_ARGS

  for %%i in (%CONF_SUPPORTED_ARGS%) do (

    if %%i==%~1 ( goto :SUB_PRC_VALID_PARSE_ARGS)
  )

  call %_err_handlers% ERR_INVALID_ARG "%~1"

  :SUB_PRC_VALID_PARSE_ARGS
    if [%~1]==[-v] CALL :PRC_PKG_VERSION
    if [%~1]==[--version] CALL :PRC_PKG_VERSION
    if [%~1]==[use] (

      if [%~2]==[] (
        echo Missing required version number for command "use".
        goto :eof
      )
      call :PRC_SET_PHP_VER %~2
    )
    @REM if [%~1]==[--install] CALL :INSTALL_PKG
    if [%~1]==[--install] CALL %_install%
    if [%~1]==[--uninstall] CALL %_uninstall%

    if [%~1]==[--help] (

      call :PRC_HELP
    )
goto :eof

:PRC_PKG_VERSION
 echo v%CONF_PKG_VER%
EXIT /b 0

:PRC_HELP rem OPT_COMMAND
  echo List of available commands:
  echo    %CONF_SUPPORTED_ARGS: =, %
EXIT /b 0

:PRC_SET_PHP_VER rem VERSION_STRING

  call php "-v" > temp.txt

  set /a current_version=0

  setlocal enabledelayedexpansion
  for /F "tokens=2 delims= " %%a in ('type temp.txt') do (

    endlocal
    set current_version=%%a
    goto :MODIFY_PATH_STRING current_version
  )

EXIT /b 0
goto :eof

:MODIFY_PATH_STRING rem VERSION_NUMBER
  SET path_string=%PATH%
  SET current_version=php%current_version%
  SET new_version=php%1

  @REM The call there causes another layer of variable expansion,
  @REM making it necessary to quote the original % signs but it all works out in the end.
  CALL SET updated_path=%%path_string:%current_version%=php%1%%%

  @REM Unquote parameter with 
  ECHO "Setting version to: %1"

  @REM echo PATH=%updated_path%

  SET "PATH=%updated_path%"
  del /Q temp.txt

  ECHO Please run "php -v" to confirm PHP version matches the desired one.
exit /b 0

goto :eof