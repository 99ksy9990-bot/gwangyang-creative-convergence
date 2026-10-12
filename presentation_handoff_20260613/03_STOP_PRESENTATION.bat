@echo off
setlocal

if not exist "%~dp0reset_presentation_mode.bat" (
  echo reset_presentation_mode.bat was not found.
  echo Unzip the presentation package first, then run this file from the extracted folder.
  pause
  exit /b 1
)

call "%~dp0reset_presentation_mode.bat" %*
