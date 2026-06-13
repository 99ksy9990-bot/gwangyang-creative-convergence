@echo off
setlocal

if not exist "%~dp0setup_presentation_mode.bat" (
  echo setup_presentation_mode.bat was not found.
  echo Unzip the presentation package first, then run this file from the extracted folder.
  pause
  exit /b 1
)

call "%~dp0setup_presentation_mode.bat" %*
