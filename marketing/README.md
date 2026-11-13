# Master Marketing Playbook: LinkedIn Rich Text Shortcuts

Welcome to the distribution and organic growth engine for **LinkedIn Rich Text Shortcuts**.

This master playbook defines the complete go-to-market plan, multi-channel launch schedule (Day 1 through Day 14), community distribution checklists, and engagement playbooks.

---

## 1. Core Positioning & Invariants

| Attribute | Specification |
|---|---|
| **Product Constraint** | Strictly bold formatting (`Ctrl+B` / `Cmd+B`). LinkedIn's editor does NOT support italics or underline natively. Never claim or imply support for them. |
| **The Hook Angle** | Every writing tool on earth (Docs, Word, Slack, Notion) has supported `Ctrl+B` for decades. Why did LinkedIn forget? |
| **The Technical Enemy** | Third-party "fancy font generators" (YayText, LingoJam). Expose how they paste mathematical Unicode symbols, break screen-reader accessibility, and hurt search visibility. |
| **Mac Parity** | Native `Cmd+B` support alongside `Ctrl+B` with zero browser bookmark conflicts. |
| **Privacy & Trust** | Zero tracking, zero analytics, under 50 KB, pure vanilla JS, Manifest V3 compliant, open-source on GitHub. |
| **Punctuation Standard** | Absolutely zero em-dashes or en-dashes. Clean punctuation only (commas, periods, colons, parentheses, or simple hyphens). |

---

## 2. Content & Asset Inventory

All marketing copy and visual creatives are organized systematically:

```
/marketing/
├── README.md                              # This master playbook
├── linkedin-posts/                        # High-converting LinkedIn organic posts
│   ├── 01-founder-launch-story.md         # Day 1: Founder launch story & problem hook
│   ├── 02-carousel-copy.md                # Day 3: 5-slide educational document carousel
│   ├── 03-the-unicode-trap.md             # Day 5: Contrasting fake fonts vs native rich text
│   ├── 04-mac-os-announcement.md          # Day 8: Dedicated Mac creator callout (Cmd+B)
│   └── 05-build-in-public.md              # Day 11: Tech breakdown (clean JS, Manifest V3, Bun)
├── twitter-posts/                         # Twitter / X viral threads
│   └── launch-thread.md                   # 7-tweet launch thread with visual cues
└── product-hunt/                          # Product Hunt launch engine
    └── ph-launch-kit.md                   # Tagline, maker comment, media sequence, outreach

/design/social-banners/                    # Generated visual creatives
├── linkedin-post-graphic.png              # Landscape announcement graphic (1200x627)
├── twitter-card.png                       # High-contrast X summary card (1200x675)
├── product-hunt-hero.png                  # Product Hunt hero presentation card (1270x760)
└── carousel/                              # 5-Slide 4:5 document carousel (1080x1350)
    ├── carousel-slide-1.png               # Slide 1: Hook (Why 90% format bold wrong)
    ├── carousel-slide-2.png               # Slide 2: The Hidden Flaw (Unicode math symbols)
    ├── carousel-slide-3.png               # Slide 3: The Secret (Native contenteditable engine)
    ├── carousel-slide-4.png               # Slide 4: The Solution (Ctrl+B / Cmd+B shortcut)
    └── carousel-slide-5.png               # Slide 5: The Action (Install free on Chrome Web Store)
```

---

## 3. Day 1 to Day 14 Launch Schedule

### Phase 1: Launch Week (Days 1 to 5)

#### Day 1 (Tuesday): The Big Launch & Product Hunt Sprint
- **00:01 PT (03:01 ET):** Product Hunt goes live. Post Maker's Comment immediately.
- **08:15 ET:** Publish **Post 01: The Founder Launch Story** on LinkedIn with `design/social-banners/linkedin-post-graphic.png`. Place Chrome Web Store link in first comment.
- **09:00 ET:** Publish the **7-Tweet Twitter/X Launch Thread** with `design/social-banners/twitter-card.png`.
- **09:30 ET:** Direct outreach to 15-20 friendly founders, colleagues, and early beta testers via WhatsApp, Slack, and Discord.
- **13:00 ET:** Post mid-day milestone update on Product Hunt ranking (aiming for Top 5).
- **All Day:** Reply to 100% of comments on Product Hunt, LinkedIn, and Twitter within 30 minutes.

#### Day 2 (Wednesday): Community Syndication & Developer Hubs
- **Show HN on Hacker News:**
  - Title: *Show HN: LinkedIn Rich Text Shortcuts - A 50KB extension for native bold text*
  - Body: Explain the discovery of LinkedIn's native rich text engine, the Unicode math symbol trap, and link to GitHub and the Chrome Web Store.
- **Reddit Communities:**
  - Post thoughtful, value-first write-ups in `r/productivity`, `r/chrome_extensions`, and `r/sideproject`.
  - Focus on screen reader accessibility and why font generators break SEO.

#### Day 3 (Thursday): Educational Visual Authority
- **09:00 ET:** Publish **Post 02: Educational Document Carousel** on LinkedIn.
- Upload the 5-slide PDF carousel (`carousel-slide-1.png` through `carousel-slide-5.png`).
- Engage actively with comments asking about screen readers and formatting nuances.

#### Day 4 (Friday): Community Engagement & Weekend Tease
- Follow up on all pending Chrome Web Store reviews and GitHub issues.
- Retweet creator shoutouts on Twitter/X.
- Post a thank-you note celebrating initial install milestones (100+ installs).

#### Day 5 (Saturday): The Unicode Trap
- **09:30 ET:** Publish **Post 03: The Unicode Trap** on LinkedIn.
- Target accessibility advocates, content creators, and copywriters.
- Contrast mathematical alphanumeric symbols (`U+1D400`) against clean HTML `<strong>` tags.

---

### Phase 2: Momentum & Expansion (Days 6 to 10)

#### Day 6 (Sunday): Review & Metrics Sync
- Audit install numbers and impressions in the Chrome Developer Dashboard.
- Analyze top referral channels (Product Hunt vs. LinkedIn vs. Twitter vs. Reddit).

#### Day 7 (Monday): Product Hunt Wrap-Up & Learnings
- Publish a short recap of the Product Hunt sprint on Twitter/X.
- Share metrics: upvotes, total installs, and visitor conversion rates.

#### Day 8 (Tuesday): macOS Creator Spotlight
- **10:00 ET:** Publish **Post 04: macOS Announcement** on LinkedIn.
- Specifically address MacBook users, Apple enthusiasts, and Notion/Bear/Slack writers.
- Emphasize native `Cmd+B` handling without triggering the browser bookmark bar.

#### Day 9 (Wednesday): Indie Hackers & Build-in-Public Forums
- Post a comprehensive post-mortem on Indie Hackers:
  - Title: *How I built and launched a single-purpose Chrome extension that hit #X on Product Hunt*
  - Share key learnings on building small tools, Manifest V3 migration, and avoiding third-party analytics bloat.

#### Day 10 (Thursday): Creator Outreach & Word of Mouth
- Identify 10 LinkedIn creators with 10k-50k followers who post daily.
- Send a personalized, value-first direct message:
  - Mention a recent post of theirs.
  - Share how the extension saves formatting time with `Ctrl+B` / `Cmd+B`.
  - Provide the direct Chrome Web Store link with zero sales pitch.

---

### Phase 3: Authority & Long-Tail Growth (Days 11 to 14)

#### Day 11 (Friday): Engineering & Craftsmanship
- **09:30 ET:** Publish **Post 05: Build in Public Engineering Story** on LinkedIn.
- Highlight clean vanilla JavaScript, Manifest V3 architecture, Bun test execution (`bun test`), and the open-source repository.
- Engage with software engineers, indie hackers, and open-source advocates.

#### Day 12 (Saturday): YouTube & Newsletter Syndication
- Pitch the extension to 3 popular productivity newsletters (such as Productivity Cafe, Creator Toolkit, or Chrome Extension Weekly).
- Provide copy-paste snippets and screenshots from `/design/store-screenshots/`.

#### Day 13 (Sunday): Weekly Retrospective & Content Repurposing
- Identify the highest-performing LinkedIn post from Weeks 1 and 2.
- Repurpose the winning hook into a standalone Twitter/X post and a short-form video script.

#### Day 14 (Monday): Milestone Celebration & Ongoing Cadence
- Publish a 2-week milestone update celebrating total active users and 5-star ratings.
- Transition into the sustained organic publishing cadence (2-3 targeted posts per week).

---

## 4. Algorithmic Optimization & Engagement Rules

### Rule 1: The First 60 Minutes (The Golden Hour)
LinkedIn and Twitter algorithms measure velocity of engagement in the first hour.
- Be active online when a post drops.
- Reply to every single comment within 15 minutes.
- Reply with a thoughtful question or insight to encourage a second reply from the user.

### Rule 2: Outbound Links Belong in the Comments
- Never place external URLs (Chrome Web Store, GitHub, Product Hunt) inside the main body of a LinkedIn post. LinkedIn penalizes external links that navigate users away from the feed.
- Always include the link in the first comment immediately after posting.
- In the post body, state clearly: "Direct link in the first comment below."

### Rule 3: The 2-Line Hook Rule
- Readers only see the first 2 or 3 lines of your post before the "...see more" fold.
- The hook must create an open cognitive loop or provoke immediate curiosity.
- Never waste the first line with greetings or pleasantries ("Hope everyone is having a great Monday").

### Rule 4: Human Tone & Clean Punctuation
- Write like you talk to a smart friend.
- Always use contractions ("don't", "can't", "it's").
- Never use banned corporate buzzwords: leverage, utilize, streamline, empower, cutting-edge, state-of-the-art, robust, synergy.
- Strictly ban big-dashes (em-dashes and en-dashes). Use clean commas, periods, parentheses, colons, or standard hyphens.

---

## 5. Metrics & Success KPIs

Track these performance indicators weekly in the Chrome Developer Dashboard and social analytics:

| KPI | Launch Target (Day 1 - 3) | 14-Day Target | Measurement Channel |
|---|---|---|---|
| **Chrome Web Store Installs** | 150+ installs | 750+ active users | Chrome Developer Dashboard |
| **Store Rating & Reviews** | 10+ ratings (5.0 average) | 25+ ratings (4.8+ average) | Chrome Web Store Listing |
| **Product Hunt Rank** | Top 5 Product of the Day | Upvoted badge earned | Product Hunt Dashboard |
| **LinkedIn Post Impressions** | 15,000+ total views | 50,000+ total views | LinkedIn Creator Analytics |
| **Twitter/X Thread Views** | 5,000+ impressions | 20,000+ impressions | X Analytics |
| **GitHub Repository Stars** | 25+ stars | 100+ stars | GitHub Repository Insights |
