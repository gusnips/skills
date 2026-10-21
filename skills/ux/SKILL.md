---
name: ux
description: 'Design, build and finish anything people see in an app, so it fits the product, answers every action, never dead-ends, and doesn''t look like every other AI-made app. Covers new screens and flows, redesigns, the special states (loading, empty, error, success, offline, 404, a new version out), the finishing pass after a feature, a marketing landing page, and reorganizing an app''s pages and menus. Keeps the project''s PRODUCT.md and DESIGN.md, and writes them when they''re missing. Use for any UI or UX work, even when the user never says "ux": build or change a page, component, form, flow or animation; make it nicer, clearer or less generic; fix an empty state, an error message or a loading state; polish, finish, wrap up, harden or clarify a feature; a landing page, homepage or marketing site; navigation, sidebar, menus or a dashboard. Not for backend-only work.'
version: 1.0.0
user-invocable: true
argument-hint: "[init | polish | states | landing | reorganize] [scope]"
metadata:
  opencode/slash: "true"
---

# UX

Build what people see so it's right for them, true to the product, and clearly this product's,
not the default every model reaches for.

Scope: $ARGUMENTS

## Start here

1. Read PRODUCT.md at the repo root and the DESIGN.md nearest the files you touch (an app can
   have its own). They say who it's for, what's true, and how this product looks and moves.
2. Missing? Run init first (`references/init.md`), then come back: PRODUCT.md when it's
   missing, DESIGN.md when the app already has screens. A small fix skips this and says in its
   report that `/ux init` would help. A brand-new app gets its DESIGN.md after its first
   screens exist, not before.
3. Read the code that already does this job: the component, the screen beside it, the app's own
   kit, the sibling apps. In a JS app our packages come before your own code: `@gusnips/react`
   and `@gusnips/server` already solve most of the states below (`references/states.md` maps
   them).
4. Pick the command from the first word of the scope and read its reference:
   - `init`: write or refresh PRODUCT.md and DESIGN.md. `references/init.md`.
   - `polish` (or finish, wrap up, harden, clarify): the finishing pass on what changed.
     `references/polish.md`.
   - `states`: find and build the special states of an app or an area. `references/states.md`.
   - `landing`: build or rebuild a marketing home page. `references/landing.md`.
   - `reorganize`: decide an app's pages, menus and page parts, then move them.
     `references/reorganize.md`.
   - Anything else: build or change it with the rules below.

## Pick the design, don't default to it

Left alone, a model builds the same app every time: a centered hero, three same-size cards, a
stat row, a modal for every edit, a gray box that says "No data". Each is a first idea nobody
chose. For anything bigger than a spacing, label or token tweak:

1. Name the reflex: the version you'd build without thinking. It stays on the list, so it has
   to win on merit.
2. Think of five versions that differ in kind, not in color: another layout, another pattern,
   another interaction, another home for it (inline, its own page, a drawer, a step in a flow,
   or no screen at all because a good default does the job). At least one comes from the
   product's own world: the things it handles and the words its users say.
3. Look before you pick: what this repo already does for the same job (reuse wins a tie), how
   the best product in the category does it (Slack and Discord for messages, Linear for lists,
   Stripe for billing), and what the sibling apps did, so this one isn't a copy.
4. Pick one for this person on this screen, and put it as "X over Y because ...". "Cleaner" and
   "more modern" aren't reasons. Who it serves, what it saves them and what it fits are.
5. Do this in your head, not in chat: the user sees the pick and its line. When two finalists
   are close, build both behind a dev-only switch (`?v=<name>`), ask which one, then delete the
   loser and the switch.

## Every action answers

Every press, click, submit, toggle, drag and shortcut shows a response within about 100 ms,
even a small one. Silence reads as broken, and people press again. Pick the response by how
long the work takes:

- Local and instant: the result is the answer. The toggle flips, the row moves. A pressed
  state (a darker fill, a 0.97 scale) covers the moment in between.
- A request: the control goes pending at once, keeps its label ("Save" with a spinner, or
  "Saving..."), and blocks a second submit. Show a spinner only past about 300 ms, and once it
  shows keep it at least 400 ms so it never flashes. End with the result in place, or a toast
  that reuses the button's verb ("Invite sent to Ana"), never "Success".
- Safe to predict (rename, reorder, like, archive): change it at once and put it back, with a
  message, if the server says no. A delete that can be undone offers Undo instead of a confirm.
- Long (more than about 10 s: imports, exports, generation): don't hold anyone on a spinner.
  Run it in the background, show progress where they'll look (the row, a drawer, a badge), let
  them leave, and tell them when it's done, with a link to the result.
- Autosave says so: "Saving...", then "Saved". A failed save keeps the input and says what to do.

The answer shows where the person is looking: on the button, in the row they changed. A corner
toast is for news from somewhere else. Feedback isn't the same as animation: a command palette
needs no motion, but it still needs a visible result.

## Never dead-end

- An error says what failed, the likely cause and the fix, with a retry when a retry can work.
  When it can't (a plan limit, a missing permission, a file that's too big), it teaches the way
  out: who can grant access, which plan has it, what to change ("That file is 12 MB. The limit
  is 10 MB."). Never a raw code, a bare "Something went wrong", or nothing at all.
- An empty state says what this place is for, what goes in it and how to add the first one,
  with the button that does it.
- A failed load never shows as empty: "No invoices" after a failed request is a lie. A failed
  refresh keeps what's on screen and says it may be out of date.
- What the person typed survives every error, every sign-in and every reload.
- A tab left open across a deploy never goes white: chunk errors and stale builds recover on
  their own, once.
- A plan limit is an offer, not an error: what they hit, what the next plan gives, and the
  button to get it.

`references/states.md` lists every special place, how to build it, and which of our helpers
does the work.

## Multi-step flows

Every finished step stays one press away. A finished step stays above the current one, marked
done (a check) and showing what the person gave, with an Edit button carrying a pencil icon that
goes back to it with their values still filled in. Set the finished steps visibly apart from the
one being filled in (a tint, a border, space), so nobody wonders which part is still open. What
a step found for them (say, the provider behind an address) opens the next step with its own
Change, not as another finished step. Ask only what changes what comes next.

## Carry what you already know

- What someone is looking at lives in the URL: the filters, the tab, the open item, the page of
  a list. Refresh, Back and a shared link all land on the same view. URLs people see use slugs,
  not raw ids.
- Don't ask for what the app already has: the email from the last screen, the search they're
  on when they ask to watch it, the workspace they're in.
- A notification, email or toast links to the exact thing: the row, the tab, the list already
  filtered.
- After sign-in, people land where they were going, not on the home page.
- Words match the real action: "Connect" links something that exists, "Create" makes a new one.

## One product, one world

A product looks like one thing across its site, sign-in, app, emails and docs. New parts come
from DESIGN.md and the app's own components, drawn the way its current art is drawn. Breaking a
DESIGN.md rule is the user's call; once agreed, DESIGN.md changes in the same commit. A fix on
the web also gets checked on the phone app and on sibling apps that share the screen.

## Build it, then look at it

- Read `references/craft.md` before your first UI edit of the session and build to it without
  reciting it: the floor (contrast, type, spacing, focus, targets, forms, motion numbers) and
  the AI defaults to refuse.
- Words follow COPY & VOICE in AGENTS.md and `~/.agents/rules/translations.md`. Every locale of
  a changed string lands in the same commit.
- Look at it running: desktop (1440×900) and phone (390×844) in one batch, both themes if the
  app has two, and once with reduced motion. Walk the states you touched: a slow network, an
  error, empty, the longest real name. Fix everything you found in one pass, look once more,
  and stop.
- Run lint and typecheck for the package you touched, and only the test files you changed.

## Report

- What you built, with the "X over Y because ..." line for each real design call.
- What you checked, on one line.
- The calls that are the user's, numbered and few: your pick and the alternative.
- What you saw and left alone, one line each.
