---
name: otherside-agentic-api
description: "Otherside Agentic API and Vibe Maker. TRIGGER when: user asks about Otherside Agentic API, Vibe Maker, MML, Metaverse Markup Language, Otherside AI integration, programmatic world generation, agentic world building, Otherside API integration, automated world creation."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside Agentic API & Vibe Maker

## Otherside Vibe Maker

Vibe Maker is the AI-assisted world building tool for Otherside, powered by the Agentic API.

### MML (Metaverse Markup Language)

MML is the declarative language used in Vibe Maker workflows to describe world configurations:

```xml
<!-- MML example — place a vending machine near spawn -->
<mml-world>
  <mml-actor type="VendingMachine" 
             position="100,0,50"
             collection="BAYC"
             price="100">
    <mml-item id="item_sword" price="150" role="None" />
    <mml-item id="item_shield" price="200" role="Koda_Owner" />
  </mml-actor>
  
  <mml-actor type="TokenGate"
             position="500,0,0"
             collection="MAYC"
             denied-message="Mutant Apes only!">
    <mml-zone radius="300" />
  </mml-actor>
</mml-world>
```

### MML Workflow

1. Describe your world intent in natural language or MML
2. Vibe Maker generates the world configuration
3. Review and refine the MML output
4. Deploy to Otherside via the ODK dashboard

## Otherside Agentic API

The Agentic API allows external integrations to interact with Otherside worlds programmatically.

### Base URL

```
https://api.otherside.xyz/v1/
```

### Documentation Query API

Query the ODK docs from any agent or integration:

```bash
# Direct documentation query
GET https://docs.otherside.xyz/odk/quick-start?ask=How+do+I+set+up+token+gating

# Returns:
{
  "answer": "...",
  "sources": ["...", "..."],
  "confidence": 0.95
}
```

### World Management

```bash
# Get world status
GET /worlds/{world-id}/status

# Update live config
PATCH /worlds/{world-id}/config
Content-Type: application/json
{
  "key": "vending.items",
  "value": [...]
}

# Trigger world event
POST /worlds/{world-id}/events
{
  "event": "task_flow.complete",
  "player_id": "0x...",
  "flow_id": "DailyQuest_Coins"
}
```

### Player Data API

```bash
# Get player NFT holdings
GET /players/{wallet-address}/nfts

# Check specific token gate
GET /players/{wallet-address}/gates/{gate-id}
# Returns: { "granted": true/false, "reason": "..." }

# Get player task flow progress
GET /players/{wallet-address}/task-flows/{flow-id}
```

### Commerce API

```bash
# Get real-time token balance
GET /wallets/{address}/balance?chain=apechain

# Initiate server-side grant
POST /grants
{
  "recipient": "0x...",
  "items": [{ "contract": "0x...", "token_id": 1, "amount": 1 }]
}
```

## AI Agent Integration Pattern

Use the Agentic API to build AI-powered in-world systems:

```python
import anthropic
import requests

client = anthropic.Anthropic()

def query_otherside_docs(question: str) -> str:
    """Query Otherside docs via the documentation API."""
    response = requests.get(
        "https://docs.otherside.xyz/odk/quick-start",
        params={"ask": question}
    )
    return response.json()["answer"]

def world_ai_assistant(player_query: str, world_context: dict) -> str:
    """In-world AI assistant using Claude and Otherside Agentic API."""
    docs_context = query_otherside_docs(player_query)
    
    response = client.messages.create(
        model="claude-opus-4-6",
        max_tokens=1024,
        messages=[{
            "role": "user",
            "content": f"""
            World context: {world_context}
            Otherside docs: {docs_context}
            Player question: {player_query}
            
            Answer as an in-world guide character.
            """
        }]
    )
    return response.content[0].text
```

## Vibe Maker Workflows

### Generate a World from Description

```
Input: "Create a pirate-themed world with:
- A vending machine selling pirate cosmetics for APE
- A treasure area gated by BAYC ownership
- A combat zone with 2 teams"

Vibe Maker output: MML configuration + ODK blueprint setup guide
```

### Iterate on Existing Worlds

Vibe Maker can analyze existing world MML and suggest improvements:
- Performance optimization suggestions
- Engagement pattern improvements
- Commerce opportunity identification

## Related Skills

- `otherside-quick-start` — world deployment after Vibe Maker generation
- `otherside-commerce-economy` — commerce API integration
- `otherside-task-flow` — programmatic task flow management via API
- `otherside-plugin-features` — features available in MML worlds
