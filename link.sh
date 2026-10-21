#!/usr/bin/env bash
# Point Claude Code and Codex at this repo. Safe to run again.
# A real file or folder already in a link's place moves to ~/.agents-backup/<time>/ first.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.agents-backup/$(date +%Y%m%d-%H%M%S)"
MOVED=0

link() { # link <source> <target>
  local src=$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/$(echo "${dst#"$HOME"/}" | tr / _)"
    MOVED=$((MOVED + 1))
  fi
  ln -sfn "$src" "$dst"
}

link "$REPO/AGENTS.md" "$HOME/.agents/AGENTS.md"
link "$HOME/.agents/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link "$HOME/.agents/AGENTS.md" "$HOME/.codex/AGENTS.md"

for rule in "$REPO"/rules/*.md; do
  name=$(basename "$rule")
  link "$rule" "$HOME/.agents/rules/$name"
  link "$HOME/.agents/rules/$name" "$HOME/.claude/rules/$name" # Claude Code also loads this folder on its own
done

for skill in "$REPO"/skills/*/; do
  name=$(basename "$skill")
  link "${skill%/}" "$HOME/.agents/skills/$name"
  link "$HOME/.agents/skills/$name" "$HOME/.claude/skills/$name"
  link "$HOME/.agents/skills/$name" "$HOME/.codex/skills/$name"
done

# A skill deleted from this repo leaves broken links behind. Remove the ones that point here.
PRUNED=0
for dir in "$HOME/.agents/skills" "$HOME/.claude/skills" "$HOME/.codex/skills"; do
  for path in "$dir"/*; do
    if [ -L "$path" ] && [ ! -e "$path" ]; then
      case "$(readlink "$path")" in
        "$REPO"/* | "$HOME"/.agents/skills/*) rm "$path" && PRUNED=$((PRUNED + 1)) ;;
      esac
    fi
  done
done

if [ "$MOVED" -gt 0 ]; then echo "Moved $MOVED things that were in the way to $BACKUP"; fi
if [ "$PRUNED" -gt 0 ]; then echo "Removed $PRUNED links to skills that are gone."; fi
echo "Linked AGENTS.md, $(ls "$REPO"/rules/*.md | wc -l | tr -d ' ') rules and $(ls -d "$REPO"/skills/*/ | wc -l | tr -d ' ') skills."
