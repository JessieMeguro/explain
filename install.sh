#!/usr/bin/env bash
set -euo pipefail

# Installer for the explain-it-to-me skill.
# Two ways to run it:
#   curl -fsSL https://raw.githubusercontent.com/JessieMeguro/explain/v1.1.0/install.sh | bash
#   ./install.sh   (from inside a clone of the repository)
#
# The remote path is pinned to a tag, not a branch, so a future push to the
# repository cannot change what this exact command downloads and runs.
# To use a different pinned version, set EXPLAIN_REF and change the URL/tag
# together; do not point at "main".

REPO_URL="https://github.com/JessieMeguro/explain.git"
REF="${EXPLAIN_REF:-v1.1.0}"
SKILL_NAME="explain-it-to-me"
VAULT_PATH="${VAULT_PATH:-$HOME/tech-vault}"

# New files created by this installer (vault, profile, skill copies) are
# personal to this machine, so keep them private to the current user.
umask 077

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
  info "downloading $REF"
  git clone --depth 1 --branch "$REF" --quiet "$REPO_URL" "$TMP_DIR/repo" || fail "could not clone $REPO_URL at $REF"
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
  ok "profile.md created (optional)"
fi

# --- 3. Install the skill --------------------------------------------------

printf '\nskill\n'

for target in "$HOME/.cursor/skills" "$HOME/.claude/skills"; do
  mkdir -p "$target"
  staging="$target/.$SKILL_NAME.new.$$"
  rm -rf "$staging"
  cp -R "$SKILL_SRC" "$staging"
  rm -rf "$target/$SKILL_NAME"
  mv "$staging" "$target/$SKILL_NAME"
  ok "$target/$SKILL_NAME"
done

# --- 4. What to do next ----------------------------------------------------

cat <<EOF

done.

  1. Optionally fill in $VAULT_PATH/profile.md with your language and existing knowledge.
  2. Open $VAULT_PATH in Obsidian, with "Open folder as vault".
  3. Restart your agent so it loads the skill.

The skill documents concepts needed to understand or maintain a delivery.
On demand: /explain-it-to-me <term>. To review what you have: /explain-it-to-me review.
EOF
