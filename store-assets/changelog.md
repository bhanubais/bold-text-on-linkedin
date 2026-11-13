# Changelog — LinkedIn Rich Text Shortcuts

All notable user and technical changes to this project will be documented in this file.
Detailed per-version release notes are maintained in [`store-assets/releases/`](./releases/).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.0.0] — 2026-11-13
*Dedicated release notes: [releases/v2.0.0.md](./releases/v2.0.0.md)*

### Added
- **macOS Shortcut Support:** Native `Cmd+B` shortcut for Mac users alongside `Ctrl+B` for Windows/Linux.
- **Manifest V3 Specification:** Complete MV3 rebuild including ephemeral background service worker (`background.js`).
- **Standardized Icon Set:** High-resolution icons at 16x16, 32x32, 48x48, and 128x128.
- **Toolbar Action:** Interactive extension icon click directing to the official Chrome Web Store listing.
- **Automated Test Suite:** Multi-platform TDD test coverage executing under Bun and Node.

### Changed
- **Resilient Editor Detection:** Upgraded DOM selector engine to support modern LinkedIn Tiptap/ProseMirror post composers, comments, and replies.
- **Repository Architecture:** Migrated all production source files into dedicated `/src/` package boundary.
- **Code Hygiene:** Stripped all debug `console.log` statements for zero-overhead execution.

### Security & Privacy
- **Enhanced Safe Browsing Compliance:** Zero privileged permissions requested.
- **Zero Data Collection:** Extension functions 100% locally on-device without remote calls.

---

## [1.0.0] — 2026-10-07
### Added
- Initial release: basic `Ctrl+B` bold formatting in LinkedIn post editor.
