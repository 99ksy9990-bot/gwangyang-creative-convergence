@echo off
setlocal

echo Switching Windows display mode to Extend...
if exist "%SystemRoot%\System32\DisplaySwitch.exe" (
  "%SystemRoot%\System32\DisplaySwitch.exe" /extend
) else (
  echo DisplaySwitch.exe was not found. Press Windows+P and choose Extend.
)

if /i "%1"=="nopause" exit /b 0
pause
