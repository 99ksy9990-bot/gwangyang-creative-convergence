@echo off
setlocal
chcp 65001 >nul

set "ROOT=%~dp0"
set "PROFILE_BASE=%LOCALAPPDATA%\GwangyangB3PresentationLocal"
set "STAMP=%RANDOM%%RANDOM%"

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js를 찾지 못했습니다. 인터넷이 되면 setup_presentation_mode.bat을 사용하세요.
  pause
  exit /b 1
)

set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

if not exist "%BROWSER%" (
  echo Edge 또는 Chrome을 찾지 못했습니다.
  pause
  exit /b 1
)

start "Local Site Server" /min cmd /c "cd /d ""%ROOT%"" && node local-site-server.cjs"
start "Local Slide Sync" /min cmd /c "cd /d ""%ROOT%"" && node local-slide-sync.cjs"
timeout /t 2 /nobreak >nul

call "%ROOT%reset_local_fallback.bat" nopause

start "Shared Slides" "%BROWSER%" --no-first-run --user-data-dir="%PROFILE_BASE%\audience" --app="http://127.0.0.1:4183/index.html?present=1&v=%STAMP%#/1"
timeout /t 1 /nobreak >nul
start "Speaker Console" "%BROWSER%" --no-first-run --user-data-dir="%PROFILE_BASE%\speaker" --app="http://127.0.0.1:4183/index.html?script=1&local=1&v=%STAMP%#/1"

echo.
echo 완료: 로컬 백업 발표 창을 열었습니다.
pause
