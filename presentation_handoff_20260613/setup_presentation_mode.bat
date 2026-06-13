@echo off
setlocal

set "BASE_URL=https://gwangyang-creative-convergence.vercel.app"
set "PROFILE_BASE=%LOCALAPPDATA%\GwangyangB3Presentation"
set "STAMP=%RANDOM%%RANDOM%"
set "BROWSER_FLAGS=--no-first-run --no-default-browser-check --disable-session-crashed-bubble --start-fullscreen"

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
set "SCREEN_FILE=%TEMP%\gwangyang_b3_screens_%RANDOM%%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; $screens=[System.Windows.Forms.Screen]::AllScreens; $primary=$null; $audience=$null; foreach($s in $screens){ if($s.Primary){ $primary=$s } elseif($null -eq $audience){ $audience=$s } }; if($null -eq $primary){ $primary=$screens[0] }; if($null -eq $audience){ $audience=$primary }; $p=$primary.Bounds; $a=$audience.Bounds; [System.IO.File]::WriteAllText('%SCREEN_FILE%', ('{0},{1},{2},{3},{4},{5},{6},{7}' -f $p.X,$p.Y,$p.Width,$p.Height,$a.X,$a.Y,$a.Width,$a.Height), [System.Text.Encoding]::ASCII)" >nul 2>nul
if exist "%SCREEN_FILE%" (
  for /f "usebackq tokens=1-8 delims=," %%A in ("%SCREEN_FILE%") do (
    set "SPEAKER_SCREEN=--window-position=%%A,%%B --window-size=%%C,%%D"
    set "AUDIENCE_SCREEN=--window-position=%%E,%%F --window-size=%%G,%%H"
  )
  del "%SCREEN_FILE%" >nul 2>nul
)

if /i not "%1"=="check" goto launch_presentation
echo Browser:
echo %BROWSER%
echo Speaker: %SPEAKER_SCREEN%
echo Audience: %AUDIENCE_SCREEN%
exit /b 0

:launch_presentation

echo Resetting online slide sync to slide 1...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='presentation-setup';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null; Write-Host 'Sync reset complete.' } catch { Write-Host 'Sync reset failed. Continuing with browser launch.' }"

echo Opening shared slide window on the audience screen...
start "Shared Slides" "%BROWSER%" %BROWSER_FLAGS% %AUDIENCE_SCREEN% --user-data-dir="%PROFILE_BASE%\audience" --app="%BASE_URL%/index.html?present=1&v=%STAMP%#/1"
timeout /t 1 /nobreak >nul

echo Opening speaker console on the laptop screen...
start "Speaker Console" "%BROWSER%" %BROWSER_FLAGS% %SPEAKER_SCREEN% --user-data-dir="%PROFILE_BASE%\speaker" --app="%BASE_URL%/index.html?script=1&local=1&v=%STAMP%#/1"

echo.
echo Done. Share only the "Shared Slides" window.
echo If a title bar or taskbar is visible, click that window and press F11 once.
if /i "%1"=="nopause" exit /b 0
pause
