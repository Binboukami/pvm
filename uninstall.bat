SET err_handlers="%~dp0lib\err_handlers.bat"

:UNINSTALL_PKG
  SET err_message=To uninstall the package please remove the base directory "%CONF_DEF_INSTALL_PATH%" from your $PATH environment variable
  CALL %err_handlers% ERR_NOT_IMPLEMENTED "%err_message%" & goto :eof
exit /b 0