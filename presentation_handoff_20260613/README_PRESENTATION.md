# 광양 B3 발표장 실행 안내

## 발표장에서 누를 파일

압축 파일은 먼저 압축을 풀고, 풀린 폴더 안에서 실행합니다. 발표장에서는 영어/숫자 파일명을 우선 사용합니다.

1. `01_START_PRESENTATION.bat`
   - 발표 시작 전에 누릅니다.
   - 공유용 슬라이드는 발표장/Zoom 공유 화면에, 대본 콘솔은 노트북 화면에 둡니다.
   - 실행할 때 온라인 싱크도 1번 슬라이드로 자동 초기화합니다.
2. `02_RESET_SYNC.bat`
   - 화면 싱크가 꼬였을 때만 누릅니다.
   - 발표 세트 실행 파일 안에도 같은 초기화가 들어 있으므로 평소에는 따로 누르지 않아도 됩니다.
3. `03_STOP_PRESENTATION.bat`
   - 발표가 끝난 뒤 누릅니다.
   - 발표용 브라우저 창만 닫고 싱크 상태를 1번으로 돌립니다.
4. `04_START_LOCAL_BACKUP.bat`
   - 발표장 인터넷이 불안할 때만 사용합니다.
   - ZIP 안의 `local_fallback` 폴더에 있는 로컬 사이트와 로컬 싱크 서버를 자동으로 켭니다.
5. `05_STOP_LOCAL_BACKUP.bat`
   - 로컬 백업 발표가 끝난 뒤 누릅니다.
6. `06_RETURN_DUPLICATE_MODE.bat`
   - 우리 발표가 끝난 뒤 다음 발표자를 위해 누릅니다.
   - 발표용 창을 닫고 Windows 화면 모드를 **복제**로 되돌립니다.

한글 파일명 `광양 B3 01 발표 세트 실행.bat` 등도 같은 기능이지만, 발표장 PC에서는 영어/숫자 파일명이 더 안정적입니다.

## 발표 전 화면 설정

1. 노트북을 발표장 화면에 연결합니다.
2. Windows + P를 눌러 **확장** 모드로 둡니다.
3. `01_START_PRESENTATION.bat`을 실행합니다. 이 파일이 Windows 화면 모드를 **확장**으로 먼저 전환합니다.
4. 주소창/탭/제목줄이 없는 전체화면 앱 창 두 개가 열립니다.
   - `Shared Slides`: 보조 화면, 발표장/공유 화면에 띄울 창
   - `Speaker Console`: 기본 화면, 발표자 노트북에서 볼 대본 콘솔
5. Zoom, Meet, OBS, HDMI 공유에서는 `Shared Slides` 창만 공유합니다.
6. 만약 제목줄이나 작업표시줄이 보이면 해당 창을 선택한 뒤 F11을 한 번 누릅니다.

## 싱크 파일 안내

온라인 발표에서는 별도 싱크 서버 파일이 필요 없습니다. Vercel 배포본의 `/api/slide-sync`가 공유 슬라이드와 발표자 콘솔을 연결합니다.

로컬 백업 발표에서는 `local_fallback/local-slide-sync.cjs`가 싱크 서버 역할을 합니다. `04_START_LOCAL_BACKUP.bat`이 자동으로 실행하므로 직접 열 필요는 없습니다.

## 발표 중 주소

- 공유용 슬라이드: `https://gwangyang-creative-convergence.vercel.app/index.html?present=1#/1`
- 발표자 콘솔: `https://gwangyang-creative-convergence.vercel.app/index.html?script=1&local=1#/1`

발표자 콘솔에서 Enter, 오른쪽 방향키, Space를 누르면 공유용 슬라이드와 인터렉션이 같이 넘어갑니다.

## 발표 후 해제

우리 발표가 끝나면 `06_RETURN_DUPLICATE_MODE.bat`을 실행합니다. 다음 발표자가 노트북 화면을 그대로 빔/Zoom에 복제해서 쓰는 기본 상태로 돌아갑니다.

우리 창만 닫고 확장 모드는 유지해야 할 때만 `03_STOP_PRESENTATION.bat`을 사용합니다.

이 파일은 다음 작업을 합니다.

- 원격 슬라이드 동기화 상태를 1번으로 되돌립니다.
- 발표용 Edge/Chrome 앱 창만 닫습니다.
- 일반 브라우저 창은 건드리지 않습니다.

## 문제 발생 시

- 콘솔과 공유 화면이 어긋나면 `reset_presentation_mode.bat` 실행 후 `setup_presentation_mode.bat`을 다시 실행합니다.
- 발표장 인터넷이 불안하면 ZIP 안의 `local_fallback` 폴더에서 `setup_local_fallback.bat`을 실행합니다.
- 로컬 백업 실행은 Node.js가 설치된 노트북에서만 동작합니다.
- 공유할 때는 반드시 발표자 콘솔이 아니라 `Shared Slides` 창만 공유합니다.
