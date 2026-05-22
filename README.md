# 광양창의융합

기후변화와 산업구조 변화가 미래 일자리에 미치는 영향을 광양 산업 구조 중심으로 발표하는 정적 HTML 슬라이드입니다.

## 실행

`index.html`은 로컬 웹 서버로 열어야 JavaScript 파일이 정상적으로 로드됩니다.

```sh
python3 -m http.server 4173 --bind 127.0.0.1
```

Then open:

```text
http://127.0.0.1:4173/
```

## 주요 파일

- `index.html`: 발표 슬라이드 본문과 스타일
- `deck-stage.js`: 슬라이드 스테이지 보조 스크립트
- `tweaks-app.jsx`: 트윅 UI
- `tweaks-panel.jsx`: 트윅 패널
- `screenshots/`: 기준 확인용 슬라이드 이미지
