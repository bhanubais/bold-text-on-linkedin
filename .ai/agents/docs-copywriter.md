# Agent State: Repository & Docs Copywriter

**Agent Identifier:** `docs-copywriter`  
**Domain Scope:** Root `/README.md`  
**Status:** 🟢 Completed  

---

## Ingested Infrastructure
- **Personas:**
  - `@.ai/personas/joanna-wiebe.md`
  - `@.ai/personas/linus-torvalds.md`
- **Skills:**
  - `@.ai/skills/humanizer.md`
  - `@.ai/skills/tdd-rules.md`
  - `@.ai/skills/manifest-v3-best-practices.md`

---

## Operational Directives & Invariants
1. **Target:** Author the official, high-converting root [`README.md`](file:///D:/Startups/Chrome%20Extensions/LinkedIn%20Editing/README.md) for the GitHub repository.
2. **Punctuation Standard:** Strictly zero em-dashes (`—`) or en-dashes (`–`). Use clean colons, commas, parentheses, or standard hyphens (`-`).
3. **Runtime Standard:** Bun exclusively (`bun test`). No Node or npm commands in instructions.
4. **Constraint:** Bold-only formatting (`Ctrl+B` / `Cmd+B`). Italic and underline are unsupported by LinkedIn and must not be promised.
5. **Humanizer Rules:** Active voice, short sentences, zero corporate fluff words (no "seamlessly", "empower", "robust").

---

## Active Task Queue

- [x] **Task 1: Hero Banner & Status Badges**
  - Project Title & One-line hook.
  - Hero image embed referencing `design/store-screenshots/screenshot-1-hero-editor.png`.
  - Shields.io badges: Manifest V3, Chrome Web Store v2.0.0, Bun Test (7/7 Passing), Zero Data Collection, License MIT, Mac & Windows.
  - Direct call-to-action button to Chrome Web Store listing.

- [x] **Task 2: Product Value & The Unicode Trap Breakdown**
  - The problem: Why does Google Docs have Ctrl+B, but LinkedIn doesn't?
  - Direct contrast table: Native Bold (Tiptap DOM) vs Fake Unicode Font Generators (screen-reader accessibility, search indexing reach, paste lag).
  - Keyboard shortcut reference table (`Ctrl+B` for Windows/Linux, `Cmd+B` for macOS).

- [x] **Task 3: Developer Quickstart (Bun-First)**
  - Clone instructions targeting canonical repo `https://github.com/bhanubais/bold-text-on-linkedin`.
  - Run automated tests in milliseconds via `bun test`.
  - Local installation in Chrome: `chrome://extensions` -> Developer Mode -> Load Unpacked -> select `/src/`.

- [x] **Task 4: Architecture, Security & Privacy Commitments**
  - Explain Manifest V3 service worker (`background.js`) and content script (`content.js`).
  - Outline zero-permission security model (zero analytics, zero external network requests).
  - Link to [`store-assets/privacy-policy.md`](file:///D:/Startups/Chrome%20Extensions/LinkedIn%20Editing/store-assets/privacy-policy.md) and [`store-assets/changelog.md`](file:///D:/Startups/Chrome%20Extensions/LinkedIn%20Editing/store-assets/changelog.md).
  - Briefly introduce the AI swarm governance in [`AGENTS.md`](file:///D:/Startups/Chrome%20Extensions/LinkedIn%20Editing/AGENTS.md).

- [x] **Task 5: Verification & Governance**
  - Run automated regex scan for zero em-dashes and zero en-dashes.
  - Audit against `humanizer.md`.
  - Mark tasks complete in this state tracker and update `@AGENTS.md` to 🟢 Completed.

---

## Execution Log
- *[Phase 0]* State initialized by Chief AI Officer. Awaiting spawn in dedicated session.
- *[Phase 1]* Authored canonical root `README.md` following Joanna Wiebe and Linus Torvalds mindsets. Verified 0 em-dashes, 0 en-dashes, 0 banned buzzwords. Validated 7/7 Bun tests passing in 30ms. Updated governance status to 🟢 Completed.
