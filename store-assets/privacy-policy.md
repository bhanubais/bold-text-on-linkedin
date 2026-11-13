# Privacy Policy: LinkedIn Rich Text Shortcuts

**Extension Name:** LinkedIn Rich Text Shortcuts  
**Current Version:** 2.0.0  
**Effective Date:** November 13, 2026  

---

## 1. Our Privacy Commitment

We built **LinkedIn Rich Text Shortcuts** with a simple principle: **your data belongs to you.**

This extension does not collect, store, sell, or transmit any user data. Everything runs 100% locally in your browser. We have no servers, no user accounts, and no tracking scripts.

---

## 2. Information We Do Not Collect

To make our stance completely clear, this extension:

- **Does NOT collect personal data:** No names, email addresses, phone numbers, IP addresses, or LinkedIn profile details.
- **Does NOT log keystrokes or text:** We never record what you type, what you select, or what you post. The extension only listens for the specific key combination `Ctrl+B` (Windows/Linux) or `Cmd+B` (macOS) to apply bold formatting to your active selection.
- **Does NOT track browsing activity:** We do not track the pages you visit, the links you click, or how long you spend on LinkedIn.
- **Does NOT use analytics or tracking pixels:** We do not include Google Analytics, Mixpanel, Sentry, or any third-party tracking scripts.
- **Does NOT use cookies or local storage:** The extension sets no cookies, uses no local web storage, and writes nothing to your disk.

---

## 3. Permissions & Host Access

The extension requests only one permission in its manifest:

- **Host Permission:** `https://www.linkedin.com/*`

### Why is this permission required?
This permission lets the extension load a small content script when you open LinkedIn. The script listens for the `Ctrl+B` and `Cmd+B` shortcut inside LinkedIn's post and comment editors. When you press the shortcut, it tells the editor to format the selected text as bold.

The extension:
- Only runs on `linkedin.com` pages.
- Cannot read data from any other website you visit.
- Does not request elevated browser permissions (such as `cookies`, `webRequest`, `management`, or `storage`).

---

## 4. Network Activity & External Communications

LinkedIn Rich Text Shortcuts makes **zero network requests**. It contains no outbound API calls, `fetch()` statements, `XMLHttpRequest` calls, or WebSocket connections. It operates completely offline once installed from the Chrome Web Store.

---

## 5. Third-Party Services & Code

The extension is 100% self-contained:
- Contains no external libraries, dependencies, or frameworks.
- Loads no remote scripts or CDN assets.
- Shares zero information with third parties or advertising partners.

---

## 6. Google Chrome Web Store Policy Compliance

This extension strictly adheres to the **Chrome Web Store Developer Program Policies**, including the **Limited Use** requirements:

1. **Single Purpose:** The extension serves one single, clearly defined function: adding a bold text keyboard shortcut to LinkedIn editors.
2. **Data Minimization:** The extension requests the minimum host permission necessary to function and collects zero user data.
3. **Developer Dashboard Disclosures:** All data collection and data usage categories are declared as **"No"** in the Chrome Web Store Developer Dashboard.

---

## 7. Children's Privacy

Because the extension collects no data from any user, it does not collect or solicit information from children under the age of 13.

---

## 8. Changes to This Policy

If we ever update this policy, we'll post the updated version directly in this repository and on the Chrome Web Store listing. Because we don't collect email addresses, please check this page for updates.

---

## 9. Contact Us

If you have questions about this privacy policy or our extension, please reach out:

- **GitHub Repository:** https://github.com/bhanubais/bold-text-on-linkedin
- **Support & Inquiries:** https://github.com/bhanubais/bold-text-on-linkedin/issues
