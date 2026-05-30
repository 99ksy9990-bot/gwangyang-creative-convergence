@echo off
call "%~dp0start-local-site.bat"
call "%~dp0start-sync-server.bat"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "BASE=%LOCALAPPDATA%\GwangyangB3Edge"
start "Audience" "%EDGE%" --no-first-run --user-data-dir="%BASE%\audience" --app="http://127.0.0.1:4183/index.html?present=1#/1"
timeout /t 1 /nobreak >nul
start "Speaker Console" "%EDGE%" --no-first-run --user-data-dir="%BASE%\speaker" --app="http://127.0.0.1:4183/index.html?present=1&script=1#/1"

