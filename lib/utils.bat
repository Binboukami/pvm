goto %1

:B_PATH_HAS_STRING rem Self String _Return
  set search_string=%~2

  set has_string=false 
  setlocal EnableDelayedExpansion
  @REM if "!path:%CONF_DEF_INSTALL_PATH%=!" NEQ "!path!" echo path contains !myVar!
  if "!path:%search_string%=!" NEQ "!path!" endlocal & set has_string=true
  endlocal

  SET %~3=%has_string%
exit /b 0