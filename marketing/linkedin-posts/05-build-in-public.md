# LinkedIn Post 05: Build in Public Engineering Story

**File:** `marketing/linkedin-posts/05-build-in-public.md`  
**Target Audience:** Software engineers, indie hackers, product builders, and tech enthusiasts.  
**Strategic Framework:** Behind-the-Scenes Build-in-Public Recap (Authority & Craftsmanship).  
**Visual Asset:** Code snippet or terminal screenshot, paired with `design/social-banners/linkedin-post-graphic.png`.  
**Posting Time:** Friday, 9:30 AM ET.  

---

## Post Copy

I just shipped version 2.0 of a Chrome extension that does exactly one thing.

It adds bold formatting to LinkedIn via Ctrl+B and Cmd+B.

No AI buzzwords. No subscription tiers. No dashboard you will never open.

Just one keyboard shortcut that works every single time.

Here is the engineering breakdown behind the rebuild:

1. Migrated 100% to Manifest V3.
Google is deprecating Manifest V2 extensions across Chrome.
We rebuilt the architecture from scratch with a lightweight background service worker. No persistent background processes hogging laptop RAM.

2. Zero dependencies. Zero frameworks.
Many extensions inject 500 KB of bundled React code into every tab you open.
We wrote pure vanilla JavaScript.
Total bundle size is under 50 KB. That includes all four icon sizes.
When you press Ctrl+B, formatting applies in less than 4 milliseconds.

3. Standardized testing on Bun.
For developer tooling and test execution, we standardized on Bun (`bun test`).
Testing keyboard shortcut handlers, DOM contenteditable boundaries, and macOS metaKey parity runs in single-digit milliseconds. Fast feedback loops keep code quality high.

4. True native bold vs. the Unicode shortcut trap.
The hardest part was ensuring we never fell into the fake character trap.
Third-party font generators replace normal ASCII characters with mathematical Unicode glyphs. That breaks screen readers and destroys LinkedIn search indexing.
Our extension inspects the active contenteditable container and invokes LinkedIn's internal editor commands. Your post stays 100% accessible and fully searchable.

5. Open source and zero data collection.
When you install an extension, security should be your first thought.
We do not track analytics.
We do not store cookies.
We do not make external API requests.
We do not collect keystrokes.
The extension only requests permission on LinkedIn.com.
The full codebase is public on GitHub so anyone can audit the code.

Small, single-purpose tools that solve real daily annoyances are my favorite software to build.

You can inspect the GitHub repository or install the extension via the link in the first comment.

What is a tiny workflow bug in your favorite web app that drives you crazy?

---

## First Comment Template (Post Immediately After Publishing)

Install LinkedIn Rich Text Shortcuts (Free on Chrome Web Store):  
https://chromewebstore.google.com/detail/linkedin-rich-text-shortc/pcnojfgoolblflomemlceeemfjdmneia

GitHub repository (Star the project if you enjoy clean code!):  
https://github.com/bhanu-k/linkedin-rich-text-shortcuts

Feel free to check out the test suite in Bun and open an issue or pull request!
