---
description: Decide what to build and how, before any code exists
disable-model-invocation: true
argument-hint: [what you want to build]
---

Work through Define then Plan for: $ARGUMENTS

Stop at the first step that produces a question only I can answer, ask it, and wait.

## First

0. `/including-project-skills Define Plan`. If this repository declares a map of its own skills in `.claude/design-eng.md`, the ones it lists for these phases run after the library's, and a line marked `— replaces` drops the library skill it names. No map means nothing is added: do not infer one.

## Define

1. If the request is vague or you are guessing at intent, run `/interview-me` first. One question at a time until you could describe the thing back to me and be right.
2. `/design-direction` to settle the visual direction. Dials, philosophy, fonts, palette. Output a mini brief I can validate before anything is drawn.
3. If there is no spec and the work spans more than one screen, `/spec-driven-development`.

## Plan

4. `/planning-and-task-breakdown` to cut the work into slices that each ship on their own.
5. `/pick-ui-library` if the work needs a primitive we do not already have. Check what the codebase already imports before proposing a dependency.
6. If several directions are genuinely open and cheap to render, `/prototype` to build them behind a picker rather than arguing about them in prose.

## Before you hand it back

State the direction in one paragraph, the slices in order, and the single decision you had to make on my behalf. If the answer to "what does the first slice ship?" is not a sentence, the plan is not done.

A `/skill` above that does not exist on this machine is a missing install, not a step to skip. Name it, point at the Install section of the design-eng README, and carry on with the rest.
