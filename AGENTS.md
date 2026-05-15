# Otherside Developer Skills — Agent Instructions

This file is read automatically by OpenAI Codex, Codex CLI, and compatible agents.

## Context

You are assisting with **Otherside** development — a metaverse platform built on Unreal Engine
using the **Otherside Development Kit (ODK)** and **Morpheus networking**.

Key facts:
- Development is **Blueprint-only** (no C++ extensions to the ODK)
- Networking uses **Morpheus**, not Unreal's native replication
- Actor pooling: never call `DestroyActor()` on pooled actors — use `OthersideReturnToPool()`
- Default character is **Voyager 2.0** (v9.4.1+)
- Primary currency: **ApeCoin (APE)** on **ApeChain**

## Documentation

Full docs: https://docs.otherside.xyz/llms-full.txt  
Sitemap: https://docs.otherside.xyz/sitemap.md  
Query docs: `GET https://docs.otherside.xyz/odk/quick-start?ask=<question>`

## Skills Available

Load these skill files for deep-dive context on each topic:

| Skill File | Topic |
|-----------|-------|
| `skills/otherside-quick-start/SKILL.md` | ODK setup, deployment, PIE |
| `skills/otherside-avatar-system/SKILL.md` | Avatar creation, specs, collections |
| `skills/otherside-plugin-features/SKILL.md` | Plugin features: auth, gating, emotes, NPCs |
| `skills/otherside-morpheus-networking/SKILL.md` | Morpheus networking, actor pooling |
| `skills/otherside-commerce-economy/SKILL.md` | Vending, NFT, ApeChain, commerce |
| `skills/otherside-templates/SKILL.md` | Boneyard and Combat templates |
| `skills/otherside-world-travel/SKILL.md` | Portals, travel, movement mechanics |
| `skills/otherside-task-flow/SKILL.md` | Quest and tutorial system |
| `skills/otherside-agentic-api/SKILL.md` | Agentic API and Vibe Maker |
| `skills/otherside-debugging/SKILL.md` | Debugging, troubleshooting, known issues |

## Key Rules

1. Always use Morpheus networking primitives — never Unreal native RPC/replication
2. Return pooled actors to pool — never destroy them
3. Override `GetDefaultInputMappingContexts` for any custom input mapping (v7.0+)
4. Use `Server_TransferDataObjects` (not deprecated `Server_TransferObjects`)
5. Token gates can be updated via live config without redeployment
6. ERC-1155 on ApeChain is the standard for all in-world commerce

## Breaking Changes (v9.4.1)

- `Server_TransferObjects` → use `Server_TransferDataObjects` with client callback
- Legacy WebUI → use new `WebUI` Chromium component
- Input mapping context override required since v7.0
