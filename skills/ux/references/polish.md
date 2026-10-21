# Polish

The finishing pass after a feature: make it right for the person and coherent with the product,
from the whole app down to the pixel, and leave no litter behind. It does what "finish", "wrap
up", "harden" and "clarify" ask for.

Bias to action. Fix what's clearly wrong and land the low-risk wins yourself: it's all in git,
one command from undone. Ask only for what's really the user's to decide. Over-asking is the
failure here, and so is inventing features nobody asked for.

## Scope

What changed: the scope's own words, or else everything this session changed. Prefer the
context you hold, since you most likely just built it. Otherwise `git status` plus the diff
against the merge-base with main, untracked files included, mapped to what people see: screens,
flows, components, emails, CLI output, docs. Say that list before you start. Files a stage
creates join it.

## The stages

Each stage owns one lane, so they don't undo each other. Run them in this order, because each
one shapes what the next refines:

1. States decide what exists. For each surface, walk `states.md`: loading, empty, error,
   success, offline, permission; long and odd input (a 60-character name, an emoji, 0 and 10,000
   items, right-to-left if the app ships it); a double submit and two tabs racing; a slow
   network; a tab left open across a deploy. Every action answers (SKILL.md). Add what's
   missing.
2. Words: every string, including the ones stage 1 just added. Walk whole paths, not lone
   strings: the button, its pending label, the toast, the error, the email it sends. One term per
   thing everywhere. Verbs match the real action. Errors name the cause and the fix. All locales
   land in the same commit, each written like a native company wrote it (COPY & VOICE in
   AGENTS.md, `~/.agents/rules/translations.md`).
3. Fit: the four questions below, top-down. Always runs.
4. Craft: the surface against `craft.md`, then look at it running (SKILL.md, "Build it, then
   look at it").
5. Tidy: no litter (below). Always runs.
6. Code: run `/simplify` on the changed code: reuse across the codebase, efficiency, structure.
   Hand it whatever quality work you logged.

Stages 1 and 2 run when the change has real frontend work (a reworked screen, a new flow or
state, real copy). A label or token tweak skips them. Stage 6 runs when the change has real logic
(services, API routes, data, workers); types and glue alone don't count. A request that names one
lane ("harden this", "clarify the copy") runs only that stage.

After each stage that changed files: lint and typecheck for the package, the test files you
changed, then one commit in the repo's format. A finding from stage 6 that overturns a decision
from stage 3, or changes a contract, is a call for the user: hold it for the report.

## Fit: the questions

1. Product fit, the one that matters most. Does this make sense for the product, and does it fit
   the whole: its mental model, its names, the screen right next to it? Or does it read like
   another product bolted on? A local win that's incoherent overall is a loss: say how to
   reconcile it. If the app has a `STRUCTURE.md`, check the change against it. A new page goes
   where its rules say, under the names it uses. A change that adds, moves or removes a page
   updates the file in the same commit. A rule that no longer fits is a call for the user, never
   a quiet exception.
2. The design. Would a different one serve the person better? Run the five versions from
   SKILL.md on the core interaction and answer honestly: is what we built the best one for this
   person and this design language, or just the first that worked? Does it match how people
   already think about the task?
3. Patterns: the right one, or the nearest one? If a better pattern is clearly right and cheap,
   adopt it and carry it to the other places that use the old one, so no one-off is left
   fighting the rest. A bigger migration gets logged, not done here. When the problem is the
   app's whole layout (which pages exist, what the menus hold), log a `/ux reorganize` run.
4. Blast radius: what else did this touch? Every flow, screen and feature it now affects,
   contradicts, orphans or makes redundant, plus the other half of the flow and the states that
   got skipped. Update those places here, so the product stays coherent. A separate workstream
   gets logged instead.

## Tidy

Delete what shouldn't ship, scoped to this change: scratch scripts, `.bak` files, debug
fixtures; stray `console.log`, `print` and `debugger`; commented-out experiments and "TODO:
remove" markers; a `.only` on a test; a hardcoded value you meant to swap back; code this change
left unused (check it really is); obvious duplication in the lines you just wrote. The deeper
pass is stage 6.

## Apply, and ask only when you must

Apply directly: bugs, correctness, mechanical fixes, small reversible wins, and the follow-through
from the fit questions.

Hold for the user only:

- a product decision with more than one defensible answer;
- a change outside what we agreed to build;
- something big or hard to undo: a contract, the data model, the product's mental model;
- voice or naming with no single right answer.

Group related findings into one call: "build the other half of the flow" is one decision with
its parts listed, not six. Unsure which side it falls on, and it's small and reversible? Do it.

## How much effort

The default is inline, in this thread, with no sub-agents: you hold the context. Fan out only
when the change is too big for one context (many surfaces, or work you didn't build). Then start
a few read-only inspectors in one batch: one for the fit questions, one per large surface for
states and craft, one for the blast radius. Tell each to start no sub-agents of its own. Merge
their findings, and one writer applies them. Read-only, because parallel writers clobber each
other and the real calls are the user's.

## Report

No wide tables: they wrap into mush in a terminal.

**Applied**: one line each, `✓ <what> (<why, in a few words>)`.

**Your call**: few, numbered. For each:

> **<the decision, as a short headline>**
> <one or two lines: what it is and why it matters>
> I'd pick <X>. The alternative is <Y>.

**Logged for later**: one line each, with why.

**Checks**: one line, `typecheck ✓ · lint ✓ · changed tests 2/2 · desktop and phone ✓`, then the
stage commits.
