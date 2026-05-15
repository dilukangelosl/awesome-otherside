# Otherside Developer Skills

Production-ready AI skills for [Otherside](https://docs.otherside.xyz/) development.
Works with **Claude Code**, **Antigravity**, **Codex**, **Gemini CLI**, **Kimi**, **Cursor**, **Windsurf**, and more.

---

## What's Included

10 skills covering the full Otherside Development Kit (ODK):

| Skill | Topic |
|-------|-------|
| `otherside-quick-start` | ODK setup, PIE testing, deployment, Unreal workflow differences |
| `otherside-avatar-system` | Character creation, GLB specs, BAYC/MAYC/Koda/Voyager, Blender pipeline |
| `otherside-plugin-features` | Auth (Privy), web browser, token gating, emotes, NPCs, moderation |
| `otherside-morpheus-networking` | Morpheus networking, actor pooling, Server_TransferDataObjects |
| `otherside-commerce-economy` | Vending machines, ApeCoin, ApeChain, ERC-1155, NFT gating |
| `otherside-templates` | Boneyard template, Combat template, environmental actors |
| `otherside-world-travel` | Portals, bubbles, grind rails, levitators, gliding, jump pads |
| `otherside-task-flow` | Task Flow System — quests, tutorials, triggers, conditions, actions |
| `otherside-agentic-api` | Agentic API, Vibe Maker, MML, programmatic world building |
| `otherside-debugging` | Credentials, logs, known issues, common blueprint errors |

---

## Quick Install

### Claude Code

```bash
./scripts/install.sh --tool claude
```

Skills are copied to `~/.claude/skills/`. The keyword-based hook is installed to `~/.claude/hooks/`.

### Antigravity

```bash
./scripts/install.sh --tool antigravity
```

Uses the same skill path as Claude Code.

### OpenAI Codex / Codex CLI

```bash
./scripts/install.sh --tool codex
```

Copies `AGENTS.md` and `skills/` to your project root. Commit both for Codex to use them.

### Gemini CLI

```bash
./scripts/install.sh --tool gemini
```

Installs `GEMINI.md` to `~/.gemini/`.

### Kimi

```bash
./scripts/install.sh --tool kimi
```

Generates `.kimi/otherside-context.md` in your project root.

### Cursor

```bash
./scripts/install.sh --tool cursor
```

Installs `.cursor/rules/otherside.mdc` in the current project directory.

### Windsurf

```bash
./scripts/install.sh --tool windsurf
```

Installs `.windsurf/rules/otherside.md` in the current project directory.

### All Tools at Once

```bash
./scripts/install.sh --all
```

---

## Manual Installation (Claude Code)

If you prefer to install manually:

```bash
# Copy a skill directly
cp -r skills/otherside-quick-start ~/.claude/skills/

# Copy all skills
cp -r skills/* ~/.claude/skills/
```

---

## Auto-Activation Hook (Claude Code / Antigravity)

The `skill-activation.ts` hook automatically suggests relevant skills based on your prompt keywords.

**Requirements:** Node.js 20+ and `tsx` available via `npx`.

The hook fires on every prompt and outputs skill suggestions when Otherside-related keywords are detected. No blocking — purely advisory.

**Trigger examples:**

| You type... | Hook suggests... |
|-------------|-----------------|
| "How do I set up token gating?" | `otherside-plugin-features` |
| "My Morpheus actor is crashing" | `otherside-morpheus-networking`, `otherside-debugging` |
| "Set up a vending machine for APE" | `otherside-commerce-economy` |
| "Add Koda avatar support" | `otherside-avatar-system` |
| "Create a quest system" | `otherside-task-flow` |

---

## Convert to Other Formats

```bash
# Convert to Aider CONVENTIONS.md
./scripts/convert.sh --tool aider

# Convert to OpenCode rules
./scripts/convert.sh --tool opencode

# Convert all formats
./scripts/convert.sh --tool all
```

Output goes to `dist/`.

---

## Skill Format

Each skill follows the standard SKILL.md format with YAML frontmatter:

```markdown
---
name: otherside-quick-start
description: "... trigger keywords ..."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Skill Title
...
```

All skills are kept under 500 lines following Anthropic's progressive disclosure guidelines.

---

## Documentation Sources

| Resource | URL |
|----------|-----|
| Otherside Docs | https://docs.otherside.xyz/ |
| Full corpus (LLM-friendly) | https://docs.otherside.xyz/llms-full.txt |
| Sitemap | https://docs.otherside.xyz/sitemap.md |
| Live query | `GET https://docs.otherside.xyz/odk/quick-start?ask=<question>` |

---

## Contributing

1. Fork this repo
2. Create your skill in `skills/<skill-name>/SKILL.md`
3. Keep it under 500 lines
4. Add trigger keywords to the `description` frontmatter field
5. Test with at least 3 real prompts before submitting a PR

---

## Platform Compatibility

| Tool | Support | Method |
|------|---------|--------|
| Claude Code | Full | Skills + hooks + settings.json |
| Antigravity | Full | Same as Claude Code |
| OpenAI Codex | Full | AGENTS.md + skills/ |
| Gemini CLI | Full | GEMINI.md |
| Kimi | Full | .kimi/otherside-context.md |
| Cursor | Full | .cursor/rules/otherside.mdc |
| Windsurf | Full | .windsurf/rules/otherside.md |
| Aider | Via convert | CONVENTIONS.md |
| OpenCode | Via convert | .opencode/rules/ |

---

## License

MIT — see [LICENSE](LICENSE)
