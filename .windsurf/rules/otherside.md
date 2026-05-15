# Otherside ODK — Windsurf Rules

## Context

Working on **Otherside** (metaverse platform): ODK on Unreal Engine 5.5.4 + Morpheus networking.
Blueprint-only development — no C++ extensions to ODK.

## Must Follow

1. **Morpheus only** for networking — never Unreal native RPC/replication
2. **Actor pooling** — `OthersideReturnToPool()`, never `DestroyActor()` on pooled actors
3. **Input** — override `GetDefaultInputMappingContexts()` for custom input mapping
4. **Commerce** — ApeCoin on ApeChain, ERC-1155, handle grant failures
5. **Data transfer** — `Server_TransferDataObjects` (deprecated: `Server_TransferObjects`)

## Skill Files

| Topic | File |
|-------|------|
| Setup & deployment | `skills/otherside-quick-start/SKILL.md` |
| Avatars & characters | `skills/otherside-avatar-system/SKILL.md` |
| Plugin features | `skills/otherside-plugin-features/SKILL.md` |
| Morpheus networking | `skills/otherside-morpheus-networking/SKILL.md` |
| Commerce & NFT | `skills/otherside-commerce-economy/SKILL.md` |
| Templates | `skills/otherside-templates/SKILL.md` |
| World travel | `skills/otherside-world-travel/SKILL.md` |
| Task flow / quests | `skills/otherside-task-flow/SKILL.md` |
| Agentic API | `skills/otherside-agentic-api/SKILL.md` |
| Debugging | `skills/otherside-debugging/SKILL.md` |

## Docs

https://docs.otherside.xyz/llms-full.txt
