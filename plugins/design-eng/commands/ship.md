---
description: Get the work out, and leave something behind for the next person
disable-model-invocation: true
argument-hint: [what is shipping]
---

Ship: $ARGUMENTS

## First

0. `/including-project-skills Ship`. If this repository ships its own skills, the ones that belong to Ship run alongside the list below. On a collision, the project's skill wins and the library one is skipped. Release process is the thing teams specialise most, so expect one here.

## Get it out

1. `/git-workflow-and-versioning` for the commits and the branch. One thread of work per commit, message that says why rather than what.
2. `/design-handoff` when engineering picks the work up from a design: measurements, states, edge cases, tokens.
3. `/shipping-and-launch` for anything user-facing going to production.

## Leave a trace

4. `/documentation-and-adrs` when the work settled a decision someone will question in six months. The decision and the constraint that forced it, not the whole debate.
5. `/prose` on anything a human reads: release notes, the PR description, the changelog entry.

## Before you hand it back

The branch, the commits in order, and the one line I would paste into Slack. If a decision was made along the way that is not written down anywhere, write it down now.

A `/skill` above that does not exist on this machine is a missing install, not a step to skip. Name it, point at the Install section of the design-eng README, and carry on with the rest.
