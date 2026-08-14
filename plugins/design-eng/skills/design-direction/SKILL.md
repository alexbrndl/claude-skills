---
name: design-direction
description: Use when starting a new design or choosing the visual direction for a screen, site, or component, before writing code or canvas work, to avoid generic AI aesthetics. Not for critiquing an existing UI (use design-review).
---

# Design Direction

## Overview

Choose a deliberate visual direction *before* writing any code or canvas work. The whole point is to escape the AI default — the centered hero over a dark mesh, AI-purple gradients, Inter + slate-900, an eyebrow over every section. Average is no longer findable; a direction reached by reflex reads as slop.

Work top to bottom: read the brief, set the dials, find real assets, pick a philosophy, choose type, query palette and style, then write a mini design brief to validate. Do not jump to a default aesthetic. If a step's reference is named, load it only when you reach it.

## 1. Brief Inference — read the room first

Before touching dials or assets, **infer what the user actually wants**. Read these signals:

- **Surface kind** — landing (SaaS / consumer / agency / event), portfolio, redesign, editorial, dashboard, app, single component.
- **Vibe words** the user used — "minimalist", "Linear-style", "Awwwards", "brutalist", "premium", "playful", "serious B2B", "editorial".
- **Reference signals** — URLs, screenshots, products or competitors they named.
- **Audience** — B2B procurement panel vs design-conscious consumer vs recruiter scanning a portfolio. The audience picks the aesthetic, not your taste.
- **Quiet constraints** — accessibility-first, public-sector, regulated, trust-first commerce, kids' products. These OVERRIDE aesthetic preference.

**Declare a one-line Design Read before anything else:**

> *"Reading this as: \<surface kind> for \<audience>, with a \<tone/register> language, leaning toward \<aesthetic family>."*

If the brief is genuinely ambiguous, ask **exactly one** clarifying question (never a multi-question dump), and only when the read truly diverges. If you can infer confidently, do not ask — declare the read and proceed.

## 2. Set the dials

After the read, set three dials. Every layout, motion, and density decision downstream is gated by them.

- **`DESIGN_VARIANCE`** — 1 = perfect symmetry, 10 = artsy chaos
- **`MOTION_INTENSITY`** — 1 = static, 10 = cinematic / physics
- **`VISUAL_DENSITY`** — 1 = art gallery / airy, 10 = cockpit / packed data

Baseline `8 / 6 / 4`. Override from the read using the table:

| Signal / product type | VARIANCE | MOTION | DENSITY |
|---|---|---|---|
| minimalist / clean / calm / editorial / Linear-style | 5-6 | 3-4 | 2-3 |
| premium consumer / Apple-y / luxury / brand | 7-8 | 5-7 | 3-4 |
| playful / Dribbble / Awwwards / experimental / agency | 9-10 | 8-10 | 3-4 |
| landing / portfolio / marketing (default) | 7-9 | 6-8 | 3-5 |
| trust-first / public-sector / regulated / a11y-critical | 3-4 | 2-3 | 4-5 |
| developer portfolio | 6 | 5 | 4 |
| editorial / blog | 6 | 4 | 3 |
| redesign — preserve | match existing | +1 | match |
| redesign — overhaul | +2 | +2 | match |

**Motion claimed = motion shown.** If `MOTION_INTENSITY > 4`, the design must actually move (hero entry, scroll-reveal, hover physics). If you can't ship working motion in scope, drop the dial to 3 and ship clean and static — never half-build motion that breaks.

## 3. Real assets first

A good hi-fi design grows from existing context. Building from nothing is the last resort and reliably produces something generic. When the task involves a concrete brand or product, run the **core assets protocol** before designing.

**Priority — assets beat specs.** A brand is recognised by, in order:

| Asset | Recognition | Required for |
|---|---|---|
| **Logo** | highest | any brand |
| **Product shots / renders** | very high | physical products |
| **UI screenshots** | very high | digital products (app / SaaS / site) |
| **Color values** | medium | supporting |
| **Fonts** | low | supporting |

Rules: extracting only color + font and skipping logo / product / UI **violates** the protocol. Hand-drawing a CSS silhouette instead of a real product shot violates it. If you can't find an asset, **stop and ask the user** — do not fill with generic CSS.

**The 5-10-2-8 rule** (for product shots / UI / reference imagery — not the logo, which you use if it exists at all):

- **5** rounds of search, across channels (official site, press kit, official social, video frame-grabs, public domain, user-supplied) — not one round and grab the first two.
- **10** candidates gathered before you start filtering.
- **2** kept — the best from the 10. Using all of them dilutes taste.
- **≥8/10** each, scored on: resolution (≥2000px), copyright clarity (official > public domain), brand-mood fit, light/composition consistency, and standalone narrative power. Below 8/10, **prefer an honest placeholder** (grey block + label) over padding. Better fewer good assets than filler.

## 4. Pick a philosophy

Load **`references/philosophies.md`**. Choose **1**, or deliberately combine **2 from different schools** for contrast. **Never a generic blend** of everything.

The 20 are grouped in five schools — Information Architecture, Motion Poetics, Minimalism, Experimental Vanguard, Eastern Philosophy. When proposing options to the user, pick across schools so the contrast is visible (e.g. a safe Müller-Brockmann grid next to a bold Active Theory WebGL world), not two siblings.

Name the philosophy by its **concrete traits and prompt DNA**, never as a style label ("in the style of Pentagram"). Use the reference's prompt-DNA blocks when briefing an image generator.

## 5. Fonts

Load **`references/fonts.md`** and run the four-step procedure: write three physical-object voice words → list your three reflex picks → reject any on the reflex-reject list → browse a real catalog → cross-check (if the pick matches the reflex, start over).

Avoid the reflex-reject fonts (Fraunces, Playfair, Inter, DM Sans, Space Grotesk, Instrument Serif…) and the saturated aesthetic lanes (editorial-typographic). Serif is very discouraged as a default — sans display is the default. Emphasis stays in the same family (italic/bold), never a foreign serif dropped into a sans headline.

## 6. Palette & style

Two data files, queried directly when you need them.

- **`references/palettes.csv`** — token-ready palettes by product type (SaaS, E-commerce, Fintech, Healthcare, Luxury Brand, AI/Chatbot, Portfolio, and ~40 more). Each row gives Primary / On Primary / Secondary / Accent / Background / Foreground / Card / Muted / Border / Destructive / Ring with WCAG-checked contrast and a Notes rationale. Find the row matching the surface, lift the hex values as design tokens.
- **`references/styles.csv`** — ~80 style recipes (Minimalism & Swiss, Glassmorphism, Brutalism, Aurora UI, Dark Mode OLED, Motion-Driven, Claymorphism…). Each row carries keywords, colors, effects, best-for / do-not-use-for, light/dark support, performance, a11y, an AI prompt, CSS/technical keywords, an implementation checklist, and design-system variables.

Cross-check against the read: the palette's `Notes` and the style's `Do Not Use For` flag mismatches. Lock **one** accent across the whole surface; do not introduce a second accent in a later section.

## 6b. Dark mode, if the surface has one

Dark mode is a second palette, not a filter over the first. Inverting the light tokens produces the two failures you see everywhere: colours that vibrate, and depth that disappears.

- **Desaturate the accent by 10 to 20%.** A hue that reads as confident on white glows on near-black, because the surrounding luminance no longer holds it back. Same hue, less saturation, and check it against the dark background rather than trusting the light-mode value.
- **Elevate with surface lightness, not with shadow.** A shadow on a dark background is invisible: there is nothing left to darken. A raised surface is a lighter surface. Build a ramp of two or three steps above the background and stop, because a fourth step lands close enough to the third that nobody reads it as a level.
- **Hold contrast at 4.5:1 for body text, 3:1 for large text and UI boundaries.** Pure white on pure black clears it and still fails, because maximum contrast on a dark surface causes halation on thin type. Take the background off pure black and the text off pure white.
- **Never a hardcoded hex in a component.** Two palettes means every colour is a token or the component only works in one mode. This is the point where the palette becomes non-negotiable, not a preference.

The `palettes.csv` rows whose `Notes` mention dark are already built this way, so lift a row rather than deriving one when a row fits.

## 7. Output — a mini design brief to validate

Before executing, write a short brief and get a nod. Do not start coding/canvas until the direction is confirmed — fixing a direction late costs far more than early.

```
Design Read: <one line from step 1>
Dials:       VARIANCE <n> / MOTION <n> / DENSITY <n>
Philosophy:  <1-2 from philosophies.md, with the trait that makes it fit>
Type:        Display <font> / Body <font> — voice words: <3 words>; scale ratio ≥1.25
Palette:     <tokens lifted from palettes.csv row "<product type>">
             --primary <hex>  --bg <hex>  --fg <hex>  --accent <hex>  --muted <hex>
Style:       <styles.csv recipe> — key effects: <…>
Spacing:     base unit <8px / 4px>, rhythm <tight groupings + generous separations>
Assets:      <logo / product / UI status — real or honest placeholder>
```

Then run the second-order slop check: could someone guess this direction from "the category, plus the thing it's avoiding"? Replacing Inter with Geist, beige+brass with editorial-typographic, AI-purple with AI-teal — those are the counter-clichés. If yes, push one step further.

## When NOT to use

- **Critiquing an existing UI** (a built screen, screenshot, or live page for AI-tells, accessibility, polish) → use **design-review**. This skill chooses a direction from scratch; it does not score finished work.
- **Animation craft specifically** (easing, scroll choreography, reduced-motion implementation) → use **motion**.
