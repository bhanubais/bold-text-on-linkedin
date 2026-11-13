# Chrome Developer Dashboard: Single-Purpose and Permission Justifications

**Extension Name:** LinkedIn Rich Text Shortcuts  
**Target Manifest Version:** Manifest V3  
**Audience:** Chrome Web Store Review Team & Enhanced Safe Browsing Evaluators  

This document contains copy-paste ready text for the Chrome Developer Dashboard submission form.

---

## 1. Single Purpose Description

> **Dashboard Field:** *Single Purpose Description / Extension Purpose*

```text
Enables the native bold text keyboard shortcut (Ctrl+B on Windows/Linux and Cmd+B on macOS) within post and comment editors on LinkedIn.
```

---

## 2. Host Permission Justification (`https://www.linkedin.com/*`)

> **Dashboard Field:** *Permission Justification for `https://www.linkedin.com/*`*

```text
The extension requires host access to `https://www.linkedin.com/*` to inject a lightweight content script into LinkedIn web pages.

1. Purpose: The content script listens for the standard keyboard shortcut (Ctrl+B or Cmd+B) when a user edits text in LinkedIn's post creator, article drafts, comment boxes, or message threads. It then calls the editor's native bold formatting command on the highlighted text.

2. Why activeTab is insufficient: The extension is designed as an automatic keyboard shortcut. Users format text dynamically as they type across various dynamic modals, comment threads, and async feed editors. Requiring the user to click the toolbar extension icon first (via activeTab) before pressing Ctrl+B breaks standard editing flow and defeats the purpose of a keyboard shortcut.

3. Minimal Scope: Host permissions are strictly restricted to `https://www.linkedin.com/*`. The extension cannot run, inspect, or interact with any other domain or browsing tab.

4. Zero Data Collection: The content script only detects keydown events for the specific B key modifier combination. It does not read, capture, store, or transmit any typed text, drafts, profile information, or account credentials.
```

---

## 3. Remote Code Justification

> **Dashboard Field:** *Does your extension use remote code?*

```text
No. The extension contains zero remote code. All logic, scripts, and assets are 100% packaged locally within the extension bundle in strict compliance with Manifest V3 policy.
```

---

## 4. Chrome Web Store Privacy Questionnaire (Data Usage)

Fill out the **Privacy practices** tab in the Developer Dashboard with these exact selections:

| Questionnaire Category | Response | Justification / Clarification |
|---|---|---|
| **Personally identifiable information** (Name, email, address, ID) | **No** | Not collected. |
| **Health information** | **No** | Not collected. |
| **Financial and payment information** | **No** | Not collected. |
| **Authentication information** (Passwords, credentials, cookies) | **No** | Not collected. |
| **Personal communications** (Emails, chat messages, posts) | **No** | The extension triggers browser formatting on active selections. It does not read, store, or transmit communications. |
| **Location information** | **No** | Not collected. |
| **Web history** (List of visited websites) | **No** | Not collected. |
| **User activity** (Clicks, mouse position, scroll) | **No** | Only listens locally for keydown of Ctrl+B / Cmd+B inside contenteditable fields. |
| **Website content** (Text, images, page content) | **No** | Does not scrape, inspect, or extract page content. |

### Data Usage Certifications:
- Check: **"I certify that this extension complies with the Chrome Web Store Limited Use policy."**
- Check: **"The extension does not sell user data to third parties."**
- Check: **"The extension does not use or transfer user data for purposes unrelated to the single purpose."**
- Check: **"The extension does not use or transfer user data for creditworthiness or lending purposes."**

---

## 5. Enhanced Safe Browsing Trust Factors (Reviewer Notes)

```text
Key factors that verify this extension's safety:
- Architecture: Manifest V3 with an ephemeral background service worker and a single content script.
- Dependency Footprint: Zero external npm dependencies, zero build obfuscation, and zero analytics libraries.
- Network Footprint: Zero outbound network connections (no fetch, XMLHttpRequest, or WebSocket).
- Total Package Size: Under 50 KB.
- Verifiable Code: All source code is clean, readable JavaScript open for direct manual audit.
```
