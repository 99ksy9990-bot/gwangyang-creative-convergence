@echo off
call "%~dp0start-local-site.bat"
call "%~dp0start-sync-server.bat"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "PROFILE=%LOCALAPPDATA%\GwangyangB3Edge\audience"
start "Audience" "%EDGE%" --no-first-run --user-data-dir="%PROFILE%" --app="http://127.0.0.1:4183/index.html?present=1#/1"

