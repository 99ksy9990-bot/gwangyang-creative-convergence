@echo off
setlocal

if exist "%~dp0local_fallback\setup_local_fallback.bat" (
  if /i not "%1"=="check" (
    if exist "%~dp000_SET_EXTEND_MODE.bat" call "%~dp000_SET_EXTEND_MODE.bat" nopause
    timeout /t 2 /nobreak >nul
  )
  call "%~dp0local_fallback\setup_local_fallback.bat" %*
  exit /b %ERRORLEVEL%
)

echo local_fallback was not found.
echo Unzip the presentation package first, then run this file from the extracted folder.
pause
exit /b 1
