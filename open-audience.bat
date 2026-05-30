@echo off
call "%~dp0start-sync-server.bat"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "PROFILE=%LOCALAPPDATA%\GwangyangB3Edge\audience"
start "Audience" "%EDGE%" --no-first-run --user-data-dir="%PROFILE%" --app="https://gwangyang-creative-convergence.netlify.app/index.html?present=1#/1"

