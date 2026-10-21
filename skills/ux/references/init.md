# Init

Write PRODUCT.md and DESIGN.md, or bring old ones up to date. Every UI task reads them first, so
no agent has to rediscover the product or make up a look.

## Where they live

- PRODUCT.md at the repo root, one per product.
- DESIGN.md at the root when the whole product shares one look. When apps look different, each
  gets its own beside it (`apps/site/DESIGN.md`, `apps/web/DESIGN.md`). A task reads the one
  nearest the files it touches.

## How

1. Look before you ask: the README, AGENTS.md, the routes, onboarding, plans and prices in the
   code, the marketing site, the locale files, the components and the tokens.
2. Make the calls yourself. Write what the code and the docs show, and mark what you inferred
   with "(guess)" so the next reader knows what to confirm. Ask the user only for a missing fact
   that would change the work (who the main user is, when nothing says): at most three
   questions, once. When nobody answers, write the guess and say so in your first reply.
3. Never invent proof: no customer counts, results, testimonials, logos or prices that aren't in
   the code or the user's own words. Write down what's missing ("No testimonials yet"), so nobody
   makes one up later.
4. An existing file stays the source. Add what's missing, fix what's stale, and keep what the
   user wrote. Leftovers from the old tooling can go: the `<!-- impeccable:product-schema 1 -->`
   comment, a YAML block that copies token values the code already holds, and `.impeccable/`
   folders. Keep any rule they carried.

## PRODUCT.md

True facts and open questions only. Leave out a section that doesn't apply rather than fill it
with filler.

```markdown
# <Product>

## Who it's for

The main users, their situation, and the job they use it for. Others only when real.

## What it does

What it does, why it exists, and what success looks like for the person using it.

## Why this one

What it does that a neighboring product couldn't truthfully claim.

## How people use it

Their day, their devices, where they are. Which jobs are daily and which are rare, each with
its source (a count, the user's words) or "(guess)".

## What it can and can't do

Real capabilities, technical limits, the product's own terms, decisions still open.

## Voice and brand

The name, the tone, and the assets and rules the user made binding.

## Proof on hand

Real demos, data, case studies and press, with paths. And what doesn't exist yet.

## Principles

Three to five product rules that decide future calls.

## Accessibility

Known needs, or the standard to meet.
```

## DESIGN.md

How this product looks, moves and behaves, so the next screen matches. Shorter is better: what
someone needs to build the next screen right, not a copy of the CSS. Token values live in code,
and DESIGN.md says which file.

Write it from what's built. On a brand-new app, build the first screens, then write DESIGN.md
from them, since decisions on paper drift from the code they describe. On an app with screens
and no DESIGN.md, read the tokens, the shared components and a few real screens, then write it.

Use the sections that apply, a few lines each:

```markdown
# <Product>: design

## The world

One or two sentences: what it looks like and why, taken from the product's world. What it is
not.

## Surfaces

Each app (site, app, docs, emails), its mode (persuade, operate, read, experience) and how dense
it is. Light, dark or both, and why.

## Tokens

The file that holds them, and the roles: ground, surface, text, muted text, primary action, each
status. Never a second palette.

## Type, shape and depth

The typefaces and what each is for, the radius ladder, border or shadow, what floats.

## Components

Where the kit lives, the signature pieces, and what never to import.

## States

The source of character (a mascot, a world object, drawings, a status mark) and what plays for
loading, empty, error, success and 404, with the reduced-motion resting pose of each.

## Motion

The idea in one line, the named eases and durations, the rules, and the test that pins them.

## Rules

What this product learned the hard way: "The X rule: ...". Short do's and don'ts.

## Landing

The home page's Spine:, Driver: and Motion: lines, its five ideas and why this one won
(written by `/ux landing`).
```

A rule earns its place when breaking it would make the next screen look like another product.
