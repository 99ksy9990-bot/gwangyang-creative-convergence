@echo off
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "BASE=%LOCALAPPDATA%\GwangyangB3Edge"
start "Audience" "%EDGE%" --no-first-run --user-data-dir="%BASE%\audience" --app="https://gwangyang-creative-convergence.netlify.app/index.html?present=1#/1"
timeout /t 1 /nobreak >nul
start "Speaker Console" "%EDGE%" --no-first-run --user-data-dir="%BASE%\speaker" --app="https://gwangyang-creative-convergence.netlify.app/index.html?present=1&script=1#/1"

