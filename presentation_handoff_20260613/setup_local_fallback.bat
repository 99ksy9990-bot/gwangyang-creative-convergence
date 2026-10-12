@echo off
setlocal

set "ROOT=%~dp0"
set "PROFILE_BASE=%LOCALAPPDATA%\GwangyangB3PresentationLocal"
set "STAMP=%RANDOM%%RANDOM%"
set "BROWSER_FLAGS=--no-first-run --no-default-browser-check --disable-session-crashed-bubble --start-fullscreen"
set "NODE_EXE=%ROOT%portable-node\node.exe"

if exist "%NODE_EXE%" goto node_ready
where node >nul 2>nul
if not errorlevel 1 (
  set "NODE_EXE=node"
  goto node_ready
)

  echo Node.js was not found.
  echo portable-node\node.exe was not found in local_fallback.
  echo Use 01_START_PRESENTATION.bat if internet is available.
  pause
  exit /b 1

:node_ready

set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

if exist "%BROWSER%" goto browser_ready
echo Edge or Chrome was not found.
pause
exit /b 1

:browser_ready

set "SPEAKER_SCREEN=--window-position=0,0 --window-size=1920,1080"
set "AUDIENCE_SCREEN=--window-position=1920,0 --window-size=1920,1080"
set "SCREEN_FILE=%TEMP%\gwangyang_b3_local_screens_%RANDOM%%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; $screens=[System.Windows.Forms.Screen]::AllScreens; $primary=$null; $audience=$null; foreach($s in $screens){ if($s.Primary){ $primary=$s } elseif($null -eq $audience){ $audience=$s } }; if($null -eq $primary){ $primary=$screens[0] }; if($null -eq $audience){ $audience=$primary }; $p=$primary.Bounds; $a=$audience.Bounds; [System.IO.File]::WriteAllText('%SCREEN_FILE%', ('{0},{1},{2},{3},{4},{5},{6},{7}' -f $p.X,$p.Y,$p.Width,$p.Height,$a.X,$a.Y,$a.Width,$a.Height), [System.Text.Encoding]::ASCII)" >nul 2>nul
if exist "%SCREEN_FILE%" (
  for /f "usebackq tokens=1-8 delims=," %%A in ("%SCREEN_FILE%") do (
    set "SPEAKER_SCREEN=--window-position=%%A,%%B --window-size=%%C,%%D"
    set "AUDIENCE_SCREEN=--window-position=%%E,%%F --window-size=%%G,%%H"
  )
  del "%SCREEN_FILE%" >nul 2>nul
)

if /i not "%1"=="check" goto launch_local
echo Browser:
echo %BROWSER%
echo Speaker: %SPEAKER_SCREEN%
echo Audience: %AUDIENCE_SCREEN%
exit /b 0

:launch_local

if /i "%NODE_EXE%"=="node" (
  start "Local Site Server" /min cmd /c "cd /d ""%ROOT%"" && node local-site-server.cjs"
  start "Local Slide Sync" /min cmd /c "cd /d ""%ROOT%"" && node local-slide-sync.cjs"
) else (
  start "Local Site Server" /min cmd /c "cd /d ""%ROOT%"" && ""%NODE_EXE%"" local-site-server.cjs"
  start "Local Slide Sync" /min cmd /c "cd /d ""%ROOT%"" && ""%NODE_EXE%"" local-slide-sync.cjs"
)
timeout /t 2 /nobreak >nul

call "%ROOT%reset_local_fallback.bat" nopause

start "Shared Slides" "%BROWSER%" %BROWSER_FLAGS% %AUDIENCE_SCREEN% --user-data-dir="%PROFILE_BASE%\audience" --app="http://127.0.0.1:4183/index.html?present=1&v=%STAMP%#/1"
timeout /t 1 /nobreak >nul
start "Speaker Console" "%BROWSER%" %BROWSER_FLAGS% %SPEAKER_SCREEN% --user-data-dir="%PROFILE_BASE%\speaker" --app="http://127.0.0.1:4183/index.html?script=1&local=1&v=%STAMP%#/1"

echo.
echo Done. Local backup windows are open.
if /i "%1"=="nopause" exit /b 0
pause
