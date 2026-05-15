---
name: otherside-task-flow
description: "Otherside Task Flow System for quests and tutorials. TRIGGER when: user asks about Task Flow System, ODK quests, quest system Otherside, tutorial system ODK, sequential tasks, task triggers, task conditions, task actions, task progression, guided experience Otherside, objective system ODK, task sequence."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v8.2"
---

# Otherside Task Flow System

Introduced in v8.2. Provides structured quest, tutorial, and objective guidance for players.

## Core Concepts

The Task Flow System is built on three primitives:

| Primitive | Purpose |
|-----------|---------|
| **Trigger** | What starts or advances a task |
| **Condition** | Requirements that must be true for the trigger to fire |
| **Action** | What happens when a task step completes |

## Task Structure

Each task flow is a **sequence** — steps must complete in order.

```blueprint
// Task Flow Blueprint structure
TaskFlow "Tutorial_BasicMovement":
  Steps:
    - Step 1: Walk to marker
        Trigger: PlayerReachesLocation(Marker_A)
        Condition: None
        Action: ShowNotification("Great! Now jump.")

    - Step 2: Jump
        Trigger: PlayerJumps()
        Condition: IsNear(Marker_A, Radius: 500)
        Action: ShowNotification("Perfect! Head to the vending machine.")

    - Step 3: Reach vending machine
        Trigger: PlayerReachesLocation(Marker_VendingMachine)
        Condition: PreviousStepComplete
        Action: GrantItem(Player, "StarterPack"), CompleteTaskFlow()
```

## Triggers

| Trigger Type | Description |
|-------------|-------------|
| `PlayerReachesLocation` | Player enters a radius around a world location |
| `PlayerInteractsWith` | Player interacts with an actor |
| `PlayerPicksUp` | Player collects a pickup actor |
| `PlayerKills` | Player eliminates another player/NPC |
| `PlayerPurchases` | Player completes a vending machine transaction |
| `TimerExpires` | Time-based trigger |
| `CustomEvent` | Fire from any blueprint via `TaskFlow.FireCustomTrigger(Name)` |

## Conditions

| Condition | Description |
|-----------|-------------|
| `None` | Always passes |
| `PreviousStepComplete` | Default sequential gating |
| `HasItem(ItemID)` | Player holds a specific item |
| `HasRole(RoleName)` | Player has a specific role |
| `NFTOwned(Collection)` | Player owns an NFT from collection |
| `ScoreAbove(Value)` | Player's score exceeds threshold |
| `And(A, B)` | Both conditions must be true |
| `Or(A, B)` | Either condition must be true |

## Actions

| Action | Description |
|--------|-------------|
| `ShowNotification(Message)` | Display ODK notification to player |
| `GrantItem(ItemID)` | Add item to player inventory |
| `GrantRole(RoleName)` | Grant a capability role |
| `PlayAnimation(AnimID)` | Trigger a world animation |
| `SpawnActor(Class, Location)` | Spawn an actor in the world |
| `OpenVendingMachine(VMID)` | Auto-open a vending machine UI |
| `TeleportPlayer(Location)` | Move player to world position |
| `CompleteTaskFlow()` | Mark the entire flow as complete |
| `BroadcastEvent(Name)` | Fire a named event to other blueprints |

## Tutorial Pattern

```blueprint
// Simple onboarding tutorial
TaskFlow "Onboarding":
  OnStart: ShowWelcomeNotification()
  
  Steps:
    - Step 1: Explore
        Trigger: TimerExpires(Duration: 30.0)
        Action: ShowNotification("Found anything interesting?")
    
    - Step 2: Find the token gate
        Trigger: PlayerReachesLocation(TokenGate_Entrance)
        Action: ShowNotification("This area requires a Bored Ape. Check your wallet!")
    
    - Step 3: Complete
        Trigger: CustomEvent("PlayerReadyConfirmed")
        Action: CompleteTaskFlow(), GrantItem("Onboarding_Badge")
```

## Quest Pattern (Repeatable)

```blueprint
// Repeatable daily quest
TaskFlow "DailyQuest_Coins":
  Repeatable: true
  ResetInterval: Daily
  
  Steps:
    - Step 1: Collect 10 coins
        Trigger: PlayerPicksUp (Count: 10, ItemType: Coin)
        Condition: None
        Action: ShowNotification("10 coins collected! Keep going.")
    
    - Step 2: Collect 50 coins total
        Trigger: PlayerPicksUp (TotalCount: 50, ItemType: Coin)
        Condition: PreviousStepComplete
        Action: GrantItem("DailyReward_APE_100"), CompleteTaskFlow()
```

## UI Integration

The Task Flow System integrates with the ODK notification system:
- Step completion fires notifications automatically if configured
- Progress UI: use `GetTaskFlowProgress(FlowID)` to build custom HUD elements
- Active task display: query `GetActiveTaskFlows(Player)` for player's ongoing quests

```blueprint
// Custom HUD widget — show task progress
OnTick():
  Progress = GetTaskFlowProgress(Player, "DailyQuest_Coins")
  TaskProgressBar.SetPercent(Progress.CompletedSteps / Progress.TotalSteps)
  TaskObjectiveText.SetText(Progress.CurrentStepDescription)
```

## Multi-Player Considerations

Task flows are **per-player** by default:
- Each player tracks their own task progress
- Use `BroadcastEvent` for team-shared objectives
- For co-op tasks, use a shared counter via world service

```blueprint
// Co-op task — shared coin collection
OnCoinPickup(Player):
  SharedCounter.Increment()
  if SharedCounter.Value >= TeamGoal:
    AllPlayers.FireCustomTrigger("SharedGoalReached")
```

## Persistence

Task flow completion can be persisted:
- Completed flags stored in ODK persistence layer
- Use `TaskFlow.SetPersistent(true)` for one-time quests
- Daily quests reset via `ResetInterval` setting

## Related Skills

- `otherside-plugin-features` — notifications and persistence systems
- `otherside-commerce-economy` — vending actions in task flows
- `otherside-templates` — Boneyard/Combat use task flows for onboarding
- `otherside-morpheus-networking` — world services for shared state
