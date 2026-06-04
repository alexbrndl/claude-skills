<!-- Derived from impeccable (Apache 2.0) — see CREDITS.md -->

# Numeric Thresholds

Hard numbers to check against the code or the rendered page. Each row gives the exact value and how to verify it. Anything outside the band is a finding.

## Color & contrast

| Threshold | Exact value | How to verify |
|---|---|---|
| Body text contrast | ≥ 4.5:1 against its background (WCAG AA) | DevTools color picker shows the contrast ratio next to the color swatch; or run an axe / Lighthouse audit. The common failure is muted gray body text on a tinted near-white |
| Large / UI text contrast | ≥ 3:1 for text ≥ 18px (or bold ≥ 14px) and for UI component boundaries | Same DevTools contrast readout; confirm the size that qualifies as "large" |
| Placeholder text contrast | ≥ 4.5:1 (same as body, not the muted-gray default) | DevTools contrast on the placeholder pseudo-element |
| Gray on color | Avoid gray text on a colored background; use a darker shade of the background's own hue, or a transparency of the text color | Inspect computed color vs background; check it is not a neutral gray |

## Typography

| Threshold | Exact value | How to verify |
|---|---|---|
| Body line length | 65–75ch | Inspect the text container's `max-width`; expect a `ch` cap or equivalent (`max-w-prose` ≈ 65ch). Count characters on a full line if no cap |
| Type scale ratio | ≥ 1.25 between adjacent steps | Read computed `font-size` of heading vs body in DevTools; divide. Flat scales (ratio < 1.25) are a finding |
| Font-family count | ≤ 3 (display + body + optional mono) | Search the CSS for distinct `font-family` declarations |
| Hero / display heading ceiling | `clamp()` max ≤ 6rem (~96px) | Inspect the rendered `font-size` at a wide viewport; resolve the `clamp()` max. 8–11rem is shouting |
| Display tracking floor | `letter-spacing` ≥ -0.04em (not tighter) | Inspect computed `letter-spacing` on display headings. -0.05 to -0.085em makes letters touch |
| Line height (body) | 1.5–1.7 (never below 1.3) | Computed `line-height` ÷ `font-size` |
| Wide tracking on body | ≤ 0.05em (reserve wide tracking for short uppercase labels) | Computed `letter-spacing` on body text |
| Text balancing | `text-wrap: balance` on h1–h3; `text-wrap: pretty` on long prose | Search CSS / inspect the computed property on headings |

## Layout

| Threshold | Exact value | How to verify |
|---|---|---|
| Z-index scale | Semantic ramp: dropdown → sticky → modal-backdrop → modal → toast → tooltip. Never arbitrary `999` / `9999` | Grep the CSS for `z-index`; flag any magic large numbers |
| Responsive grid (no breakpoints) | `repeat(auto-fit, minmax(280px, 1fr))` | Inspect `grid-template-columns` |
| Container horizontal padding | ≥ 16px (ideally 24–32px); body text must not touch the viewport edge | Inspect the page container's padding / `max-width` + `mx-auto` |
| Container padding (bordered/colored) | ≥ 8px, ideally 12–16px inside bordered, outlined, or colored containers | Inspect `padding` on the element vs its boundary |
| Viewport height | Use `dvh` / `min-h-[100dvh]`, never `100vh` / `h-screen` for full-height sections | Search for `100vh` / `h-screen` |

## Motion

| Threshold | Exact value | How to verify |
|---|---|---|
| Reduced motion | Every animation has a `@media (prefers-reduced-motion: reduce)` alternative (crossfade or instant) | Grep CSS for the media query; toggle "Emulate prefers-reduced-motion" in DevTools rendering panel |
| Animated properties | Only `transform` and `opacity` (not `width`/`height`/`top`/`left`/`padding`/`margin`) | Inspect `transition` / keyframe targets; layout-property animation is a finding |
| Easing | Ease-out exponential (quart/quint/expo). No bounce, no elastic | Inspect the `cubic-bezier` / easing token |
| Micro-interaction duration | 150–300ms; UI transitions ≤ 500ms | Inspect `transition-duration` |
