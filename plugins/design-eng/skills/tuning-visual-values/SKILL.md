---
name: tuning-visual-values
description: Adjust a numeric visual value that already renders but looks wrong. Use whenever the work is choosing a number for spacing, radius, blur, opacity, shadow, font size, line height, duration or easing, and the user says something is too big, too tight, too slow, too heavy, or just off. Also use when the user asks what value to pick, or asks to make something feel better without naming a number. Not for choosing which component to use, and not for animation vocabulary or easing theory: this skill is only about landing on the number.
---

# Tuning a visual value

A value that "looks wrong" is almost never wrong in isolation. It is wrong relative to its neighbours. So the work is not to guess a better number, it is to make the comparison visible and then read the answer off it.

## Render the variants, do not describe them

The failure mode here is arguing about a number in prose. Nobody can see prose. Produce the candidates side by side in the real context, at the real size, on the real background, then look.

Three candidates, not seven. One clearly below the current value, one clearly above, and the current one. If the answer is between two of them, run a second pass between those two. Bisecting twice lands closer than picking from a long list, because a long list makes every option look plausible.

Change one value at a time. If you adjust padding and radius together and it improves, you have learned nothing about which one was wrong.

## Read the value off the system first

Before inventing a number, look for the scale that already exists in the codebase: the spacing tokens, the type scale, the duration constants. If a token already sits where you were about to land, use the token. A one-off value is a debt that the next person pays, and it is invisible in review because it looks like a deliberate choice.

If no scale exists and you are adding the first of a family, say so out loud and propose the scale rather than the single value. The second and third use will arrive within days.

Some values are not a matter of taste and already have a band. Contrast, line length, type scale ratio, touch target, breakpoints and dark-mode saturation are in `../design-review/references/thresholds.md`; durations, stagger, waiting and gesture are in `../motion/references/timing.md`. Check those first: if the value you are tuning has a documented band, you are not choosing, you are complying, and the work is to find why the current value is outside it.

## Anchor on the thing it sits next to

Values are legible in ratios, not absolutes. A 24px gap means nothing; a gap that is twice the gap above it and half the gap below it means something. When you propose a number, state the ratio you are targeting and to what.

The same holds for time. A duration is fast or slow relative to the distance travelled and to the other transitions on the same screen. A number that works for a 200px slide is wrong for an 8px nudge.

## Where the eye actually goes

Some values carry a lot and some carry almost nothing. Getting the optical alignment of an icon against a label right changes how the whole row reads. Moving a shadow's blur by 2px usually changes nothing anyone will notice. Spend the passes where the difference is visible at a glance, and stop when a change stops being visible: that is the signal you have arrived, not a sign you should try harder.

## Say what you changed and why

End with the value, the value it replaced, and the ratio or token that justifies it. One line. This is what lets someone disagree with you productively instead of reopening the whole question:

> `gap-3` to `gap-4`, so the gap between rows is twice the gap inside a row, matching the list above.

## When not to use this

If the layout is wrong, no value will fix it. If two elements are fighting for the same role, the fix is hierarchy, not numbers. Notice this early and say it, rather than tuning your way around a structural problem.
