---
name: deploy
description: Ship finished work end to end. Commits what is left, pushes, marks the PR ready, watches CI and the staging deploy, applies migrations when the change has them, asks one yes/no before doing the same for production, then cleans up the worktree and branches. Use when the user says deploy, ship it, release it, send it, merge and deploy, go live or promote, even if they never name the skill. Not for opening a draft PR or pushing a branch for review. Those release nothing.
version: 1.1.2
user-invocable: true
argument-hint: "[PR number or branch] [dry-run]"
metadata:
  opencode/slash: "true"
---

# Deploy

The user's word ("deploy", "ship it") releases the work in front of you. Staging goes without
asking, because the word is the ask. Production waits for one yes/no after staging is green,
because a change to production is the user's call every time.

Scope: $ARGUMENTS

This skill is the order of the steps. The repo says what each step runs: read its AGENTS.md
(CI/CD, branching and deploy model, database and migrations, before submitting work) and its
workflows README first, and any release notes the repo keeps (a `RELEASE.md` beside the
workflows, say). They hold the commands this skill leaves out.

## Before you start

1. Find what ships: the PR of the current branch, or the one in the arguments
   (`gh pr view --json number,isDraft,labels,state,headRefName,headRefOid,mergeStateStatus`).
   No PR yet: open it as a draft first, then continue.
2. Stop and ask when the PR has a `hold` label (someone asked it not to merge; never remove it
   yourself), when the branch is another agent's, or when the diff holds files you did not mean
   to ship.
3. Already merged: skip to Release, item 4, and watch the deploys.
4. `dry-run` in the arguments: do these reading steps, print the sequence you would run with this
   PR's real state (draft or ready, migrations or none, which deploys would start, how far
   production is behind), and change nothing.

## Server checks with infrakit

For a deploy to a Linux server, read its private adoption record and use its pinned
`@gusnips/infra` version for the checks and jobs it supports. Reuse the package instead of copying
its scripts into the app. Keep app builds, database migrations and releases in the repo's pipeline.
Cloudflare-only Pages, Workers and D1 deployments skip this host step.

- Run the host's full configured read-only audit before marking a server deploy ready, and again
  before production. Use a private version 1 manifest, a JSON file listing expected services,
  at mode 0600. A fleet inventory file is not a CLI manifest. Keep the complete output and exit
  status. Missing coverage stays unverified; never clear fields or raise thresholds to force a pass.
- `inspect` exits nonzero for any finding or unverified check. That is an audit result, not an
  automatic app-deploy failure. For each item, check which service it affects and whether the
  planned release depends on it. Record the current evidence, the owner and the follow-up.
- Stop for a failed or unreadable readiness check: SSH access, a required app or dependency,
  the target's free disk or inodes below its documented limit, a live security fault, or a required
  migration or backup prerequisite. Keep the repo's CI, migration, health and deploy-lock gates.
  A conflicting deploy, reboot or maintenance reservation also stops the release.
- Housekeeping can be advisory when current checks prove the target has enough disk and memory
  and the app's required dependencies are healthy. Examples: reclaimable Docker images without
  space pressure, old uncompressed rotations, an unrelated service's uncapped Redis without memory
  pressure, or missing host-alert mail proof when the app does not use that mail setup. These are
  still open findings, not passes. Do not prune rollback images, rewrite old logs or restart another
  service just to make the audit green.
- If a finding's effect is unclear, a required dependency cannot be verified, or a documented
  mandatory check fails, stop and ask. A green public health URL alone does not settle missing
  dependency or migration checks. This distinction never removes a `hold` or grants production
  approval. Do not change the package's exit status or weaken a repo gate to get through.
- Verify the package version and path against the host's record. The CLI can run on the operator
  machine over SSH. Cron uses absolute paths to the pinned packaged Bash jobs, without a Node or
  Bun dependency. Do not add an app dependency just to run a server check.
- An app deploy does not install, upgrade or reconfigure infrakit. Those need a separate approved
  rollout, staging first and one physical host at a time. Several hostnames can name the same box;
  measure current DNS and runtime state before choosing a target. Never disable SSH key checks.
- `install` prints a plan; version 0.1.0's `install --apply` is unsupported. A package copy or CLI
  help does not prove working backup jobs, mail, live compression or a restore. Report those gaps.
  Keep old cron jobs and backup prefixes until replacement coverage and retention are verified,
  including a week of successful backup runs. Never remove them as app-deploy cleanup.

## 1. Make the branch shippable

- Commit what is left, by pathspec and in small commits, never `git add -A`. Use the repo's
  commit format and the user's rules for message bodies and attribution.
- Run the checks CI does not: lint for the packages you touched, the formatter on the files you
  changed, the one test file you changed (never the whole suite), the i18n or other gates the repo
  names when their inputs changed. CI typechecks the changed packages and does nothing else, so
  once you push nothing catches these. A failure is yours: fix the cause on this branch.
- `git fetch origin && git rebase origin/main`, then `git push -u origin HEAD`. Use
  `--force-with-lease` only when the rebase rewrote commits you had already pushed, and only on
  your own branch.

## 2. Migrate staging first, if the diff has migrations

Look: `git diff --name-only origin/main...HEAD -- '*migrations*'`. None: skip this step.

Do it before the PR is ready, not after. CI merges the PR and the staging deploy then refuses
to run while migrations are pending, so migrating after the merge makes the first deploy red and
costs a rerun. Migrations here are expand-only, so one that lands ahead of its code is safe for
the code running now.

Check that your migration number is still free on `origin/main` (other sessions merge too), and
renumber yours if it was taken. Read the status first and expect exactly your files pending. Check
the lock window the repo names before DDL on a busy table.

## 3. Release

1. `gh pr ready <n>`. CI runs, and merges the PR when it passes.
2. Watch in the background, not with a sleep loop: `gh pr checks <n> --watch`, then
   `gh pr view <n> --json state,mergedAt,mergeCommit`.
3. CI red: it is yours. `gh run view <id> --log-failed`, fix the cause on the branch, push,
   watch again. Never bypass the gate or flip the PR back to draft to dodge it.
4. Merged: the staging deploys start from CI, only for apps whose files changed. List them with
   `gh run list --limit 10 --json databaseId,name,status,createdAt` and keep the ones that
   started after `mergedAt`: CI dispatches them, so they do not sit under the merge commit.
   Watch each to its end. No run for an app: check that its paths are on the repo's ignore list
   before you say nothing needed deploying.
5. A deploy goes red: read its log before anything else (a pending migration is the usual
   cause), then stop and report. Keep the worktree.

## 4. Report, then ask about production

No production environment in the repo's docs: skip to Clean up.

Otherwise send one report: what merged (PR and commit), what each staging deploy did, which
migrations were applied, and what you did not verify. Then ask one yes/no question (AskUserQuestion
in Claude Code). Say exactly what production would get: the commits that would go out, the
migrations that would run, the deploys that would start. No answer counts as no. An earlier
yes does not carry over. If the user's own words already named production ("deploy and
promote"), that was the answer: skip the question.

## 5. Production, on yes

Same order as staging, with more care because it is live.

1. See what would go out: the commits on the main branch that the production branch lacks.
   Promoting ships the tip, so other people's merged work rides along. If there is some, list
   it and ask, or ship only your commit by the repo's documented way.
2. Make sure nobody else is promoting: `gh run list --branch prod --status in_progress` shows no
   production deploy (`prod` here; take the repo's own production branch). Without the branch it
   lists every run in the repo, so someone else's CI would look like a production deploy and hold
   the promote. One is running: wait for it to end, then do item 1 again, because its commits are
   now live.
3. Migrations before the code. The server's checkout is the last promoted commit and does not
   have your file yet, and promoting first puts code ahead of its schema. Status, then apply.
4. Promote with the repo's own command. Never use its force flag: its gate is what proves CI
   was green on this exact commit.
5. Watch every production deploy to its end and confirm the health check it runs. Report.

## 6. Clean up

Only what this run created, and only when the PR is merged and every deploy you watched is
green. If anything is red, leave all of it and say what is kept and why.

First prove it is merged. A squash merge rewrites SHAs, so `git log origin/main..<branch>`
always lists commits and proves nothing. Instead: `gh pr view <n> --json state,headRefOid` says
MERGED and `headRefOid` equals your local branch tip. A local commit that is not on the PR is
unmerged work: stop and say so.

1. Worktree and local branch. In a session started with `--worktree`, ExitWorktree with
   `remove` does it all (unlocks, removes, deletes the local branch). Elsewhere, from the main
   checkout: `git worktree remove .claude/worktrees/<task>` (run `git worktree unlock` first
   for a leftover from `claude -p`), then `git branch -D <branch>`. `-D` because `-d` refuses a
   squash-merged branch.
2. Remote branch. `git ls-remote --heads origin <branch>`: still there means
   `git push origin --delete <branch>` (GitHub often deletes it on merge).
3. `git fetch --prune origin` and `git worktree prune`, so refs and records of what is gone go too.
4. Anything you copied to a server for the run (probe scripts, a one-off migration file the
   deploy will not overwrite): remove it.

Other worktrees, branches and stashes you did not create stay, even when they look merged. List
them in the report as "found, not mine" and let the user decide.

## What this skill never decides

Production without the yes. The force flag of the promote gate. Removing a `hold` label.
Merging or promoting a peer's work as if it were yours. Whether a red check is "just flaky".
Printing an env file or a secret: read single keys, mask values.
