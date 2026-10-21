# skills

How my AI coding agents work: the instructions every session starts with, the rules they point to, and the skills I wrote. Claude Code and Codex both read them.

## What's here

- `AGENTS.md`: the instructions every session loads. Claude Code reads it as `~/.claude/CLAUDE.md`, and Codex as `~/.codex/AGENTS.md`.
- `rules/`: two longer rules that `AGENTS.md` points to. `before-writing-code.md` says to reuse what already exists before building anything. `translations.md` says to write every language the way a native company would.
- `skills/`:
  - `ux`: everything people see. It builds screens and flows, picks each design from five versions instead of the first idea, makes every action answer and every error say how to fix it, and keeps the project's PRODUCT.md and DESIGN.md (writing them when they're missing). It also runs:
    - `/ux init` to write PRODUCT.md and DESIGN.md;
    - `/ux polish` after a feature: states, words, fit with the rest of the product, craft, then a tidy-up, with one commit per stage;
    - `/ux states` to build the loading, empty, error, success and offline states an app is missing;
    - `/ux landing` to rebuild a marketing home page so it shows, as you scroll or play with it, what the app does and who it's for;
    - `/ux reorganize` to decide which pages an app keeps and what goes in each menu, then move things one commit at a time.
  - `deploy`: ships finished work. It commits what is left, pushes, marks the PR ready, watches CI and the staging deploy and applies migrations when the change has them. Then it asks one yes/no before doing the same for production, and cleans up the worktree and branches.
  - `simplify`: tidies recently changed code without changing what it does. It's Anthropic's [code-simplifier](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-simplifier) agent turned into a skill, under Apache-2.0 (see `skills/simplify/LICENSE`).

## Install

As a plugin in Claude Code:

```text
/plugin install skills --marketplace gusnips/skills
```

Or just the skills with the `skills` CLI:

```bash
npx skills add gusnips/skills
```

Everything, as links, so an edit here shows up in your next session:

```bash
git clone https://github.com/gusnips/skills.git ~/dev/skills
~/dev/skills/link.sh
```

`link.sh` points `~/.agents`, `~/.claude` and `~/.codex` at this folder. It moves any real file that's in the way to `~/.agents-backup/` first, removes links to skills this repo no longer has, and it's safe to run again.

## License

MIT, see `LICENSE`. `skills/simplify` keeps its own Apache-2.0 license (`skills/simplify/LICENSE`).
