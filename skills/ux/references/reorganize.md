# Reorganize

Decide where everything in the app lives. Get the user's yes on the big moves. Then move things, one slice at a time.

The scope is whatever follows `reorganize`. Empty means the app people log in to, in this repo. In a monorepo that's usually `apps/web`; the marketing site and the internal admin are separate runs. The scope can also be one area ("settings", "the dashboard") or a set of sibling repos (see "Sibling apps"). A run on one area changes only that area. Anything you find outside it goes on the list for later.

## Why this order

The questions below depend on each other. The pages decide the menus. The menus decide the top bar and the user menu. The pages decide which components exist. So one mind answers them, in order, and writes one map.

Sub-agents gather facts and draft competing maps. They never answer one question each: split that way, you get eight answers that are each fine and don't fit together, which is the mess this skill exists to fix. Tell each sub-agent to do its part itself and start no sub-agents of its own. One test run let its fact-gatherers fan out: 16 agents instead of 6, and two hours.

## The questions

Answer all eight, in this order, for the scope:

1. Pages: which do we keep, merge, adapt, add or remove?
2. Menus: which pages go in the side menu, which in a sub-menu, which become tabs inside another page, and which have no menu entry and are reached by links?
3. Side menu or user menu: what goes in each? Does anything belong in both?
4. Top bar: what goes there, and what stays out?
5. Dashboard: which parts does it show, in what order, and which can people dismiss?
6. Each page: which parts does it have, and where does each one go?
7. Each part: what comes first inside it, and what comes last?
8. Components: across the app, which do we keep, adapt, add or remove?

Every answer is a decision plus one line of why. "Keep" is a decision too. The rules for deciding are at the end of this file.

## Sibling apps

Some apps grew from one template and still share most of their code. Run them together (`/ux reorganize app-a app-b app-c`).

- One shell for all of them: the kind of side menu, top bar, user menu, phone nav and settings layout. They're maintained together and fixes get copied between them, so a shell that differs for no product reason turns every copied fix into a merge.
- Separate menu items, pages and page recipes per app. Each product has its own people and jobs: a salon owner and an iPhone store owner don't need the same menu.
- Facts split by app, not by topic: one sub-agent per repo writes all three fact files for it.
- Drafts split by idea, not by app: each drafter maps all the apps at once, so every draft already has one shell.
- Each repo gets its own STRUCTURE.md. The shell section is the same text in all of them.

## 1. Gather the facts

Read PRODUCT.md (who uses the app, for what), DESIGN.md if there is one, the router, and the shell: side menu, top bar, user menu, phone nav. No PRODUCT.md? Init writes it first (`init.md`), and the three facts this map can't do without are who uses the app, their top three jobs, and which of those they do every day. When the code can't tell you those, ask.

For the whole app, start three read-only sub-agents at once. Each writes facts, not opinions, to `$TMPDIR/reorganize-<app>/`:

- `pages.md`: every route. What it shows, the job it serves, what the code treats it as (its data and API), how people reach it (menu, link, deep link), what links to it, who can see it. Include links from outside the app: payment returns, emails, SDKs, the marketing site.
- `nav.md`: side menu, sub-menus, tabs, top bar, user menu, phone nav and breadcrumbs as they are today. Items, order, groups, labels in every locale. Anything reachable from two places.
- `parts.md`: each page's parts, top to bottom. Components used on two or more pages, one-offs, near-copies. Everything dismissible, and where the app stores the dismissal. Every banner, badge and status: what makes it show, and whether it can say something that isn't true. Missing empty and error states. If the app runs locally, screenshot each page at desktop and phone width: hierarchy is judged on pixels, not JSX.

Usage beats opinion. If the repo has analytics, or a read-only way to count visits or records per page, count. If not, write "usage: unknown". Never guess a number, and treat words the same way: "daily", "rare" and "most used" are usage claims too. Each one names its source (a count, a line in PRODUCT.md) or says "guess".

Just one area, a handful of pages? Skip the sub-agents and gather the facts yourself. Same result, a fraction of the cost.

## 2. Draft competing maps

Start three sub-agents at once. Each reads the facts, PRODUCT.md and the rules below, answers all eight questions, and writes a full map (format below) to the same folder. Each starts from a different idea:

- By job: built around what people come to do.
- By thing: built around what people own and work on (contacts, appointments, campaigns).
- Fewest: the fewest pages and menu items that still cover every job.

You write the other two yourself: today's structure, fixed only where it breaks a rule, and your own merge of the best parts. Those are the five versions. Whole maps, not per-question pieces: that's the point of drafting them.

One area only: draft them yourself.

## 3. Pick one map

Read the drafts, then write the map yourself: pick the strongest, or merge. Then check it:

- Walk each top job from PRODUCT.md. From sign-in, how many clicks does it take? More than today is a red flag.
- Every page has a way in and a way back.
- Nothing lives in two places. Every menu label is a word a new user knows.
- Every promise in PRODUCT.md still holds. If it says owners can always reach billing, no state of the new map hides billing.
- Every banner, badge and status from `parts.md` still shows somewhere, or you removed it on purpose and said why. Moving a part can quietly delete the only place a message appears.
- Everything you moved is still what it was. Check how the code treats a feature before you file it with others: an import that looks like a channel may be a one-off job.

Write it to `STRUCTURE.md` at the app root, in the language the repo's PRODUCT.md uses, headings included. It holds decisions, reasons and rules, not a copy of the route table. The code says what exists; this file says why, and where the next page goes.

## 4. Get the user's yes on the big moves

Show them:

- The side menu, top bar and user menu, before and after, as two trees.
- Every page removed or merged, and every URL that changes.
- Each call where the drafts disagreed: your pick, and the alternative.
- Any new library the map needs.
- The slices you'll commit, one line each.

Group moves that only make sense together into one call, so the list stays short. These wait for their yes because they're hard to undo: people lose bookmarks and habits. The rest (order inside a page, what comes first inside a part, merging near-copy components) you apply without asking. If the user already said to go ahead, show the map and start. If nobody can answer, stop here with the map written.

## 5. Apply, one slice at a time

One writer, this order, one commit per slice:

1. Shell: side menu, sub-menus, top bar, user menu, phone nav. Redirect every URL that moves or goes away to its new home, keeping its query string. A URL something outside the app links to (a payment return, an email) is cheaper to keep than to redirect.
2. Merged and removed pages. Delete the code they leave unused.
3. Shared components: merge near-copies, add what the map calls for. Build from what the app already has: its own components, the libraries it already imports, then plain HTML (`<dialog>`, `<details>`, `popover`). A new library is a big move, so it needs the user's yes in step 4.
4. Pages, dashboard first, one per slice. Build each from its recipe in the map, with the five versions from SKILL.md for its layout and `craft.md` for the surface.

Each slice: labels in every locale, typecheck and lint green (plus any test file you changed), screenshots at desktop and phone width, every link from outside the app still lands on the right page and tab, commit by pathspec.

One writer per repo, because every slice touches the same few files (routes, the nav config, the locale files) and two writers collide there. Sibling repos share no files, so their writers can run at the same time.

Move things; don't invent them. No new features, no changes to what data a page loads, no copy rewrites beyond the labels the map renames. The polish pass (`polish.md`) owns the words and the states. One exception: a status that says something false ("Online" while the feature is off) is a bug. Fix it in the slice that touches it.

## 6. Finish

Run the polish pass (`polish.md`) on the surfaces you changed. Report: a link to STRUCTURE.md, one line per slice commit, and what you logged for later.

## Map format

Each of the eight questions has a place in it, so a reader can find every answer. Trees and
recipes go in `text` blocks, so a formatter keeps their alignment.

````markdown
# Structure: <app>

Who uses it, and for what: <two lines from PRODUCT.md>

## Menus

```text
Side menu
  Inbox       daily (PRODUCT.md): answer customers
  Contacts
  Flows       was "Automations"; Templates is a tab here
  Reports     weekly (guess)
  Settings    footer; team settings, as tabs
Top bar: workspace switcher · search · notifications · user menu
User menu: profile · plan and billing · language · sign out
Phone: bottom bar with Inbox, Contacts, Flows; the rest in the drawer
```

## Pages

- /inbox: keep. The daily job.
- /reports + /analytics → /reports. Same numbers on two screens.
- /old-import: remove, redirects to /settings/import. Nothing links to it.

## Page recipes

```text
/dashboard (job: see what needs you today)
  1. Waiting on you: list, the main part
  2. This week: three numbers
  3. Getting started: dismissible, gone when done
```

## Components

- EmptyState: keep. Every list uses it.
- ContactCard + LeadCard → PersonCard. Same card, two names.

## Rules for what comes next

- A new page goes in the side menu only if people use it most days. Otherwise it's a tab or a link.
````

## Rules for deciding

These are defaults. When one would split a job that PRODUCT.md names, the job wins: keep it in one place and write down which rule you broke and why. For example, checking usage and paying for it are one job, even though the rule below puts billing in the user menu.

### Pages

- Keep a page that serves one job people come to do.
- Merge two pages when they show the same thing, when people always open one right after the other, or when one is too thin to stand on its own.
- Adapt a page when the job is right but the page gets in its way.
- Remove a page when no job needs it or another page already does its job. Its URL redirects.
- Add a page only for a job that has no home today.

### Menus

- Side menu: the places people go to do their main work. Aim for five; past seven, group them. Daily places first. When the work runs in steps (set up a campaign, send it, answer the replies), follow the steps. Name them all the same way (all things, or all jobs).
- Sub-menu: only for a section with three or more pages people switch between, each worth a visit on its own. One level deep, never two.
- Tabs: different views of one thing, like a contact's history, notes and settings, or the sections of team settings. Two to six. Each tab has its own URL, so a link can open the right one.
- No menu entry: a page about one item (a contact, an order). People reach it from a list, a search or a link, and always get a way back.
- User menu: things about the person and their account: profile, plan and billing, language, theme, sign out.
- Both menus: almost never. Every page has one home. Team settings live in the side menu; personal settings live in the user menu.
- Top bar: what applies on every page: which workspace you're in, search, notifications, help (if the app has any), the user menu. Not the page's own actions (those go in the page header), and not a copy of the side menu.
- Phone: the side menu becomes a drawer, or a bottom bar with up to five daily places. The top bar keeps the workspace and the user menu. If PRODUCT.md says most people use a phone, design the phone nav first and the desktop after.

### Dashboard

It answers three questions, in this order:

1. What needs me now? Things waiting on the user. First and biggest.
2. How are things going? Two to four numbers that change what the user does next. A number nobody acts on doesn't get a spot.
3. What's next? The next step, or recent work to pick up again.

A new account sees a getting-started list at the top until it's done.

### Dismissible parts

- People can dismiss what's optional or one-time: tips, announcements, a finished checklist.
- Never dismissible: errors, warnings about money or data, anything waiting on the user.
- The app remembers the dismissal, so it doesn't come back next visit. If it had lasting value, people can bring it back from Help or Settings.

### Inside a page

- One page, one main job. The part that serves it comes first and gets the most weight: size, position, contrast.
- Order the other parts by how often people need them, not by the data model or the order they were built.
- One main action per page, in the same spot on every page: the page header.
- Same kind of part, same place, every page: title and main action on top, filters right above the list they filter, settings and delete at the bottom.

### Inside a part

- Order: what it is (title), then its state or key number, then details, then actions.
- Parts of the same kind put their actions in the same place.
- Every part has an empty state (what goes here, how to add the first one) and an error state (what failed, why, how to fix it, a retry).

### Components

- Keep a component with one clear job that pages use the same way.
- Merge near-copies: two cards that differ only in spacing are one card.
- Add one only when two or more pages need it. Until then it stays inside its page. Build it from what the app already has (see step 5).
- Remove what nothing imports anymore.
