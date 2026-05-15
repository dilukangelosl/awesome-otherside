#!/usr/bin/env bash
# Otherside Skills — Conversion Script
# Converts SKILL.md files to formats for different AI tools.
# Usage: ./scripts/convert.sh --tool <tool>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_DIR/skills"
OUT_DIR="$REPO_DIR/dist"

GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'
info()    { echo -e "${BLUE}[info]${NC} $*"; }
success() { echo -e "${GREEN}[done]${NC} $*"; }

TOOL="${2:-all}"
while [[ $# -gt 0 ]]; do
  case $1 in --tool) TOOL="$2"; shift 2 ;; *) shift ;; esac
done

mkdir -p "$OUT_DIR"

convert_aider() {
  # Aider uses CONVENTIONS.md in project root
  OUT="$OUT_DIR/CONVENTIONS.md"
  info "Converting to Aider CONVENTIONS.md ..."
  echo "# Otherside Development Conventions" > "$OUT"
  echo "" >> "$OUT"
  echo "Read these conventions before making any changes to Otherside ODK projects." >> "$OUT"
  echo "" >> "$OUT"
  cat "$REPO_DIR/AGENTS.md" >> "$OUT"
  echo -e "\n---\n" >> "$OUT"
  for skill_dir in "$SKILLS_DIR"/*/; do
    cat "$skill_dir/SKILL.md" >> "$OUT"
    echo -e "\n---\n" >> "$OUT"
  done
  success "Aider: $OUT"
}

convert_cursor() {
  # Cursor uses .mdc files
  DEST="$OUT_DIR/cursor"
  mkdir -p "$DEST"
  cp "$REPO_DIR/.cursor/rules/otherside.mdc" "$DEST/otherside.mdc"
  success "Cursor: $DEST/otherside.mdc"
}

convert_windsurf() {
  DEST="$OUT_DIR/windsurf"
  mkdir -p "$DEST"
  cp "$REPO_DIR/.windsurf/rules/otherside.md" "$DEST/otherside.md"
  success "Windsurf: $DEST/otherside.md"
}

convert_opencode() {
  # OpenCode uses .opencode/rules/
  DEST="$OUT_DIR/opencode/.opencode/rules"
  mkdir -p "$DEST"
  cp "$REPO_DIR/AGENTS.md" "$DEST/otherside.md"
  success "OpenCode: $DEST/otherside.md"
}

convert_codex() {
  DEST="$OUT_DIR/codex"
  mkdir -p "$DEST"
  cp "$REPO_DIR/AGENTS.md" "$DEST/AGENTS.md"
  cp -r "$SKILLS_DIR" "$DEST/"
  success "Codex: $DEST/"
}

case "$TOOL" in
  aider)    convert_aider ;;
  cursor)   convert_cursor ;;
  windsurf) convert_windsurf ;;
  opencode) convert_opencode ;;
  codex)    convert_codex ;;
  all)
    convert_aider
    convert_cursor
    convert_windsurf
    convert_opencode
    convert_codex
    success "All conversions complete — output in $OUT_DIR/"
    ;;
  *)
    echo "Unknown tool: $TOOL"
    echo "Supported: aider, cursor, windsurf, opencode, codex, all"
    exit 1
    ;;
esac
