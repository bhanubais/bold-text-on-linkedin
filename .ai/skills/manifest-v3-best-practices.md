# Skill: Manifest V3 Best Practices

## Purpose
Ensure the Chrome extension manifest is complete, compliant, and optimized for trust signals.

## Required Manifest Fields

### Identity
- `manifest_version`: 3 (mandatory)
- `name`: Human-readable, ≤45 characters
- `version`: Semver format (e.g., "2.0.0")
- `description`: ≤132 characters, keyword-rich
- `author`: Developer name or organization
- `homepage_url`: Link to Chrome Web Store listing or project page

### Icons (ALL sizes required)
```json
"icons": {
  "16": "icons/icon-16.png",
  "32": "icons/icon-32.png",
  "48": "icons/icon-48.png",
  "128": "icons/icon-128.png"
}
```

### Action (Toolbar behavior)
```json
"action": {
  "default_icon": {
    "16": "icons/icon-16.png",
    "32": "icons/icon-32.png",
    "48": "icons/icon-48.png"
  },
  "default_title": "LinkedIn Rich Text Shortcuts"
}
```

### Content Scripts
- Use narrowest possible `matches` pattern.
- Set `run_at` to `document_idle` for non-blocking injection.
- Avoid `all_frames: true` unless specifically needed.

### Permissions
- Prefer `activeTab` over broad host permissions.
- Only declare permissions you actually use.
- Avoid `storage`, `tabs`, `cookies` unless functionally required.

### Service Worker (Background)
```json
"background": {
  "service_worker": "background.js"
}
```
- Service workers are ephemeral. Do not rely on global state.
- Use for: action click handling, extension lifecycle events.

## Enhanced Safe Browsing Compliance
- Clear, specific `description` — state exactly what the extension does.
- Minimal permissions — request only what you need.
- Privacy policy URL in Chrome Web Store listing.
- No obfuscated code.
- No remote code execution.
- Single, clear purpose.
