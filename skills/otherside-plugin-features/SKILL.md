---
name: otherside-plugin-features
description: "Otherside ODK plugin features and components. TRIGGER when: user asks about ODK authentication, Privy wallet, Chromium web browser, token gating, NFT gate, interaction component, Millicast video screen, physics objects, selfie cam, Koda cam, notifications, persistence, emotes, feels, moderation, analytics, movement modes, blueprint nodes, NPCs, NPC stations, ODK input management, ODK UI widgets, scannable objects."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside ODK Plugin Features

## Authentication & Wallet

### Privy Integration
- Seamless wallet creation without crypto knowledge
- Collection access control via Privy sessions
- Cross-experience profile identity on ApeChain (v8.2+)

### Wallet Views
- Display owned NFTs and balances in-experience
- ApeChain wallet-to-wallet transactions
- Real-time balance updates via WebSocket: `realtime/nft/userBalance`

## Web Browser (Chromium)

Available since v8.2:
- Full Chromium-based browser renderable in-world
- In-experience content delivery (videos, web apps, docs)
- Replaces legacy WebUI: update old web browser logic to new `WebUI` component
- Millicast streaming screen integration

## Input Management

### UI Mode
- Toggle with **Ctrl+U** at runtime for widget hierarchy debugging
- Separate input contexts for world vs. UI interaction

### Components & Keybindings
- Override `GetDefaultInputMappingContexts` to customize input mapping (required since v7.0)
- Controller support: gamepad fully supported across vending machines, movement, emotes

## Token Gating

Control access to areas, items, or features based on NFT ownership:
```
Supported gate types:
- Collection-level (all tokens in a collection)
- Contract address
- Specific chain (ApeChain)
- Specific token ID
- Metadata trait-based gating
```

Configuration via live config — no full redeploy needed for gate updates.

### Per-project Whitelisting
In v9.2+, presence endpoint collection whitelisting allows per-project control over which collections are recognized.

## Interaction System

The ODK Interactable Component (introduced v1.0, migrated v7.0):
- Priority-based interaction events
- Lightweight for high-performance worlds
- Assign interactions to any actor with the component attached
- Use the **ODK Interaction Component** (not raw overlap events) for correct Morpheus behavior

## Video / Millicast Screens

- Display streaming video content in-world
- Supports Millicast streaming protocol
- Configurable screen actors placeable in the level

## Physics Objects

Standard physics actors that work within Morpheus networking constraints. Note: not all Unreal physics features behave identically — test in PIE before deploying.

## Selfie Cam & Koda Cam

- **Selfie Cam**: Player-facing camera for in-experience photos
- **Koda Cam**: Enhanced camera for Koda avatars (introduced v5.0); known issue: camera wobble/shaking

**Performance note**: Rapid "P" key spam in selfie mode can cause performance issues.

## Notifications System

Send developer-configured messages to players in-experience:
```blueprint
// ODK Notification Blueprint node
SendODKNotification(PlayerRef, "Your message here", NotificationType)
```
Integrates with existing ODK messaging infrastructure.

## Persistence

Save player data across sessions:
- Persistent emote preferences
- Custom emote data (introduced v5.0)
- Cross-experience progression tracking

## Emotes (Feels)

### Design, Upload & Sell
- Custom emote creation workflow
- Emote stickers appear above character heads (v9.4.1)
- Non-co-op emotes play locally only (no network sync overhead)
- Auto emote wheel closure on bubble join/leave
- Audio: footstep SFX for emotes; non-footstep audio plays locally only

### Emote Rules
```
- Sticker emotes: visual only, above character head
- Co-op emotes: requires both players to confirm
- Cancellation: handled automatically on world transition
```

## Moderation

Built-in simplified moderation system (v8.2+):
- Free to use (replaced previous Community Sift paid integration)
- Configurable from ODK dashboard
- Player reporting and content moderation tools

## Analytics

Track in-experience events:
- Player engagement metrics
- Commerce events (purchases, vending interactions)
- Custom event tracking via ODK analytics blueprint nodes

## Movement Modes

| Mode | Description |
|------|-------------|
| Walk / Run | Standard locomotion |
| Grinding | Rail grinding with controller support |
| Gliding | From levitators or heights; supports strafing |
| Jump Pad | Triggers somersault animation on launch |
| Falling | Triggered when exiting bubbles |

## Blueprint Node Library

ODK exposes a full blueprint node library:
- Morpheus networking utilities
- Avatar/character queries
- Commerce and NFT checks
- Notification and UI helpers
- Analytics event dispatch
- Movement mode control

See `https://docs.otherside.xyz/plugin-features` for full node reference.

## Visual Effects (VFX)

Blueprint-accessible VFX for in-world effects. Standard Unreal Niagara systems are supported with Morpheus networking constraints.

## NPCs & NPC Stations

- Place NPCs in worlds for ambient life or interaction points
- NPC Stations define interaction areas around NPCs
- Configure dialogue, quests, and commerce triggers on NPC actors

## Scannable Objects

Players can scan in-world objects to:
- Reveal metadata (collection info, token ID)
- Trigger interactions or token-gate checks
- Display web overlay content

## Deprecated Features

| Feature | Replacement |
|---------|-------------|
| `Server_TransferObjects` event | `Server_TransferDataObjects` (with client callback) |
| Legacy WebUI | New `WebUI` Chromium component |
| Community Sift moderation | Built-in ODK moderation (v8.2) |
| Old interaction component | ODK Interaction Component migration (v7.0) |

## Related Skills

- `otherside-morpheus-networking` — networking internals
- `otherside-commerce-economy` — vending machines, NFT, ApeChain
- `otherside-task-flow` — Task Flow System for quests and tutorials
- `otherside-world-travel` — bubbles, portals, world transitions
