
rem if you updated the html pages or js just relaunch the app
rem else we cleanup and redeploy the service
call %~dp0.\cleanup.bat
call %~dp0.\setup.bat

exit /B 0
