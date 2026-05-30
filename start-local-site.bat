@echo off
where node >nul 2>nul
if errorlevel 1 exit /b 0
start "Gwangyang B3 Local Site" /min node "%~dp0local-site-server.cjs"
