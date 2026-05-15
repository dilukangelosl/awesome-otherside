---
name: otherside-templates
description: "Otherside ODK project templates. TRIGGER when: user asks about Boneyard template, Combat template, ODK template, arcade machine template, token gating template, teams template, scoreboard Otherside, respawn system ODK, role promotion ODK, coin pickup ODK, Squerris Wheel, Boneyard map, combat template setup, spawn points Otherside."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside ODK Templates

Templates are the fastest way to start an Otherside experience. Select from the ODK Launcher when creating a new project.

## Boneyard Template

The Boneyard template demonstrates core gameplay and commerce features.

### Included Systems

| System | Description |
|--------|-------------|
| Coin pickups | Collectible currency scattered around the world |
| Arcade machines | Interactable game stations with score tracking |
| Token gating | Area/item access gated by NFT ownership |
| Boneyard map | The official Otherside Boneyard level layout |
| Vending machine | Pre-configured ApeCoin shop |

### Key Actors

```
BP_CoinPickup          — Collectible coin actor (uses actor pooling)
BP_ArcadeMachine       — Interactive arcade station
BP_TokenGate_Area      — Area gate requiring NFT ownership
BP_VendingMachine      — Pre-configured commerce point
```

### Coin Pickup Pattern

```blueprint
// Coin actor — uses pool return, not DestroyActor
OnPickup(Player):
  AddCoinsToPlayer(Player, CoinValue)
  PlayPickupEffect()
  OthersideReturnToPool(Self)  // Return to pool, not destroy
```

### Token Gating Example (Boneyard)

The Boneyard template gates premium areas by BAYC/MAYC ownership:
```blueprint
// Configured on BP_TokenGate_Area
Gate.SetCollection("BAYC")
Gate.SetChain(ApeChain)
Gate.SetDeniedMessage("Bored Apes only beyond this point!")
```

## Combat Template (v4.0+)

The Combat Template provides a full multiplayer game experience with team-based combat.

### Included Systems

| System | Description |
|--------|-------------|
| Teams | Auto-assignment to balanced teams |
| Scoreboard | Live kill/death/objective tracking |
| Respawn system | Configurable respawn points and timers |
| Role promotion | Promote players to special roles mid-match |
| Shotgun weapon | Hitscan weapon with ammo management |
| Grenades | Throwable with cooldown |
| Health system | Per-character HP with damage/heal events |
| Spawn points | Configurable team spawn zones |
| Custom emotes | Combat-themed emote set |

### Team Configuration

```blueprint
// Team setup in Combat Template
CombatManager.SetTeamCount(2)
CombatManager.SetMaxPlayersPerTeam(8)
CombatManager.SetAutoBalance(true)
CombatManager.SetRespawnDelay(3.0)  // seconds
```

### Scoreboard

```blueprint
// Scoreboard update event
OnPlayerKill(Killer, Victim):
  Scoreboard.AddKill(Killer)
  Scoreboard.AddDeath(Victim)
  BroadcastScoreUpdate()
```

### Role Promotion System

Promote players mid-match to special roles (introduced v6.0):
```blueprint
// Grant a special role in-match
GrantRole(Player, "Sniper")
// Role capabilities are defined in ODK dashboard
```

### Spawn Points

Configure spawn zones per team:
```
BP_SpawnPoint_Team1   — Places in Team 1 spawn zone
BP_SpawnPoint_Team2   — Places in Team 2 spawn zone
BP_SpawnPoint_Neutral — Used for spectators/waiting players
```

### Weapon System

```blueprint
// Shotgun blueprint pattern
OnFire():
  if AmmoCount > 0:
    PerformHitscanMultiple(Origin, Direction, PelletCount: 8, Range: 500)
    AmmoCount -= 1
    PlayFireAnimation()
  else:
    PlayEmptySound()
    TriggerReload()
```

### Grenade System

```blueprint
// Grenade with cooldown
OnThrowGrenade():
  if GrenadeCooldown.IsReady():
    SpawnGrenade(ThrowOrigin, ThrowDirection)
    GrenadeCooldown.Start(CooldownSeconds: 5.0)
  else:
    ShowCooldownUI(GrenadeCooldown.Remaining)
```

## World Environmental Features

Both templates share access to environmental traversal actors:

| Actor | Description |
|-------|-------------|
| Squerris Wheel | Moving platform traversal |
| Levitators | Vertical lift, triggers gliding |
| Grind Rails | High-speed rail grinding with controller support |
| Jump Pads | Launch points that trigger somersault animations |
| Teleportation Portals | World-to-world travel (see `otherside-world-travel`) |

## Template Customization

### Adding to Boneyard

1. Duplicate existing actors as starting points
2. Configure token gate conditions in the actor details panel
3. Connect to Morpheus events via ODK blueprint nodes
4. Test in PIE before deploying

### Adding to Combat

1. Place spawn points in both team zones
2. Configure team count and respawn delay in CombatManager
3. Add optional role definitions in ODK dashboard
4. Set scoreboard win conditions (kill limit or time limit)

## Related Skills

- `otherside-commerce-economy` — vending machine and NFT gate setup
- `otherside-morpheus-networking` — actor pooling for pickups
- `otherside-plugin-features` — full plugin feature reference
- `otherside-world-travel` — adding portals to templates
