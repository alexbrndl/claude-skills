<!-- Adapted from impeccable (Apache 2.0) — see CREDITS.md -->

# Font selection

Choosing type by reflex is the single most-tested AI tell. Run the procedure every project. Never skip it.

## Font selection procedure

1. **Read the brief. Write three concrete brand-voice words.** Not "modern" or "elegant" — physical-object words: "warm and mechanical and opinionated", or "calm and clinical and careful".
2. **List the three fonts you'd reach for by reflex.** If any appear in the reflex-reject list below, reject them. They are training-data defaults and they create monoculture.
3. **Browse a real catalog** (Google Fonts, Pangram Pangram, Future Fonts, Adobe Fonts, ABC Dinamo, Klim, Velvetyne) with the three words in mind. Find the font for the brand *as a physical object*: a museum caption, a 1970s terminal manual, a fabric label, a cheap-newsprint children's book, a concert poster, a receipt from a mid-century diner. Reject the first thing that "looks designy".
4. **Cross-check.** "Elegant" is not necessarily serif. "Technical" is not necessarily sans. "Warm" is not Fraunces. **If the final pick lines up with the original reflex, start over.**

## Reflex-reject list (fonts)

Training-data defaults. Ban list. Look further:

> Fraunces · Newsreader · Lora · Crimson · Crimson Pro · Crimson Text · Playfair Display · Cormorant · Cormorant Garamond · Syne · IBM Plex Mono · IBM Plex Sans · IBM Plex Serif · Space Mono · Space Grotesk · Inter · DM Sans · DM Serif Display · DM Serif Text · Outfit · Plus Jakarta Sans · Instrument Sans · Instrument Serif

**Specifically banned as display defaults:** `Fraunces` and `Instrument Serif` (the two LLM-favorite display serifs).

**The reflex-reject list applies to new design choices only.** When an existing brand has already committed to a font as part of its identity, identity-preservation wins — variants on a shipping surface don't second-guess what's already there. The ban is for greenfield decisions and for departure-mode variants.

## Reflex-reject list (aesthetic lanes)

Parallel to the font list. Currently saturated aesthetic families that have flooded brand surfaces. If a brief lands in one of these lanes *without a register reason that requires it* (a literal magazine, a literal terminal, a literal industrial signage system), it's the second-order reflex — the trap one tier deeper than picking Fraunces. Look further.

- **Editorial-typographic.** Display serif (often italic) + small mono labels + ruled separators + monochromatic restraint. Klim-influenced, magazine-cover affectation. By 2026 every Stripe-adjacent and Notion-adjacent brand has landed here. The fingerprint: three rule-separated columns, an italic Fraunces / Recoleta / Newsreader headline, lowercase track-spaced metadata, no imagery.

(Brutalist-utility and acid-maximalism may join this list as they saturate. Removing entries when they fall back below saturation is also fine.)

## Serif discipline (very discouraged as default)

Serif is **very discouraged as a default** for any project. "It feels creative / premium / editorial" is NOT a reason to reach for serif — "creative brief = serif" is the most-tested AI tell in production.

Serif is only acceptable when ONE of these is explicitly true:
- The brand brief literally names a serif font, OR
- The aesthetic family is genuinely editorial / luxury / publication / manuscript / heritage / vintage AND you can articulate why *this specific serif* fits *this specific brand*.

For everything else (creative agency, design studio, modern brand, premium consumer, portfolio, lifestyle), **default to sans-serif display** — it is not "boring", it is the default for the same reason black is the default in fashion. Candidates: Geist Display, ABC Diatype, Söhne Breit, Cabinet Grotesk Display, Migra Sans, GT Walsheim, Inter Display, PP Neue Montreal.

**If a serif IS justified** (rare), rotate from this pool — do not reuse the same serif across consecutive projects: PP Editorial New, GT Sectra Display, Cardinal Grotesque, Reckless Neue, Tiempos Headline, Recoleta, Cormorant Garamond, Playfair Display, EB Garamond, IvyPresto, Migra, Editorial Old, Saol Display, Söhne Breit Kursiv, Domaine Display, Canela, Schnyder, Tobias, NB Architekt, ITC Galliard.

## Pairing and voice

Distinctive + refined is the goal. The shape depends on the brand, not its category. A category ("restaurant", "dev tool", "magazine", "fintech") is not a recipe.

- **Two families minimum is the rule only when the voice needs it.** A single well-chosen family with committed weight/size contrast is stronger than a timid display+body pair.
- **Emphasis rule:** to emphasize a word inside a headline, use **italic or bold of the SAME family**. Do not inject a random serif word into a sans headline (or vice versa) for visual interest — mixed-family emphasis is amateur.
- **Italic descender clearance:** when italic display type contains a descender (`y g j p q`), `leading-none` clips it. Use `leading-[1.1]` minimum and add bottom reserve. Audit every italic word in display headlines before shipping.

## Scale

- Modular scale, fluid `clamp()` for headings, **≥1.25 ratio** between steps. Flat scales (1.1× apart) read as uncommitted.
- Light text on dark backgrounds: add 0.05–0.1 to line-height. Light type reads as lighter weight and needs more breathing room.

## Font bans

- **Mono as lazy shorthand for "technical / developer".** If the brand isn't technical, mono reads as costume.
- **System fonts (SF Pro / Inter / Roboto / Arial) as display** — reads as "demo page", not "designed product". Exception: the brand spec explicitly uses them.
- **All-caps body copy.** Reserve caps for short labels and headings.
- **Single-family pages picked by reflex, not voice.** A single family chosen deliberately is fine.
