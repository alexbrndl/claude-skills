# design-eng

Design engineering skills for Claude Code. Ten skills I own, four commands that wrap the lifecycle, and the rest referenced from the people who maintain it better than I would.

The bet is not "more skills". Only skills with automatic invocation compete when Claude picks one, so every skill you install makes the next choice slightly worse. This library carries what I actually use and declares the rest.

## Install

```
/plugin marketplace add alexbrndl/design-eng
/plugin install design-eng@alexbrndl-skills
```

That is the whole library. It has no dependencies, on purpose: a `dependencies` entry that cannot be resolved disables the plugin that declared it, and none of the skills below are needed for the ten in here to work.

The commands do call skills from elsewhere, and a command whose step points at a skill you do not have will tell you so instead of skipping it quietly. Install what you want:

```
/plugin install mattpocock-skills@claude-plugins-official   # spec and ticket flows
/plugin install superpowers@claude-plugins-official          # debugging, verification, code review
/plugin marketplace add addyosmani/agent-skills              # the engineering lifecycle
/plugin marketplace add anthropics/knowledge-work-plugins    # accessibility-review, design-handoff
npx skills@latest add emilkowalski/skills -a claude-code     # motion and UI craft
npx skills@latest add shadcn-ui/ui -a claude-code            # shadcn, migrate-radix-to-base
```

After the two `marketplace add` lines, install the plugin each one carries: open `/plugin`, find it in the list and take the name from there rather than guessing it. Then `/reload-plugins`, or restart, before checking that anything landed.

## The four commands

Commands are the point of the library. They wrap the phases so you type one thing instead of remembering forty skill names, and each one calls the skills of its phase in order.

| Command | Phase | What it does |
|---|---|---|
| `/define` | Define, Plan | Settles intent and visual direction, then cuts the work into slices that ship on their own |
| `/build` | Build | Searches for what already exists before writing, then implements one slice |
| `/review` | Verify, Review | Drives it in a browser first, then the isolated checklist and judgment passes |
| `/ship` | Ship | Commits, hands off, and writes down the decision someone will question later |

Each command stops at the first question only you can answer.

Each one also starts by looking at the repository it is running in. If the project ships skills of its own in `.claude/skills/`, the ones whose moment falls in the command's phase run alongside the library's. When a project skill and a library skill claim the same moment, the project's wins and the library one is skipped, and the command says which. That rule lives in `including-project-skills`, not copied into each command.

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

Everything else comes from the dependencies: the engineering lifecycle from `agent-skills`, spec and ticket flows from `mattpocock-skills`, debugging and code review from `superpowers`, `webapp-testing` from `example-skills`, motion and UI craft from `emilkowalski-skills`.

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
