---
name: otherside-quick-start
description: "Getting started with Otherside Development Kit (ODK). TRIGGER when: user asks about ODK setup, installing Otherside plugin, Unreal Engine Otherside integration, MSquared World Builder, ODK Launcher, Play-in-Editor testing, deploying worlds, PIE, quick start, technical overview, ODK project setup, otherside.xyz development."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside Development Kit — Quick Start

## What is the ODK?

The Otherside Development Kit (ODK) is built on top of **MSquared's World Builder** platform, enabling rapid content iteration with support for large player counts. Development uses **Blueprint-only Unreal Engine** workflows (no C++ required).

## Prerequisites

- Unreal Engine 5.5.4 (managed via ODK Launcher)
- ODK Launcher (Windows primary; Mac PAK embedded builds supported)
- Node.js v20.x (for avatar pipeline automation)
- Blender 4.5 LTS (for character/avatar work)

## Installation & Setup

### 1. ODK Launcher

Download and run the ODK Launcher. Features:
- Custom installation path selection
- Windows Start Menu integration
- Multiple project template support
- Optional content downloads
- Automatic project registration
- Editor version management with auto-updates
- Built-in log access for bug reporting

### 2. Create a New Project

Choose from available templates in the launcher:
- **Boneyard Template** — coins, arcade machines, token gating example
- **Combat Template** — teams, scoreboards, respawn logic, role promotion

### 3. Key Workflow Differences from Native Unreal

The ODK has important differences from standard Unreal Engine:
- Uses **Morpheus networking** instead of Unreal's built-in networking
- Uses **actor pooling** for performance optimization (do not destroy pooled actors directly)
- Blueprint-only: avoid C++ extensions to the ODK plugin
- **GetDefaultInputMappingContexts** must be overridden for input mapping context changes (v7.0+)

## Play-in-Editor (PIE) Testing

Test your experience locally before deploying:
1. Open your project in Unreal Editor
2. Press Play — the PIE session uses Morpheus networking
3. Use **Ctrl+U** at runtime to toggle UI Mode for debugging widget hierarchy

**Known PIE issues:**
- Morpheus array garbage collection can crash PIE (fixed in v9.4.1)
- Credentials may need clearing between sessions (see Debugging skill)

## Deployment

From the ODK Editor toolbar:
1. Select your map for deployment
2. Upload content and configure live settings
3. Use live configuration editing without full redeploy for minor updates
4. Inspector access is role-gated via `Capabilities.Morpheus.InspectorEnabled`

## Documentation Resources

| Resource | URL |
|----------|-----|
| Full docs corpus | `https://docs.otherside.xyz/llms-full.txt` |
| Sitemap | `https://docs.otherside.xyz/sitemap.md` |
| MSquared World Builder | Referenced in ODK docs |
| Breaking changes | `https://docs.otherside.xyz/breaking-changes` |

## Ask the Docs

Query the ODK docs directly:
```
GET https://docs.otherside.xyz/odk/quick-start?ask=<your+question>
```
Returns a direct answer plus relevant doc excerpts.

## Version History Summary

| Version | Key Changes |
|---------|-------------|
| v9.4.1 | Morpheus GC crash hotfix, emote stickers, Voyager 2.0 default |
| v9.2 | Unreal 5.5.4, Curtis Network, Mac PAK builds, presence whitelisting |
| v8.2 | Profile Overlay identity, Chromium web browser, Task Flow System |
| v7.0 | Vending Machine enhancements, interaction component migration |
| v6.0 | Teleportation, role granting, Koda Cam improvements |
| v5.0 | Koda Cam, Avatar Selector, custom emotes persistence |
| v4.0 | Combat Template, teams, scoreboard, spawn points |
| v1.0 | V1 NFT Avatar Selector, token gating, ApeChain commerce |

## Related Skills

- `otherside-avatar-system` — character creation and avatar specs
- `otherside-plugin-features` — all ODK plugin capabilities
- `otherside-morpheus-networking` — Morpheus networking deep dive
- `otherside-debugging` — troubleshooting and credential management
