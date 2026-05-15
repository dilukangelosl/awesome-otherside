---
name: otherside-avatar-system
description: "Otherside avatar and character system. TRIGGER when: user asks about BAYC, MAYC, Koda, Voyager, Meebit avatars, character creation, GLB/GLTF export, Blender rigging, avatar polygon limits, texture specs, skeleton requirements, custom avatar upload, NFT avatar, avatar collections, PBR shading Otherside, avatar conforming, avatar testing, character pipeline."
source: "https://docs.otherside.xyz/"
date_added: "2026-05-15"
version: "v9.4.1"
---

# Otherside Avatar & Character System

## Supported Collections

| Collection | Notes |
|------------|-------|
| BAYC | Bored Ape Yacht Club |
| MAYC | Mutant Ape Yacht Club (includes Murtis variants) |
| Meebits | Standard support |
| Kodas | Up to 10,000; custom animation rig |
| Voyagers | Customizable exoskeletons; Voyager 2.0 is the v9.4.1 default character |
| Custom / Third-party | Via avatar pipeline (see below) |

## Technical Specifications

### Geometry
- **Height**: 1 – 2 meters
- **Max polygon count**: 50,000 triangles
- **File size**: ≤ 20 MB (recommended < 10 MB)
- **Format**: gLTF 2.0 — GLB binary packaging

### Textures
| Channel | Required | Max Resolution |
|---------|----------|----------------|
| Basecolor | Yes | 2048×2048 |
| Normal | No | 2048×2048 |
| ORM (occlusion/roughness/metalness) | No | 2048×2048 |
| Emissive | No | 2048×2048 |

**Shading model**: PBR (Physically Based Rendering)

### Skeleton / Rigging
- Standard humanoid skeleton
- Max **4 bone influences** per vertex
- Vertex weighting required for mesh deformation
- Koda avatars: custom animation rig supported
- Third-party avatars: animation compatibility is limited

### Materials
| Type | Notes |
|------|-------|
| Metallic | Full support; set metallic=1.0, adjust roughness for chrome effect |
| Matte | Full support |
| Glowing | Full support (Emissive channel) |
| Dithered transparency | Limited support |
| Blended transparency | Limited support — use "Render Method" dropdown to configure |

## Blender Workflow (v4.5 LTS)

### Naming Conventions
- Trait format: `trait_type_trait_name`
- Follow platform naming conventions exactly to avoid pipeline failures

### Bulk GLB Export
Use the provided Python scripting for bulk export:
```python
# Python script for bulk GLB export — run inside Blender
# Follows Blender 4.5 LTS workflow
# See ODK avatar-tools CLI for full pipeline
```

### Avatar Tools CLI (Node.js v20.x)
```bash
# Install dependencies
npm install  # from avatar-tools directory

# Conform mesh to standard skeleton
avatar-tools conform --input my_avatar.glb --output conformd.glb

# Validate specs
avatar-tools validate --file conformd.glb
```

## Making Avatars Available in Otherside

**Four-step process:**
1. Create the GLB following specs above
2. Upload via ODK dashboard / avatar pipeline
3. Configure metadata (collection, token ID, traits)
4. Test in-editor with Play-in-Editor (PIE)

### JSON Metadata Structure
```json
{
  "name": "Avatar Name",
  "collection": "custom",
  "token_id": "1",
  "traits": [
    { "trait_type": "Background", "value": "Blue" },
    { "trait_type": "Eyes", "value": "Standard" }
  ]
}
```

## Metaverse Markup Language (MML)

MML is used in **Otherside Vibe Maker** workflows for avatar and world configuration. See `otherside-agentic-api` skill for MML details.

## Avatar Selector (ODK Plugin)

The ODK Avatar Selector component lets players:
- Switch between owned NFT avatars in-experience
- Access wallet-connected collections via Privy integration
- See cross-experience profile identity (ApeChain, v8.2+)

## Range of Motion (ROM) Test

Before submitting avatars, run the ROM test animations:
- Validates skeleton range of motion
- Checks for mesh clipping issues
- Tests footstep SFX synchronization
- Validates emote animation compatibility

## Known Issues

| Issue | Status |
|-------|--------|
| Avatar spawns without equipment after teleportation | Known |
| Titan avatar jitters on grind rails | Known |
| Avatar hand visibility in first-person mode | Known |
| Third-party avatar animation limitations | By design |

## Rules of the Road

Custom avatars must comply with Otherside's Rules of the Road:
- No offensive or rights-violating content
- Must meet all technical specs above
- Platform reserves right to revoke (NFT revocation logic in v6.0+)

## Related Skills

- `otherside-quick-start` — ODK setup and project creation
- `otherside-plugin-features` — moderation and avatar plugin components
- `otherside-commerce-economy` — NFT gating and collection access
