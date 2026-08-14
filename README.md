# design-eng

Design engineering skills for Claude Code. Ten skills I own, four commands that wrap the lifecycle, and the rest referenced from the people who maintain it better than I would.

The bet is not "more skills". Only skills with automatic invocation compete when Claude picks one, so every skill you install makes the next choice slightly worse. This library carries what I actually use and declares the rest.

## Install

```
/plugin marketplace add alexbrndl/design-eng
/plugin install design-eng@alexbrndl-skills
```

That is the whole library. It declares no dependencies, on purpose: an unresolved dependency disables the plugin that declared it, and nothing below is needed for the ten skills in here to work.

The commands do call skills from elsewhere. Install what you want, in any order. Marketplace names do not always match repository names, so they are spelled out here:

```
/plugin install superpowers@claude-plugins-official
/plugin install mattpocock-skills@claude-plugins-official
/plugin install design@knowledge-work-plugins

/plugin marketplace add anthropics/skills
/plugin install example-skills@anthropic-agent-skills

/plugin marketplace add addyosmani/agent-skills
/plugin install agent-skills@addy-agent-skills

/plugin install emilkowalski-skills@alexbrndl-skills
npx skills@latest add shadcn-ui/ui -a claude-code
```

Then `/reload-plugins`, or restart, before checking that anything landed.

Emil Kowalski's skills are reachable two ways, this marketplace entry or `npx skills@latest add emilkowalski/skills -a claude-code`. Pick one: installing both puts the same ten skills in two places. If a `github` source ever fails with `Permission denied (publickey)`, it cloned over SSH; `CLAUDE_CODE_PLUGIN_PREFER_HTTPS=1` switches that, and the entry in this marketplace already uses an explicit HTTPS url.

## Where each command's steps come from

A command step whose skill is missing says so rather than skipping quietly. This is the map, so you can install only the phases you use:

| Source | Skills the commands call |
|---|---|
| this repository | `design-direction`, `design-review`, `motion`, `prose`, `reusing-project-components`, `editing-translated-strings`, `tuning-visual-values`, `orchestrating-parallel-design-agents`, `brand-illustrations` |
| `agent-skills` | `interview-me`, `spec-driven-development`, `planning-and-task-breakdown`, `frontend-ui-engineering`, `incremental-implementation`, `browser-testing-with-devtools`, `code-review-and-quality`, `git-workflow-and-versioning`, `shipping-and-launch`, `documentation-and-adrs` |
| `emilkowalski-skills` | `animate`, `apple-design`, `review-animations`, `pick-ui-library` |
| `superpowers` | `systematic-debugging`, `verification-before-completion` |
| `design` | `accessibility-review`, `design-handoff` |
| `example-skills` | `webapp-testing` |
| `mattpocock-skills` | `prototype` |
| shadcn | `shadcn`, `migrate-radix-to-base` |

`prototype` exists in both `mattpocock-skills` and `emilkowalski-skills`, and which one answers `/prototype` when both are installed is not documented. If `/define` gives you the wrong one, invoke it namespaced.

## The four commands

Commands are the point of the library. They wrap the phases so you type one thing instead of remembering forty skill names, and each one calls the skills of its phase in order.

| Command | Phase | What it does |
|---|---|---|
| `/define` | Define, Plan | Settles intent and visual direction, then cuts the work into slices that ship on their own |
| `/build` | Build | Searches for what already exists before writing, then implements one slice |
| `/review` | Verify, Review | Drives it in a browser first, then the isolated checklist and judgment passes |
| `/ship` | Ship | Commits, hands off, and writes down the decision someone will question later |

Each command stops at the first question only you can answer.

Each one also reads `.claude/design-eng.md` if the repository has one: a short map declaring which of the project's own skills belong to which phase, and which of the library's they replace. No map means the command runs its own skills and says so. It does not infer a mapping from the project's skill descriptions, because that was measured twice and both times it pulled in steps that had no business running, including ones that commit and push. `/including-project-skills --draft` proposes a map for you to cut down.

## The skills

Ten, in this repository.

| Skill | Phase | When it fires |
|---|---|---|
| `design-direction` | Define | Choosing the visual direction of a screen or component before coding |
| `orchestrating-parallel-design-agents` | Plan | Exploring several directions in one shared file without collision |
| `reusing-project-components` | Build | Before adding interface code, and when the same shape appears a third time |
| `motion` | Build | Adding, reviewing or debugging animation and transitions |
| `brand-illustrations` | Build | A coherent illustration series, or a reusable Style DNA |
| `editing-translated-strings` | Build | Copy that exists in several locales, including RTL and formats |
| `prose` | Build | Anything a human reads, without the AI tics |
| `design-review` | Review | Critiquing an existing UI before shipping |
| `tuning-visual-values` | Review | A value that renders but looks wrong, and no documented band covers it |
| `including-project-skills` | All | Called by the commands, folds the project's own skills into the phase running |

Everything else the commands call lives elsewhere, see the map above.

## Where the numbers live

Two reference files hold every threshold, so no skill invents a value:

- `design-review/references/thresholds.md` for contrast, line length, type scale, touch targets, breakpoints, dark mode
- `motion/references/timing.md` for the duration ladder, stagger, waiting states, gesture

`tuning-visual-values` is the method for the values those two files do not cover: render three candidates, bisect, anchor on a ratio, use the token if one exists.

## Add a skill

```
plugins/design-eng/skills/<name>/
├── SKILL.md          # required, frontmatter with name + description
├── references/       # loaded on demand
└── scripts/          # executable, no context cost until run
```

The `description` is the only lever on when the skill fires. Write it as the moment it serves, and end it with what it is *not* for, pointing at the skill that is. Two descriptions that name the same moment are a collision, and the routing will pick between them at random.

Add `disable-model-invocation: true` to anything with a side effect or anything you want to control the timing of. It costs nothing at routing and stays available as `/name`.

Then:

```
scripts/validate-skills.sh
```

It checks the frontmatter, the 500-line ceiling, self-promotional links, and flags descriptions that overlap an existing skill.

## Licence

MIT, see `LICENSE`. Derived content keeps its original licence, see `CREDITS.md`. The Apache 2.0 licence of `impeccable` requires its attribution be preserved.
