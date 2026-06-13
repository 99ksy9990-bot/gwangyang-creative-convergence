# 광양창의융합 발표장 실행 안내

## 발표 전 설정

1. 노트북을 발표장 화면에 연결합니다.
2. Windows + P를 눌러 **확장** 모드로 둡니다.
3. `setup_presentation_mode.bat`을 실행합니다.
4. 열린 창 두 개를 아래처럼 둡니다.
   - `Shared Slides`: 발표장/공유 화면에 띄울 창
   - `Speaker Console`: 발표자 노트북에서 볼 대본 콘솔
5. Zoom, Meet, OBS, HDMI 공유에서는 `Shared Slides` 창만 공유합니다.

## 발표 중 주소

- 공유용 슬라이드: `https://gwangyang-creative-convergence.vercel.app/index.html?present=1#/1`
- 발표자 콘솔: `https://gwangyang-creative-convergence.vercel.app/index.html?script=1&local=1#/1`

발표자 콘솔에서 Enter, 오른쪽 방향키, Space를 누르면 공유용 슬라이드와 인터렉션이 같이 넘어갑니다.

## 발표 후 해제

발표가 끝나면 `reset_presentation_mode.bat`을 실행합니다.

이 파일은 다음 작업을 합니다.

- 원격 슬라이드 동기화 상태를 1번으로 되돌립니다.
- 발표용 Edge/Chrome 앱 창만 닫습니다.
- 일반 브라우저 창은 건드리지 않습니다.

## 문제 발생 시

- 콘솔과 공유 화면이 어긋나면 `reset_presentation_mode.bat` 실행 후 `setup_presentation_mode.bat`을 다시 실행합니다.
- 발표장 인터넷이 불안하면 ZIP 안의 `local_fallback` 폴더에서 `setup_local_fallback.bat`을 실행합니다.
- 로컬 백업 실행은 Node.js가 설치된 노트북에서만 동작합니다.
- 공유할 때는 반드시 발표자 콘솔이 아니라 `Shared Slides` 창만 공유합니다.
