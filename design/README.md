# LinkedIn Rich Text Shortcuts: Design Catalog & Brand System

Welcome to the visual identity and asset specification library for **LinkedIn Rich Text Shortcuts**.

This catalog details all visual touchpoints, Chrome Web Store listing assets, social creatives, and upload specifications for store publishing and marketing distribution.

---

## Brand System Invariants

- **Primary Color:** LinkedIn Blue (`#0A66C2`)
- **Accent Color:** Dark Navy (`#1B1F23`)
- **Background Gradient:** Light Blue Gradient (`#E8F4FD` to `#FFFFFF`)
- **Typography:** System Sans-Serif (`Inter`, `SF Pro`, `Segoe UI`)
- **Visual Motif:** 3D tactile keycaps (`Ctrl+B` / `Cmd+B`), clean before-and-after contrast, and native editor previews.
- **Punctuation Standard:** Zero em-dashes and zero en-dashes. Clean colons, commas, parentheses, and standard hyphens only.

---

## Directory Topology

```
/design/
├── README.md                          # Master design catalog & guidelines
├── render-all.ps1                     # Automated pixel-perfect asset build pipeline
├── assets/
│   └── icon.png                       # Master high-resolution 3D keycap icon (1254x1254)
├── promo-tiles/                       # Chrome Web Store promotional tiles
│   ├── small-promo-tile-440x280.png   # Small promo tile (440x280 px)
│   ├── large-promo-tile-920x680.png   # Large promo tile (920x680 px)
│   └── marquee-banner-1400x560.png    # Marquee hero carousel banner (1400x560 px)
├── store-screenshots/                 # Official Chrome Web Store listing screenshots (1280x800)
│   ├── screenshot-1-hero-editor.png   # 01: The Native Shortcut LinkedIn Forgot
│   ├── screenshot-2-how-it-works.png  # 02: How It Works in 3 Simple Steps
│   ├── screenshot-3-native-vs-unicode.png # 03: Native Bold vs. Broken Unicode Fonts
│   ├── screenshot-4-universal-support.png # 04: Universal LinkedIn Support
│   └── screenshot-5-privacy-first.png # 05: Built for Privacy. Zero Tracking.
└── social-banners/                    # Multi-platform marketing & launch creatives
    ├── linkedin-post-graphic.png      # Landscape post graphic (1200x627 px, 1.91:1)
    ├── twitter-card.png               # High-contrast X/Twitter summary card (1200x675 px, 16:9)
    ├── product-hunt-hero.png          # Product Hunt gallery hero banner (1270x760 px)
    └── carousel/                      # 5-Slide viral LinkedIn educational carousel (1080x1350 px, 4:5)
        ├── carousel-slide-1.png       # Slide 1: Hook (Why 90% format bold wrong)
        ├── carousel-slide-2.png       # Slide 2: The Hidden Flaw (Unicode math symbols)
        ├── carousel-slide-3.png       # Slide 3: The Secret (Native contenteditable engine)
        ├── carousel-slide-4.png       # Slide 4: The Solution (Ctrl+B / Cmd+B shortcut)
        └── carousel-slide-5.png       # Slide 5: The Action (Install free on Chrome Web Store)
```

---

## Asset Specifications & Upload Guidelines

### 1. Chrome Web Store Promotional Tiles (`/design/promo-tiles/`)

Promotional tiles are featured in store category search rankings and top carousel placements.

| Asset File | Target Dimensions | Aspect Ratio | Color Space | Purpose |
|---|---|---|---|---|
| `small-promo-tile-440x280.png` | 440 x 280 px | ~1.57:1 | RGB PNG | Required for search result cards and category listings. Highlights the 3D keycap icon and core 1-second promise. |
| `large-promo-tile-920x680.png` | 920 x 680 px | 1.35:1 | RGB PNG | Featured category banner for Chrome Web Store editorial consideration. Features editor mockup and accessibility chips. |
| `marquee-banner-1400x560.png` | 1400 x 560 px | 2.5:1 | RGB PNG | Premium top banner for the Chrome Web Store homepage carousel and featured extensions header. |

> **Upload Instructions:**  
> In the [Chrome Developer Dashboard](https://chrome.google.com/webstore/devconsole), navigate to your extension -> **Store listing** -> **Promotional images**. Upload the small tile (440x280), large tile (920x680), and marquee banner (1400x560) into their respective slots.

---

### 2. Store Screenshots (`/design/store-screenshots/`)

All store screenshots strictly conform to the 1280 x 800 px specification (16:10 aspect ratio), completely eliminating the faulty 1280 x 880 px legacy format.

| Asset File | Target Dimensions | Core Theme | Mike Monteiro Design Objective |
|---|---|---|---|
| `screenshot-1-hero-editor.png` | 1280 x 800 px | The Native Shortcut LinkedIn Forgot | Showcases the live LinkedIn editor with native bold text and active `Ctrl+B / Cmd+B` shortcut indicator. Proves immediate value in under 3 seconds. |
| `screenshot-2-how-it-works.png` | 1280 x 800 px | How It Works in 3 Simple Steps | 3 sequential visual cards: Select Text -> Press Shortcut -> Instant Native Bold. Eliminates user hesitation. |
| `screenshot-3-native-vs-unicode.png` | 1280 x 800 px | Native Bold vs. Broken Unicode Fonts | Direct contrast showing why external generators hurt accessibility, trigger spam filters, and display missing character boxes (tofu). |
| `screenshot-4-universal-support.png` | 1280 x 800 px | Universal LinkedIn Support | 4-quadrant UI demonstrating bold formatting across feed posts, post comments, comment replies, and direct messages (DMs/InMail). |
| `screenshot-5-privacy-first.png` | 1280 x 800 px | Built for Privacy. Zero Tracking. | Privacy dashboard verifying zero remote servers, zero analytics, zero data storage, and tight host-scoped permissions. |

> **Upload Instructions:**  
> In the Chrome Developer Dashboard, navigate to **Store listing** -> **Screenshots**. Drag and drop all 5 screenshots in sequential order (1 through 5). The dashboard supports up to 5 screenshots at 1280x800 px.

---

### 3. Social Media & Launch Creatives (`/design/social-banners/`)

Engineered specifically for viral launch campaigns, organic founder posts, and social media syndication.

| Asset File | Platform | Dimensions | Aspect Ratio | Strategic Objective |
|---|---|---|---|---|
| `linkedin-post-graphic.png` | LinkedIn Feed | 1200 x 627 px | 1.91:1 | High-contrast launch announcement graphic for personal and company page posts. |
| `twitter-card.png` | Twitter / X | 1200 x 675 px | 16:9 | High-contrast dark card designed for large summary image previews in X threads. |
| `product-hunt-hero.png` | Product Hunt | 1270 x 760 px | 1.67:1 | Primary hero image for the Product Hunt gallery submission. |
| `carousel/carousel-slide-1.png` | LinkedIn Carousel | 1080 x 1350 px | 4:5 | Slide 1: High-curiosity hook on why creators format bold text wrong. |
| `carousel/carousel-slide-2.png` | LinkedIn Carousel | 1080 x 1350 px | 4:5 | Slide 2: Explains how Unicode generators replace letters with math symbols. |
| `carousel/carousel-slide-3.png` | LinkedIn Carousel | 1080 x 1350 px | 4:5 | Slide 3: Reveals LinkedIn's native contenteditable bold formatting engine. |
| `carousel/carousel-slide-4.png` | LinkedIn Carousel | 1080 x 1350 px | 4:5 | Slide 4: Shows the universal `Ctrl+B / Cmd+B` solution in action. |
| `carousel/carousel-slide-5.png` | LinkedIn Carousel | 1080 x 1350 px | 4:5 | Slide 5: Call to action with Chrome Web Store install instructions. |

---

## Regeneration Pipeline

All assets are built programmatically using headless Chromium via Microsoft Edge. To regenerate or modify any asset:

1. Update the template code inside `design/render-all.ps1`.
2. Run the generator in PowerShell:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "design\render-all.ps1"
   ```
3. The script automatically renders each HTML composition, captures full-bleed screenshots at exact target dimensions, and validates file sizes and pixel aspect ratios.
