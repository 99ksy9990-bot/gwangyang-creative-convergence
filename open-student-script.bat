@echo off
call "%~dp0start-local-site.bat"
call "%~dp0start-sync-server.bat"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "PROFILE=%LOCALAPPDATA%\GwangyangB3Edge\student"
start "Student Script" "%EDGE%" --no-first-run --user-data-dir="%PROFILE%" --app="http://127.0.0.1:4183/index.html?present=1&script=1&local=1#/1"

