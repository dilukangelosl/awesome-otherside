# Otherside Developer Skills — Gemini CLI Instructions

This file is loaded automatically by Gemini CLI when present in the project root or `~/.gemini/`.

## Project Context

You are working on **Otherside** — a metaverse platform using the **Otherside Development Kit (ODK)**.
The ODK is built on **Unreal Engine 5.5.4** with **Morpheus networking** (not Unreal native replication).

## Tool Mapping (Gemini CLI → Skill equivalents)

When the user asks about Otherside topics, read the corresponding skill file:

```
ODK setup / quick start          → skills/otherside-quick-start/SKILL.md
Avatar / character / BAYC / GLB  → skills/otherside-avatar-system/SKILL.md
Plugin features / auth / emotes  → skills/otherside-plugin-features/SKILL.md
Morpheus / networking / pooling  → skills/otherside-morpheus-networking/SKILL.md
Vending / NFT / ApeChain         → skills/otherside-commerce-economy/SKILL.md
Boneyard / Combat template       → skills/otherside-templates/SKILL.md
Portals / world travel / bubbles → skills/otherside-world-travel/SKILL.md
Task flow / quests / tutorials   → skills/otherside-task-flow/SKILL.md
Agentic API / Vibe Maker / MML   → skills/otherside-agentic-api/SKILL.md
Debug / crash / credentials      → skills/otherside-debugging/SKILL.md
```

## Essential Rules

- **No C++ ODK extensions** — Blueprints only
- **Morpheus only** — never Unreal native replication or RPCs
- **Actor pooling** — `OthersideReturnToPool()`, never `DestroyActor()` on pooled actors
- **Commerce** — ApeCoin on ApeChain, ERC-1155 standard
- **Deprecated** — `Server_TransferObjects` → use `Server_TransferDataObjects`

## Documentation Query

For live documentation lookup:
```
GET https://docs.otherside.xyz/odk/quick-start?ask=<question>
```

Full corpus: https://docs.otherside.xyz/llms-full.txt
