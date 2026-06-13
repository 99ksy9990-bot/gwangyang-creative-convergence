@echo off
setlocal
chcp 65001 >nul

set "BASE_URL=https://gwangyang-creative-convergence.vercel.app"
set "PROFILE_MARKER=GwangyangB3Presentation"

echo 원격 슬라이드 동기화를 1번으로 되돌립니다.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='presentation-reset';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null } catch { Write-Host '동기화 초기화 실패: 인터넷 연결을 확인하세요.' }"

echo 발표용 브라우저 앱 창을 닫습니다.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$marker='%PROFILE_MARKER%'; Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq 'msedge.exe' -or $_.Name -eq 'chrome.exe') -and $_.CommandLine -like ('*' + $marker + '*') } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch {} }"

echo 완료: 발표용 창을 정리했습니다.
pause
