# Agent State: Creative Director & Brand Designer (Asset Remediation Phase)

**Agent Identifier:** `brand-designer`  
**Domain Scope:** `/design/`  
**Active Branch:** `feat/design-assets-migration`  
**Status:** 🟢 Completed (Original 3D Masters Promoted)  

---

## Remediation Mandate & Invariants
1. **Zero Synthetic HTML Screenshots:** Delete `design/render-all.ps1` and all low-quality HTML-rendered PNGs.
2. **Promote Original 3D Masters from `/images/`:**
   - The original assets contain authentic 3D glossy keycaps (`Ctrl + B`), real LinkedIn post cards, and professional typography. They are the single source of truth.
3. **Punctuation Standard:** Strictly zero em-dashes (`-`) or en-dashes (`-`). Clean colons, commas, or standard hyphens (`-`).

---

## Active Task Queue

- [x] **Task 1: Clean Synthetic Artifacts**
  - Delete `design/render-all.ps1` and purge all amateur HTML screenshot assets.

- [x] **Task 2: Promote & Standardize Promotional Tiles (`/design/promo-tiles/`)**
  - **Small Promo Tile (440×280 px):** Copy directly from `/images/Make LinkedIn Posts Stand Out-440x280.png`.
  - **Large Promo Tile (920×680 px):** Scale/composite directly from `/images/Make LinkedIn Posts Stand Out.png` (1571×1001) using high-quality bicubic sampling in Bun/.NET.
  - **Marquee Banner (1400×560 px):** Composite and scale from `/images/Bold Text on LinkedIn-1.png` (1586×992).

- [x] **Task 3: Promote & Standardize Store Screenshots (`/design/store-screenshots/`)**
  - **Screenshot 1 (1280×800 px):** Copy directly from `/images/Bold Text on LinkedIn-1-1280x880.png` (verified exact dimensions: 1280×800 px). Rename to `screenshot-1-hero-shortcut.png`.
  - **Screenshot 2 (1280×800 px):** Copy directly from `/images/LinkedIn Bold Formatting Before and After-1280x800.png` (verified exact dimensions: 1280×800 px). Rename to `screenshot-2-before-after.png`.
  - **Screenshot 3 (1280×800 px):** Real editor composition from `/images/Screenshot 2026-10-07 135444.png` on brand gradient background. Rename to `screenshot-3-in-situ-editor.png`.

- [x] **Task 4: Social Media Creatives (`/design/social-banners/`)**
  - **LinkedIn Post Creative (1167×1347 px):** Copy `/images/LinkedIn post.png` to `/design/social-banners/linkedin-post-portrait.png`.
  - Twitter card and Product Hunt hero were not part of the remediation mandate and remain unchanged.

- [x] **Task 5: Master Catalog Documentation & PR Readiness**
  - Re-write `/design/README.md` to catalog all authentic 3D assets with exact pixel dimensions and upload guidance.
  - Mark this file complete and update active status in `@AGENTS.md`.

---

## Execution Log
- *[Phase 0]* Remediation mandate initialized by Chief AI Officer on branch `feat/design-assets-migration`.

- [2026-11-13 11:49 UTC] Completed asset remediation, confirmed output dimensions, removed synthetic promotional and store screenshot PNGs and render script, rewrote the design catalog.

