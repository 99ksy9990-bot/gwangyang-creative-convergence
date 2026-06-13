@echo off
setlocal

if exist "%~dp003_STOP_PRESENTATION.bat" (
  call "%~dp003_STOP_PRESENTATION.bat" nopause
)

echo Switching Windows display mode back to Duplicate...
if exist "%SystemRoot%\System32\DisplaySwitch.exe" (
  "%SystemRoot%\System32\DisplaySwitch.exe" /clone
) else (
  echo DisplaySwitch.exe was not found. Press Windows+P and choose Duplicate.
)

echo Done. The next presenter can use the normal duplicated screen.
if /i "%1"=="nopause" exit /b 0
pause
