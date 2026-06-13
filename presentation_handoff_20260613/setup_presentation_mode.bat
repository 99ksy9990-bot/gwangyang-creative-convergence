@echo off
setlocal
chcp 65001 >nul

set "BASE_URL=https://gwangyang-creative-convergence.vercel.app"
set "PROFILE_BASE=%LOCALAPPDATA%\GwangyangB3Presentation"
set "STAMP=%RANDOM%%RANDOM%"

set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%BROWSER%" set "BROWSER=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

if not exist "%BROWSER%" (
  echo Edge 또는 Chrome을 찾지 못했습니다.
  pause
  exit /b 1
)

echo 원격 슬라이드 동기화를 1번으로 초기화합니다.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='presentation-setup';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null } catch { Write-Host '동기화 초기화 실패: 인터넷 연결을 확인하세요.' }"

echo 공유용 슬라이드 창을 엽니다.
start "Shared Slides" "%BROWSER%" --no-first-run --user-data-dir="%PROFILE_BASE%\audience" --app="%BASE_URL%/index.html?present=1&v=%STAMP%#/1"
timeout /t 1 /nobreak >nul

echo 발표자 콘솔 창을 엽니다.
start "Speaker Console" "%BROWSER%" --no-first-run --user-data-dir="%PROFILE_BASE%\speaker" --app="%BASE_URL%/index.html?script=1&local=1&v=%STAMP%#/1"

echo.
echo 완료: Shared Slides 창은 발표장 화면으로, Speaker Console 창은 노트북 화면으로 둡니다.
echo 발표 후에는 reset_presentation_mode.bat을 실행하세요.
pause
