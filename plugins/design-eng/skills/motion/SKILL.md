---
name: motion
description: Use when adding, reviewing, or debugging animations and transitions (CSS, Vue Transition, GSAP, scroll-driven effects), or when exporting an HTML animation as a clean MP4 demo. Not for choosing the overall visual direction (use design-direction).
---

# Motion

## Overview

Animation craft: easing, scroll choreography, reduced-motion, and exporting a clean demo video. This skill is about *how* motion is built and debugged, not *whether* a surface should move — that decision belongs to design-direction's `MOTION_INTENSITY` dial. Every animation here must be motivated: it communicates hierarchy, sequence, feedback, or a state change. "It looked cool" is not a reason.

## 1. Core rules

- **Animate only `transform` and `opacity`.** Never animate `top`, `left`, `width`, `height` — they trigger layout and repaint every frame. Use `will-change: transform` sparingly, only on elements that actually animate.
- **`prefers-reduced-motion` is mandatory.** Any non-trivial motion must honor it. In CSS, gate behind `@media (prefers-reduced-motion: no-preference)` or disable in a `reduce` block. In React/Motion, branch on `useReducedMotion()`. Infinite loops, parallax, scroll-hijack, and magnetic physics must collapse to static/instant.
- **Never use scroll event listeners.** `window.addEventListener('scroll', ...)` and `window.scrollY`-driven state are banned — they run every frame with no batching. Use IntersectionObserver, CSS `animation-timeline: view()`, or GSAP ScrollTrigger. See §4.
- **Durations:** before choosing any value, read `references/timing.md`. It carries the named ladder (`duration-instant` 50ms to `duration-deliberate` 600ms), the stagger window, the waiting states and the gesture thresholds. The bands are 150-300ms for UI micro-interactions (hover, toggle, swap); 400-800ms for scene-level reveals and transitions. Slower than that reads as sluggish; faster than ~120ms reads as a flicker.
- **Easings:** use standard curves. A good default is `cubic-bezier(0.16, 1, 0.3, 1)` (ease-out, decisive entry). Use `ease-out` for elements entering, `ease-in` for leaving, `ease-in-out` for movement that starts and ends on screen. Springs (`stiffness ~100, damping ~20`) for physical/playful feel — never linear easing on UI.

## 2. Pure render principle

A robust animation's visual state is a **pure function of time**: `render(t)` always produces the same DOM for a given `t`. State must not hide in elapsed timers or one-shot `setTimeout` chains.

This is the prerequisite for two things: **debugging** by scrubbing to any moment, and **clean video export** (the recorder seeks and resets). When a side effect is unavoidable (toggling a class), track it in a `fired` set with an explicit `reset()`, and expose `window.__seek(t)` that resets then renders. The full starter tick template is in `references/pitfalls.md` (recording-start offset). Treat the pure-render shape as the default for any hand-written timeline animation.

## 3. Debugging

When an animation misbehaves — drifting elements, blank gaps between scenes, glyphs not rendering, layout that jumps once fonts load, a recording that starts mid-animation — go to **`references/pitfalls.md`**. It is 16 real failures written as symptom / cause / fix, including: `position: absolute` without a `position: relative` ancestor; rare Unicode glyphs the font cannot render; hardcoded `grid-template-columns` vs data-driven N; scene-transition cross-fades; measuring before `document.fonts.ready`; and the pure-render/seekable principle. Match the symptom, apply the fix.

## 4. Scroll-driven motion

For pinned sections, horizontal pans, scroll reveals, and simultaneous swaps, use the canonical skeletons in **`references/scroll-patterns.md`**. It carries three flavors:

- **GSAP + ScrollTrigger** — sticky-stack and horizontal-pan, each with `gsap.context().revert()` cleanup and a reduced-motion bail-out. Plus a lighter `whileInView` scroll-reveal stagger.
- **No library** — IntersectionObserver reveal and CSS `animation-timeline: view()`, both reduced-motion-gated.
- **Vue** — `<Transition>` with `position: absolute` on the leaving element so swaps cross-fade simultaneously (not `mode="out-in"`).

Pin failures almost always trace to the trigger start: use `start: "top top"`, not `"top center"` or `"top 80%"`.

## 5. Export a demo video

To turn a self-contained HTML animation into a clean MP4, use **`scripts/render-video.js`** (Playwright + ffmpeg).

```bash
NODE_PATH=$(npm root -g) node scripts/render-video.js my-animation.html \
  --duration=30 --width=1920 --height=1080
```

Requirements:
- Global Playwright (`npm install -g playwright`) and `ffmpeg` on PATH.
- The HTML must signal readiness: set `window.__ready = true` on the animation tick's first frame (the starter template in `references/pitfalls.md` does this). Without it the script falls back to a font-wait timer and may leave blank frames or start mid-animation.
- Mark debug chrome (progress bar, replay button, counters) with `.no-record` so it is hidden from the export; pass `--keep-chrome` to keep it.

The script runs a throwaway warmup context, then a fresh record context where the animation starts at t=0, waits for `window.__ready`, optionally calls `window.__seek(0)` to correct timing, records the full duration, and ffmpeg-trims the startup latency into an H.264 MP4 next to the source file. Verify the result by extracting frame 0 and the last frame — they must be the animation's initial and final states.

## When NOT to use

- **Choosing the overall visual direction** (aesthetic, dials, palette, type, how much the surface should move) → use **design-direction**. This skill implements and debugs motion; it does not pick the direction.
- **Critiquing a finished UI** for AI-tells, accessibility, or polish → use **design-review**.
