---
name: design-review
description: Use when reviewing or critiquing an existing UI (code, screenshot, or live page) for visual quality, AI-generated look, accessibility, or polish before shipping. Not for starting a new design (use design-direction) or animation issues (use motion).
---

# Design Review

## Overview

Critique an existing UI by running **two independent assessments, then synthesizing**. Assessment A is a deterministic checklist (mechanical, repeatable). Assessment B is free design judgment (a director's eye). Keep them isolated: form your design opinion in B *before* you read A's findings, so the checklist doesn't anchor your taste. Only after both are done do you merge them into one ranked report.

If sub-agents are available, run A and B in parallel agents that cannot see each other's output. Otherwise run them sequentially: record A, then do B without re-reading A, then synthesize.

Resolve the target first to a concrete thing: a source file path, a screenshot, or a live URL. Prefer a source path over a dev-server URL when both point at the same surface.

## Assessment A — Deterministic checklist

Run these three references against the code/screenshot, in order. Load each only when you reach it.

1. **`references/ai-tells.md`** — the banned AI signatures (palettes, eyebrows, fake screenshots, decoration). Walk the table; record every hit with its severity.
2. **`references/thresholds.md`** — the numeric checks (contrast ratios, line length, type scale, hero clamp, tracking floor, z-index). Verify each with DevTools or by reading the computed values.
3. **`references/antipatterns.md`** — the ~36 detector rules. Walk the list manually.

If the `impeccable` CLI is available, run `npx impeccable detect <file|url>` for deterministic counts and file locations, and fold its hits into the list (exit 0 = clean, 2 = findings). It is optional; never block the review on it.

Output of A: a flat list of concrete violations, each with the rule id/name, the file or element, and the severity from the reference.

## Assessment B — Design judgment

Do this **before reading A's findings**. Read the source / look at the page and react like a design director. Use **`references/scoring.md`**: score the five dimensions (philosophy alignment, visual hierarchy, craft quality, functionality, originality) 1–10 with the bands, then spot-check the curated UX rules (focus states, touch targets, form labels, reduced motion, contrast).

Judge the whole, not the parts: Does the eye flow where intended (squint test)? Is there rhythm in the spacing or is everything uniform? Does it feel coherent, or like stitched-together pieces? Does it have a personality, or could you guess the palette from the category alone?

Output of B: AI-slop gut verdict, the five scores with one line each, 2–3 genuine strengths, the 3–5 issues that matter most, and the single biggest opportunity.

## Synthesis

Merge A and B into one report. Do not concatenate. Note where the checklist and your judgment **agree** (high confidence), where the checklist caught something you missed, and where a checklist hit is a **false positive** in context (e.g. an italic serif hero that the editorial brief genuinely wants).

Rank every surviving finding by severity:

- **P0 — Blocking.** Prevents the UI from working or shipping: unreadable contrast, broken images, div-based fake screenshots, AI-purple/beige-brass palette as the whole identity.
- **P1 — Must fix.** Significant quality or AI-tell problem: overused fonts, eyebrow-on-every-section, gradient text, missing focus states, sub-44px touch targets.
- **P2 — Improvement.** Real but with a workaround: monotonous spacing, decorative dots, middle-dot overuse.
- **P3 — Nitpick.** Polish, no real user impact.

Each finding = **file/element + the problem + a concrete fix**. "The submit button," not "some elements." Say why it matters to the user. Cut "consider exploring"; give the actual change.

## Second-order slop check

Before delivering the fixes, check that they don't fall into the obvious counter-cliché. Avoiding the first reflex but landing on the second is still a tell:

- Replacing Inter with Geist or Plus Jakarta Sans (also overused) — pick a face with real personality instead.
- Replacing beige+brass with the "editorial-typographic" default for any non-SaaS brief, or "terminal-native dark" for any non-navy fintech.
- Swapping AI-purple for AI-teal.
- Killing all motion to avoid the uniform-fade reflex, shipping a dead page.

Test: could someone guess your fix's aesthetic from "the category, plus the thing it's avoiding"? If yes, push it one step further.

## When NOT to use

- **Starting a new design** (no existing UI to critique, choosing a direction/palette/fonts from scratch) → use **design-direction**.
- **Animation problems specifically** (easing, scroll-driven motion, choreography, reduced-motion implementation) → use **motion**. This skill flags motion *tells* but does not fix motion craft.
