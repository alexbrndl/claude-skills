---
description: Build a slice of interface, reusing what exists
disable-model-invocation: true
argument-hint: [the slice to build]
---

Build: $ARGUMENTS

## First

0. `/including-project-skills Build`. If this repository declares a map of its own skills in `.claude/design-eng.md`, the ones it lists for this phase run in the order the file lists them, and a line marked `— replaces` takes the slot of the library skill it names instead of being appended at the end. No map means nothing is added: do not infer one.

## Before writing anything

1. `/reusing-project-components`. Search the codebase three ways, by shape, by neighbour, by name. Tell me what you found and what you will extend before you write a new component.
2. If the slice touches copy that exists in several locales, `/editing-translated-strings`. Changing one locale and leaving the others is the default failure.

## While building

3. `/frontend-ui-engineering` for the implementation itself: accessible, responsive, real states rather than the happy path only.
4. `/incremental-implementation`. One slice, committed on its own. If you are about to write a large amount of code in one pass, stop and cut it.
5. `/motion` when the slice animates. `/animate` for building an animation from scratch, `/apple-design` when the interaction is gestural or spring-based.
6. `/shadcn` when the component belongs to a shadcn project, and check `/migrate-radix-to-base` before adding a Radix primitive to a project already on Base UI.

## Before you hand it back

The diff, what you reused, what you created and why nothing existing fit. If you created something that is 80% of an existing component, revert and extend the existing one instead.

A `/skill` above that does not exist on this machine is a missing install, not a step to skip. Name it, point at the Install section of the design-eng README, and carry on with the rest.
