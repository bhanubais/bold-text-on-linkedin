# AGENTS.md: LinkedIn Rich Text Shortcuts

## Project Overview
A Chrome extension (Manifest V3) that enables native bold text formatting (`Ctrl+B` / `Cmd+B`) in LinkedIn's post editor. The extension intercepts the keyboard shortcut and applies bold formatting via the editor's contenteditable API.

**Product constraint:** Only bold (`Ctrl+B`) is supported. LinkedIn's editor does NOT support italic or underline formatting. Do not attempt to add these.

## Scope Classification
End-to-End Venture: this project spans engineering, Chrome Web Store listing, marketing, social media, and brand design.

## Directory Topology
- `/src/`: Extension source code (manifest, scripts, icons). This is the build/package root.
- `/marketing/`: LinkedIn posts, Twitter posts, blog content, social copy.
- `/design/`: Artwork, banners, store screenshots, social media creatives.
- `/store-assets/`: Chrome Web Store listing copy, privacy policy, changelog.
- `/images/`: Legacy assets from v1 (preserved for reference).
- `/.ai/`: The Swarm Brain. Agent infrastructure, personas, skills, state.

## Master Continuity & CAIO State
- Chief AI Officer Macro-State Tracker: `@.ai/CAIO_STATE.md` (Read upon session initialization or context reset).

## Operational Rules for All Agents
1. **Never modify files outside your designated directory** without explicit CAIO approval.
2. **Always read your persona and skill files** before starting work.
3. **Execution Runtime:** Standardize strictly on **Bun** (`bun test`, `bun run`). Node is deprecated for this workspace.
4. **Clean Punctuation (Zero Big-Dashes):** Never use em-dashes (`—`) or en-dashes (`–`) anywhere in copy, marketing posts, documentation, or code comments. Use clean punctuation: commas, periods, colons, parentheses, or simple hyphens (`-`).
5. **Agent Completion & Tracking Protocol:** Whenever an agent finishes its work, it must:
   - Check off all completed items in its state file under `/.ai/agents/<agent-name>.md`.
   - Record an execution log entry with timestamps in its state file.
   - Update its status to 🟢 Completed in `AGENTS.md` under `## Active Agents`.
   - Provide a concise deliverables summary for the CAIO to ingest.
6. **Bold-only constraint is absolute.** Do not add italic, underline, or any other formatting shortcuts.
7. **Mac support is required.** All keyboard shortcuts must support both `Ctrl` (Windows/Linux) and `Cmd` (macOS).
8. **No console.log in production.** Remove all debug logging before final build.
9. **Manifest V3 compliance** is non-negotiable. No Manifest V2 APIs.
10. **The extension icon must be declared** in the manifest at 16, 32, 48, and 128px sizes.

## Active Agents
| Agent | Domain | State File | Status |
|---|---|---|---|
| Extension Architect | `/src/` | `@.ai/agents/extension-architect.md` | 🟢 Completed |
| Store Copywriter & Trust Strategist | `/store-assets/` | `@.ai/agents/store-copywriter.md` | 🟢 Completed |
| Creative Director & Brand Designer | `/design/` | `@.ai/agents/brand-designer.md` | 🟢 Completed |
| Organic Growth Hacker | `/marketing/` | `@.ai/agents/growth-hacker.md` | 🟢 Completed |
| Repository & Docs Copywriter | Root `/` | `@.ai/agents/docs-copywriter.md` | 🟡 Provisioned |

## Persona Library
See `/.ai/personas/` for available expert mindsets.

## Skill Library
See `/.ai/skills/` for available capability modules.
