<!-- Derived from Owl-Listener/designer-skills (MIT) — see CREDITS.md -->

# Laws and effects

A glossary, not a procedure. Seventeen named effects that give a shared word to a critique finding. Reach for one when you need to explain *why* something is wrong to someone who disagrees; skip it when the finding stands on its own.

Naming the law is not the finding. "This violates Hick's Law" says nothing actionable. "Eleven top-level nav items, decision time grows with the count, cut to five and nest the rest" is the finding, and the law is the shorthand you attach to it.

## Attention and memory

| Law | What it says | Where it bites in a review |
|---|---|---|
| **Hick's Law** | Decision time grows with the number of simultaneous choices | A screen offering everything at once. Count the top-level choices; if more than about seven, the hierarchy is missing |
| **Miller's Law** | Working memory holds about four chunks | Ungrouped lists of fields, menu items or steps. Chunk them and the same content reads as less |
| **Serial Position Effect** | First and last items in a sequence are recalled best | The most important nav item or list entry buried in the middle |
| **Von Restorff Effect** | The element that differs from its neighbours is the one remembered | Two primary buttons on one screen. If everything is emphasised, nothing is |
| **Zeigarnik Effect** | Incomplete tasks stay mentally active | Progress indicators that show completion earn their space; a form with no sense of remaining steps loses people |
| **Peak-End Rule** | A flow is remembered by its most intense moment and its last | Polish the error recovery and the confirmation, not the middle steps |

## Grouping, the Gestalt set

| Law | What it says | Where it bites in a review |
|---|---|---|
| **Law of Proximity** | Spatial closeness groups elements more strongly than any other cue | The most common spacing bug: a label closer to the field below it than to its own field |
| **Law of Common Region** | A shared container, background or border groups elements regardless of spacing | A card that visually adopts the element sitting just outside it |
| **Law of Similarity** | Shared colour, shape or size signals one category | Two different things styled identically, or one category styled two ways |
| **Law of Continuity** | The eye follows alignment and unbroken paths | Broken alignment down a column reads as an error even when it is deliberate |
| **Law of Closure** | The eye completes implied shapes from partial forms | You can drop a border and keep the grouping. Useful for reducing visual noise |
| **Law of Figure-Ground** | One layer reads as foreground and actionable, the other as background | Modals and overlays that do not establish which layer is live |

## Perception and response

| Law | What it says | Where it bites in a review |
|---|---|---|
| **Doherty Threshold** | Keep system response under 400ms to preserve flow | Above 400ms the user's attention leaves. See the loading ladder in `thresholds.md` for what to show instead |
| **Fitts's Law** | Target acquisition time depends on size and distance | Small targets far from the thumb. Pairs with the 44×44px minimum |
| **Jakob's Law** | Users expect your product to work like the others they use | Innovating on a familiar pattern costs comprehension. Spend that budget where it differentiates, not on the nav |
| **Tesler's Law** | Every process has irreducible complexity that someone must absorb | Complexity removed from the interface lands on the user or on the code. Say which, deliberately |
| **Aesthetic-Usability Effect** | Polished interfaces are perceived as more usable and forgive minor friction | Why craft is not decoration. Also why a usability test on an ugly prototype over-reports problems |
