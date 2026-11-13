# LinkedIn Post 01: The Founder Launch Story

**File:** `marketing/linkedin-posts/01-founder-launch-story.md`  
**Target Audience:** Creators, founders, marketers, and professionals who write on LinkedIn.  
**Strategic Framework:** Problem -> Agitate -> Solution (Justin Welsh style founder narrative).  
**Visual Asset:** `design/social-banners/linkedin-post-graphic.png`  
**Posting Time:** Tuesday or Wednesday, 8:15 AM ET.  

---

## Post Copy

Every time I draft a LinkedIn post, I hit Ctrl+B to bold an idea.

And every single time, absolutely nothing happens.

Think about your daily workflow:
- Google Docs: Ctrl+B / Cmd+B works.
- Slack: Ctrl+B / Cmd+B works.
- Notion: Ctrl+B / Cmd+B works.
- Microsoft Word: It has worked since 1995.

Yet on LinkedIn, the world's largest professional network, pressing Ctrl+B does nothing.

For years, people solved this with an annoying workaround:
1. Open a new tab.
2. Search for a "fancy text font generator".
3. Paste the text.
4. Copy the "bold" text back into LinkedIn.

Last month, I dug into the LinkedIn editor DOM out of sheer frustration.

What I found blew my mind.

LinkedIn already has a rich text engine built right into its post editor. It can render clean, native bold text. The team simply never hooked up the keyboard shortcut.

Those external font generators you see people use? They don't generate real bold text. They paste mathematical Unicode symbols (like 𝘉 or 𝗕).

That breaks screen readers for visually impaired people. It also confuses LinkedIn's search algorithm because the platform cannot read fake math glyphs as normal text.

So I wrote a simple Chrome extension to fix it once and for all: **LinkedIn Rich Text Shortcuts**.

Here is what it does:
- Highlight any text in a LinkedIn post or comment.
- Press Ctrl+B (Windows) or Cmd+B (Mac).
- Your text turns bold instantly. Hit it again to unbold.

No new tabs. No third-party font websites. No fake Unicode symbols.

Just one keystroke using LinkedIn's native rich text engine.

It weighs under 50 KB, runs entirely inside your browser, collects zero personal data, and requires zero setup.

I just published version 2.0 on the Chrome Web Store. It is 100% free and open source.

I dropped the install link in the first comment below.

What formatting feature do you wish LinkedIn built next?

---

## First Comment Template (Post Immediately After Publishing)

Install the extension directly on the Chrome Web Store (Free):  
https://chromewebstore.google.com/detail/linkedin-rich-text-shortc/pcnojfgoolblflomemlceeemfjdmneia

Full source code on GitHub (Clean JS, Manifest V3, zero external dependencies):  
https://github.com/bhanu-k/linkedin-rich-text-shortcuts

Let me know what you think once you try your first Ctrl+B / Cmd+B!

---

## Publishing Checklist
- [ ] Image attached: `design/social-banners/linkedin-post-graphic.png`
- [ ] Link placed exclusively in first comment (never in post body)
- [ ] Reply to every comment within the first 60 minutes
- [ ] Tag relevant collaborators or beta testers in comments
