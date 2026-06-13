@echo off
setlocal

set "BASE_URL=https://gwangyang-creative-convergence.vercel.app"
set "PROFILE_MARKER=GwangyangB3Presentation"

echo Resetting online slide sync to slide 1...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='presentation-reset';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null; Write-Host 'Sync reset complete.' } catch { Write-Host 'Sync reset failed. Check internet connection.' }"

echo Closing presentation browser windows...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$marker='%PROFILE_MARKER%'; Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq 'msedge.exe' -or $_.Name -eq 'chrome.exe') -and $_.CommandLine -like ('*' + $marker + '*') } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch {} }"

echo Done.
if /i "%1"=="nopause" exit /b 0
pause
