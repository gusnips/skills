# States

Everything off the happy path: waiting, nothing here yet, something broke, it worked, it's your
turn, the app changed under you. Most apps build these last and plain. They're where people
decide whether to trust the app, so ours design them like any screen, and the best of them are
the moments people remember.

Run on its own (`/ux states [scope]`): list the scope's surfaces, walk the inventory below for
each, and build what's missing, most-seen first. The polish pass runs the same walk over what
changed.

## Where the character comes from

Each product gets one source of character for its states, taken from its world, and every state
uses it. Never stock art: no gray cloud, broken robot, astronaut or magnifying glass.

Three we've built, to show the range (yours comes from your product, not from this list):

- A mascot that lives in the product's world (a hummingbird for a messaging app) owns loading,
  success and empty. Errors go to an object from that world (a sign hanging by one screw), never
  to a sad mascot: the mascot is the brand, and a broken brand reads as a broken product.
- Schematic drawings made of the app's own material (a code tool drawing its own diagrams): its
  hairlines, one live accent, no text so nothing needs translating, and one shared box so states
  side by side share a horizon. Things draw themselves from a source, because the product derives
  everything from code.
- A status mark with a life cycle (tabrunner): working is a dot that breathes; waiting on you is
  still, amber, with a "?" (never pulsing: a pulse says "busy, not you"); done is a check or a
  cross that clears itself.

Pick it from what the product handles (messages, code, invoices, machines) and how it handles
them. Record it in DESIGN.md's States section with what plays for each moment, so the next
state uses it instead of inventing another.

## The motion contract

- A state scene plays once and rests. Only loading loops.
- The words don't wait for the drawing: they're readable within about 0.3 s, and an error says
  what failed within about 0.2 s.
- The resting style is the finished state. Under reduced motion, show the final pose; nothing
  waits at opacity 0 behind a delay (put staggered entrances behind `motion-safe:` or the media
  query, since reduced-motion resets usually zero the duration but not the delay).
- Spinners and progress bars keep turning under reduced motion, slower: a frozen spinner reads
  as a hang.
- Loops pause when they scroll out of view.
- Pin the contract with one small test, so the next edit can't quietly break it (one app's
  `motion.test.ts` checks every scene's timing, loop count and resting pose).

## The inventory

For each item: when it shows, what it says, and what it offers. The words follow the house copy
rules: plain, specific, the next step named.

### Waiting

- A page loading: a skeleton shaped like the real content (same rows, same heights), shown only
  after about 200 ms so fast loads never flash. Not a spinner centered on a blank page.
- A part loading: its own skeleton, while the rest of the page works.
- A refresh: keep the content. At most a small, quiet indicator.
- Long work: real numbers when you have them ("120 of 400 rows"), named steps when you don't.
  It runs in the background and says when it's done.
- The first load of the app, or a big generation: the one place the product's loading scene
  loops.

### Nothing here yet

- First run: what this place is for, what goes in it, the one button that adds the first one,
  and a preview of what it looks like full (sample rows, labeled as an example). It's where
  people start using the product, so it gets the best scene.
- No results: say what was searched and how to widen it (clear a filter, a near match, a
  broader term). Never only "No results".
- All done (nothing waiting, inbox empty): good news, said like good news, plus what happens
  next.
- Not allowed (a role): who can give access, and a way to ask them.
- Not on this plan: what it does, which plan has it, and the button to get it. Written as an
  offer, not an error.

### Something went wrong

- A field: the message sits under the field and says what to change ("Use at least 8
  characters"). Check on blur or submit, not on every keystroke. On submit, focus goes to the
  first field with a problem. Nothing typed is ever cleared.
- A part of a page: that part shows the error and a retry. The rest of the page keeps working.
- A failed refresh: the content stays, with a quiet line that it may be out of date and a retry.
- A whole page: the problem, its cause, the fix and an action. The request id sits under it in
  small type, for support.
- A crash: an error boundary around each area, not one for the whole app, so the menu stays on
  screen. It offers a reload and a way to report it.
- 404: print the address it looked for, offer the nearest real place (the parent that the URL
  still names) before "Home", plus search if the app has it.
- 403: name who can give access and offer to ask them.
- Offline: say it once, keep what's on screen, hold or disable what needs the network and say
  why, and recover by itself when the connection is back.
- Session expired: sign in again in place, keep what they typed, and return to the same spot.
- A limit: say when it clears ("Try again in 2 minutes") or what clears it (upgrade, delete
  something). Never a retry button that can't work.
- Payment failed or plan ended: what stopped, what still works, and the one place to fix it.
- Down for maintenance: what's affected, when it should be back, where to check.
- Gone (deleted or moved): say so and link to the list it was in.

### It worked

- A small action: the result in place, or a toast with the button's own verb.
- A milestone (the first message sent, the first import, setup done): the product's one authored
  moment. A scene that plays once (the colibri's flight, a stamp), then the next step. One or
  two per product, or it stops meaning anything.
- Saved: "Saved", next to what was saved.

### Your turn

- Something needs the person (an approval, a reconnect, a reply): marked and still, it says what
  to do and where. It never moves like work in progress.
- Unsaved changes: warn when they try to leave, not on every click.
- A destructive action: Undo when it can be undone (trash, archive). When it can't, a confirm
  that names the thing and what goes with it ("Delete 'Q3 report' and its 12 comments? You
  can't undo this."). Typing the name only for the worst ones.

### The app changed under you

A tab stays open for days. Deploy, and its next click asks for a file that's gone, or the old
code reads a field the API just renamed. Either way: a white screen on a button that worked a
minute ago.

- Host config first: no SPA fallback under `/assets/`. A missing asset gets a real, uncacheable
  404, never `index.html` with a 200 that a cache rule then keeps for a year.
- `installPreloadErrorHandler()` in the browser entry.
- In each error boundary and the router's error element, reload on a missing chunk, and on any
  other crash only when the server has a newer build. `reloadOnce` reloads at most once a
  minute, whatever the reason:

  ```ts
  if (isChunkLoadError(error) && reloadOnce()) return null;
  if (await isStaleBuild()) reloadOnce(); // a crash with no clue in it
  ```

- A tab people keep open all day (a dashboard, an inbox): check `isStaleBuild()` when the tab
  comes back into focus. If it's stale, show a quiet "A new version is ready" with a Reload
  button, and reload by itself on the next page change when nothing is being typed.

### The way in

- Sign-in keeps the email between its screens, has the right `autocomplete` on every field
  (`email`, `current-password`, `new-password`, `one-time-code`), works with password managers,
  and allows paste.
- A magic link or code screen says where it was sent, and how and when to resend.
- After sign-in, back to where they were going.
- Onboarding asks only what changes the first screen, and each answer shows up right away.

## Ours first

frontkit ships behavior, not looks: no components, so each app draws its states its own way,
with the same rules underneath. Each package's README (in `node_modules/@gusnips/<name>/`) has
the reasons and the edge cases.

- Loading, failed or ready, with a refresh error kept apart: `queryView(query)` from
  `@gusnips/react`. Never `isError ? <Error /> : <Data />`.
- Retry only what waiting can fix: `queryDefaults({ durableLimitCodes })`, `shouldRetry`.
- Words for an error, and which button to offer: `createErrorDescriber(...)` returns `cause`,
  `fix`, `recover` (`retry`, `signin`, `wait` or `none`) and `reference`.
- The shape of error and empty states: `ErrorStateProps` (`fix` and `action` are required) and
  `EmptyStateProps`.
- A crash in one area: `ErrorBoundary`.
- Surviving a deploy: `installPreloadErrorHandler`, `isChunkLoadError`, `isStaleBuild`,
  `reloadOnce`.
- A copy button that says when it failed: `useCopy`.
- The email between sign-in screens: `rememberAuthEmail`, `recallAuthEmail`.
- Back to where they were going: `returnPathFromLocation`, `safeInternalPath`, and the guards in
  `@gusnips/react/guards`.
- No flash of the wrong theme: `themeScript` from `@gusnips/vite/theme`. No flash of the wrong
  language: `localeGateScript` from `@gusnips/locale`.
- On the server, errors people can act on: `createAppError` from `@gusnips/server`. A 429 must
  state `retryAfterSecs`: a number, or `null` when waiting won't fix it, so the app never offers
  a retry that can't work.
