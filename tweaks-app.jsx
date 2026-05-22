/* Tweaks app — mood/transition/font/color/text-size/autoplay */
const { useEffect } = React;

const DEFAULTS = /*EDITMODE-BEGIN*/{
  "mood": "dark",
  "transition": "fade-slide",
  "korFont": "pretendard",
  "accentPalette": ["#FF6B35", "#22D3EE"],
  "textScale": 1,
  "transitionDur": 900,
  "autoplay": false
}/*EDITMODE-END*/;

const MOOD_OPTIONS = [
  { value: "dark",       label: "Industrial Climate" },
  { value: "light",      label: "Industrial Clean" },
  { value: "editorial",  label: "Editorial Serif" }
];

const TRANSITION_OPTIONS = [
  { value: "fade-slide", label: "Fade + Slide" },
  { value: "fade",       label: "Pure Fade" },
  { value: "scale",      label: "Scale-in Cinematic" },
  { value: "parallax",   label: "Parallax" }
];

const FONT_OPTIONS = [
  { value: "pretendard", label: "Pretendard (모던)",     stack: '"Pretendard Variable", Pretendard, -apple-system, sans-serif' },
  { value: "notosans",   label: "Noto Sans KR (안정)",    stack: '"Noto Sans KR", "Pretendard Variable", sans-serif' },
  { value: "notoserif",  label: "Noto Serif KR (에디토리얼)", stack: '"Noto Serif KR", "Pretendard Variable", serif' }
];

// Curated accent palettes — first color drives --accent, second drives --accent-2
const ACCENT_PALETTES = [
  ["#FF6B35", "#22D3EE"],   // carbon pressure + transition tech
  ["#22D3EE", "#91F7BA"],   // transition tech + human readiness
  ["#FF6B35", "#91F7BA"],   // regulation pressure + just transition
  ["#9CA3AF", "#22D3EE"],   // steel + hydrogen
  ["#C2410C", "#67E8F9"]    // deep carbon + soft transition
];

function App() {
  const [t, setTweak] = window.useTweaks(DEFAULTS);

  // Apply tweaks to <body> + CSS variables
  useEffect(() => {
    document.body.setAttribute("data-mood", t.mood);
    document.body.setAttribute("data-transition", t.transition);

    const root = document.documentElement;
    // accent palette
    if (Array.isArray(t.accentPalette)) {
      root.style.setProperty("--accent", t.accentPalette[0] || "#ff6b35");
      if (t.accentPalette[1]) root.style.setProperty("--accent-2", t.accentPalette[1]);
    }
    // text scale
    root.style.setProperty("--t-scale", String(t.textScale));
    // transition duration
    root.style.setProperty("--t-dur", t.transitionDur + "ms");
    // korean font
    const f = FONT_OPTIONS.find(x => x.value === t.korFont);
    if (f) root.style.setProperty("--font-head", f.stack);
    // editorial mood overrides headline font separately
    if (t.mood === "editorial") {
      root.style.setProperty("--font-disp", '"Noto Serif KR", "Pretendard Variable", serif');
    } else {
      root.style.setProperty("--font-disp", 'var(--font-head)');
    }

    // autoplay
    if (window.__setAutoplay) window.__setAutoplay(!!t.autoplay);
  }, [t.mood, t.transition, t.korFont, t.accentPalette, t.textScale, t.transitionDur, t.autoplay]);

  const { TweaksPanel, TweakSection, TweakRadio, TweakSelect, TweakSlider, TweakToggle, TweakColor } = window;

  return (
    <TweaksPanel title="Tweaks">
      <TweakSection title="Mood">
        <TweakSelect
          label="톤"
          value={t.mood}
          options={MOOD_OPTIONS}
          onChange={(v) => setTweak("mood", v)}
        />
      </TweakSection>

      <TweakSection title="Transition">
        <TweakSelect
          label="전환 효과"
          value={t.transition}
          options={TRANSITION_OPTIONS}
          onChange={(v) => setTweak("transition", v)}
        />
        <TweakSlider
          label="전환 시간"
          value={t.transitionDur}
          min={300} max={1800} step={50} unit="ms"
          onChange={(v) => setTweak("transitionDur", v)}
        />
      </TweakSection>

      <TweakSection title="Typography">
        <TweakSelect
          label="한글 폰트"
          value={t.korFont}
          options={FONT_OPTIONS}
          onChange={(v) => setTweak("korFont", v)}
        />
        <TweakSlider
          label="텍스트 크기"
          value={t.textScale}
          min={0.8} max={1.2} step={0.02} unit="x"
          onChange={(v) => setTweak("textScale", v)}
        />
      </TweakSection>

      <TweakSection title="Color">
        <TweakColor
          label="액센트 팔레트"
          value={t.accentPalette}
          options={ACCENT_PALETTES}
          onChange={(v) => setTweak("accentPalette", v)}
        />
      </TweakSection>

      <TweakSection title="Playback">
        <TweakToggle
          label="자동 재생 (8초)"
          value={t.autoplay}
          onChange={(v) => setTweak("autoplay", v)}
        />
      </TweakSection>
    </TweaksPanel>
  );
}

ReactDOM.createRoot(document.getElementById("tweaks-root")).render(<App />);
