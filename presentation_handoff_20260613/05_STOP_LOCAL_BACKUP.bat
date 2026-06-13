@echo off
setlocal

if exist "%~dp0local_fallback\reset_local_fallback.bat" (
  call "%~dp0local_fallback\reset_local_fallback.bat" %*
  exit /b %ERRORLEVEL%
)

echo local_fallback was not found.
echo Unzip the presentation package first, then run this file from the extracted folder.
pause
exit /b 1
