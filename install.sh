#!/usr/bin/env bash
set -euo pipefail

# Instalador da skill explica-pra-mim.
# Funciona de duas formas:
#   curl -fsSL https://raw.githubusercontent.com/JessieMeguro/obsidian/main/install.sh | bash
#   ./install.sh   (de dentro do repositorio clonado)

REPO_URL="https://github.com/JessieMeguro/obsidian.git"
SKILL_NAME="explica-pra-mim"
VAULT_PATH="${VAULT_PATH:-$HOME/vault-tecnico}"

info()  { printf '  %s\n' "$1"; }
ok()    { printf '  ok   %s\n' "$1"; }
skip()  { printf '  ja   %s\n' "$1"; }
fail()  { printf 'erro: %s\n' "$1" >&2; exit 1; }

printf '\nexplica-pra-mim\n\n'

# --- 1. Localizar os arquivos da skill -------------------------------------

SOURCE_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ -n "$SOURCE_DIR" ] && [ -f "$SOURCE_DIR/skills/$SKILL_NAME/SKILL.md" ]; then
  REPO_DIR="$SOURCE_DIR"
  info "usando os arquivos locais em $REPO_DIR"
else
  command -v git >/dev/null 2>&1 || fail "git nao encontrado. Instale o git ou clone o repositorio manualmente."
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  info "baixando o repositorio"
  git clone --depth 1 --quiet "$REPO_URL" "$TMP_DIR/repo" || fail "nao consegui clonar $REPO_URL"
  REPO_DIR="$TMP_DIR/repo"
fi

SKILL_SRC="$REPO_DIR/skills/$SKILL_NAME"
[ -f "$SKILL_SRC/SKILL.md" ] || fail "SKILL.md nao encontrado em $SKILL_SRC"

# --- 2. Criar o vault ------------------------------------------------------

printf '\nvault em %s\n' "$VAULT_PATH"

mkdir -p "$VAULT_PATH/conceitos" "$VAULT_PATH/projetos"
ok "conceitos/ e projetos/"

if [ -f "$VAULT_PATH/indice.md" ]; then
  skip "indice.md preservado"
else
  cp "$REPO_DIR/vault-template/indice.md" "$VAULT_PATH/indice.md"
  ok "indice.md criado"
fi

# O perfil e pessoal: nunca sobrescreve.
if [ -f "$VAULT_PATH/perfil.md" ]; then
  skip "perfil.md preservado"
else
  cp "$SKILL_SRC/assets/template-perfil.md" "$VAULT_PATH/perfil.md"
  ok "perfil.md criado (edite para a skill te conhecer)"
fi

# --- 3. Instalar a skill ---------------------------------------------------

printf '\nskill\n'

for target in "$HOME/.cursor/skills" "$HOME/.claude/skills"; do
  mkdir -p "$target"
  rm -rf "$target/$SKILL_NAME"
  cp -R "$SKILL_SRC" "$target/$SKILL_NAME"
  ok "$target/$SKILL_NAME"
done

# --- 4. Proximos passos ----------------------------------------------------

cat <<EOF

pronto.

  1. Edite $VAULT_PATH/perfil.md com sua profissao e suas analogias.
  2. Abra $VAULT_PATH como vault no Obsidian ("Open folder as vault").
  3. Reinicie o Cursor para ele carregar a skill.

A skill passa a documentar sozinha ao fim de cada entrega.
Sob demanda: /explica <termo>. Para revisar: /revisar.
EOF
