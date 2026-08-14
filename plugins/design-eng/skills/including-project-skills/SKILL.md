---
name: including-project-skills
description: Read the map a project declares of its own skills and fold the ones it lists into the phase currently running. Called by the /define, /build, /review and /ship commands with one or more phase names. Also drafts that map on request, by inspecting the repository once, for a human to cut down and commit. Not for writing a new skill, and not for personal skills in the home directory, which already fire on their own through normal routing.
disable-model-invocation: true
argument-hint: [phases: Define Plan Build Verify Review Ship] [--draft]
---

# Folding a project's own skills into a phase

A command names the skills it knows about. A repository can carry skills it should run instead, and the team that wrote them knows which. So this reads a declaration; it does not guess.

Guessing was tried twice and measured twice, on a repository with 67 project skills. Sorting them by the moment their description names gave 6 relevant steps out of 19. Adding a second axis for the stack gave 8 out of 24. Both runs pulled in skills that commit and push, because a description written for a different purpose cannot tell you whether a skill belongs in a phase. The information does not exist in the descriptions. It exists in someone's head, and it costs ten lines to write down.

## 1. Read the map

`.claude/design-eng.md`, at the repository root. One section per phase, one skill per line.

```md
## Build
- compose-from-library — replaces reusing-project-components
- semantic-search

## Verify
- quality

## Ship
- open-pr — replaces git-workflow-and-versioning
```

Take the sections matching the phases in `$ARGUMENTS`.

A line marked `— replaces <library-skill>` **takes that skill's slot**, at its position in the command, and the library skill is dropped. Owning the moment means owning the position: a skill whose job is to search before code is written cannot do it once the code exists, which is what happens if you append it at the end.

A line with no `— replaces` has no slot to inherit, so it runs after the library skills of its phase, in the order the file lists them.

Anything not listed does not run, whatever its description says.

Check every name resolves before running anything:

```bash
ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")
find -L "$ROOT" \( -name node_modules -o -name vendor -o -name .git -o -name dist \) -prune -o \
     -path '*/.claude/skills/*/SKILL.md' -print 2>/dev/null | sort -u
```

`-L` matters: a repository serving several agent harnesses keeps one real skills directory and exposes the others as symlinks. A name in the map with no skill behind it is a stale line to report, not a step to invent.

Then honour `skillOverrides` in `.claude/settings.local.json` and `.claude/settings.json`. A skill the project set to `off` or `name-only` does not run even if the map lists it, and you say so in one line, because the map and the settings disagreeing is worth knowing.

## 2. No map

Do not fall back to inference. Add nothing to the command, and say so once:

> No `.claude/design-eng.md` here, running the library skills only. `/including-project-skills --draft` proposes one.

That is the whole behaviour. A command that silently runs a project's release skill during Build is worse than a command that runs one step too few.

## 3. Drafting a map, with `--draft`

Only on request, and the output is a proposal for a human, never something you write to disk yourself.

Discover the skills with the `find` above and read only their frontmatter, `name` and `description`. Then, for each one, answer two questions and drop it if either fails:

- **Which moment does the description name?** *Before adding a button, check the variants that exist* is Build. *Judge whether the button reads as primary* is Review. No moment named means no phase: put it under a `## Unplaced` heading rather than guessing, since a four-word description can hide a genuinely useful skill.
- **Does it apply to what this repository actually is?** Read the boundaries the description states, the *do not use for*, the *only*, the named framework. A Livewire-only skill in a React codebase is out.

Then cut hard, and print the counts: skills found, skills proposed, skills dropped. Aim for a handful per phase. A map with twenty lines in Build is a map nobody will trust, and the point of the file is that a human agreed to every line in it.

Mark a `— replaces` where a proposed skill covers the same moment as a skill the command already calls, and say which. That line is the interesting one: it tells the library's author their skill is redundant here.

Present it as a fenced block for the user to paste, with a note that skills doing anything irreversible, committing, pushing, opening pull requests, writing to a tracker, belong in Ship or in no map at all.

## Scope

Personal skills in `~/.claude/skills/` are out of scope. They follow you across every project, they are already part of your routing, and enumerating them would make the same command behave differently on two machines. This is why step 1 anchors on the git root.

Plugin skills are out of scope too. They are namespaced `plugin:skill`, declared by the library rather than discovered, and `skillOverrides` does not apply to them at all.

And the ceiling, plainly: every project skill stays automatically invocable while the command runs, so any of them can fire on its own regardless of the map. This decides the **order and the ownership** of the steps a command takes. It does not, and cannot, stop a project skill from triggering by itself.
