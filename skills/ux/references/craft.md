# Craft

The floor every screen meets. DESIGN.md beats anything here; your own habit doesn't. Build to
it without reciting it, then check the result, not the intention.

## Pick the mode first

A screen has one main job, and the job sets how dense it is:

- Persuade (the site, pricing, sign-up): one idea per screen, big type, room, one main button.
- Operate (the app): dense, easy to scan, predictable. Rows over cards, the next action obvious,
  nothing decorative between the person and their data.
- Read (docs, help, long text): a 65–75 character column, quiet chrome, clear way-finding.
- Experience (a landing's story, a demo): motion and art can lead, but the words still work alone.

A page that mixes modes picks one per section.

## Layout and hierarchy

- One main thing per screen, and it's the biggest, highest or strongest thing on it. When three
  things compete, demote two.
- Many texts at the same weight means the hierarchy is missing: decide what's read first, second
  and last, and show it in three clear steps of size, weight or color, not ten small ones.
- Tight inside a group, more space between groups, more space above a heading than below it.
- Cards are for things you could pick up (an item, a task), not for every paragraph. Never a card
  inside a card. Rows beat cards for anything people scan or compare.
- Numbers in tables use tabular figures and align right.

## Type

- Body text at least 16 px on phones; iOS zooms into inputs below that.
- Reading text runs 65–75 characters wide. Display type tops out around 6rem. Letter-spacing no
  tighter than -0.04em; -0.02 to -0.03em usually reads better.
- Sentence case. `text-wrap: balance` on headings, `pretty` on paragraphs.
- Numbers that change (counters, prices, timers) use `tabular-nums`, so they don't jiggle.
- Test with the longest real name and the longest locale. Wrap, or cut with an ellipsis and show
  the full text on hover. Never let it overflow.

## Color and contrast

- Text 4.5:1. Large text, icons and input borders 3:1. Measure on the real background, after any
  texture, in both themes.
- Color goes on actions and status; big surfaces stay neutral. A status color always comes with
  a label or an icon, never alone.
- Secondary text on a colored surface is a shade of that color, not gray.
- Light or dark comes from where it's used (a dashboard open all day, a phone in the sun), not
  from the category.
- Theme what the browser draws: text selection, the caret, scrollbars, focus rings,
  `color-scheme` on `<html>` and the `theme-color` meta. No flash of the wrong theme on load.

## Depth and shape

- A border or a shadow, not both: a hairline under a wide soft shadow is the ghost card.
- Shadows have an offset and a soft blur. No colored glow. No hard block shadow unless the world
  really is brutalist.
- Corner radii come from one short ladder (say 6, 8 and 12 px, pills for small controls). An
  inner radius is the outer one minus the padding.

## Motion

- Motion explains where a thing came from, what changed, or that something is working. If it
  explains nothing, cut it.
- Don't animate what people do all day: a command palette, a keyboard shortcut, a list they open
  a hundred times. Instant is the feature there.
- Durations: a press 100–160 ms, a tooltip or small popover 125–200 ms, a dropdown 150–250 ms, a
  dialog or drawer 200–350 ms. App UI stays under 300 ms when it can. Exits run faster than
  entrances.
- Easing: a strong ease-out for things that enter or leave (`cubic-bezier(0.23, 1, 0.32, 1)`),
  `cubic-bezier(0.32, 0.72, 0, 1)` for a drawer. Never ease-in on UI: it feels slow to start.
  Linear only for spinners and progress.
- Animate `transform` and `opacity` (and `clip-path` or `filter` when they stay smooth). Never
  width, height, top or left.
- Enter from `scale(0.95)` and opacity 0, never from `scale(0)`. A popover grows out of its
  trigger (`transform-origin` on the trigger's side). A press scales to 0.97.
- Stagger a list by 30–80 ms per item, and keep the whole entrance short.
- CSS transitions for what people can interrupt (hover, toggles, drawers), keyframes for what
  plays once.
- Hover effects only where hover exists: `@media (hover: hover) and (pointer: fine)`.
- Reduced motion keeps opacity and color changes and drops the movement. Spinners and loops
  follow the contract in `states.md`.
- One authored moment per page, not the same fade-up on every section.

## Interaction

- Hit targets at least 24×24 px, 44×44 on touch. Grow the hit area with padding or a
  pseudo-element, not the drawing.
- Everything clickable has hover, pressed, focus-visible and disabled styles. Focus rings are
  visible and on-brand, and never removed without a replacement.
- Links are `<a href>`, so a new tab and a middle click work. Actions are `<button>`. Never a
  `<div>` with a click handler.
- Tab reaches everything in a sensible order. Escape closes the top layer. Enter submits a form.
  Focus goes back to the trigger when a dialog closes.
- A modal only when the task needs the interruption. Inline editing, a drawer or a page usually
  fit better.
- Back and refresh work: state in the URL, scroll position restored, deep links to tabs and items.
- Never block zoom, paste, autofill or text selection.

## Forms

- Labels are always visible. A placeholder shows an example ("ana@example.com"), never the label
  or the instructions.
- Each field gets the right `type`, `inputmode` and `autocomplete`, so the phone shows the right
  keyboard and password managers fill it.
- The submit button stays enabled until it's pressed; then it goes pending and stops a second
  submit. A write that must not run twice sends an idempotency key.
- Errors sit next to their field. On submit, focus goes to the first one. Nothing typed is lost.
- Brazilian documents, phones and CEPs use the masks in `@gusnips/br`: format as they type, and
  validate without blocking the typing.
- Warn before leaving a form with unsaved changes.

## Phones and screens

- Design the phone at the same time as the desktop, not after. Check 390 px and 1440 px together,
  plus about 2000 px for a marketing site.
- Respect the safe areas. No sideways scroll at any width. Tap targets don't touch each other.
- A wide table keeps a sticky first column or turns into a list on a phone. It never just shrinks.

## Emails

An email is a screen too: the product's look, generous spacing, one main button, a plain-text
part, and it still makes sense with images off. The subject says what happened, not "Update".

## AI defaults to refuse

These are what a model builds when it isn't deciding. Any of them can be right when the
product's own system has it. Reaching for one out of habit means rewriting it, not toning it
down.

- A small uppercase label above every heading. Let the heading speak.
- Three or four same-size cards (an icon, a title, two lines) as the structure of a page.
- The hero-metric block: one huge number, a small label, three stats beside it.
- Section numbers (01, 02, 03) when the order means nothing.
- Gradient text, glass and blur as decoration, glowing borders, a thick colored stripe down the
  left of cards and alerts.
- The looks every AI-made app shares: a purple-to-blue gradient on white, dark navy with neon, or
  cream with a serif. If yours looks like one of them, it was a default.
- Emoji or Unicode symbols as icons. Use one icon set at one stroke weight.
- Monospace as a "technical" costume rather than for code and data.
- Fake proof: invented metrics, testimonials, logos, "trusted by". Examples are labeled as
  examples.
- Sparklines and progress rings standing in for real content.
- A modal for something that could happen in place.
- A spinner on a blank page where a skeleton would show the shape.

Then give the screen one thing only this product has (the colibri, the Scene drawings, the
breathing status dot), and take away one decoration before you ship.
