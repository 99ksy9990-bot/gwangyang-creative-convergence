@echo off
setlocal
chcp 65001 >nul

set "BASE_URL=https://gwangyang-creative-convergence.vercel.app"
set "PROFILE_BASE=%LOCALAPPDATA%\GwangyangB3Presentation"
set "STAMP=%RANDOM%%RANDOM%"
set "BROWSER_FLAGS=--no-first-run --no-default-browser-check --disable-session-crashed-bubble --start-fullscreen"

set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

if not exist "%BROWSER%" (
  echo Edge 또는 Chrome을 찾지 못했습니다.
  pause
  exit /b 1
)

set "SPEAKER_SCREEN=--window-position=0,0 --window-size=1920,1080"
set "AUDIENCE_SCREEN=--window-position=1920,0 --window-size=1920,1080"
set "SCREEN_FILE=%TEMP%\gwangyang_b3_screens_%RANDOM%%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-Type -AssemblyName System.Windows.Forms; $screens=[System.Windows.Forms.Screen]::AllScreens; $primary=$null; $audience=$null; foreach($s in $screens){ if($s.Primary){ $primary=$s } elseif($null -eq $audience){ $audience=$s } }; if($null -eq $primary){ $primary=$screens[0] }; if($null -eq $audience){ $audience=$primary }; $p=$primary.Bounds; $a=$audience.Bounds; [System.IO.File]::WriteAllText('%SCREEN_FILE%', ('{0},{1},{2},{3},{4},{5},{6},{7}' -f $p.X,$p.Y,$p.Width,$p.Height,$a.X,$a.Y,$a.Width,$a.Height), [System.Text.Encoding]::ASCII)"
if exist "%SCREEN_FILE%" (
  for /f "usebackq tokens=1-8 delims=," %%A in ("%SCREEN_FILE%") do (
    set "SPEAKER_SCREEN=--window-position=%%A,%%B --window-size=%%C,%%D"
    set "AUDIENCE_SCREEN=--window-position=%%E,%%F --window-size=%%G,%%H"
  )
  del "%SCREEN_FILE%" >nul 2>nul
)

echo 원격 슬라이드 동기화를 1번으로 초기화합니다.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='presentation-setup';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null } catch { Write-Host '동기화 초기화 실패: 인터넷 연결을 확인하세요.' }"

echo 공유용 슬라이드 창을 엽니다.
start "Shared Slides" "%BROWSER%" %BROWSER_FLAGS% %AUDIENCE_SCREEN% --user-data-dir="%PROFILE_BASE%\audience" --app="%BASE_URL%/index.html?present=1&v=%STAMP%#/1"
timeout /t 1 /nobreak >nul

echo 발표자 콘솔 창을 엽니다.
start "Speaker Console" "%BROWSER%" %BROWSER_FLAGS% %SPEAKER_SCREEN% --user-data-dir="%PROFILE_BASE%\speaker" --app="%BASE_URL%/index.html?script=1&local=1&v=%STAMP%#/1"

echo.
echo 완료: 두 창 모두 주소창/제목줄 없는 전체화면 앱 창으로 열었습니다.
echo Shared Slides 창은 발표장 화면으로, Speaker Console 창은 노트북 화면으로 둡니다.
echo 발표 후에는 reset_presentation_mode.bat을 실행하세요.
pause
