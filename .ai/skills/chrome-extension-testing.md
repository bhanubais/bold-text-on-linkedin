# Skill: Chrome Extension Testing

## Purpose
Systematic validation of the extension across all surfaces, states, and environments.

## Test Matrix

### Functional Tests
| ID | Test Case | Steps | Expected |
|---|---|---|---|
| F1 | Bold toggle ON | Select text in post editor → Ctrl+B | Selected text becomes bold |
| F2 | Bold toggle OFF | Select bold text → Ctrl+B | Bold removed |
| F3 | Empty selection | Place cursor (no selection) → Ctrl+B | No error, no crash |
| F4 | Multi-paragraph | Select across paragraphs → Ctrl+B | All selected text bolded |
| F5 | Mac shortcut | Select text → Cmd+B | Same as F1 |
| F6 | Comment editor | Select text in comment box → Ctrl+B | Bold applied if editor supports it |
| F7 | Non-LinkedIn page | Visit google.com → Ctrl+B | Extension does NOT interfere |

### Manifest & Icon Tests
| ID | Test Case | Expected |
|---|---|---|
| M1 | Extensions page (chrome://extensions) | 48px icon renders correctly |
| M2 | Toolbar icon | 16/32px icon visible, not puzzle piece |
| M3 | Toolbar click | Opens Chrome Web Store page OR shows popup |
| M4 | Context menu (right-click icon) | Shows extension name, options link |

### Trust & Safety Tests
| ID | Test Case | Expected |
|---|---|---|
| T1 | Install from CWS | No "Proceed with caution" warning |
| T2 | Enhanced Safe Browsing ON | Extension installs without friction |
| T3 | Permission audit | Only declared permissions shown, no surprises |

### Compatibility Tests
| ID | Environment | Expected |
|---|---|---|
| C1 | Chrome Stable (latest) | Full functionality |
| C2 | Chrome Beta | Full functionality |
| C3 | Edge (Chromium) | Full functionality |
| C4 | Windows 10/11 | Ctrl+B works |
| C5 | macOS | Cmd+B works |
| C6 | Linux | Ctrl+B works |
