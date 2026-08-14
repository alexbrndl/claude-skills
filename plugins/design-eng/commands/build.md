---
description: Build a slice of interface, reusing what exists
disable-model-invocation: true
argument-hint: [the slice to build]
---

Build: $ARGUMENTS

## First

0. `/including-project-skills Build`. If this repository ships its own skills, the ones that belong to Build run alongside the list below. On a collision, the project's skill wins and the library one is skipped. This is the phase where it happens most: a codebase with a design system usually has its own version of step 1.

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
