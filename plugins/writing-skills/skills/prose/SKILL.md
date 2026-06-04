---
name: prose
description: Use when writing or editing prose in French or English (articles, READMEs, landing copy, UI copy, emails, docs) to remove AI-sounding patterns and tighten the text. Not for code comments or commit messages.
---

# Prose

## Overview

Prose written or touched by an AI carries predictable tells: throat-clearing openers, fake binary contrasts, inanimate things doing human verbs, runways of negation before the actual point. This skill names the patterns and gives the fix. It applies to anything a reader reads as a sentence: articles, READMEs, landing and UI copy, emails, docs. Not code comments, not commit messages.

The detailed pattern catalog lives in `references/banned-patterns.md`. The rules below are the ones to keep in your head while drafting.

## 1. Core rules

- **Name the human.** Inanimate things don't act. "The team fixed it that week" beats "the complaint becomes a fix." Decisions don't emerge, cultures don't shift, data doesn't tell you anything: a person decides, changes behavior, reads the data. If no specific person fits, use "you" and put the reader in the seat.
- **State it directly.** No "not X, but Y" contrasts, no setup-and-reversal. "Speed isn't the problem, accuracy is" becomes "Accuracy is the problem." Drop the negation and assert the point.
- **Show the specific thing.** No vague declaratives. "The implications are significant" names nothing: name the implication. If a sentence calls something important, deep, or structural without showing it, replace it with the specific thing or cut it.
- **Cut the runway.** No negative listing before the point ("Not a framework. Not a library. A runtime."). State the destination. The reader doesn't need the buildup.
- **One idea per sentence.** Find the actor, put them at the front, say what they did. Active voice over passive. Vary sentence length so the rhythm isn't metronomic.

## 2. Quick checks

Run these before delivering a text:

- Passive voice anywhere? Find the actor, make them the subject.
- Inanimate thing doing a human verb ("the decision emerges")? Name the person.
- Sentence starts with a Wh- word (What/When/Why/How)? Restructure, lead with the subject.
- Any "here's what / this / that" throat-clearing? Cut to the point.
- Any "not X, it's Y" contrast? State Y directly.
- Negative listing before the reveal? State the destination.
- Vague declarative ("the implications are significant")? Name the specific thing.
- Narrator-from-a-distance ("Nobody designed this")? Put the reader in the scene.
- Meta-joiners ("the rest of this essay...")? Delete. Let the text move.
- Business jargon (navigate, deep dive, circle back)? Swap for plain words.
- Dramatic fragment ("That's it. That's the fix.")? Use a complete sentence.
- Three consecutive sentences the same length? Break one.

## 3. French specifics

The repo owner writes content in French and code in English. For French content:

- **Never use em dashes (tirets cadratins).** This is a hard project preference for French content: use commas, periods, or parentheses instead. In English, em dashes are fine sparingly.
- **Concrete, descriptive titles, not abstract or "creative" ones.** "Opacity seule" over "Le crossfade". A title should say what the section is about.
- **Don't over-explain after a code snippet or example.** If the code or example speaks for itself, a short sentence is enough. No paragraph restating what the reader just saw.

## 4. Full pattern list

For the full editing pass, with every pattern, a concrete example, and its fix, go to **`references/banned-patterns.md`**. It carries the catalog as tables: throat-clearing, emphasis crutches, the business jargon replacement table, meta-commentary, false intimacy, telling-instead-of-showing, vague declaratives, the eleven fake binary contrasts, negative listing, dramatic fragmentation, rhetorical setups, false agency, narrator-from-a-distance, passive voice, and sentence-starter / rhythm fixes. Match a pattern, apply the fix, move on.
