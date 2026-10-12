@echo off
call "%~dp0start-local-site.bat"
call "%~dp0start-sync-server.bat"
timeout /t 2 /nobreak >nul
call "%~dp0reset-slide-sync.bat"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "PROFILE=%LOCALAPPDATA%\GwangyangB3Edge\audience"
set "STAMP=%RANDOM%%RANDOM%"
set "BROWSER_FLAGS=--no-first-run --no-default-browser-check --disable-session-crashed-bubble --start-fullscreen"
start "Audience" "%EDGE%" %BROWSER_FLAGS% --user-data-dir="%PROFILE%" --app="http://127.0.0.1:4183/index.html?present=1&v=%STAMP%#/1"

