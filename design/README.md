# LinkedIn Rich Text Shortcuts Design Catalog

The design package uses the original artwork in `/images/` as its visual source of truth. Promotional masters feature glossy 3D keycaps and LinkedIn post cards. Store screenshots use original product and editor captures.

## Brand system

- Primary color: LinkedIn Blue (`#0A66C2`)
- Accent color: Dark Navy (`#1B1F23`)
- Background: light blue gradient (`#E8F4FD` to `#FFFFFF`)
- Typography: system sans-serif, including Inter, SF Pro, or Segoe UI
- Product shortcut: bold only, `Ctrl+B` on Windows and Linux, `Cmd+B` on macOS

## Chrome Web Store promotional tiles

| File | Dimensions | Source and treatment | Upload recommendation |
|---|---:|---|---|
| `promo-tiles/small-promo-tile-440x280.png` | 440 x 280 px | Direct copy of `/images/Make LinkedIn Posts Stand Out-440x280.png` | Upload to the small promotional tile slot. |
| `promo-tiles/large-promo-tile-920x680.png` | 920 x 680 px | High quality bicubic center crop from `/images/Make LinkedIn Posts Stand Out.png` (1571 x 1001 px) | Upload to the large promotional tile slot. The source composition is center-cropped to fill the required aspect ratio. |
| `promo-tiles/marquee-banner-1400x560.png` | 1400 x 560 px | Full source composition from `/images/Bold Text on LinkedIn-1.png` (1586 x 992 px), bicubic scaled to fit over the light blue brand gradient | Upload to the marquee slot where available. The source art is preserved in full with gradient side and top/bottom space. |

## Chrome Web Store screenshots

Upload the screenshots in the listed order. The store accepts up to five screenshots. These three files are all 1280 x 800 px PNGs.

| Order and file | Dimensions | Source and content |
|---|---:|---|
| `store-screenshots/screenshot-1-hero-shortcut.png` | 1280 x 800 px | Direct copy of `/images/Bold Text on LinkedIn-1-1280x880.png`. The source image itself is 1280 x 800 px. |
| `store-screenshots/screenshot-2-before-after.png` | 1280 x 800 px | Direct copy of `/images/LinkedIn Bold Formatting Before and After-1280x800.png`. |
| `store-screenshots/screenshot-3-in-situ-editor.png` | 1280 x 800 px | `/images/Screenshot 2026-10-07 135444.png` (1240 x 909 px), bicubic scaled to fit over the light blue brand gradient. The full editor capture is retained. |

## Social creative

| File | Dimensions | Source and recommendation |
|---|---:|---|
| `social-banners/linkedin-post-portrait.png` | 1167 x 1347 px | Direct copy of `/images/LinkedIn post.png`. Use as a portrait LinkedIn feed creative. Its dimensions are close to, but do not exactly match, the 1080 x 1350 px 4:5 portrait guideline. |

## Source masters

The original files remain preserved in `/images/` as the master archive. The promoted files above are ready to upload at their stated dimensions. Keep the original aspect ratio when creating future derivatives, and use high quality bicubic resampling for resized raster artwork.
