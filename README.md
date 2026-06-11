# 광양창의융합 발표자료

기후변화, 일자리, 그리고 광양의 미래를 주제로 한 정적 HTML 발표자료입니다.

## 현재 작업 기준

- 최종 발표 파일: `index.html`
- 발표 보조 스크립트: `deck-stage.js`, `image-slot.js`
- 로컬 발표 주소: `http://127.0.0.1:4183/index.html?present=1`
- 수정 원칙: 발표 내용과 스타일은 기본적으로 `index.html`에서 관리합니다.
- 금지 파일: `deck-stage.js`, `image-slot.js`는 별도 요청 없이는 수정하지 않습니다.
- 업로드 원칙: 사용자가 "GitHub/Netlify 업데이트"라고 요청할 때만 원격 저장소나 Netlify에 반영합니다.

## 로컬 실행

프로젝트 폴더에서 정적 서버를 실행합니다.

```sh
python -m http.server 4183 --bind 127.0.0.1
```

발표 모드로 확인할 때는 아래 주소를 엽니다.

```text
http://127.0.0.1:4183/index.html?present=1
```

## Zoom 공유용 Audience 앱 모드

Zoom 공유용 Audience 창은 일반 브라우저가 아니라 Edge 앱 모드로 여는 것을 권장합니다.

실행창에서 아래 명령어를 입력하세요.

```bat
msedge --app="https://gwangyang-creative-convergence.vercel.app/index.html?present=1#/1"
```

이렇게 열면 주소창, 탭, 북마크바 없이 슬라이드만 보이는 창이 열립니다.
Zoom에서는 이 Audience 앱 창만 공유하세요.

## 발표 화면 주소

- Audience / Zoom 공유용: `https://gwangyang-creative-convergence.vercel.app/index.html?present=1#/1`
- 진행자 콘솔 / Audience 따라가기 전용: `https://gwangyang-creative-convergence.vercel.app/index.html?present=1&script=1#/1`
- 학생용 대본 보기 / 자유 이동 가능: `https://gwangyang-creative-convergence.vercel.app/index.html?present=1&script=1&local=1#/1`

진행자 콘솔은 Audience를 따라가기만 하며, 학생용 대본 보기는 발표 화면에 영향을 주지 않습니다.

## 주요 파일

- `index.html`: 발표 슬라이드 본문, 스타일, 발표 모드 보정 스크립트
- `deck-stage.js`: 슬라이드 스테이지 웹 컴포넌트
- `image-slot.js`: 이미지 슬롯 웹 컴포넌트
- `assets/images/`: 발표에 실제 사용되는 이미지
- `screenshots/`: 로컬 검수용 스크린샷
- `scraps/`: 사용하지 않는 후보 이미지나 작업 중 산출물 보관

## 배포 메모

현재 GitHub 원격 저장소는 `origin`입니다.

```text
https://github.com/99ksy9990-bot/gwangyang-creative-convergence.git
```

Vercel은 정적 사이트로 배포하며, production alias는 `https://gwangyang-creative-convergence.vercel.app`입니다. Netlify 배포 설정은 기존 호환을 위해 유지합니다.

## 배포 전 체크리스트

- `index.html`의 슬라이드 라벨이 `01`부터 `19`까지 이어지는지 확인합니다.
- 발표에 참조되는 `assets/images/` 파일이 모두 존재하고 Git 추적 대상인지 확인합니다.
- `deck-stage.js`, `image-slot.js`에 의도하지 않은 변경이 없는지 확인합니다.
- 로컬 주소 `http://127.0.0.1:4183/index.html?present=1`에서 최종 발표 모드를 확인합니다.
- GitHub/Netlify 반영은 사용자가 명시적으로 요청한 뒤 진행합니다.

## 산출물 보관 정책

- 발표에 쓰지 않는 후보 이미지는 `scraps/unused-assets-*` 아래에 보관합니다.
- 전체 슬라이드 검수 스크린샷은 `screenshots/all-slides-local-*` 아래에 보관합니다.
- 위 보관 폴더들은 `.gitignore`에 포함되어 배포 대상과 섞이지 않습니다.
