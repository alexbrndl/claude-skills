<!-- Scoring rubric adapted from huashu-design (MIT); UX rules from ui-ux-pro-max-skill (MIT) — see CREDITS.md -->

# Scoring Rubric & UX Rules

Use this for Assessment B (free design judgment). Score the five dimensions 1–10, then sanity-check against the curated UX rules.

## Five-dimension scoring rubric

Score each dimension on its band. An overall score is the weighted feel, not a strict average; weight by the scene emphasis table below.

### 1. Philosophy alignment
Does the design embody the chosen direction/philosophy in every detail, or just imitate it on the surface?

| Score | Band |
|---|---|
| 9–10 | Perfectly embodies the chosen philosophy; every detail has a rationale |
| 7–8 | Right direction, core traits present, a few details drift |
| 5–6 | Intent visible but mixed with other styles; not pure |
| 3–4 | Surface imitation only; the philosophy's core is not understood |
| 1–2 | Essentially unrelated to the chosen philosophy |

Check: signature techniques of the named designer/system present? Color, type, layout consistent with it? Any self-contradicting element (e.g. Kenya Hara minimalism but the page is packed)?

### 2. Visual hierarchy
Does the eye flow where the designer intended, with zero friction reaching the key information?

| Score | Band |
|---|---|
| 9–10 | Eye flows naturally along intent; information acquired frictionlessly |
| 7–8 | Clear primary/secondary order; 1–2 ambiguous spots |
| 5–6 | Title vs body separable, but middle levels muddled |
| 3–4 | Information laid out flat; no clear visual entry point |
| 1–2 | Chaotic; the user doesn't know where to look first |

Check: heading/body size contrast ≥ 2.5×? 3–4 clear levels via color/weight/size? Whitespace guiding the eye? Squint test: still clear with eyes narrowed?

### 3. Craft quality
Pixel-level precision: alignment, spacing, color.

| Score | Band |
|---|---|
| 9–10 | Pixel-precise; alignment, spacing, color flawless |
| 7–8 | Polished overall; 1–2 tiny alignment/spacing issues |
| 5–6 | Roughly aligned; spacing inconsistent, color not systematic |
| 3–4 | Obvious alignment errors, messy spacing, too many colors |
| 1–2 | Rough; looks like a draft |

Check: one spacing system (e.g. 8pt grid)? Same-type elements spaced consistently? Color count controlled (≤ 3–4)? Font families ≤ 2? Edges precisely aligned?

### 4. Functionality
Does every element serve the goal? Zero redundancy.

| Score | Band |
|---|---|
| 9–10 | Every element serves the goal; zero redundancy |
| 7–8 | Clearly function-led; a little removable decoration |
| 5–6 | Usable, but decorative elements clearly distract |
| 3–4 | Form over function; the user has to hunt for information |
| 1–2 | Drowned in decoration; fails to communicate |

Check: removing any element makes it worse (else remove it)? CTA/key info in the most prominent spot? Any "added because it looks nice" element? Information density matched to the medium?

### 5. Originality
Fresh within the chosen framework, not template-by-numbers.

| Score | Band |
|---|---|
| 9–10 | Genuinely fresh; a unique expression within the philosophy |
| 7–8 | Has its own ideas; not a plain template fill-in |
| 5–6 | Conventional; looks like a template |
| 3–4 | Heavy cliché use (gradient orb = AI, etc.) |
| 1–2 | Pure template / asset mash-up |

Check: avoids the common clichés (see ai-tells.md)? Personal expression while respecting the philosophy? Any "unexpected but right" decisions?

### Overall band
8.0+ excellent · 6.0–7.9 good · 4.0–5.9 needs work · < 4.0 failing.

### Scene emphasis (weight dimensions by output type)

| Scene | Most important | Secondary | Can relax |
|---|---|---|---|
| Cover / hero image | Originality, hierarchy | Philosophy | Functionality |
| Infographic | Functionality, hierarchy | Craft | Originality (accuracy first) |
| Slides (PPT/Keynote) | Hierarchy, functionality | Craft | Originality (clarity first) |
| PDF / whitepaper | Craft, functionality | Hierarchy | Originality (professional first) |
| Landing page / site | Functionality, hierarchy | Originality | — (full bar) |
| App UI | Functionality, craft | Hierarchy | Philosophy (usability first) |

## Curated UX rules

Spot-checks across accessibility, forms, animation, interaction. Severity in parentheses. Map each violation to a P-level in synthesis.

### Accessibility
- Color contrast: body ≥ 4.5:1; `#333` on white (7:1) good, `#999` on white (2.8:1) fails (High).
- Don't convey meaning by color alone: pair red/green with an icon or text (High).
- Alt text: descriptive `alt` on meaningful images; not `alt=""` for content images (High).
- Heading hierarchy: sequential h1→h2→h3, never skip levels for styling (Medium).
- ARIA labels: icon-only buttons need `aria-label` (High).
- Keyboard navigation: tab order matches visual order; no traps, no unreachable elements (High).
- Semantic HTML: `<nav> <main> <article>`, not div soup (Medium).
- Error messages announced: `role="alert"` / `aria-live`, not visual-only (High).
- Skip links: "skip to main content" on nav-heavy pages (Medium).
- Motion sensitivity: respect `prefers-reduced-motion`; don't force parallax/scroll-jacking (High).

### Focus, touch & interaction
- Focus states: visible focus ring on interactive elements; never `outline: none` without a replacement (High).
- Touch target size: minimum 44×44px (High).
- Touch spacing: ≥ 8px gap between adjacent targets (Medium).
- Hover vs tap: don't rely on hover for important actions on touch devices (High).
- Active states: immediate feedback on press (e.g. `active:scale-95`) (Medium).
- Disabled states: reduced opacity + `cursor-not-allowed`, visually distinct (Medium).
- Loading buttons: disable + spinner during async to prevent double submit (High).
- Tap delay: `touch-action: manipulation` to kill the 300ms delay (Medium).

### Forms
- Input labels: visible `<label>` above/beside every input; placeholder is not a label (High).
- Error placement: error below the related input, not all errors at the top (Medium).
- Inline validation: validate on blur, not only on submit (Medium).
- Input types: use `type="email"`/`tel`/`number`/`url`, plus `inputmode` on mobile (Medium).
- Required indicators: mark required fields clearly (Medium).
- Password visibility: provide a show/hide toggle (Medium).
- Submit feedback: loading → success/error state after submit (High).
- Autofill: correct `autocomplete` attributes; don't blanket `autocomplete="off"` (Medium).

### Animation & feedback
- Excessive motion: animate 1–2 key elements per view max (High).
- Duration: 150–300ms for micro-interactions; avoid > 500ms for UI (Medium).
- Reduced motion: check `prefers-reduced-motion` (High).
- Transform performance: animate `transform`/`opacity`, not `width`/`height`/`top`/`left` (Medium).
- Easing: ease-out for entering, ease-in for exiting; never linear for UI (Low).
- Loading indicators: skeleton/spinner for operations > 300ms (High).
- Empty states: helpful message + action, not blank space (Medium).
- Error recovery: clear next steps (e.g. a "Try again" button) (Medium).
