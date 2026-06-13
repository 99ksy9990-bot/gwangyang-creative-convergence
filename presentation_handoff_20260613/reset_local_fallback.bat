@echo off
setlocal
chcp 65001 >nul

set "PROFILE_MARKER=GwangyangB3PresentationLocal"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='local-presentation-reset';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri 'http://127.0.0.1:4184/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null } catch {}"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$marker='%PROFILE_MARKER%'; Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq 'msedge.exe' -or $_.Name -eq 'chrome.exe') -and $_.CommandLine -like ('*' + $marker + '*') } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch {} }"

if /i "%1"=="nopause" exit /b 0
echo 완료: 로컬 백업 발표 창을 정리했습니다.
pause
