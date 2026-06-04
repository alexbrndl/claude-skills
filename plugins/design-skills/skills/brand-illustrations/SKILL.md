---
name: brand-illustrations
description: Use when generating a series of illustrations or brand visuals that must stay visually consistent across images, or when defining a reusable illustration style (style DNA) for a product, blog, or doc.
---

# Brand illustrations

Generate a set of illustrations that read as one visual language. The hard part is not drawing one good image, it is keeping 4-9 images consistent in style, color meaning, and density. Consistency comes from a written art-direction document (the **style DNA**) that every image is generated against, not from prompting each image fresh.

This skill is tool-agnostic: it works with any image generation model. It produces raster illustrations, not editable vectors.

## 1. Style DNA first

Before generating anything, create or load the style DNA: a separate art-direction document, one per product/blog/series, reused for every image.

- Use `references/style-dna-template.md` as the structure. It covers visual rules (rendering style, line quality, whitespace minimum, canvas ratio), the semantic color code, must/never lists, and an optional recurring element.
- **Ground it on the brand's real assets when they exist.** If the illustrations represent a real brand or product, find and use the actual logo, product renders, UI screenshots, and brand palette before inventing a look. A brand is recognized by its assets first, its color values last. Do not substitute a generic style or a hand-drawn silhouette for a real product image: that produces a "generic tech illustration" that any brand could have. If you cannot find the assets, ask the user for them rather than filling with generic placeholders.
- The semantic color code is the backbone of consistency: each color carries exactly one fixed role (structure / flow / alert / secondary state) across the whole series, never two.

If a style DNA already exists for this surface, load it and follow it. Do not silently invent a competing one.

## 2. Workflow

1. **Digest the content.** Read the article, doc, or brief. Extract the core ideas and the cognitive anchors: key judgments, before/after contrasts, input→output loops, branch points, role/state changes. Do not illustrate evenly; illustrate the anchors.
2. **Shot list.** One concept = one image. For each shot write: where it goes, theme, core idea, structure type, what the recurring element does, suggested objects, suggested labels. Default 4-8 images; 1-3 for short content; rarely more than 9. Enough to carry the meaning, not a picture book.
3. **Generate one image at a time.** Use the prompt pattern in `references/prompt-template.md` — a fixed block from the style DNA plus the per-image variable slots. Never pack several illustrations into one prompt.
4. **QA each image** (see §4) before moving on.
5. **Iterate** with a surgical edit when possible, a regeneration only when the concept itself fails.

## 3. Metaphor method

Each image needs its own metaphor invented from the current content. Three steps:

1. Turn the abstract concept into a **physical action**: get stuck, leak, pile up, sort, ferment, unfold, unpack, reroute.
2. Turn the system or structure into a **low-tech object**: a broken machine, a box, a drawer, a pipe, a mailbox, a scale, a well, a ladder, an odd workstation. Use one or two, never a pile.
3. Make the recurring element (if any) **perform that action** — wedged in the machine, holding the gate, carrying, patching, weighing — not standing beside it.

**Anti-copy rule:** never re-copy a metaphor already produced in this series. Same topic, new metaphor every time. If "handoff path" was a winding road in image 2, make it something else in image 6 (e.g. hooking a tail onto a door handle). Reusing a metaphor is the fastest way to make a series look like clip art.

## 4. QA

Two binary tests plus a compliance check, run on every image:

- **Remove-the-central-element test.** Mentally delete the main subject (or the recurring element). If the meaning still fully survives without it, that element was decorative → regenerate so it carries the core action. The subject must be load-bearing.
- **Semantic color code compliance.** Every color used must match its one assigned role from the style DNA, and the whitespace minimum and annotation budget must hold. Off-role color or an overcrowded canvas → fix.
- **Surgical edit over full regeneration.** When only one thing is wrong (a stray corner title, one wrong label, one off element), use the surgical edit prompt from `references/prompt-template.md`: remove only X, fill with the same background, preserve everything else exactly. This keeps the rest of the series pixel-stable. Regenerate only when the metaphor or composition itself is wrong.

Reject corner titles naming the diagram type, formal flowchart/slide looks, dense explainers, busy backgrounds, and anything off-palette.

## When NOT to use

- **One-shot illustrations** with no consistency requirement. The whole apparatus (style DNA, semantic color code, anti-copy rule) exists to keep a *series* coherent. For a single standalone image it is overhead.
- **Precise, editable vector art** (icons, logos, diagrams that must be tweaked later). This skill produces raster output from generative tools. Work directly in SVG or Figma instead.
- **Choosing the overall product visual direction** (aesthetic, type, layout system) → that is a design-direction decision, not an illustration-series one.
