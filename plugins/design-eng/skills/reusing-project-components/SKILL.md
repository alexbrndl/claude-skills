---
name: reusing-project-components
description: Search the codebase for an existing component before writing a new one, and pull a repeated pattern into a shared component once it has appeared three times. Use whenever the task is to add or change a piece of interface: a card, a modal, a table, a form field, an empty state, a badge, a toolbar. Also use when the user says a screen looks inconsistent with the rest of the app, or asks whether something already exists, or asks to factor out duplication. Not for choosing a third-party UI library, and not for design system documentation.
---

# Reuse before writing, extract after repeating

Two different moments, one habit. Before you add interface code, the codebase probably already solves it. After the same shape appears a third time, it wants to become one thing.

## Before writing: look, and look properly

A grep for the obvious name finds almost nothing, because the thing you want is rarely called what you would call it. An empty state might live in `Placeholder`, `NoResults`, `BlankSlate`, or inside a `Table` as a prop. So search three ways and only then conclude it does not exist:

- By shape: the JSX or template of what you want to render. Search for a distinctive class combination or an element nesting, not a name.
- By neighbour: open the closest existing screen that does something similar and read what it imports. Screens are the honest index of what is available.
- By name, last: the concept and its synonyms.

If you find something close but not exact, extending it usually beats writing a sibling. A second component that is 80% the first is worse than one component with a prop, because reviewers cannot tell them apart and the next person picks at random.

Report what you found before you build. "There is a `Card` with a `footer` slot, I will use that" is a decision the user can correct in five seconds. Silently writing a new card is a decision they discover in review.

## After repeating: extract on the third occurrence, not the second

Two occurrences are a coincidence. Three is a pattern, and by then you have enough examples to see which parts genuinely vary. Extracting at two almost always produces the wrong seam, because you generalise the one difference you happen to have seen.

When you extract, the variation goes into props, not into a fork. If you find yourself adding a boolean that switches large chunks of markup, the seam is wrong: those are two components, and the shared part is smaller than you thought.

Move the file to where both callers can reach it without reaching sideways. A component imported from a sibling feature is a signal it belongs one level up.

## Do not extract these

Layout that happens to look the same. Two screens with the same grid are not sharing a component, they are sharing a page structure, and coupling them means one cannot change without the other.

Anything with only two callers where the second is speculative. "We will need it elsewhere" is the reason most shared components end up with five props nobody uses.

## What to leave behind

After extracting, the call sites should be shorter than before. If they are not, the abstraction is not paying for itself and it is better to revert than to keep it out of politeness to your own work.

State the count when you propose an extraction: how many occurrences, which files, what varies between them. That is the whole argument, and it either holds or it does not.
