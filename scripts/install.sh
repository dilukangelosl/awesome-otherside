#!/usr/bin/env bash
# Otherside Skills — Installation Script
# Installs skills and hooks for the specified AI coding tool.
# Usage: ./scripts/install.sh [--tool <tool>] [--all] [--list]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_DIR/skills"

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[info]${NC} $*"; }
success() { echo -e "${GREEN}[done]${NC} $*"; }
warn()    { echo -e "${YELLOW}[warn]${NC} $*"; }

TOOL="${1:-}"
ALL=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --tool) TOOL="$2"; shift 2 ;;
    --all)  ALL=true; shift ;;
    --list) list_tools; exit 0 ;;
    *) shift ;;
  esac
done

list_tools() {
  echo "Supported tools:"
  echo "  claude      — Claude Code (~/.claude/skills/)"
  echo "  codex       — OpenAI Codex (copies AGENTS.md to project)"
  echo "  gemini      — Gemini CLI (~/.gemini/ or project root)"
  echo "  cursor      — Cursor (.cursor/rules/)"
  echo "  windsurf    — Windsurf (.windsurf/rules/)"
  echo "  antigravity — Antigravity (uses same structure as Claude)"
  echo "  kimi        — Kimi (copies skills as context files)"
}

install_claude() {
  DEST="$HOME/.claude/skills"
  info "Installing to $DEST ..."
  mkdir -p "$DEST"
  for skill_dir in "$SKILLS_DIR"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$DEST/$skill_name"
    cp "$skill_dir/SKILL.md" "$DEST/$skill_name/SKILL.md"
    success "Installed: $skill_name"
  done

  # Install hook
  HOOK_DEST="$HOME/.claude/hooks"
  mkdir -p "$HOOK_DEST"
  cp "$REPO_DIR/.claude/hooks/skill-activation.ts" "$HOOK_DEST/otherside-skill-activation.ts"
  success "Hook installed: otherside-skill-activation.ts"

  # Merge settings
  SETTINGS="$HOME/.claude/settings.json"
  if [[ ! -f "$SETTINGS" ]]; then
    cp "$REPO_DIR/.claude/settings.json" "$SETTINGS"
    success "Settings created: $SETTINGS"
  else
    warn "settings.json already exists at $SETTINGS — manually add the hook from .claude/settings.json"
  fi
}

install_antigravity() {
  # Antigravity uses same skill path as Claude Code
  install_claude
  success "Antigravity uses Claude Code skill paths — installation complete."
}

install_codex() {
  PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
  info "Copying AGENTS.md to $PROJECT_ROOT ..."
  cp "$REPO_DIR/AGENTS.md" "$PROJECT_ROOT/AGENTS.md"
  mkdir -p "$PROJECT_ROOT/skills"
  cp -r "$SKILLS_DIR"/. "$PROJECT_ROOT/skills/"
  success "Codex/OpenAI Agents installation complete"
  info "Commit AGENTS.md and skills/ to your repository for Codex to pick up."
}

install_gemini() {
  GEMINI_DIR="$HOME/.gemini"
  mkdir -p "$GEMINI_DIR"
  cp "$REPO_DIR/GEMINI.md" "$GEMINI_DIR/GEMINI.md"
  success "Gemini CLI: installed to ~/.gemini/GEMINI.md"
  info "Also copy skills/ to your project root for file references to work."
}

install_cursor() {
  PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
  DEST="$PROJECT_ROOT/.cursor/rules"
  mkdir -p "$DEST"
  cp "$REPO_DIR/.cursor/rules/otherside.mdc" "$DEST/otherside.mdc"
  mkdir -p "$PROJECT_ROOT/skills"
  cp -r "$SKILLS_DIR"/. "$PROJECT_ROOT/skills/"
  success "Cursor rules installed to .cursor/rules/otherside.mdc"
}

install_windsurf() {
  PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
  DEST="$PROJECT_ROOT/.windsurf/rules"
  mkdir -p "$DEST"
  cp "$REPO_DIR/.windsurf/rules/otherside.md" "$DEST/otherside.md"
  mkdir -p "$PROJECT_ROOT/skills"
  cp -r "$SKILLS_DIR"/. "$PROJECT_ROOT/skills/"
  success "Windsurf rules installed to .windsurf/rules/otherside.md"
}

install_kimi() {
  PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"
  KIMI_DIR="$PROJECT_ROOT/.kimi"
  mkdir -p "$KIMI_DIR"
  # Kimi uses context files — concatenate all skills into one context
  cat "$REPO_DIR/AGENTS.md" > "$KIMI_DIR/otherside-context.md"
  echo -e "\n---\n" >> "$KIMI_DIR/otherside-context.md"
  for skill_dir in "$SKILLS_DIR"/*/; do
    skill_name=$(basename "$skill_dir")
    echo -e "\n## Skill: $skill_name\n" >> "$KIMI_DIR/otherside-context.md"
    cat "$skill_dir/SKILL.md" >> "$KIMI_DIR/otherside-context.md"
    echo -e "\n---\n" >> "$KIMI_DIR/otherside-context.md"
  done
  success "Kimi context file created: .kimi/otherside-context.md"
}

if $ALL; then
  install_claude
  install_codex
  install_gemini
  install_cursor
  install_windsurf
  install_kimi
  success "All tools installed."
  exit 0
fi

case "$TOOL" in
  claude)      install_claude ;;
  antigravity) install_antigravity ;;
  codex)       install_codex ;;
  gemini)      install_gemini ;;
  cursor)      install_cursor ;;
  windsurf)    install_windsurf ;;
  kimi)        install_kimi ;;
  "")
    echo "Usage: ./scripts/install.sh --tool <tool>"
    echo "       ./scripts/install.sh --all"
    echo ""
    list_tools
    exit 1
    ;;
  *)
    warn "Unknown tool: $TOOL"
    list_tools
    exit 1
    ;;
esac
