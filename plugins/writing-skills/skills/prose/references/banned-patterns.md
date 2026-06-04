<!-- Adapted from stop-slop by Hardik Pandya (https://hvpandya.com), MIT license.
     Discards the original adverb ban, the absolute em-dash ban, and the 1-10 scoring system. -->

# Banned patterns

Detailed editing pass. Match a pattern, apply the fix, move on.

## Throat-clearing openers

Announcement phrases before the actual point. Cut them and state the point.

| Pattern | Example | Fix |
|---------|---------|-----|
| "Here's the thing:" | "Here's the thing: caching is hard." | "Caching is hard." |
| "Here's what / this / that [X]" | "Here's what makes it slow." | Name what makes it slow. |
| "Here's why [X]" | "Here's why it matters." | State why directly. |
| "The uncomfortable truth is" | "The uncomfortable truth is nobody reads docs." | "Nobody reads the docs." |
| "It turns out" | "It turns out the cache was stale." | "The cache was stale." |
| "The real [X] is" | "The real problem is latency." | "Latency is the problem." |
| "Let me be clear" | "Let me be clear: this is broken." | "This is broken." |
| "The truth is," | "The truth is, it never shipped." | "It never shipped." |
| "I'll say it again:" | — | Delete. Say it once. |
| "I'm going to be honest" | — | Delete. Just be honest. |
| "Can we talk about" | "Can we talk about error handling?" | "Error handling is missing." |
| "Here's what I find interesting" | — | State the interesting thing. |
| "Here's the problem though" | — | State the problem. |

Any "here's what / this / that" construction is throat-clearing. Cut it.

## Emphasis crutches

These add no meaning. Delete them.

| Pattern | Example | Fix |
|---------|---------|-----|
| "Full stop." / "Period." | "It doesn't work. Full stop." | "It doesn't work." |
| "Let that sink in." | — | Delete. |
| "This matters because" | "This matters because users churn." | "Users churn." |
| "Make no mistake" | — | Delete. |
| "Here's why that matters" | — | State why, or cut. |

Also cut: "At its core", "In today's [X]", "It's worth noting", "At the end of the day", "When it comes to", "In a world where", "The reality is".

## Business jargon

Replace with plain language.

| Avoid | Use instead |
|-------|-------------|
| Navigate (challenges) | Handle, address |
| Unpack (analysis) | Explain, examine |
| Lean into | Accept, embrace |
| Landscape (context) | Situation, field |
| Game-changer | Significant, important |
| Double down | Commit, increase |
| Deep dive | Analysis, examination |
| Take a step back | Reconsider |
| Moving forward | Next, from now |
| Circle back | Return to, revisit |
| On the same page | Aligned, agreed |

## Meta-commentary

Self-referential asides. The text should move, not announce its own structure.

| Pattern | Example | Fix |
|---------|---------|-----|
| "Hint:" | — | Delete. |
| "Plot twist:" / "Spoiler:" | — | Delete. |
| "You already know this, but" | — | Delete the hedge, keep the point. |
| "But that's another post" | — | Delete. |
| "X is a feature, not a bug" | — | State what X does. |
| "Dressed up as" | — | Name the thing plainly. |
| "The rest of this essay explains..." | — | Delete. Let the essay move. |
| "Let me walk you through..." | — | Just walk through it. |
| "In this section, we'll..." | — | Delete. |
| "As we'll see..." | — | Delete. |
| "I want to explore..." | — | Explore it. |

## False intimacy / performative emphasis

Manufactured sincerity.

| Pattern | Example | Fix |
|---------|---------|-----|
| "creeps in" | "Doubt creeps in." | Name what happens. |
| "I promise" | "It works, I promise." | "It works." |
| "They exist, I promise" | — | Show one. |

## Telling instead of showing

Announcing difficulty or significance rather than demonstrating it.

| Pattern | Example | Fix |
|---------|---------|-----|
| "This is genuinely hard" | — | Show the hard part. |
| "This is what leadership actually looks like" | — | Show the action. |
| "This is what X actually looks like" | — | Show X. |
| "actually matters" | "Speed actually matters." | Show the cost of slowness. |

## Vague declaratives

Sentences that announce importance without naming the specific thing. Kill these or replace with the specific thing.

| Pattern | Example | Fix |
|---------|---------|-----|
| "The reasons are structural" | — | Name the structure. |
| "The implications are significant" | — | Name the implication. |
| "This is the deepest problem" | — | Name the problem. |
| "The stakes are high" | — | Name what's at stake. |
| "The consequences are real" | — | Name the consequence. |

## Fake binary contrasts

False drama through a setup-and-reversal. State the point directly; drop the negation.

| Pattern | Example | Fix |
|---------|---------|-----|
| "Not because X. Because Y." / "Not because X, but because Y." | "Not because it's slow. Because it's wrong." | "It's wrong." |
| "[X] isn't the problem. [Y] is." | "Speed isn't the problem. Accuracy is." | "Accuracy is the problem." |
| "The answer isn't X. It's Y." | "The answer isn't more servers. It's caching." | "Caching solves it." |
| "It feels like X. It's actually Y." | "It feels like a bug. It's actually config." | "It's a config issue." |
| "The question isn't X. It's Y." | "The question isn't how. It's why." | "Ask why." |
| "Not X. But Y." / "not X, it's Y" / "isn't X, it's Y" | "Not a tool. A platform." | "It's a platform." |
| "It's not this. It's that." | — | State "that". |
| "stops being X and starts being Y" | "It stops being a hobby and starts being work." | "It's work now." |
| "doesn't mean X, but actually Y" | — | State Y. |
| "is about X but not Y" | — | State what it's about. |
| "not just X but also Y" | "Not just fast but also cheap." | "Fast and cheap." |

## Negative listing

Listing what something is *not* before revealing what it *is*. A rhetorical striptease.

| Pattern | Example | Fix |
|---------|---------|-----|
| "Not a X... Not a Y... A Z." | "Not a framework. Not a library. A runtime." | "It's a runtime." |
| "It wasn't X. It wasn't Y. It was Z." | — | "It was Z." |

State Z. The reader doesn't need the runway.

## Dramatic fragmentation

Sentence fragments for emphasis read as manufactured profundity.

| Pattern | Example | Fix |
|---------|---------|-----|
| "[Noun]. That's it. That's the [thing]." | "Caching. That's it. That's the fix." | "Caching fixes it." |
| "X. And Y. And Z." | "Fast. And cheap. And simple." | "Fast, cheap, and simple." |
| "This unlocks something. [Word]." | "This unlocks something. Speed." | "This makes it faster." |

Complete sentences. Trust content over presentation.

## Rhetorical setups

These announce insight rather than deliver it.

| Pattern | Example | Fix |
|---------|---------|-----|
| "What if [reframe]?" | "What if the cache was the problem?" | "The cache was the problem." |
| "Here's what I mean:" | — | Just mean it. |
| "Think about it:" | — | Delete. |
| "And that's okay." | — | Delete the permission. |
| "By the time X, I was Y." | — | State the fact. |
| "X that isn't Y" | "code that isn't tested" | "untested code" |

## False agency

Inanimate things given human verbs. A person does something to make those things happen. AI loves this because it avoids naming the actor.

| Pattern | Why it's wrong |
|---------|----------------|
| "a complaint becomes a fix" | The complaint did nothing. Someone fixed it. |
| "a bet lives or dies in days" | Bets don't have lifespans. Someone kills the project or ships it. |
| "the decision emerges" | Decisions don't emerge. Someone decides. |
| "the culture shifts" | Cultures don't shift on their own. People change behavior. |
| "the conversation moves toward" | Conversations don't move. Someone steers. |
| "the data tells us" | Data sits there. Someone reads it and draws a conclusion. |
| "the market rewards" | Markets don't reward. Buyers pay for things. |

Name the human. "The team fixed it that week" beats "the complaint becomes a fix." If no specific person fits, use "you" to put the reader in the seat.

## Narrator-from-a-distance

Floating above the scene instead of putting the reader in it.

| Pattern | Fix |
|---------|-----|
| "Nobody designed this." | "You don't sit down one day and decide to..." |
| "This happens because..." | Put the reader in the scene. |
| "This is why..." | Same. |
| "People tend to..." | "You" beats "people". |

## Passive voice

Every sentence needs a subject doing something. Passive voice hides the actor and drains energy.

| Pattern | Fix |
|---------|-----|
| "X was created" | Name who created it. |
| "It is believed that" | Name who believes it. |
| "Mistakes were made" | Name who made them. |
| "The decision was reached" | Name who decided. |

Find the actor. Put them at the front of the sentence.

## Sentence starters and rhythm

| Pattern | Fix |
|---------|-----|
| Sentences starting with What, When, Where, Which, Who, Why, How | Restructure. Lead with the subject. "What makes this hard is..." becomes "The constraint is..." |
| Paragraphs starting with "So" | Start with content. |
| Sentences starting with "Look," | Remove. |
| Three-item lists | Two items beat three. |
| Questions answered immediately | Let them breathe or cut them. |
| Every paragraph ends punchily | Vary endings. |
| "Not always. Not perfectly." | Hedging disguised as reassurance. Cut. |
| Lazy extremes (every, always, never, everyone, nobody) | False authority. Use specifics. |
