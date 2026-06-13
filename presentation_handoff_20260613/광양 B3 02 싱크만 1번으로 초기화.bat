@echo off
setlocal
chcp 65001 >nul

set "BASE_URL=https://gwangyang-creative-convergence.vercel.app"

echo 온라인 슬라이드 싱크를 1번으로 초기화합니다.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$body=@{type='slide-change';index=1;sourceId='manual-sync-reset';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri '%BASE_URL%/api/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null; Write-Host '싱크 초기화 완료' } catch { Write-Host '싱크 초기화 실패: 인터넷 연결을 확인하세요.'; exit 1 }"

pause
