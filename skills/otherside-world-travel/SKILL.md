---
name: otherside-world-travel
description: "Otherside world travel, portals, and bubbles. TRIGGER when: user asks about teleportation Otherside, Otherside portals, world transition, avatar persistence across worlds, cross-experience, bubble system, bubble join, bubble leave, levitators, grind rails, movement mechanics, jump pads, gliding Otherside, fall damage Otherside, world-to-world travel."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside World Travel & Navigation

## Teleportation Portals

Portals allow players to travel between Otherside experiences while maintaining their avatar and profile.

### Portal Actor Setup

```blueprint
// Configure a portal in your world
Portal.SetDestinationWorld("world-slug-or-id")
Portal.SetTransitionType(ETransitionType.Fade)
Portal.SetActivationTrigger(ETriggerType.Overlap)  // or Interact
```

### Avatar Persistence Across Worlds

When players travel through a portal:
- Equipped avatar and cosmetics persist
- ApeChain profile identity carries over (v8.2+)
- Inventory state may reset depending on destination world's rules
- **Known issue**: Avatar spawns without equipment after teleportation in some cases

### Cross-Experience Progression

Track player progress across multiple experiences:
- Use ApeChain on-chain data for persistent state
- Profile Overlay displays cross-experience identity
- Custom progression data: use ODK persistence layer

## Bubble System

Bubbles are Morpheus spatial zones defining player proximity groups.

### Bubble Events

```blueprint
// Subscribe to bubble transition events
OnBubbleJoin(Player):
  // Player entered a bubble — sync nearby state
  SyncNearbyActors(Player)
  EmoteWheel.Close()  // Auto-close on join (v9.4.1)

OnBubbleLeave(Player):
  // Player left a bubble — trigger fall if applicable
  if WasInAirOnLeave:
    TriggerFallBehavior(Player)
  EmoteWheel.Close()  // Auto-close on leave (v9.4.1)
```

### Bubble Collision Detection

Bubble boundaries were improved in v8.3 — players no longer clip through boundary edges. Design world geometry to avoid overlapping bubble boundaries.

## Movement Systems

### Grind Rails

High-speed rail traversal:
- Full gamepad/controller support
- Titan avatar has known jitter issue on rails
- Configure rail direction and speed on the `BP_GrindRail` actor

```blueprint
// Grind rail configuration
GrindRail.SetSpeed(1200.0)      // Units per second
GrindRail.SetDirection(Forward)
GrindRail.SetLooping(false)
GrindRail.SetExitBehavior(EExitBehavior.Launch)
```

### Levitators (Vertical Traversal)

Levitators launch players upward and activate gliding:
```blueprint
Levitator.SetLiftForce(1500.0)
Levitator.SetActivationRadius(150.0)
Levitator.SetGlideTriggerHeight(400.0)  // Height at which glide activates
```

### Gliding

Activated from levitators or sufficient height:
- Supports lateral strafing during glide
- Duration determined by height and glide speed settings
- Ends when player lands or enters a bubble

### Jump Pads

Launch players to defined locations:
```blueprint
JumpPad.SetTarget(TargetLocation)
JumpPad.SetArcHeight(800.0)
JumpPad.SetLaunchAnimation(ELaunchAnim.Somersault)
```
Somersault animation plays on launch (v3.0+).

### Falling

Falling triggers when:
- Player exits a bubble mid-air
- Player walks off a ledge
- Levitator glide ends before landing

Falling has sound and animation. Configure fall damage if applicable.

## World Deployment & Live Config

### Deploying a World

1. Select map from ODK toolbar dropdown
2. Upload content (assets must be processed first)
3. Publish — world goes live immediately

### Live Configuration

Update world settings without redeployment:
- Token gate rules
- Vending machine inventory
- Notification messages
- Spawn point weights

```bash
# Update live config via ODK CLI
odk config update --world my-world-slug --key "vending.items" --value "[...]"
```

## Portal UX Patterns

### Recommended Portal Placement

- Place portals at natural navigation endpoints (exits, edges of map)
- Use visible portal VFX so players recognize them
- Add an optional interaction prompt (press E / gamepad A)
- Show destination world name in portal UI

### Loading Transition

```blueprint
// Show loading UI during world transition
Portal.OnActivated():
  ShowLoadingScreen(DestinationWorldName)
  // Morpheus handles actual world transfer
```

## Known Issues

| Issue | Status |
|-------|--------|
| Avatar spawns without equipment post-teleport | Known — verify equipment state OnSpawn |
| Titan avatar jitter on grind rails | Known |
| Emote wheel not closing on bubble transition | Fixed v9.4.1 |

## Related Skills

- `otherside-morpheus-networking` — bubble system internals
- `otherside-plugin-features` — input and movement mode configuration
- `otherside-templates` — environmental actors (rails, levitators, pads)
- `otherside-quick-start` — world deployment workflow
