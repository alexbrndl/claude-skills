---
name: editing-translated-strings
description: Change user-facing copy in a product where the same string exists in several languages. Use whenever the task touches a label, button, error message, empty state, tooltip or email subject in a project that has locale files, translation keys, or an i18n setup. Also use when the user rewrites one language and forgets the others, when a key is about to be added, or when a string turns out to be hardcoded instead of translated. Not for writing the copy itself from scratch, and not for choosing an i18n framework.
---

# Editing copy that exists in several languages

The bug is always the same: one locale gets the new wording and the others keep the old one. Nobody notices, because nobody reads the app in every language. So the discipline is to treat a string change as a change to a set, never to a line.

## Find every locale that holds the key

Before editing, list the files that contain the key. Do this by searching for the key, not for the text, because the text differs per language and the key does not. If the project has five locale files and the key appears in three, that is already a finding worth reporting: two locales were falling back silently.

Then edit all of them in the same change. A partial change is worse than no change, because the fallback at least looked deliberate.

## If you cannot write a language, say so and leave the key

You will hit locales you cannot write. Do not machine-translate silently into a language you cannot check, and do not delete the key to make the inconsistency disappear.

Leave the old value, and report exactly which locales need a human. A short list is actionable:

> `errors.payment.declined` updated in `fr` and `en`. Needs a translator for `de` and `it`, old wording still in place.

## Keys describe the place, not the words

A key named after its current text dies the moment the text changes. `button.clickHereToSave` becomes a lie when the button says "Enregistrer". Name the key for where it lives and what it does: `invoice.actions.save`.

When you add a key, put it next to its siblings in the file rather than at the end. Locale files that grow at the bottom become impossible to review, and duplicates creep in because nobody can see that a neighbouring key already says the same thing.

## Watch for what breaks in other languages

Length is the usual one, and it is measurable rather than a feeling:

| From English | Expansion |
|---|---|
| German | +20 to 35% |
| Finnish | +30 to 40% |
| French | +15 to 25% |
| Arabic | −20 to 30%, but right-to-left and a different script |

So a label that fits its button in English can wrap or clip elsewhere. If the string sits in a constrained space, check the longest locale, not the one you are writing. For navigation, test every item together at **130% of the English length**: menus break as a set, not one label at a time.

Right-to-left is not a translation problem, it is a layout one. Arabic and Hebrew mirror the whole interface: order of elements, direction of icons that imply direction, side the drawer opens from. Text alignment flips, but a play button does not. And both are cursive scripts with letter-joining rules, so they need a larger minimum font size, 16px and up, to stay readable.

Formats travel with the locale too, not with the string: dates, decimal separators, currency position, name order. A hardcoded `DD/MM/YYYY` is the same bug as a hardcoded label.

Plurals and interpolation are the other. If the new wording introduces a count or a name, every locale needs the matching plural forms, and some languages have more than two. Adding `{count}` to one locale and not the others produces a visible `{count}` in production.

Avoid splitting a sentence across two keys to reuse a fragment. Word order differs between languages and the fragment will land in the wrong place.

## Hardcoded strings

If the string you were asked to change is not in a locale file at all, that is the actual task. Move it to a key, add it to every locale, then make the change. Editing it in place is faster today and guarantees the same bug next time.

Report it either way, because a hardcoded string usually has company nearby.
