@echo off
setlocal

if not exist "%~dp0setup_presentation_mode.bat" (
  echo setup_presentation_mode.bat was not found.
  echo Unzip the presentation package first, then run this file from the extracted folder.
  pause
  exit /b 1
)

if /i not "%1"=="check" (
  if exist "%~dp000_SET_EXTEND_MODE.bat" call "%~dp000_SET_EXTEND_MODE.bat" nopause
  timeout /t 2 /nobreak >nul
)

call "%~dp0setup_presentation_mode.bat" %*
