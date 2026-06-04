<!-- Method adapted from ian-xiaohei-illustrations (MIT) — see CREDITS.md -->

# Prompt template

One prompt = one image. Never ask for several illustrations in a single prompt. The prompt is a **fixed block** (copied verbatim from the style DNA so every image shares it) plus a small set of **variable slots** filled per image. Works with any image generation tool.

## Generation prompt

Fill the `{...}` slots from the shot list; leave the fixed block unchanged across the whole series.

```text
Generate one standalone {canvas_ratio} illustration.

Visual DNA:
{Paste the Visual rules block from the style DNA verbatim: rendering style, line
quality, whitespace minimum, background, annotation budget. Include every
"Never" item as a negative instruction (no gradients, no shadows, no PPT look,
no corner title, etc.).}

Recurring element (if the DNA defines one):
{Paste the recurring element definition verbatim. State that it must perform the
core action, not decorate the scene.}

Theme:
{theme}

Structure type:
{structure_type}

Core idea:
{core_idea}

Composition:
{composition: where the recurring element is, what it is doing, the main object,
how information flows left-to-right or A-to-B}

Color use:
{Paste the semantic color code verbatim: one fixed role per color.}

Constraints:
One image explains only one core idea. Keep the main subject around 40-60% of the
canvas and preserve the whitespace minimum. Use at most {N} short labels. Do not
write a title naming the diagram type. Do not make it a formal diagram or slide.
Invent a fresh metaphor for this specific content; do not reuse a metaphor already
produced in this series. Clear but not instructional, interesting but not childish.
```

## Surgical edit prompt

Prefer editing one element over regenerating the whole image, so the rest of the series stays pixel-stable. The pattern is a tight remove-and-fill instruction with an explicit preserve-everything clause:

```text
Edit the provided image. Remove only {X} (e.g. the corner title and its underline).
Fill that area with the same background, matching the surrounding {background}.
Preserve everything else exactly: the recurring element, labels, paths, line style,
composition, aspect ratio, and image quality. Do not add any new text or objects.
```

For a content change rather than a removal, keep the same shape: name the single change, then "Preserve everything else exactly."
