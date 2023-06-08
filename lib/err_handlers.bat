goto %1

:ERR_INVALID_ARG rem SELF OPT_ARG
  set base_msg=Invalid or unsupported argument
  set base_help=Check available commands with "--help"

  set arg_hint=
  if not [%2]==[] ( set arg_hint= "%~2" )

  echo %base_msg%%arg_hint%.%base_help% & goto:eof
exit /b 0

:ERR_NOT_IMPLEMENTED rem SELF OPT_ADDITIONAL_INFO
  echo Interal Error: Method not yet implemented
  if not [%2]==[] echo %2
exit /b 0