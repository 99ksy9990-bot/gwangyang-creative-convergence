@echo off
start "Audience" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --new-window --app="https://gwangyang-creative-convergence.netlify.app/index.html?present=1#/1"
timeout /t 1 /nobreak >nul
start "Speaker Console" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --new-window --app="https://gwangyang-creative-convergence.netlify.app/index.html?present=1&script=1#/1"

