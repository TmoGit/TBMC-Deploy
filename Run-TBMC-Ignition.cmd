@echo off
setlocal
cd /d "%~dp0"
echo TBMC Ignition deployment bootstrap
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Deploy-TBMC-Ignition.ps1" %*
echo.
echo Deployment launcher finished. Review any errors displayed above.
pause
