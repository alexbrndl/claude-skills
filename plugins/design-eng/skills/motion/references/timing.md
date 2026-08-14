<!-- Derived from Owl-Listener/designer-skills (MIT) — see CREDITS.md -->

# Timing ladders

The numbers to reach for before inventing one. `thresholds.md` in `design-review` gives the verification bands (150–300ms for micro-interactions, ≤ 500ms for UI transitions); this file gives the named steps inside those bands, and the ladders for waiting and gesture.

## Duration ladder

Name the durations as tokens so a reviewer can see the intent, not just the value.

| Token | Value | What it is for |
|---|---|---|
| `duration-instant` | 50ms | State changes that must feel immediate: checkbox tick, toggle |
| `duration-fast` | 100ms | Small element transitions: tooltip appear, chip dismiss |
| `duration-normal` | 200ms | Default for most transitions: dropdown open, focus ring |
| `duration-moderate` | 300ms | Medium elements: modal entry, panel slide |
| `duration-slow` | 400ms | Page-level transitions, simple choreography |
| `duration-deliberate` | 600ms | Intentionally paced, high-emphasis moments: onboarding reveal |

Above 400ms you are spending the user's attention, so the motion has to carry meaning. Under reduced motion, override every duration token to `0ms` globally rather than removing animations one by one.

## Stagger

Related elements entering together stagger by **30–50ms**, leading with the most important. The whole staggered sequence should land within **500ms**.

Owl-Listener's own files disagree here, one says 500ms and another 700ms. 500 is the safer ceiling: past that, a list that staggers feels like a list that is loading.

## Waiting

What to show is a function of how long the wait is, not of how the code is written.

| Wait | What to show |
|---|---|
| under 100ms | Nothing. An indicator that flashes is worse than no indicator |
| 100ms – 1s | A subtle cue: opacity change, skeleton |
| 1 – 10s | A clear loading state, with progress if the total is knowable |
| over 10s | Detailed progress, a time estimate, and a way to send it to the background |

Toasts auto-dismiss after **3–5s**. Anything the user must act on does not auto-dismiss at all.

After an error, leave **300–600ms** before the next prompt. Rushing the recovery reads as the system not having noticed.

## Gesture

| Threshold | Value |
|---|---|
| Movement before a drag or swipe activates | 10–15px |
| Long-press | 500ms |

Below 10px you fire on taps; above 15px the gesture feels unresponsive.
