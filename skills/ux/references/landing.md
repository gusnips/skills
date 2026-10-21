# Landing

Make the landing page show, while you scroll or play with it, what the product does and who it's
for. Not a brand poster with text under it: the page moves, and the movement is the explanation.

Every landing this makes moves. No two move the same way, because each one's motion comes from
what that product does. A story that runs straight down the page is one option, not the default.

The scope after `landing` is a site path (`apps/site`) or sibling repos (`app-a app-b`). Empty
means the home page of the marketing site in this repo: `apps/site`, `apps/marketing` or `site/`,
whichever exists. Other pages (pricing, docs, blog) stay as they are, except where the new home
page breaks a link to them.

## The bar

Every page meets all five. Everything else is free.

1. The first screen says what the product does and who it's for, in words a child could follow.
2. The main motion is the product doing its job. Something real goes in and what the product
   makes of it comes out, as you scroll, type, drag or watch. Hide the words: the motion alone
   should still show what the product does. Fades, floating shapes and parallax layers are
   decoration. They can stay, but they don't count.
3. The people it's for are in the story. They can be the examples it works on, one chapter each,
   or a switch that changes the demo. Readers find their own case without hunting for it. When
   there's only one kind of customer, the story is about their work instead: the jobs they hand
   over, the questions their buyers ask, one sale from start to finish.
4. Everything shown is something the product can really do. That's what "true" means here: can
   do, not did. Examples are welcome and should read as examples: a made-up business, name, price
   and conversation, labeled as an example. What never goes on the page:
   - anything that suggests the product already has users: customer counts, "four customers
     served today", testimonials, logos, results;
   - an internal setting dressed up as a selling point, like a timeout, a debounce window or a
     limit from the code. A buyer can't tell what "7 s" means.
5. The brand serves the explanation. Keep what the site already owns and put it to work in the
   story. A page that is all brand and no "what it does" misses the bar.

This decides what the page shows and how it moves. The look comes from the site's DESIGN.md and
`craft.md`. One world owns the page: however much it changes as you scroll, the type, grid,
components and the product itself stay one system.

## 1. Learn what the product really does

Read PRODUCT.md, the app's features (routes, onboarding choices, templates, integrations, plans)
and the current site. Then fill in one sentence: "It takes ___ and turns it into ___, for ___."
For example, a WhatsApp assistant takes a customer's question and turns it into an answer and a
booking, for small business owners. The page's motion comes from this sentence.

List who it's for: 2 to 5 kinds of people or jobs. Each one needs a feature, template or setting
you can point to in the code. If the product serves one kind of customer (only phone resellers,
only dentists), don't invent personas to fill chapters. List that person's use cases instead:
the moments, jobs or questions the product takes off their hands.

When the product makes things (images, posts, reports, rows of data), the page shows things it
really made. Generate a pool of examples with the product's own pipeline and keep only the good
ones. Then show a different few on each visit, chosen after the page loads, so the server render
and search engines get a fixed set. Label them as examples. Before generating, check what one
example costs. Start with a small batch, and scale up only if the results are good. Report how
many you made, what it cost and how many you kept.

List what the site already owns: a mascot, illustrations, photos, a live demo, animations, a
section people remember. Keep all of it and use it more. Drop one only when it says something
false.

When the product talks (a chat assistant, a bot, anything that writes replies), every example
conversation is one it could really have. That means its real tone and its real limits: it gives
a price only if it reads one from a price table, books only if it can book, and hands over to a
person the way it really does. Write the replies from its prompt and rules, and check each one
against a feature in the code. Don't copy real or test conversations from the database or the
demo: examples are made up on purpose. A reply the product couldn't give is a false promise.

Examples use today's things: current phone models at current prices, this year's apps. An
example with a six-year-old phone makes the whole page look old.

## 2. Find this page's own idea

Three choices make the page:

- The spine: the order the story is told in.
- The driver: what moves the story. It can be the scroll, the reader's hand (typing, dragging,
  hovering, choosing), time, or the product itself running on the page.
- The motion: what moves, and how.

Take all three from the sentence in step 1, not from a page you've seen.

Some spines, to show the range. This is not a menu to pick the first item from:

- one job from start to finish, each scroll step one stage of it;
- one thing followed through the product (a message, a lead, a file) as it changes;
- a day, with an hour per scene;
- one chapter per kind of person;
- before and after, with the reader scrubbing between them;
- the result assembled piece by piece until it's whole;
- a zoom from the whole picture into one detail, or out of it.

The page scrolls down; the story doesn't have to, and it doesn't have to scroll at all. Some
forms, to show the range:

- a track that slides sideways while the page holds still;
- a camera that zooms from the whole into one detail, or flies through one object;
- a thing that turns, unfolds, opens or comes apart, in 3D if it earns it;
- a scene the reader plays: they type their city, drag a slider or pick their trade, and the
  product answers;
- the product running for real on the page, live or replayed from a real run;
- cards dealt out, a stack that fills, a drawing that draws itself, a scene generated new on
  each visit;
- several of these, changing as the story changes gear.

Go as far as the idea earns: SVG, canvas, WebGL, shaders, physics. Use the one the product calls
for. A plain story down the page is right when its steps are taller than a screen, hold text
people read or copy, need jump links that land on each step, or build up one thing that stays in
view. A sideways track suits stages of the same size, a before and after, a row of outputs, or
anything wide. A scene the reader plays suits a product whose proof is the reader's own case. A
3D object suits a product that works on a physical thing.

For the motion, ask what the product literally does to things, and show that happening:

- a scraper turns web pages into rows, so a page's text can fall into a table;
- a post generator fills an empty square;
- an inspection tool walks around a machine and marks what it finds.

Write five ideas that fit this product, each with a different spine, driver or motion. At least
two of them aren't a story told straight down the page, so the page is picked, not defaulted.
Pick the one this product owns: the one that would look wrong on any other product. When it calls
for a technically extraordinary effect (a shader, real 3D, physics), build that part as its own
component that loads after the first screen.

Then check the landings already built this way, so this one isn't a copy. Their choices sit in
the `## Landing` section of each site's DESIGN.md, in the repos next to this one. This works from
a worktree too:

```bash
root=$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")/..
find "$root" -maxdepth 5 -name DESIGN.md -not -path '*/node_modules/*' -not -path '*/.claude/*' \
  -exec grep -H '^Spine:\|^Driver:\|^Motion:' {} +
```

If your pick shares its spine, driver and motion with one of them, pick again. Sharing one or two
is fine. Sharing all three is the same page in another color.

## 3. Write the brief

Write it into the site's DESIGN.md, under `## Landing`, so every later change to this page reads
it, and so it survives a long run that loses its notes. It holds:

- `Spine:`, `Driver:` and `Motion:`, one line each, with those exact labels at the start of the
  line. They are how the next landing avoids copying this one.
- The five ideas from step 2, one line each, and why this one won.
- The sentence from step 1.
- Who it's for, and where each of them shows up in the story.
- The first screen: what it does, who it's for, the main button, and a way to jump to your own
  case if the page has more than one.
- Each step of the story, one line each: what's on screen, what moves it, what moves, and what
  that shows.
- Any library the idea needs beyond what the site has, with its weight and when it loads.
- After the story: how to start in a few short steps, the price or a link to pricing, and a real
  close with the main button again.

The build and motion rules below stay here; don't copy them into the brief.

## 4. Build it

If the site already has a look (a DESIGN.md, or a clear style in its code), keep it and let the
story grow from it. If the user asked for a new look, or the site has none, pick the world with
the five versions from SKILL.md, each taken from the product's world. When two are close, build
the first screen in both behind a dev-only `?v=` switch and let the user pick.

Build the page still first: every step a finished frame, in order, with no motion. Then add the
motion on top. A page that only works while moving is broken for anyone who turns motion off, and
for every search engine.

Words follow the house copy rules. Headlines speak to the reader, in the second person, and say
what happens ("You're with a customer. It books the next one."). They are not a slogan, and not a
customer talking in the first person ("I've got scissors in my hand"): that reads like a caption
nobody said. Every instruction to the reader uses one verb form across the page. In pt-BR that's
"responda", "aponte", "fale", never the spoken "responde" or "aponta". Next to "Ela atende",
"Responde umas perguntas" reads as "she answers some questions". Give every step title a subject
or an imperative, never a bare "Começa em 10 minutos" (what starts?). Every locale lands in the
same commit, each written like a native company wrote it.

## Build rules

The first test run got each of these wrong and had to rebuild. Build them in from the start.

- New art is drawn the way the site's current art is drawn. If the mascot is hand-painted with a
  texture filter, everything new is painted with the same filter, line weight and grain. Reuse
  its SVG filters and components, and read DESIGN.md's rules for new illustrations before you
  draw. Clean vectors next to a painted mascot look like two websites.
- A step is finished when the reader arrives at it: its top reaches the header, its panel stops
  in a sideways track, the zoom settles. Jump links land exactly there, so a sign still
  half-painted at that point is what visitors see. Entry animations run while the step
  approaches, never after it arrives.
- Motion plays where the reader is looking. A figure that draws as it comes into view draws
  while it is on screen, not while it rises past the bottom edge. A CSS `entry` range on a tall
  figure is done before its lower half shows, so its rows land unseen: one home page shipped
  that way and looked still. Measure where each part moves (step 5).
- Each background fills to the edges. No strip of the old color at the top or bottom.
- Text that proves something (a message, a stamp, a price, a result) is readable at rest: 4.5:1
  for normal text and 3:1 for large text, measured after any texture or mask. A reveal ends at
  full strength as soon as the element is fully on screen.
- Nothing the site already floats (the chat button, a greeting pop-up, a cookie bar) covers the
  story's text, at any screen width. Check every step.
- The hero fills the first screen at every size, from a phone to a wide monitor. If the next
  section shows before anyone scrolls, it's on purpose and whole enough to read, never a cut
  sliver of the next scene. A negative margin or an overlapping edge between sections must not
  reach into the first screen.
- On a phone, the first screen still says what and for whom, and holds the jump links if the page
  has them. Put them above a big image if they don't fit.
- Each step shows what's new in it. A detail the reader just saw, like the same setup answer
  under every chapter, doesn't come back. Show it once, then show what that step's example has
  of its own (its price row, its hand-off person).
- Days, times, prices and hours agree across the page and with the product's setup. If a reply
  says "tomorrow from 8", the day it's sent and the business's opening hours have to make that
  true.

## Motion rules

Any form goes. These rules keep it readable, fast and in the reader's hands.

- The reader stays in control. The scroll can drive the story, but it never takes over the
  scroll: don't catch the wheel, change scroll speed or snap against the thumb. Pin with
  `position: sticky` and drive the scene from how far the reader has scrolled. A sideways track
  is a sticky section as tall as the track is long. A scene the reader plays answers their hand
  at once and never blocks the page around it.
- Pick the lightest tool that does the idea. First CSS scroll-driven animations
  (`animation-timeline: view()` or `scroll()`) with a still fallback under `@supports`, then the
  motion library already in `package.json` (`framer-motion`: `useScroll` with `useTransform`),
  then SVG or canvas. Only then a new library (GSAP, three.js, a shader), when the idea needs it.
  It loads after the first screen, its weight goes in the brief, and the page reads whole before
  it arrives. A library that smooths or hijacks the scroll (Lenis and the like) is out, by the
  first rule.
- On the page, animate `transform`, `opacity` and `clip-path`, never layout. A canvas or WebGL
  scene pauses when it is off screen and stays smooth on a mid-range phone.
- Text stays real HTML. Each step is a `<section>` with its own heading and an `id` that jump
  links can use, and a step of a sideways track or a scene gets one too. A canvas or 3D scene
  sits beside or behind the words, never in place of them: no words baked into images or a
  canvas, because search engines, screen readers and translators can't read them.
- With `prefers-reduced-motion`, the steps sit one after another as still frames, with a short
  crossfade at most. A scene the reader plays still answers, without the travel. Only the motion
  is lost.
- On a phone, tell the same story in a form a thumb handles: shorter pins, a swipe row for a
  sideways track, a tap where the desktop hovers, a lighter scene. Scrolling feels like any other
  page.
- The first screen loads as fast as the old one did, and later steps load their images as the
  reader gets close. Run Lighthouse on mobile before and after. If the score drops, cut weight
  until it's back.

## 5. Check it

Take screenshots at a wide monitor (about 2000×1160), a laptop (1440×900) and a phone (390×844),
each of the first screen, every step, and one frame halfway through the main motion; for a scene
the reader plays, one after a real input; the same with reduced motion on; and a tap on each jump
link. Then measure where the motion plays: scroll in small steps in headless Chrome and log, for
each animated element, where it sits on screen while its animation is between 5% and 95% done
(`el.getAnimations()[0].effect.getComputedTiming().progress`). Motion that lives in the bottom
fifth of the screen reads as no motion. Check every build rule and `craft.md` against each step.
Fix everything in one batch, confirm with one more round, and stop.

Run screenshots, Lighthouse and the build in the foreground, with a timeout. A sub-agent that
leaves them in the background can sit waiting for a notice that never comes.

Before you hand off, run what the repo's CI runs on the files you touched, format and dead-code
checks included. Markdown you wrote gets formatted too, and a type exported but only used in its
own file fails a dead-code check. The first test run's pull request went red on both.

The page's pattern is new to the design system: how the story is drawn and how it moves. Record
it in the site's DESIGN.md (the brief under `## Landing`, plus any new illustration or motion
rule in its own section), so later pages on this site reuse it.

Then run the polish pass (`polish.md`) on the site.

Commit after the brief, after the still page, after the motion, and after the fixes.

## Sibling sites

Sites that grew from one template run together: `/ux landing app-a app-b app-c`. Each gets its
own spine, driver, motion and look, and step 2's check runs across all of them. The shared
template is where the code came from, not a style to keep. One writer per repo; different repos
can run at the same time.

## Report

- The sentence from step 1, and who it's for.
- The spine, driver and motion you picked, and the four ideas you didn't.
- The landings you checked against, and the spine, driver and motion each one uses.
- The screenshots, and the Lighthouse mobile score before and after.
- The pull request.
