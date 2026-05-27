---
name: orchestrating-parallel-design-agents
description: Use when exploring several design directions at once in one shared design file (Paper, Figma canvas) by dispatching one agent per direction, when their outputs risk colliding on the canvas or drifting apart, or when tempted to run them sequentially because they share a file.
---

# Orchestrating Parallel Design Agents

## Overview
To explore several design directions fast, dispatch **one agent per direction**, all building in ONE shared canvas at the same time (the user watches it fill). A canvas is shared state, but unlike a source file it is **spatially partitionable**: give each agent a disjoint region and writes never overlap and node IDs never clash (the tool assigns them).

**Core principle:** One agent per track to explore. The orchestrator *centrally* assigns each a disjoint canvas corridor. Don't default to sequential just because they share a file, and don't fix the count — it equals the number of directions.

## When to use
- Exploring N design directions / screens at once (N = number of tracks, never a hardcoded number).
- You want the user to watch the canvas fill in real time.
- Outputs must stay visually coherent across agents.

## When NOT to use
- One direction only → one agent, no corridors.
- Agents must edit the *same* nodes/region (true contention) → sequential.

## The non-obvious part
General parallel-dispatch guidance says "shared state → run sequential." A canvas is the exception: shared *file*, partitionable *space*. **Composable (not a dependency):** superpowers:dispatching-parallel-agents covers general fan-out (one agent per domain, focused prompts, review/integrate); this skill adds the shared-canvas coordination it lacks.

## Protocol (orchestrator side)
1. **One agent per track.** Count = number of directions to compare. Each owns one direction end-to-end, which keeps that direction internally consistent.
2. **Assign corridors centrally.** Give each agent an explicit, distinct x (e.g. 0 / 1700 / 3400 …, spaced wider than an artboard). NEVER let agents self-pick "the first free spot" — independent agents converge on the same coordinate and collide. (Observed failure mode.)
3. **Inject one shared spec into every agent.** Identical design tokens (colors, type scale, radii), component specs, and exact content/copy in every prompt. This is what makes N independent outputs read as one system.
4. **Hand each agent the isolation contract** (below).
5. **Diverge → review → converge.** Dispatch in parallel, then screenshot each corridor, critique comparatively, converge to one direction. Agents never cross-reference each other live.

## The isolation contract (paste into each agent prompt)
```
- Work only on the active page; never switch or create pages.
- Your corridor is x=<N>. Create your own artboards there; stack vertically with a gap.
- Touch only nodes you created. Never move/delete/edit a node you didn't create.
- Reference your nodes by the IDs returned to you. NEVER rely on get_selection
  (it's global; other agents change it).
- Screenshot YOUR artboard by id, not the page, so others' work doesn't pollute your review.
- After creating an artboard, verify its position (the tool may auto-reposition); force your x if needed.
- finish_working_on_nodes only on your own artboards.
```
(Tool names are Paper's; adapt the equivalents for Figma.)

## Presenting the explorations (optional output format)
When explorations must stay legible for review, handoff, or sharing, have each agent wrap its track in a self-describing presentation frame instead of bare stacked artboards:
- **Large identifier** (letter/number) — assigned centrally by the orchestrator, same as the corridor.
- **Title** (direction name) + **light-weight subtitle** (one-line pitch). Contrast a Medium/SemiBold title against a Light subtitle.
- The screens laid out inside (clone the real artboards at native size), each with a small step badge + a short caption.
- Light, airy ground; generous vertical rhythm.

**Lock the format on one frame first**, then fan out: later agents replicate it by inspecting that frame (reference it by node id) so every deck matches.

## Quick reference
| Concern | Rule |
|---|---|
| Agent count | One per direction to explore (not fixed) |
| Region | Orchestrator assigns a distinct x per agent |
| Node IDs | Tool-assigned, unique; each agent tracks its own |
| Selection | Global/shared → never drive work from it |
| Coherence | Same spec block in every prompt |
| Coordination | None live; review + converge after |

## Common mistakes
- **Hardcoding the agent count** instead of one per direction → directions merged, or idle agents.
- **Letting agents self-assign position** → all pick "first free" → overlap. Assign centrally.
- **Defaulting to sequential** because they share a file → lose the speed and the live build.
- **Different spec per agent** → stylistic drift; outputs don't read as one system.
- **Driving work via get_selection** → cross-agent pollution; use explicit node IDs.
- **Cloning loses position** → a cloned screen inherits the source's absolute x/y and lands off-frame; reset it to 0 within its container.
- **Building in the wrong file** → the tool follows the *active* file, which changes when another file is opened; verify file/page before building, and remember clones can't cross files.
- **Trusting agents' position reports** → an agent may report placing its frame at x=N while the left/top never persisted, so the frame collapses to the origin and overlaps the others. After fanout, read each frame's real left/top (not the agent's summary) and correct any that didn't stick.

## Related (composable, not required)
- superpowers:dispatching-parallel-agents — general fan-out mechanics.
- Paper MCP `get_guide` (paper-mcp-instructions) — visual quality discipline.
- paper-desktop:design-to-code — handoff to real components afterward.
