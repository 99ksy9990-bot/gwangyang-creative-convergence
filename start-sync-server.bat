@echo off
setlocal
set "NODE=%~dp0portable-node\node.exe"
if not exist "%NODE%" (
  where node >nul 2>nul
  if errorlevel 1 exit /b 0
  set "NODE=node"
)
start "Gwangyang B3 Sync" /min "%NODE%" "%~dp0local-slide-sync.cjs"
