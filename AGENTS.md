# AGENTS.md — LinkedIn Rich Text Shortcuts

## Project Overview
A Chrome extension (Manifest V3) that enables native bold text formatting (`Ctrl+B` / `Cmd+B`) in LinkedIn's post editor. The extension intercepts the keyboard shortcut and applies bold formatting via the editor's contenteditable API.

**Product constraint:** Only bold (`Ctrl+B`) is supported. LinkedIn's editor does NOT support italic or underline formatting. Do not attempt to add these.

## Scope Classification
End-to-End Venture — this project spans engineering, Chrome Web Store listing, marketing, social media, and brand design.

## Directory Topology
- `/src/` — Extension source code (manifest, scripts, icons). This is the build/package root.
- `/marketing/` — LinkedIn posts, Twitter posts, blog content, social copy.
- `/design/` — Artwork, banners, store screenshots, social media creatives.
- `/store-assets/` — Chrome Web Store listing copy, privacy policy, changelog.
- `/images/` — Legacy assets from v1 (preserved for reference).
- `/.ai/` — The Swarm Brain. Agent infrastructure, personas, skills, state.

## AI Agent Rules
1. **Never modify files outside your designated directory** without explicit CAIO approval.
2. **Always read your persona and skill files** before starting work.
3. **Track all progress** in your agent state file under `/.ai/agents/`.
4. **Bold-only constraint is absolute.** Do not add italic, underline, or any other formatting shortcuts.
5. **Mac support is required.** All keyboard shortcuts must support both `Ctrl` (Windows/Linux) and `Cmd` (macOS).
6. **No console.log in production.** Remove all debug logging before final build.
7. **Manifest V3 compliance** is non-negotiable. No Manifest V2 APIs.
8. **The extension icon must be declared** in the manifest at 16, 32, 48, and 128px sizes.

## Active Agents
| Agent | State File | Status |
|---|---|---|
| Extension Architect | `@.ai/agents/extension-architect.md` | 🟢 Completed |

## Persona Library
See `/.ai/personas/` for available expert mindsets.

## Skill Library
See `/.ai/skills/` for available capability modules.
