@echo off
setlocal
cd /d "%~dp0"
echo TBMC Database deployment bootstrap
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Deploy-TBMC-Database.ps1" %*
echo.
echo Deployment launcher finished. Review any errors displayed above.
pause
