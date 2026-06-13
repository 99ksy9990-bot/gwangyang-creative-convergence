@echo off
call "%~dp0start-local-site.bat"
call "%~dp0start-sync-server.bat"
timeout /t 2 /nobreak >nul
call "%~dp0reset-slide-sync.bat"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%EDGE%" set "EDGE=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "BASE=%LOCALAPPDATA%\GwangyangB3Edge"
set "STAMP=%RANDOM%%RANDOM%"
set "BROWSER_FLAGS=--no-first-run --no-default-browser-check --disable-session-crashed-bubble --start-fullscreen"
start "Audience" "%EDGE%" %BROWSER_FLAGS% --user-data-dir="%BASE%\audience" --app="http://127.0.0.1:4183/index.html?present=1&v=%STAMP%#/1"
timeout /t 1 /nobreak >nul
start "Speaker Console" "%EDGE%" %BROWSER_FLAGS% --user-data-dir="%BASE%\speaker" --app="http://127.0.0.1:4183/index.html?script=1&local=1&v=%STAMP%#/1"

