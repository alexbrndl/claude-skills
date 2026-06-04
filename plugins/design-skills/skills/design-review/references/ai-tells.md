<!-- Derived from taste-skill (MIT) and impeccable (Apache 2.0) — see CREDITS.md -->

# AI Tells Checklist

Signatures that make a UI read as "AI made this." Each is a hard ban unless the brief explicitly calls for it. Spot them by reading code (class names, hex values, copy strings) and by looking at the rendered page.

## Color & palette tells

| Pattern | How to spot it | Severity |
|---|---|---|
| AI-purple / blue glow | Purple/violet gradients, neon outer glows, `box-shadow` with a saturated colored blur. Dark bg + glowing colored accents | P0 |
| Beige+brass premium-consumer palette | Backgrounds `#f5f1ea`, `#f7f5f1`, `#fbf8f1`, `#efeae0`, `#ece6db`, `#faf7f1`, `#e8dfcb`; accents `#b08947`, `#b6553a`, `#9a2436`, `#9c6e2a`, `#bc7c3a`, `#7d5621`; text `#1a1714`, `#1a1814`, `#1b1814`. The default "warm craft" reflex for cookware/wellness/luxury | P0 |
| Cream / sand / beige body bg | Warm-neutral near-white surface reached for by reflex. Token names `--paper`, `--cream`, `--sand`, `--bone`, `--linen`, `--parchment`, `--wheat`, `--ivory` are tells in themselves | P1 |
| Pure black `#000000` / pure white `#ffffff` | Kills depth. Use off-black (zinc-950) and off-white | P2 |
| More than one accent color drifting across the page | A warm-grey site that grows a blue CTA in section 7; a rose site with a teal footer badge | P1 |

## Typography tells

| Pattern | How to spot it | Severity |
|---|---|---|
| Overused fonts | Inter, Roboto, Fraunces, Geist, Plus Jakarta Sans, Space Grotesk as default | P1 |
| Italic serif display hero | Oversized italic Fraunces / Recoleta / Playfair / Newsreader as the hero headline | P1 |
| Single font for everything | One family, no display/body contrast | P2 |
| Flat type hierarchy | Heading/body sizes within < 1.25 ratio; nothing dominates | P1 |
| Crushed letter-spacing | Tracking tighter than -0.04em; letters touch | P2 |
| Oversized H1 | A full-sentence headline at display size, dominating the viewport | P1 |
| All-caps body copy | Paragraphs in uppercase. Reserve uppercase for ≤4-word labels | P1 |
| `<br>`-broken italicized headlines | `for thirty<br><em>years.</em>` splits as a "design move" | P2 |
| Gradient text | `background-clip: text` + gradient bg, on headings/metrics | P1 |

## Eyebrows, section markers & numbering

| Pattern | How to spot it | Severity |
|---|---|---|
| Eyebrow above every section | Small uppercase wide-tracking label (`text-[11px] uppercase tracking-[0.18em]`) on every heading. Limit: **eyebrow count ≤ ceil(sections / 3)**, hero counts as 1 | P1 |
| Numbered section markers (`01 / 02 / 03`) | `01 · About / 02 · Process / 03 · Pricing` above every section. Legit only for a real ordered sequence | P1 |
| Numbered eyebrows | `00 / INDEX`, `001 · Capabilities`, `002 · Featured commission`, `06 · how it works` | P1 |
| `01 / 4`-style pagination on images / bento tiles | If the user can count, they don't need the label | P2 |
| `Brand · No. 01` sub-eyebrows | `Marrow · No. 01 · The 6-quart` micro-meta lines | P2 |
| Range-label eyebrows | `Index of Work, 2018 - 2026` as an eyebrow | P2 |

## Decoration & separators

| Pattern | How to spot it | Severity |
|---|---|---|
| Side-stripe borders | `border-left` / `border-right` > 1px as a colored accent on cards, list items, callouts, alerts. Clashes worse on rounded corners | P0 |
| Decorative status dots | Colored dot before every nav link, list row, badge, or `ONE Q4 SLOT OPEN`. Zero by default; allowed only for real semantic state, sparingly | P1 |
| Middle-dot `·` as universal separator | `foo · bar · baz · qux`. Ration to max 1 per metadata line | P2 |
| Glassmorphism by default | Decorative blurs / frosted cards everywhere. Rare and purposeful, or none | P1 |
| Crosshair / hairline grid lines as decoration | Vertical+horizontal lines drawn just to "feel designed" | P2 |
| Vertical rotated text | `INDEX OF WORK` rotated 90°. Agency cliché | P2 |
| Decoration text strip at hero bottom | `BRAND. MOTION. SPATIAL.`, `TYPE / FORM / MOTION`, `DESIGN · BUILD · SHIP` mono-caps strip | P2 |
| `border-t` + `border-b` on every row | A 10-row spec table with a hairline under each row | P2 |
| Filled-track scoring / progress bars | Big `bg-zinc-200` tracks with partial fill as comparison visuals on a landing page | P2 |

## Fake content & previews

| Pattern | How to spot it | Severity |
|---|---|---|
| Div-based fake screenshots | "Product preview" built from `<div>` rectangles: fake task list, fake terminal, fake dashboard. The #1 LLM tell | P0 |
| Fake version footers inside mockups | `v0.6.2-rc.1`, `last sync 4s ago · main` inside fake screenshots | P1 |
| Broken / placeholder images | `<img>` with empty/missing/placeholder `src` | P0 |
| Hand-rolled SVG icons / sketchy illustrations | Custom icon paths; `loose-sketch`/`doodle` class names; `feTurbulence` paper-grain filters. Use Phosphor/HugeIcons/Radix/Tabler | P1 |
| Generic placeholder content | "John Doe", "Acme", "Nexus", `99.99%`, Lorem ipsum, Lucide-egg avatars | P1 |
| Pills / labels overlaid on images | `<span>` overlay tags `Brand · 02`, `PLATE · BRAND` on photos | P2 |
| Decorative photo-credit captions | `Field study no. 12 · Ines Caetano`, `Frame XII · 35mm` under stock images | P2 |
| Version footers on marketing pages | `v1.4.2`, `Build 0048` on a landing/portfolio page | P2 |

## Copy & layout tells

| Pattern | How to spot it | Severity |
|---|---|---|
| Em-dash `—` (and en-dash `–` as separator) | Anywhere visible: headlines, body, quotes, captions, buttons, alt text. Completely banned. Use `-` | P1 |
| Marketing buzzwords | streamline / empower / supercharge / leverage / unleash / transform / seamless / world-class / enterprise-grade / next-generation / cutting-edge / game-changer | P1 |
| Aphoristic cadence | 3+ blocks landing on "X. No Y." / "Not a feature. A platform." rebuttal shapes | P2 |
| "X theater" / "actually X" / "not just X, it's Y" | `productivity theater`, `engagement theater` framing | P2 |
| "Quietly in use at" / poetic section labels | `Quietly trusted by`, `From the field`, `Currently on the bench`, `On our desks` | P2 |
| Locale / weather / time strips | `Lisbon 14:23 · 18°C`, `LIS 14:23 · 18°C` in nav/header/footer. Banned for 99% of briefs | P1 |
| Scroll cues | `Scroll`, `↓ scroll`, `Scroll to explore`, animated mouse-wheel icons | P1 |
| Generic step labels | `Stage 1 / 2 / 3`, `Step 1 / 2 / 3`, `Phase 01 / 02 / 03`. Use the verb-noun directly | P2 |
| Three equal feature cards | Three identical icon+heading+text cards in a row | P1 |
| Identical card grids | Same-sized cards repeated endlessly | P1 |
| Hero-metric template | Big number, small label, supporting stats, gradient accent. SaaS cliché | P1 |
| Marquee overuse | Horizontal scrolling text marquee more than once per page. Max 1 | P2 |
| Zigzag overuse | More than 2 consecutive image+text-split sections. Max 2 in a row | P2 |
| Micro-meta-sentences under eyebrows | `Each of these is a feature we ship today, not a roadmap promise.` clutter under a heading | P2 |
| Custom mouse cursors | Outdated, a11y- and perf-hostile | P2 |
