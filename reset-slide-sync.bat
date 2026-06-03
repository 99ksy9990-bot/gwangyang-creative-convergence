@echo off
setlocal
powershell -NoProfile -Command "$body=@{type='slide-change';index=1;sourceId='desktop-reset';at=[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()}|ConvertTo-Json -Compress; try { Invoke-RestMethod -Uri 'http://127.0.0.1:4184/slide-sync' -Method Post -ContentType 'application/json' -Body $body | Out-Null } catch {}"
