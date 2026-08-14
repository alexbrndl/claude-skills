---
description: Verify it works, then judge whether it is good enough to ship
disable-model-invocation: true
argument-hint: [file, screenshot, or URL]
---

Review: $ARGUMENTS

Verify comes before Review. A design critique on something that does not work wastes both passes.

## First

0. `/including-project-skills Verify Review`. If this repository declares a map of its own skills in `.claude/design-eng.md`, the ones it lists for these phases run after the library's, and a line marked `— replaces` drops the library skill it names. No map means nothing is added: do not infer one.

## Verify

1. `/webapp-testing` or `/browser-testing-with-devtools` to drive the thing in a real browser. Empty, loading, error and success states, not the happy path only.
2. `/systematic-debugging` on anything that fails, before proposing a fix.
3. `/verification-before-completion` before you claim it works. Run the commands, show the output.

## Review

4. `/design-review` is the main pass: deterministic checklist and design judgment kept isolated, then synthesised and ranked P0 to P3. Do not skip the isolation, it is the point.
5. `/tuning-visual-values` on every finding that is a number rather than a structure. Render the candidates side by side instead of arguing about them.
6. `/accessibility-review` for the WCAG pass, contrast, focus order, touch targets, reduced motion.
7. `/review-animations` when motion is involved. It defaults to flagging, approval is earned.
8. `/code-review-and-quality` on the diff itself, separately from the visual pass.

## Before you hand it back

One ranked list, not two. Each finding is a file or element, the problem, and the concrete fix. Say where the checklist and your judgment disagreed, and which checklist hit is a false positive in this context.

A `/skill` above that does not exist on this machine is a missing install, not a step to skip. Name it, point at the Install section of the design-eng README, and carry on with the rest.
