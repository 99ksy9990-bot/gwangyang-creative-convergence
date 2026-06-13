@echo off
setlocal
chcp 65001 >nul

if exist "%~dp0local_fallback\setup_local_fallback.bat" (
  call "%~dp0local_fallback\setup_local_fallback.bat"
  exit /b %ERRORLEVEL%
)

if exist "%~dp0..\open-presentation-pair.bat" (
  call "%~dp0..\open-presentation-pair.bat"
  exit /b %ERRORLEVEL%
)

echo 로컬 백업 파일을 찾지 못했습니다.
pause
exit /b 1
