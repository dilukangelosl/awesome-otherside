#!/usr/bin/env npx tsx
/**
 * Otherside Skills — UserPromptSubmit hook
 * Suggests relevant ODK skills based on the user's prompt keywords.
 * Output goes to stdout and is injected as context before Claude sees the prompt.
 */

import * as readline from "readline";

interface SkillSuggestion {
  name: string;
  description: string;
  keywords: string[];
}

const SKILLS: SkillSuggestion[] = [
  {
    name: "otherside-quick-start",
    description: "ODK setup, installation, deployment, PIE testing",
    keywords: [
      "odk", "otherside", "other side", "quick start", "setup", "install",
      "launcher", "pie", "play in editor", "deploy", "world builder", "msquared",
      "unreal otherside", "technical overview",
    ],
  },
  {
    name: "otherside-avatar-system",
    description: "Avatar creation, specs, collections, Blender workflow",
    keywords: [
      "avatar", "character", "bayc", "mayc", "koda", "voyager", "meebit",
      "glb", "gltf", "skeleton", "rig", "blender", "polygon", "texture",
      "pbr", "avatar upload", "custom character", "avatar collection",
      "bored ape", "mutant ape",
    ],
  },
  {
    name: "otherside-plugin-features",
    description: "ODK plugin features — auth, web browser, token gating, emotes, NPCs",
    keywords: [
      "privy", "web browser", "chromium", "token gate", "nft gate", "interaction",
      "millicast", "selfie cam", "koda cam", "notification", "emote", "feels",
      "moderation", "analytics", "movement mode", "blueprint node", "npc",
      "scannable", "physics", "persistence",
    ],
  },
  {
    name: "otherside-morpheus-networking",
    description: "Morpheus networking, actor pooling, data transfer",
    keywords: [
      "morpheus", "actor pool", "networking", "server_transfer", "replication",
      "multiplayer odk", "morpheus array", "garbage collection", "world service",
      "curtis network", "stale object", "dangling pointer", "bubble",
    ],
  },
  {
    name: "otherside-commerce-economy",
    description: "Vending machines, ApeCoin, ApeChain, NFT, ERC-1155",
    keywords: [
      "vending machine", "apecoin", "ape coin", "apechain", "ape chain",
      "erc-1155", "erc1155", "nft gate", "token gate", "bulk buy", "affordability",
      "wallet transaction", "server grant", "commerce", "shop", "purchase",
      "balance", "real-time balance",
    ],
  },
  {
    name: "otherside-templates",
    description: "Boneyard and Combat project templates",
    keywords: [
      "boneyard", "combat template", "odk template", "arcade machine",
      "scoreboard", "respawn", "role promotion", "spawn point", "squerris wheel",
      "teams odk", "coin pickup",
    ],
  },
  {
    name: "otherside-world-travel",
    description: "Portals, world travel, bubbles, movement mechanics",
    keywords: [
      "portal", "teleport", "world travel", "cross-experience", "grind rail",
      "levitator", "gliding", "jump pad", "falling", "bubble join", "bubble leave",
      "avatar persistence", "world transition",
    ],
  },
  {
    name: "otherside-task-flow",
    description: "Task Flow System — quests, tutorials, objectives",
    keywords: [
      "task flow", "quest", "tutorial", "objective", "trigger", "condition",
      "action", "sequential task", "task sequence", "task system",
      "guided experience", "onboarding flow",
    ],
  },
  {
    name: "otherside-agentic-api",
    description: "Agentic API, Vibe Maker, MML",
    keywords: [
      "agentic api", "vibe maker", "mml", "metaverse markup", "api integration",
      "world generation", "programmatic", "otherside api", "ai world",
    ],
  },
  {
    name: "otherside-debugging",
    description: "Debugging, troubleshooting, credential clearing, known issues",
    keywords: [
      "debug", "crash", "credential", "windows credential", "log", "error",
      "troubleshoot", "camera wobble", "avatar jitter", "pik crash", "bug",
      "fix", "known issue", "odk error", "support",
    ],
  },
];

function findMatchingSkills(prompt: string): SkillSuggestion[] {
  const normalized = prompt.toLowerCase();
  return SKILLS.filter((skill) =>
    skill.keywords.some((kw) => normalized.includes(kw))
  );
}

async function main() {
  const rl = readline.createInterface({ input: process.stdin });
  let input = "";

  for await (const line of rl) {
    input += line + "\n";
  }

  let data: Record<string, unknown> = {};
  try {
    data = JSON.parse(input.trim() || "{}");
  } catch {
    process.exit(0);
  }

  const prompt = String(data.prompt || "");
  if (!prompt) process.exit(0);

  const matches = findMatchingSkills(prompt);
  if (matches.length === 0) process.exit(0);

  const suggestions = matches
    .map((s) => `  • ${s.name} — ${s.description}`)
    .join("\n");

  process.stdout.write(
    `\n<otherside-skill-suggestions>\n` +
    `Relevant Otherside skills detected for this task:\n${suggestions}\n` +
    `Use the Skill tool to load any of the above before proceeding.\n` +
    `</otherside-skill-suggestions>\n`
  );
}

main().catch(() => process.exit(0));
