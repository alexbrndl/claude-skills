<!-- Derived from impeccable (Apache 2.0) — see CREDITS.md -->

# Anti-Patterns Checklist

The ~36 rules from impeccable's detector registry, as a manual checklist. Each item: `id` — name, what it is, and how to detect it by hand (reading code or looking at the page).

> Deterministic detection available via `npx impeccable detect <file|url>` (external tool, optional). When the tool is present, run it for exact counts and file locations; otherwise walk this list manually. Exit code 0 = clean, 2 = findings.

## Slop — tells that something was AI-generated

- **`side-tab` — Side-tab accent border.** Thick colored border on one side of a card; the most recognizable AI tell. Detect: grep `border-left` / `border-right` > 1px with a colored value.
- **`border-accent-on-rounded` — Border accent on rounded element.** Thick accent border on a rounded card; the border clashes with the corners. Detect: colored thick border + `border-radius` on the same element.
- **`overused-font` — Overused font.** Inter, Roboto, Fraunces, Geist, Plus Jakarta Sans, Space Grotesk. Detect: read `font-family` declarations.
- **`single-font` — Single font for everything.** One family for the whole page. Detect: only one distinct `font-family` in the CSS.
- **`flat-type-hierarchy` — Flat type hierarchy.** Sizes too close; no hierarchy (aim ≥ 1.25 ratio). Detect: compare computed `font-size` across heading/body.
- **`gradient-text` — Gradient text.** Decorative `background-clip: text` + gradient, esp. on headings/metrics. Detect: grep `background-clip: text` / `-webkit-background-clip`.
- **`ai-color-palette` — AI color palette.** Purple/violet gradients and cyan-on-dark. Detect: inspect gradient stops and accent hues.
- **`cream-palette` — Cream / beige palette.** Warm cream/beige page background reached for by reflex. Detect: body bg in the warm near-white band (L 0.84–0.97, low chroma, hue 40–100).
- **`nested-cards` — Nested cards.** Cards inside cards; visual noise. Detect: a bordered/elevated container inside another.
- **`monotonous-spacing` — Monotonous spacing.** The same spacing value everywhere; no rhythm. Detect: identical gap/margin across all sections.
- **`bounce-easing` — Bounce or elastic easing.** Dated, tacky. Detect: grep `bounce` / `elastic` / spring-overshoot easing.
- **`dark-glow` — Dark mode with glowing accents.** Dark bg + colored `box-shadow` glows. Detect: dark surface + saturated colored shadow.
- **`icon-tile-stack` — Icon tile stacked above heading.** Small rounded-square icon container above every heading; the universal feature-card template. Detect: repeated icon-box-then-heading shape.
- **`italic-serif-display` — Italic serif display headline.** Oversized italic Fraunces/Recoleta/Playfair/Newsreader as the hero. Detect: hero `h1` with italic serif at display size. (Editorial register may legitimately want this.)
- **`hero-eyebrow-chip` — Hero eyebrow / pill chip.** Tiny uppercase tracked label or pill chip immediately above an oversized hero headline. Detect: small `uppercase tracking` element above the hero `h1`.
- **`repeated-section-kickers` — Repeated section kicker labels** (advisory). Tiny uppercase tracked labels above section headings turning the page into editorial scaffolding. Detect: count eyebrows across sections.
- **`numbered-section-markers` — Numbered section markers (01 / 02 / 03)** (advisory). Numbered display markers as section labels. Detect: `01`/`02`/`03` above headings without a real sequence.
- **`em-dash-overuse` — Em-dash overuse.** More than two em-dashes (`—` or `--`) in body copy. Detect: grep the visible text for `—` / `--`.
- **`marketing-buzzword` — Marketing buzzword.** streamline / empower / supercharge / world-class / enterprise-grade / next-generation / cutting-edge. Detect: grep copy strings.
- **`aphoristic-cadence` — Aphoristic-cadence copy.** 3+ sections landing on a short rebuttal ("X. No Y." / "Not a feature. A platform."). Detect: read section copy endings.
- **`oversized-h1` — Oversized hero headline.** A full-sentence headline at display size dominating the viewport. Detect: long `h1` text + display `font-size`.
- **`extreme-negative-tracking` — Crushed letter spacing.** Tracking past the point characters keep their shape. Detect: computed `letter-spacing` tighter than ~-0.04em on display type.
- **`broken-image` — Broken or placeholder image** (quality). `<img>` with empty/missing/placeholder `src`. Detect: grep `src=""`, missing `src`, placeholder strings.

## Quality — general design & accessibility

- **`gray-on-color` — Gray text on colored background.** Washed out; use a darker shade of the bg color or near-white. Detect: gray text color over a colored surface.
- **`low-contrast` — Low contrast text.** Below WCAG AA (4.5:1 body, 3:1 large). Detect: DevTools/axe contrast readout.
- **`layout-transition` — Layout property animation.** Animating width/height/padding/margin → jank. Detect: `transition` / keyframes targeting layout props.
- **`line-length` — Line length too long.** Lines wider than ~80 chars. Detect: text container without a 65–75ch `max-width`.
- **`cramped-padding` — Cramped padding.** Text too close to a container edge (own padding too low, or children flush against a visible boundary). Detect: < 8px padding inside bordered/colored containers.
- **`body-text-viewport-edge` — Body text touching viewport edge.** Paragraphs flush against the left/right edge, no container padding. Detect: top-level text with no horizontal padding / `max-width` + `mx-auto`.
- **`tight-leading` — Tight line height.** `line-height` below 1.3× the font size. Detect: computed line-height ÷ font-size.
- **`skipped-heading` — Skipped heading level.** h1 then h3 with no h2. Detect: read the heading outline.
- **`justified-text` — Justified text.** `text-align: justify` without hyphenation → rivers of white. Detect: grep `justify`.
- **`tiny-text` — Tiny body text.** Below 12px (use ≥ 14px, ideally 16px). Detect: computed `font-size` on body.
- **`all-caps-body` — All-caps body text.** Long passages in uppercase. Detect: `text-transform: uppercase` on body-length text.
- **`wide-tracking` — Wide letter spacing on body text.** `letter-spacing` above 0.05em on body. Detect: computed letter-spacing on paragraphs.
- **`text-overflow` — Content overflowing its container.** Spills out or forces a horizontal scrollbar. Detect: element wider than parent / page has horizontal scroll.
- **`clipped-overflow-container` — Positioned child clipped by overflow container.** `overflow: hidden`/`clip` wrapping an absolutely-positioned tooltip/menu/popover. Detect: clipping container around a positioned layer.

## Provider tells (gated off by default — enable with `--gpt` / `--gemini`)

- **`gpt-thin-border-wide-shadow` — Hairline border with wide shadow** (gpt, advisory). 1px border + wide diffuse shadow on the same element. Detect: `border: 1px` + `box-shadow` blur ≥ 16px together.
- **`repeating-stripes-gradient` — Repeating-gradient stripes** (gpt, advisory). `repeating-linear-gradient` as surface decoration. Detect: grep `repeating-linear-gradient` in backgrounds.
- **`theater-slop-phrase` — Theater framing copy** (gpt, advisory). Dismissing something as "theater". Detect: grep `theater`.
- **`image-hover-transform` — Image hover transform** (gemini, advisory). Scaling/rotating an `<img>` on hover (incl. Tailwind `group-hover:scale` on a child image). Detect: `:hover` transform on images.
