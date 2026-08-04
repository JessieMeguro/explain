#!/usr/bin/env bash
set -euo pipefail

# Installer for the explain-it-to-me skill.
# Two ways to run it:
#   curl -fsSL https://raw.githubusercontent.com/JessieMeguro/explain/main/install.sh | bash
#   ./install.sh   (from inside a clone of the repository)

REPO_URL="https://github.com/JessieMeguro/explain.git"
SKILL_NAME="explain-it-to-me"
VAULT_PATH="${VAULT_PATH:-$HOME/tech-vault}"

info()  { printf '  %s\n' "$1"; }
ok()    { printf '  ok    %s\n' "$1"; }
skip()  { printf '  kept  %s\n' "$1"; }
fail()  { printf 'error: %s\n' "$1" >&2; exit 1; }

printf '\nexplain-it-to-me\n\n'

# --- 1. Locate the skill files ---------------------------------------------

SOURCE_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -n "$SOURCE_DIR" ] && [ -f "$SOURCE_DIR/skills/$SKILL_NAME/SKILL.md" ]; then
  REPO_DIR="$SOURCE_DIR"
  info "using the local files in $REPO_DIR"
else
  command -v git >/dev/null 2>&1 || fail "git not found. Install git, or clone the repository by hand."
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  info "downloading the repository"
  git clone --depth 1 --quiet "$REPO_URL" "$TMP_DIR/repo" || fail "could not clone $REPO_URL"
  REPO_DIR="$TMP_DIR/repo"
fi

SKILL_SRC="$REPO_DIR/skills/$SKILL_NAME"
[ -f "$SKILL_SRC/SKILL.md" ] || fail "SKILL.md not found in $SKILL_SRC"

# --- 2. Create the vault ---------------------------------------------------

printf '\nvault at %s\n' "$VAULT_PATH"

mkdir -p "$VAULT_PATH/concepts" "$VAULT_PATH/projects"
ok "concepts/ and projects/"

if [ -f "$VAULT_PATH/index.md" ]; then
  skip "index.md, left as it was"
else
  cp "$REPO_DIR/vault-template/index.md" "$VAULT_PATH/index.md"
  ok "index.md created"
fi

# The profile is personal: never overwrite it.
if [ -f "$VAULT_PATH/profile.md" ]; then
  skip "profile.md, left as it was"
else
  cp "$SKILL_SRC/assets/profile-template.md" "$VAULT_PATH/profile.md"
  ok "profile.md created (fill it in so the skill knows you)"
fi

# --- 3. Install the skill --------------------------------------------------

printf '\nskill\n'

for target in "$HOME/.cursor/skills" "$HOME/.claude/skills"; do
  mkdir -p "$target"
  rm -rf "$target/$SKILL_NAME"
  cp -R "$SKILL_SRC" "$target/$SKILL_NAME"
  ok "$target/$SKILL_NAME"
done

# --- 4. What to do next ----------------------------------------------------

cat <<EOF

done.

  1. Fill in $VAULT_PATH/profile.md with your profession and your analogies.
  2. Open $VAULT_PATH in Obsidian, with "Open folder as vault".
  3. Restart your agent so it loads the skill.

From then on the skill documents on its own at the end of each delivery.
On demand: /explain <term>. To review what you have: /review.
EOF
