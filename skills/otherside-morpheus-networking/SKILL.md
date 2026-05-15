---
name: otherside-morpheus-networking
description: "Otherside Morpheus networking system. TRIGGER when: user asks about Morpheus, actor pooling, network synchronization, Server_TransferDataObjects, Server_TransferObjects, replication Otherside, multiplayer ODK, Morpheus array, garbage collection crash, PIE networking, Curtis Network, networked blueprints Otherside, world services, stale objects."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside Morpheus Networking

## Overview

Morpheus is the custom networking layer used by the ODK instead of Unreal Engine's native replication system. It enables:
- Large concurrent player counts
- Blueprint-only networking without C++ replication
- Cross-experience state synchronization

**Do not use Unreal's native `Replicated` properties or RPCs** — always use Morpheus networking primitives.

## Actor Pooling

Actor pooling is the core performance pattern for Morpheus worlds.

### Rules
- **Never destroy pooled actors directly** — return them to the pool
- Use the ODK pool return methods instead of `DestroyActor()`
- Pooled actors maintain state — reset state explicitly when returning

### Common Mistakes
```blueprint
// WRONG — destroys the actor permanently
DestroyActor(PooledActor)

// CORRECT — returns to pool for reuse
OthersideReturnToPool(PooledActor)
```

## Data Transfer

### Server_TransferDataObjects (Current)
Introduced to replace `Server_TransferObjects`. Supports:
- Client-side callback with success/failure message
- Structured data object transfer
- Error handling on client side

```blueprint
// Server_TransferDataObjects with client callback
Server_TransferDataObjects(
  DataObjects: [...],
  OnSuccess: { /* handle success */ },
  OnFailure: { /* handle failure, show user message */ }
)
```

### Server_TransferObjects (Deprecated)
**Deprecated** — migrate to `Server_TransferDataObjects`.
The old event had no client-side callback and provided no feedback on failure.

## Morpheus Arrays

Morpheus arrays are networked data structures. Key behaviors:
- Garbage collection (GC) can crash PIE when arrays hold stale references (fixed in v9.4.1)
- **Stale object dangling pointers**: explicitly null references before returning actors to pool
- Array mutations must go through Morpheus methods, not standard Unreal array operations

### Anti-Pattern: Stale References
```blueprint
// Before returning actor to pool — clear Morpheus array references
MorpheusArray.Remove(ActorRef)
ActorRef = None  // Null the reference to prevent dangling pointer
OthersideReturnToPool(ActorRef_Copy)
```

## World Services

World services handle global state and shared systems:
- Cleanup fixes applied in v8.3
- Use world service references rather than direct singleton access
- World services are Morpheus-aware and handle reconnection

## Curtis Network (v9.2+)

Curtis Network is an enhanced networking layer for specific use cases:
- Improves reliability in high-player-count scenarios
- Configured per-world in deployment settings

## PIE Networking Behavior

Play-in-Editor uses a local Morpheus instance:
- Multi-player PIE spawns separate Morpheus sessions per player window
- Credential conflicts can occur — use separate test accounts per PIE window
- Bubble join/leave events fire correctly in PIE (v8.3 collision detection fix)

## Bubble System

Bubbles are Morpheus's spatial proximity zones:
- Players entering/leaving bubbles triggers network events
- Emote wheel auto-closes on bubble transitions (v9.4.1)
- Falling behavior triggers on bubble exit
- Bubble collision detection improved in v8.3

## Roles & Capabilities

Morpheus uses a capability system for access control:
```
Capabilities.Morpheus.InspectorEnabled  → Grants inspector access
```
Roles are granted per-player and persist across the session. Role granting introduced in v6.0.

## Real-Time Updates

WebSocket channels for live data:
```
realtime/nft/userBalance  → Live NFT balance updates for commerce
```

## Input Mapping Context (v7.0+ Breaking Change)

If you override input contexts, you must now implement:
```blueprint
// Required override since v7.0
GetDefaultInputMappingContexts() -> Array<InputMappingContext>
```
Failure to override causes input mapping to reset to defaults on world load.

## Known Networking Issues

| Issue | Version Fixed | Notes |
|-------|---------------|-------|
| Morpheus array GC crash in PIE | v9.4.1 | Array references held during GC |
| Stale object dangling pointer access | v9.4.1 | Null refs before pool return |
| Bubble collision detection | v8.3 | Boundary edge cases |
| World services cleanup | v8.3 | Shutdown sequence ordering |

## Related Skills

- `otherside-quick-start` — PIE setup and editor workflow
- `otherside-plugin-features` — plugin features that use Morpheus
- `otherside-debugging` — diagnosing networking issues
- `otherside-world-travel` — cross-world travel and state persistence
