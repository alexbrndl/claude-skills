<!-- Adapted from huashu-design (MIT) — see CREDITS.md. Animation pitfalls, translated and condensed from the original animation-pitfalls.md. -->

# Animation pitfalls

The bugs HTML animations hit most often, and how to avoid them. Every entry comes from a real failure. Reading this before writing an animation saves an iteration.

Each pitfall is written as **symptom / cause / fix**.

## 1. `position: absolute` without a `position: relative` ancestor

**Symptom:** an absolutely positioned child flies far outside its intended container (e.g. 200px past the bottom of the screen), anchored to the wrong element.

**Cause:** the container holding the absolute children has no `position: relative`, so the children resolve their coordinates against the nearest positioned ancestor (often `.canvas` or the viewport) instead of the wrapper you meant.

**Fix:**
- Any container with `position: absolute` children **must** declare `position: relative` explicitly, even when no visual offset is needed — it is the coordinate anchor.
- When writing `.parent { ... }` whose subtree has `.child { position: absolute }`, add `position: relative` to the parent reflexively.
- Quick check: for every `position: absolute`, walk up the ancestors and confirm the nearest positioned one is the coordinate system you actually want.

## 2. Rare Unicode characters the font does not render

**Symptom:** a glyph like `␣` (U+2423 OPEN BOX) shows as blank space or a tofu box. The audience sees nothing.

**Cause:** the chosen font (e.g. Noto Serif SC, Cormorant Garamond) has no glyph for that codepoint, so it falls back to nothing.

**Fix:**
- Every character that appears in the animation must exist in the selected font.
- Blacklist of common offenders: `␣ ␀ ␐ ␋ ␨ ↩ ⏎ ⌘ ⌥ ⌃ ⇧ ␦ ␖ ␛`.
- To represent meta-characters (space, return, tab), build a **semantic CSS box** instead of a glyph:
  ```html
  <span class="space-key">Space</span>
  ```
  ```css
  .space-key {
    display: inline-flex;
    padding: 4px 14px;
    border: 1.5px solid var(--accent);
    border-radius: 4px;
    font-family: monospace;
    text-transform: uppercase;
    letter-spacing: 0.2em;
  }
  ```
- Verify emoji too: some emoji fall back to a grey box outside Noto Emoji. Prefer an `emoji` font-family or inline SVG.

## 3. Hardcoded `grid-template-columns` vs data-driven N

**Symptom:** JS renders `N = 6` tokens but the CSS reads `grid-template-columns: 80px repeat(5, 1fr)`. The 6th token has no column and the whole matrix shifts out of alignment.

**Cause:** the column count is duplicated — once as a JS array length, once as a literal in CSS. Change one and the other silently drifts.

**Fix:**
- When the count comes from a JS array (`TOKENS.length`), the template must be data-driven too.
- Option A — inject a CSS variable from JS:
  ```js
  el.style.setProperty('--cols', N)
  ```
  ```css
  .grid { grid-template-columns: 80px repeat(var(--cols), 1fr); }
  ```
- Option B — use `grid-auto-flow: column` and let the browser expand.
- Ban the "fixed literal + JS constant" combination outright.

## 4. Scene-transition gaps — cross-fade, do not blank out

**Symptom:** between two scenes (zoom1 fades out over 0.6s, then zoom2 fades in over 0.6s plus a stagger delay) there is roughly one second of pure blank canvas. Viewers think the animation froze.

**Cause:** fade-out fully completes before fade-in starts. The two transitions are sequential, not overlapping.

**Fix:**
- Overlap fade-out and fade-in so they **cross-fade** — start the incoming scene while the outgoing one is still leaving:
  ```js
  // Bad: 0.4s of blank between scenes
  if (t >= 19.0) hideZoom('zoom1')
  if (t >= 19.4) showZoom('zoom2')

  // Good: cross-fade, both start together
  if (t >= 18.6) hideZoom('zoom1')
  if (t >= 18.6) showZoom('zoom2')
  ```
- Or keep an anchor element (e.g. the main sentence) briefly visible across the cut as a visual bridge.
- Do the transition-duration arithmetic so the next transition does not fire before the current one finishes.

## 5. Pure render principle — visual state must be seekable

**Symptom:** an animation chained with `setTimeout` + a fire-once helper plays fine forwards, but frame-by-frame recording or seeking to an arbitrary time breaks — timeouts that already ran cannot be "un-run".

**Cause:** the animation carries hidden state in side effects (elapsed timers, one-shot class toggles) instead of being a function of time.

**Fix:**
- Treat `render(t)` as a **pure function**: a given `t` always produces the same DOM state. This is the prerequisite for debugging by scrubbing and for clean video export.
- If side effects are unavoidable (e.g. toggling a class), track them in a `fired` set with an explicit reset:
  ```js
  const fired = new Set()
  function fireOnce(key, fn) { if (!fired.has(key)) { fired.add(key); fn() } }
  function reset() { fired.clear() /* clear all .show classes */ }
  ```
- Expose a seek hook for Playwright / debugging:
  ```js
  window.__seek = (t) => { reset(); render(t) }
  ```
- Keep animation-related `setTimeout` under ~1s; longer ones break seeking when time jumps backward.

## 6. Measuring before fonts load = measuring wrong

**Symptom:** layout code reads `getBoundingClientRect` / `offsetWidth` on `DOMContentLoaded`. The font is not loaded yet, so every measurement uses fallback-font metrics. When the real font arrives (~500ms later), the cached pixel offsets are permanently wrong.

**Cause:** DOM measurement ran before `document.fonts.ready`.

**Fix:**
- Wrap any measurement-dependent layout in `document.fonts.ready.then()`, plus one `requestAnimationFrame` so the browser commits layout:
  ```js
  document.fonts.ready.then(() => {
    requestAnimationFrame(() => {
      buildLayout()
      tick()
    })
  })
  ```
- For Google Fonts CDN, add `<link rel="preconnect">` to speed first load.

## 7. Recording prep — leave handles for video export

**Symptom:** Playwright `recordVideo` records from context creation. The first 1-2s of page/font loading land in the exported file as blank or flashing frames.

**Cause:** no separation between "page is loading" and "animation has started", and no clean first frame.

**Fix:**
- Use `scripts/render-video.js`: warmup navigate → fresh record context → wait duration → ffmpeg trim head + transcode to H.264 MP4.
- Frame 0 must be the complete initial state (final layout in place), never blank or loading.
- For 60fps, prefer ffmpeg frame duplication (`fps=60`) for compatibility; `minterpolate` only when you have tested the target player.

## 8. Temp directories need a PID/random suffix for concurrency

**Symptom:** running `render-video.js` for three HTML files in parallel: the first process to finish deletes the shared temp dir; the other two crash with `ENOENT`.

**Cause:** the temp dir is named with `Date.now()` only, so processes started in the same millisecond collide on one directory.

**Fix:**
- Name any potentially-shared temp dir with a PID or random suffix:
  ```js
  const TMP_DIR = path.join(DIR, '.video-tmp-' + Date.now() + '-' + process.pid)
  ```
- For true parallelism, orchestrate with shell `&` + `wait`, not a single forking node script. Three or more files: run serially.

## 9. Debug chrome elements polluting the recording

**Symptom:** progress bar, replay button, and time counter — added for human debugging — appear at the bottom of the exported MP4, as if devtools were filmed.

**Cause:** human-facing "chrome" and the animation content are not separated, so the recorder captures both.

**Fix:**
- Mark chrome with a `.no-record` class convention; the recorder hides anything carrying it.
- `render-video.js` injects CSS hiding common chrome class names (`.progress .counter .phases .replay .masthead .footer .no-record [data-role="chrome"]`) via `addInitScript`, so it survives reloads.
- Pass `--keep-chrome` when you want the raw HTML with controls.

## 10. Warmup frames leaking into the recording

**Symptom:** the first few seconds of the export show "mid-animation → cut → animation restarting from 0", a stuttering double-start.

**Cause:** an old flow of `goto → wait fonts → reload → wait duration` records during warmup, so the animation has already played a bit before the reload restarts it from 0.

**Fix:**
- Use **two separate contexts**: a throwaway warmup context (no `recordVideo`) that loads the URL, waits for fonts, then closes; and a fresh record context (with `recordVideo`) where the animation starts cleanly at t=0.
- ffmpeg `-ss` trims only the small Playwright startup latency (~0.3s); it cannot mask warmup frames — the source must be clean.

## 11. Do not draw fake chrome inside the frame

**Symptom:** the Stage already provides a scrubber + timecode + pause button (real chrome, hidden on export). A decorative "magazine page-number" progress bar drawn at the bottom of the canvas results in two progress bars on screen. Users read it as a bug.

**Cause:** decorative "page-number / magazine / signature strip" elements are high-frequency AI filler that collides with the real chrome.

**Fix:** ownership test for every element drawn into the canvas:

| What it is | What to do |
|---|---|
| Narrative content of a scene | Keep it |
| Global chrome (controls / debug) | Add `.no-record`, hide on export |
| Neither a scene's content nor chrome | Delete it — it is ownerless filler |

Before delivery, screenshot a static frame and ask: is there anything that looks like player UI (a horizontal progress bar, timecode, control-button shapes)? Does the same kind of information (progress / time / signature) appear twice? If so, merge it into one place (the chrome).

## 12. Recording-start offset — the `__ready` × tick × lastTick trap

**Symptom (A):** a 60s export has 2-3s of blank page at the start that `--trim` cannot remove.
**Symptom (B):** the video "doesn't start playing until 19s in" — the animation was recorded from t=5, looped back to 0, and the real opening lands in the last 5s.

**Cause:** `recordVideo` writes WebM from `newContext()`, while Babel/React/fonts take L seconds to load. Two common mistakes: setting `window.__ready` in `useEffect`/setup (before the first tick frame) → leading blank; or initializing `lastTick = performance.now()` at module top → L seconds folded into the first frame's `dt`, so `time` jumps to L → permanent lag.

**Fix:** use this starter tick template for hand-written animations:

```js
let time = 0
let playing = false   // do not play until fonts are ready
let lastTick = null   // sentinel — first frame's dt is forced to 0 (never performance.now())
const fired = new Set()

function tick(now) {
  if (lastTick === null) {
    lastTick = now
    window.__ready = true   // pair: "recording start" with "animation t=0", same frame
    render(0)
    requestAnimationFrame(tick)
    return
  }
  const dt = (now - lastTick) / 1000
  lastTick = now
  if (playing) {
    let t = time + dt
    if (t >= DURATION) {
      t = window.__recording ? DURATION - 0.001 : 0   // no loop while recording
      if (!window.__recording) fired.clear()
    }
    time = t
    render(time)
  }
  requestAnimationFrame(tick)
}

document.fonts.ready.then(() => {
  render(0)
  playing = true
  requestAnimationFrame(tick)
})

window.__seek = (t) => { fired.clear(); time = t; lastTick = null; render(t) }
```

Recorder-side defenses: inject `window.__recording = true` via `addInitScript` before goto; `waitForFunction(() => window.__ready === true)` and record that offset as the ffmpeg trim; then proactively call `window.__seek(0)` as a second line of defense for HTML that does not follow the template.

Verify after export:
```bash
ffmpeg -i video.mp4 -ss 0 -vframes 1 frame-0.png
ffmpeg -i video.mp4 -ss $((DURATION-1)) -vframes 1 frame-end.png
```
Frame 0 must be the animation's initial state; the last frame must be its final state, not a second-loop moment.

## 13. No looping while recording — the `window.__recording` signal

**Symptom:** the Stage defaults to `loop=true` (handy in the browser). The recorder waits `duration + 300ms` before stopping; that buffer lets the Stage enter the next loop, so the video's last 0.5-1s snaps back to Scene 1.

**Cause:** no handshake telling the HTML "you are being recorded", so it keeps looping as in interactive use.

**Fix:**
1. Recorder injects `window.__recording = true` (before goto):
   ```js
   await recordCtx.addInitScript(() => { window.__recording = true })
   ```
2. Stage reads it and forces `loop=false`:
   ```js
   const effectiveLoop = (typeof window !== 'undefined' && window.__recording) ? false : loop
   if (next >= duration) return effectiveLoop ? 0 : duration - 0.001
   ```
3. The final sprite should use `fadeOut={0}` when recording, so the video ends on a clear final frame instead of fading to transparent.

## 14. 60fps via frame duplication — minterpolate compatibility

**Symptom:** a 60fps MP4 produced with `minterpolate=fps=60:mi_mode=mci...` will not open in some macOS QuickTime/Safari versions (black or refused). VLC and Chrome open it fine.

**Cause:** minterpolate's H.264 elementary stream carries SEI/SPS fields some players mishandle.

**Fix:**
- Default to a simple `fps=60` filter (frame duplication) for broad compatibility.
- Enable interpolation explicitly with a `--minterpolate` flag only after testing the target player locally.
- Add `-profile:v high -level 4.0` for better H.264 compatibility. For CSS animation, perceived smoothness gain from true interpolation is marginal.

## 15. `file://` + external `.jsx` CORS trap — inline the engine for single-file delivery

**Symptom:** an HTML using `<script type="text/babel" src="animations.jsx">` opened by double-click (`file://`) goes black. Chrome logs a CORS error ("Cross origin requests are only supported for protocol schemes: http, https, ...") but no `pageerror`, so it looks like "the animation never triggered".

**Cause:** Babel Standalone fetches the external `.jsx` over XHR, which `file://` forbids.

**Fix:**
- Single-file delivery (double-click to run) → inline the engine inside `<script type="text/babel">...</script>`. Do not use `src="..."`.
- Multi-file project (served over HTTP) → external loading is fine; document the `python3 -m http.server 8000` command on delivery.
- Minimal check: double-click the HTML (no server). It passes only if the first frame shows.

## 16. Cross-scene inverted contexts — do not hardcode colors on shared elements

**Symptom:** elements that appear across all scenes (chapter label, scene number, watermark) hardcode `color: #1A1A1A`. They are visible on the first light scenes but vanish on a later dark scene. No error, no warning — the information is just invisible.

**Cause:** a fixed dark color on an element reused over backgrounds of varying lightness.

**Fix:**
- Forbid hardcoded color values on elements reused across multiple scenes (chapter labels, scene numbers, timecode, watermark).
- Use one of: `color: currentColor` inherited from a per-scene container; an explicit `invert` prop on the component; or a contrast-based computed color from the scene background.
- This pitfall has no automatic alarm — before delivery, capture a representative frame of each scene and eyeball every cross-scene element for visibility.

## Pre-flight checklist (5 seconds before starting)

- [ ] Every `position: absolute` parent has `position: relative`?
- [ ] Special characters (`␣ ⌘`, emoji) all exist in the font?
- [ ] Grid/flex column count matches the JS data length?
- [ ] Scene cuts cross-fade, with no blank > 0.3s?
- [ ] DOM measurement wrapped in `document.fonts.ready.then()`?
- [ ] `render(t)` is pure, or has an explicit reset?
- [ ] Frame 0 is the complete initial state, not blank?
- [ ] No fake chrome (progress bar / timecode / signature strip) colliding with the real scrubber?
- [ ] Tick sets `window.__ready = true` on its first frame?
- [ ] Stage detects `window.__recording` and forces `loop=false`?
- [ ] Final sprite `fadeOut` set to 0 so the video ends on a clear frame?
- [ ] 60fps MP4 uses frame duplication by default (interpolation only with `--minterpolate`)?
- [ ] After export, frame 0 and the last frame verified as initial/final states?
- [ ] Single-file HTML: the engine is inlined, not `src="..."`?
- [ ] Cross-scene elements have no hardcoded color, visible on every scene background?
