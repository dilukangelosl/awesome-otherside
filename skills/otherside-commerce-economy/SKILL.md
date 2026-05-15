---
name: otherside-commerce-economy
description: "Otherside commerce, economy and NFT integration. TRIGGER when: user asks about vending machine ODK, ApeCoin, ApeChain, ERC-1155, NFT gating, token gate, NFT revocation, bulk buying, vending categories, wallet transactions, in-world commerce, ApeChain transactions, NFT balance, real-time balance, server grant, affordability check, role-based items, gamepad vending."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside Commerce & Economy

## Vending Machine System

The ODK Vending Machine is the primary in-experience commerce tool.

### Core Features (v7.0+)

| Feature | Description |
|---------|-------------|
| Bulk purchase | Buy multiple items in one transaction |
| Categorization tabs | Organize items by category for better UX |
| Live affordability checks | Real-time validation before purchase attempt |
| Gamepad support | Full controller support for console/gamepad users |
| Role-based item access | Restrict items to specific roles/capabilities |

### Configuration
```blueprint
// Vending Machine Actor setup
VendingMachine.SetItems([
  { ItemID: "item_001", Price: 100, Category: "Weapons", RequiredRole: "None" },
  { ItemID: "item_002", Price: 500, Category: "Premium", RequiredRole: "Koda_Owner" }
])

VendingMachine.SetBulkBuyEnabled(true)
VendingMachine.SetAffordabilityCheckLive(true)
```

### Deprecated: Web Window Device Variant
The Web Window device variant for vending machines was removed. Use the standard in-world vending machine actor instead.

## NFT Integration & ApeChain

### ERC-1155 Token Support

The ODK supports ERC-1155 multi-token standard on ApeChain:
- Fungible tokens (currencies, consumables)
- Non-fungible tokens (unique items, avatars)
- Mixed token types in single contract

### Real-Time Balance Updates

WebSocket endpoint for live balance tracking:
```
ws://realtime/nft/userBalance
```
- Fires on any wallet balance change
- Use to update UI without polling
- Update vending affordability UI on balance change

### Wallet-to-Wallet Transactions

Players can send tokens directly to other players on ApeChain:
```blueprint
// ApeChain transaction blueprint
InitiateApeChainTransfer(
  SenderWallet: CurrentPlayer.Wallet,
  RecipientWallet: TargetPlayer.Wallet,
  TokenContract: "0x...",
  TokenID: 1,
  Amount: 1
)
```

### Server Grant Failure Handling

When a server-side item grant fails (network issue, contract error):
```blueprint
// Always handle server grant failures
Server_TransferDataObjects(
  Items: [GrantItem],
  OnSuccess: { UpdatePlayerInventory() },
  OnFailure: { 
    ShowNotification("Purchase failed. Please try again."),
    RefundIfCharged()
  }
)
```

## Token Gating

Restrict world areas, items, or features to NFT holders.

### Gate Configuration

```blueprint
// Token gate check
TokenGate.Configure(
  CollectionAddress: "0x...",
  Chain: ApeChain,
  TokenID: None,  // None = any token in collection
  MinBalance: 1
)
```

### Gate Types

| Gate Type | Description |
|-----------|-------------|
| Collection-level | Any token from the collection |
| Contract address | Specific contract address |
| Chain-specific | ApeChain only |
| Token ID | Specific token (1-of-1 gates) |
| Metadata traits | Trait-based (e.g., "Background: Gold") |

### Live Configuration

Token gate rules can be updated via live config without redeployment.

### Per-Project Whitelisting (v9.2+)

Whitelist specific collections per project:
```json
{
  "presence_endpoint_whitelist": [
    "0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d",
    "0x60e4d786628fea6478f785a6d7e704777c86a7c6"
  ]
}
```

## NFT Revocation (v6.0+)

The platform can revoke NFT-derived capabilities when:
- Token ownership changes (wallet transfer)
- Token is burned
- Collection policy changes

Always design gated experiences to gracefully handle capability loss mid-session.

## Cross-Experience Identity (v8.2+)

Profile Overlay provides cross-experience identity on ApeChain:
- Player profile persists across different Otherside experiences
- Display username, avatar, and owned collections
- Use as social proof in your experience UI

## ApeCoin (APE)

ApeCoin is the primary currency for in-world commerce:
- Priced in APE for all vending transactions
- Real-time exchange rate integration available
- Bulk purchase discounts are developer-configurable

### Bulk Purchase UX Pattern

```blueprint
// Show bulk purchase UI
ShowBulkPurchaseModal(
  Items: SelectedItems,
  TotalCost: CalculateBulkPrice(SelectedItems),
  DiscountRate: 0.1  // 10% discount for bulk
)
```

## Commerce Analytics

Track all commerce events via ODK analytics:
- Purchase attempts (successful and failed)
- Affordability check failures (indicates pricing misalignment)
- Token gate denials (insight into non-holder traffic)
- Category engagement (which tabs players browse most)

## Related Skills

- `otherside-plugin-features` — token gating and wallet plugin features
- `otherside-morpheus-networking` — Server_TransferDataObjects for grant handling
- `otherside-avatar-system` — NFT avatar collections and access
- `otherside-debugging` — diagnosing transaction failures
