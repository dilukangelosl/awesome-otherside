---
name: otherside-debugging
description: "Otherside ODK debugging and troubleshooting. TRIGGER when: user asks about ODK debug, Otherside crash, credential clearing, Windows Credential Manager, Unreal log collection, UI mode debug, web cache clear, PIE crash, Morpheus crash, ODK error, blueprint error Otherside, support bug report, ODK troubleshooting, known issues Otherside, camera wobble Koda, avatar jitter."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside ODK Debugging & Troubleshooting

## In-Editor Debug Tools

### UI Mode (Ctrl+U)

Toggle UI Mode at runtime to debug widget hierarchy:
```
Ctrl+U   →   Toggle UI Debug Mode
```
- Shows all active widgets and their render order
- Helps diagnose overlapping UI elements
- Shows focus state and input routing

### ODK Launcher Logs

Access logs directly from the ODK Launcher:
- Click the log button in the launcher toolbar
- Logs include editor startup, plugin loading, and build output
- Share logs with Otherside support for bug reports

### Unreal Log Collection

For crash reports and support tickets:
1. Navigate to `<ProjectDir>/Saved/Logs/`
2. Collect the most recent `.log` file
3. Include the `UE4` or `UnrealEditor-*.log` files

```bash
# Quick log collection command (macOS/Linux)
cp ~/Documents/Unreal\ Projects/MyODKProject/Saved/Logs/UnrealEditor.log ~/Desktop/

# Windows
copy "%USERPROFILE%\Documents\Unreal Projects\MyODKProject\Saved\Logs\UnrealEditor.log" "%USERPROFILE%\Desktop\"
```

## Credential Management

### Clearing Credentials

If authentication fails or you need to switch accounts:

**Windows:**
1. Open Windows Credential Manager (`Win+S` → "Credential Manager")
2. Go to "Windows Credentials" tab
3. Find credentials with "Otherside" or "MSquared" in the name
4. Click "Remove" on each

**Web Cache:**
1. Navigate to `%APPDATA%\Otherside\` (Windows) or `~/Library/Application Support/Otherside/` (Mac)
2. Delete the `cache` folder
3. Restart the ODK Launcher

### PIE Credential Conflicts

When running multi-player PIE:
- Each PIE window needs a separate test account
- Credential conflicts cause authentication failures on the second window
- Use browser profile separation for each test account's web session

## Known Issues Reference

### v9.4.1 (Current)

| Issue | Type | Notes |
|-------|------|-------|
| Avatar spawns without equipment post-teleport | Bug | Workaround: re-equip on `OnSpawn` event |
| Performance degrades on rapid P-key spam in selfie mode | Bug | Add rate limiting to selfie activation |
| Camera wobble/shaking in Koda Cam | Bug | Active investigation |
| Titan avatar jitter on grind rails | Bug | Avoid Titan with high-speed rails |
| Web browser content processing failures | Bug | Retry with exponential backoff |
| Avatar hand visibility in first-person mode | Known limitation | Design workaround in first-person experiences |

### Fixed in v9.4.1

| Issue | Was in |
|-------|--------|
| Morpheus array GC crash in PIE | v9.4 |
| Stale Morpheus object dangling pointer access | v9.4 |
| Emote wheel not closing on bubble transition | v9.2 |

## Common Blueprint Errors

### "Invalid Pooled Actor" Error

**Cause**: Calling `DestroyActor()` on a pooled actor  
**Fix**: Use `OthersideReturnToPool()` instead

```blueprint
// WRONG
DestroyActor(PickupActor)

// CORRECT  
OthersideReturnToPool(PickupActor)
```

### Input Mapping Not Working After World Load

**Cause**: `GetDefaultInputMappingContexts` not overridden (required since v7.0)  
**Fix**: Override `GetDefaultInputMappingContexts` in your PlayerController

### Server_TransferObjects Deprecated Warning

**Cause**: Using old deprecated event  
**Fix**: Migrate to `Server_TransferDataObjects` with client callback

```blueprint
// OLD (deprecated)
Server_TransferObjects(Items)

// NEW (required)
Server_TransferDataObjects(
  Items,
  OnSuccess: { ... },
  OnFailure: { ShowErrorNotification() }
)
```

### Token Gate Not Working

**Checklist:**
1. Verify collection contract address is correct
2. Check per-project whitelist includes the collection (v9.2+)
3. Confirm player wallet is connected via Privy
4. Check live config is not overriding the gate condition
5. Test with a wallet that actually owns a token

### Morpheus Networking Not Syncing

**Checklist:**
1. Verify you're using Morpheus blueprint nodes (not Unreal native RPC)
2. Check Morpheus actor is properly registered
3. Review PIE logs for "Morpheus: connection failed" messages
4. Clear credentials and restart if session is stale

## Mac-Specific Issues

- PAK embedded builds fixed in v9.2
- World builder setting detection improved in v9.2
- Use `~/Library/Application Support/Otherside/` for cache clearing on Mac

## Reporting Bugs

When submitting a bug report to Otherside support, include:
1. ODK version number (from Launcher title bar)
2. Unreal Engine version (5.5.4 unless specified)
3. Relevant `.log` file from `Saved/Logs/`
4. Steps to reproduce
5. Whether the issue occurs in PIE, packaged build, or deployed world
6. Platform (Windows / Mac)

**Support channel**: Follow the link in the ODK Launcher or at `https://docs.otherside.xyz/faq`

## Related Skills

- `otherside-morpheus-networking` — Morpheus-specific debugging
- `otherside-quick-start` — PIE setup and deployment
- `otherside-plugin-features` — plugin feature troubleshooting
- `otherside-commerce-economy` — diagnosing transaction failures
