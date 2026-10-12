@echo off
setlocal

set "BASE_URL=https://gy-creative.vercel.app"

echo Resetting online slide sync to slide 1...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='manual-sync-reset';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null; Write-Host 'Sync reset complete.' } catch { Write-Host 'Sync reset failed. Check internet connection.'; exit 1 }"

if /i "%1"=="nopause" exit /b %ERRORLEVEL%
pause
