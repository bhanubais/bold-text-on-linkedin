# PowerShell script to generate all brand design assets for LinkedIn Rich Text Shortcuts
# Strict Brand Invariants:
# - Primary: #0A66C2
# - Accent: #1B1F23
# - Background: Light blue gradient (#E8F4FD to #FFFFFF)
# - System sans-serif typography
# - 3D keycap shortcut aesthetic
# - ZERO em-dashes (no —) and ZERO en-dashes (no –)

param(
    [string]$EdgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
)

$ErrorActionPreference = "Continue"

$workspace = "D:\Startups\Chrome Extensions\LinkedIn Editing"
$designDir = Join-Path $workspace "design"
$promoDir = Join-Path $designDir "promo-tiles"
$screenDir = Join-Path $designDir "store-screenshots"
$socialDir = Join-Path $designDir "social-banners"
$carouselDir = Join-Path $socialDir "carousel"
$tempDir = Join-Path $designDir ".temp_html"

New-Item -ItemType Directory -Force -Path $promoDir | Out-Null
New-Item -ItemType Directory -Force -Path $screenDir | Out-Null
New-Item -ItemType Directory -Force -Path $socialDir | Out-Null
New-Item -ItemType Directory -Force -Path $carouselDir | Out-Null
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

$iconPath = "file:///" + ((Join-Path $designDir "assets\icon.png") -replace '\\', '/')

function Render-Asset {
    param(
        [string]$Name,
        [int]$Width,
        [int]$Height,
        [string]$HtmlContent,
        [string]$OutputDir
    )

    # Strict check for em-dash and en-dash
    if ($HtmlContent.Contains([char]0x2014) -or $HtmlContent.Contains([char]0x2013)) {
        throw "Punctuation violation: $Name contains em-dash or en-dash!"
    }

    $htmlFile = Join-Path $tempDir "$Name.html"
    $pngFile = Join-Path $OutputDir "$Name.png"

    [System.IO.File]::WriteAllText($htmlFile, $HtmlContent, [System.Text.Encoding]::UTF8)

    $url = "file:///" + ($htmlFile -replace '\\', '/')
    Start-Process -FilePath $EdgePath -ArgumentList "--headless=new", "--screenshot=`"$pngFile`"", "--window-size=$Width,$Height", "--hide-scrollbars", "`"$url`"" -Wait -NoNewWindow

    Start-Sleep -Milliseconds 800

    if (-not (Test-Path $pngFile)) {
        Start-Sleep -Seconds 1
    }

    if (Test-Path $pngFile) {
        Add-Type -AssemblyName System.Drawing
        $img = [System.Drawing.Image]::FromFile($pngFile)
        $actualW = $img.Width
        $actualH = $img.Height
        $sizeBytes = (Get-Item $pngFile).Length
        $img.Dispose()

        Write-Host " Rendered: $Name.png ($actualW x $actualH, $([math]::Round($sizeBytes / 1024, 1)) KB)"
        if ($actualW -ne $Width -or $actualH -ne $Height) {
            Write-Warning "Dimension mismatch for $($Name): Expected $($Width)x$($Height), got $($actualW)x$($actualH)"
        }
    } else {
        throw "Failed to render $pngFile"
    }
}

Write-Host "=== Generating Promotional Tiles ==="

# 1. Small Promo Tile (440x280)
$html_small_promo = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 440px; height: 280px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FA 0%, #FFFFFF 65%, #F0F6FD 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 24px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.2);
  }
  .bg-glow {
    position: absolute; width: 260px; height: 260px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.12) 0%, rgba(10, 102, 194, 0) 70%);
    top: -50px; right: -50px; border-radius: 50%; pointer-events: none;
  }
  .top-row {
    display: flex; align-items: center; justify-content: space-between; z-index: 2;
  }
  .badge {
    display: inline-flex; align-items: center; gap: 6px;
    background: rgba(10, 102, 194, 0.08); color: #0A66C2;
    font-size: 11px; font-weight: 700; letter-spacing: 0.6px;
    text-transform: uppercase; padding: 4px 10px; border-radius: 20px;
    border: 1px solid rgba(10, 102, 194, 0.25);
  }
  .content {
    display: flex; align-items: center; gap: 18px; z-index: 2; margin-top: 4px;
  }
  .icon-img {
    width: 94px; height: 94px; border-radius: 20px;
    box-shadow: 0 12px 24px rgba(10, 102, 194, 0.22), 0 4px 8px rgba(0, 0, 0, 0.08);
    flex-shrink: 0;
  }
  .text-box {
    display: flex; flex-direction: column; gap: 6px;
  }
  .title {
    font-size: 22px; font-weight: 800; line-height: 1.22;
    color: #1B1F23; letter-spacing: -0.3px;
  }
  .title span {
    color: #0A66C2;
  }
  .subtitle {
    font-size: 13px; color: #5E6E7E; font-weight: 500; line-height: 1.35;
  }
  .bottom-row {
    display: flex; align-items: center; justify-content: space-between; z-index: 2;
    padding-top: 10px; border-top: 1px solid rgba(10, 102, 194, 0.12);
  }
  .keys {
    display: inline-flex; align-items: center; gap: 5px;
  }
  .key {
    background: linear-gradient(180deg, #FFFFFF 0%, #EDF2F7 100%);
    border: 1px solid #CBD5E1; border-bottom: 3px solid #94A3B8;
    border-radius: 6px; padding: 3px 8px; font-size: 11px; font-weight: 700;
    color: #1E293B; box-shadow: 0 2px 4px rgba(0,0,0,0.06);
  }
  .key-plus {
    font-size: 11px; font-weight: 700; color: #64748B;
  }
  .pill {
    font-size: 11px; font-weight: 700; color: #0A66C2;
  }
</style>
</head>
<body>
  <div class="bg-glow"></div>
  <div class="top-row">
    <div class="badge">Chrome Extension</div>
    <div class="pill">Native Rich Text</div>
  </div>
  <div class="content">
    <img class="icon-img" src="$iconPath">
    <div class="text-box">
      <div class="title">Bold on LinkedIn <span>in 1 Second</span></div>
      <div class="subtitle">The native shortcut LinkedIn forgot.</div>
    </div>
  </div>
  <div class="bottom-row">
    <div class="keys">
      <span class="key">Ctrl</span>
      <span class="key-plus">+</span>
      <span class="key">B</span>
      <span style="font-size: 11px; color: #64748B; margin: 0 4px;">or</span>
      <span class="key">Cmd</span>
      <span class="key-plus">+</span>
      <span class="key">B</span>
    </div>
    <span class="pill">100% Free & Private</span>
  </div>
</body>
</html>
"@
Render-Asset -Name "small-promo-tile-440x280" -Width 440 -Height 280 -HtmlContent $html_small_promo -OutputDir $promoDir

# 2. Large Promo Tile (920x680)
$html_large_promo = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 920px; height: 680px; overflow: hidden;
    background: linear-gradient(145deg, #E8F4FD 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 44px 50px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.2);
  }
  .bg-circle-1 {
    position: absolute; width: 450px; height: 450px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.12) 0%, rgba(10, 102, 194, 0) 70%);
    top: -100px; right: -100px; border-radius: 50%; pointer-events: none;
  }
  .bg-circle-2 {
    position: absolute; width: 350px; height: 350px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.08) 0%, rgba(10, 102, 194, 0) 70%);
    bottom: -80px; left: -80px; border-radius: 50%; pointer-events: none;
  }
  .header-row {
    display: flex; align-items: center; justify-content: space-between; z-index: 2;
  }
  .brand-group {
    display: flex; align-items: center; gap: 14px;
  }
  .brand-icon {
    width: 48px; height: 48px; border-radius: 12px;
    box-shadow: 0 4px 12px rgba(10, 102, 194, 0.25);
  }
  .brand-title {
    font-size: 15px; font-weight: 800; color: #1B1F23; letter-spacing: -0.2px;
  }
  .brand-sub {
    font-size: 12px; color: #5E6E7E; font-weight: 500;
  }
  .tag {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2;
    font-size: 12px; font-weight: 700; padding: 6px 14px; border-radius: 20px;
    border: 1px solid rgba(10, 102, 194, 0.25); letter-spacing: 0.5px;
    text-transform: uppercase;
  }
  .hero-text {
    z-index: 2; margin-top: 10px;
  }
  .hero-headline {
    font-size: 38px; font-weight: 800; color: #1B1F23; line-height: 1.18;
    letter-spacing: -0.8px;
  }
  .hero-headline span {
    color: #0A66C2;
  }
  .hero-desc {
    font-size: 17px; color: #475569; margin-top: 10px; line-height: 1.45;
    max-width: 760px; font-weight: 500;
  }
  .editor-preview {
    z-index: 2; background: #FFFFFF; border-radius: 16px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 16px 36px rgba(10, 102, 194, 0.12), 0 4px 12px rgba(0, 0, 0, 0.04);
    padding: 24px 28px; position: relative; margin-top: 6px;
  }
  .editor-header {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 14px;
    padding-bottom: 12px; border-bottom: 1px solid #EDF2F7;
  }
  .editor-user {
    display: flex; align-items: center; gap: 12px;
  }
  .avatar {
    width: 38px; height: 38px; border-radius: 50%;
    background: linear-gradient(135deg, #0A66C2 0%, #004182 100%);
    color: #FFFFFF; font-weight: 700; font-size: 14px;
    display: flex; align-items: center; justify-content: center;
  }
  .user-meta-name {
    font-size: 14px; font-weight: 700; color: #1B1F23;
  }
  .user-meta-sub {
    font-size: 11px; color: #64748B;
  }
  .editor-body {
    font-size: 16px; line-height: 1.55; color: #334155;
  }
  .bold-highlight {
    background: rgba(10, 102, 194, 0.1);
    color: #0A66C2; font-weight: 800; padding: 2px 8px; border-radius: 6px;
    border: 1px dashed #0A66C2; position: relative; display: inline-block;
  }
  .floating-keycaps {
    position: absolute; right: 28px; bottom: 22px;
    display: flex; align-items: center; gap: 6px;
    background: #1B1F23; padding: 8px 14px; border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
  }
  .floating-label {
    font-size: 11px; font-weight: 700; color: #94A3B8; text-transform: uppercase; margin-right: 4px;
  }
  .key-dark {
    background: linear-gradient(180deg, #FFFFFF 0%, #E2E8F0 100%);
    border: 1px solid #CBD5E1; border-bottom: 3px solid #94A3B8;
    border-radius: 6px; padding: 4px 10px; font-size: 12px; font-weight: 800;
    color: #0F172A;
  }
  .feature-bar {
    display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; z-index: 2; margin-top: 10px;
  }
  .feature-item {
    background: rgba(255, 255, 255, 0.9); border: 1px solid rgba(10, 102, 194, 0.16);
    border-radius: 12px; padding: 14px 16px; display: flex; align-items: center; gap: 12px;
    box-shadow: 0 4px 10px rgba(10, 102, 194, 0.05);
  }
  .feature-icon {
    font-size: 20px;
  }
  .feature-title {
    font-size: 13px; font-weight: 700; color: #1B1F23;
  }
  .feature-sub {
    font-size: 11px; color: #64748B; margin-top: 2px;
  }
</style>
</head>
<body>
  <div class="bg-circle-1"></div>
  <div class="bg-circle-2"></div>
  <div class="header-row">
    <div class="brand-group">
      <img class="brand-icon" src="$iconPath">
      <div>
        <div class="brand-title">LinkedIn Rich Text Shortcuts</div>
        <div class="brand-sub">Native Formatting Extension for Chrome</div>
      </div>
    </div>
    <div class="tag">Chrome Store Editorial Pick</div>
  </div>
  <div class="hero-text">
    <div class="hero-headline">Native Bold Formatting. <span>Zero Hacks.</span></div>
    <div class="hero-desc">Format bold text directly in LinkedIn posts, comments, and messages with Ctrl+B or Cmd+B. Works instantly and accessible to screen readers.</div>
  </div>
  <div class="editor-preview">
    <div class="editor-header">
      <div class="editor-user">
        <div class="avatar">SC</div>
        <div>
          <div class="user-meta-name">Sarah Chen · Top Voice in Product</div>
          <div class="user-meta-sub">Post to Anyone · Public</div>
        </div>
      </div>
      <div style="font-size: 12px; font-weight: 600; color: #0A66C2;">LinkedIn Feed Post</div>
    </div>
    <div class="editor-body">
      Most LinkedIn posts get lost in the feed within minutes.<br>
      <span class="bold-highlight">Highlight your most important insights with native bold text.</span><br>
      No font generator websites. No broken unicode. Pure keyboard shortcut speed.
    </div>
    <div class="floating-keycaps">
      <span class="floating-label">Shortcut:</span>
      <span class="key-dark">Ctrl</span>
      <span style="color: #94A3B8; font-weight: 700;">+</span>
      <span class="key-dark">B</span>
      <span style="color: #64748B; margin: 0 2px;">/</span>
      <span class="key-dark">Cmd</span>
      <span style="color: #94A3B8; font-weight: 700;">+</span>
      <span class="key-dark">B</span>
    </div>
  </div>
  <div class="feature-bar">
    <div class="feature-item">
      <div class="feature-icon">⚡</div>
      <div>
        <div class="feature-title">Native Rich Text</div>
        <div class="feature-sub">Real contenteditable bold</div>
      </div>
    </div>
    <div class="feature-item">
      <div class="feature-icon">♿</div>
      <div>
        <div class="feature-title">Screen Reader Safe</div>
        <div class="feature-sub">100% accessible text</div>
      </div>
    </div>
    <div class="feature-item">
      <div class="feature-icon">🔒</div>
      <div>
        <div class="feature-title">Zero Data Tracking</div>
        <div class="feature-sub">Runs completely locally</div>
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "large-promo-tile-920x680" -Width 920 -Height 680 -HtmlContent $html_large_promo -OutputDir $promoDir

# 3. Marquee Banner (1400x560)
$html_marquee = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1400px; height: 560px; overflow: hidden;
    background: linear-gradient(135deg, #E8F4FD 0%, #FFFFFF 52%, #F1F7FD 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; align-items: center; justify-content: space-between;
    padding: 50px 70px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.2);
  }
  .bg-glow-right {
    position: absolute; width: 600px; height: 600px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.12) 0%, rgba(10, 102, 194, 0) 70%);
    top: -100px; right: -50px; border-radius: 50%; pointer-events: none;
  }
  .left-col {
    width: 650px; z-index: 2; display: flex; flex-direction: column; gap: 18px;
  }
  .brand-badge {
    display: inline-flex; align-items: center; gap: 10px;
    background: rgba(10, 102, 194, 0.08); color: #0A66C2;
    padding: 6px 14px; border-radius: 20px; border: 1px solid rgba(10, 102, 194, 0.22);
    font-size: 13px; font-weight: 700; width: fit-content; letter-spacing: 0.5px;
    text-transform: uppercase;
  }
  .headline {
    font-size: 44px; font-weight: 800; line-height: 1.15; color: #1B1F23;
    letter-spacing: -1px;
  }
  .headline span {
    color: #0A66C2;
  }
  .subhead {
    font-size: 18px; color: #475569; line-height: 1.45; font-weight: 500;
  }
  .shortcut-showcase {
    display: flex; align-items: center; gap: 16px; margin-top: 4px;
  }
  .keycap-pair {
    display: inline-flex; align-items: center; gap: 6px;
    background: #FFFFFF; padding: 6px 12px; border-radius: 10px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 4px 10px rgba(0,0,0,0.04);
  }
  .key-label {
    font-size: 11px; font-weight: 700; color: #64748B; text-transform: uppercase; margin-right: 2px;
  }
  .key {
    background: linear-gradient(180deg, #FFFFFF 0%, #EDF2F7 100%);
    border: 1px solid #CBD5E1; border-bottom: 3px solid #94A3B8;
    border-radius: 6px; padding: 4px 10px; font-size: 13px; font-weight: 800;
    color: #1E293B;
  }
  .badges-row {
    display: flex; align-items: center; gap: 20px; margin-top: 6px;
  }
  .badge-item {
    font-size: 13px; font-weight: 700; color: #0A66C2;
    display: flex; align-items: center; gap: 6px;
  }
  .right-col {
    width: 540px; z-index: 2; position: relative;
  }
  .editor-card {
    background: #FFFFFF; border-radius: 20px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 24px 48px rgba(10, 102, 194, 0.15), 0 6px 16px rgba(0, 0, 0, 0.05);
    padding: 28px; position: relative;
  }
  .card-top {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px;
    padding-bottom: 14px; border-bottom: 1px solid #F1F5F9;
  }
  .card-user {
    display: flex; align-items: center; gap: 12px;
  }
  .card-avatar {
    width: 44px; height: 44px; border-radius: 50%;
    background: #0A66C2; color: #FFF; font-weight: 700; font-size: 16px;
    display: flex; align-items: center; justify-content: center;
  }
  .card-name {
    font-size: 15px; font-weight: 700; color: #1B1F23;
  }
  .card-sub {
    font-size: 12px; color: #64748B;
  }
  .card-text {
    font-size: 16px; line-height: 1.55; color: #334155; margin-bottom: 20px;
  }
  .bold-snippet {
    color: #1B1F23; font-weight: 800; background: rgba(10, 102, 194, 0.1);
    padding: 3px 6px; border-radius: 4px; border-left: 3px solid #0A66C2;
  }
  .card-footer {
    display: flex; align-items: center; justify-content: space-between;
    padding-top: 14px; border-top: 1px solid #F1F5F9;
  }
  .post-btn {
    background: #0A66C2; color: #FFFFFF; font-weight: 700; font-size: 14px;
    padding: 8px 22px; border-radius: 20px; border: none;
  }
</style>
</head>
<body>
  <div class="bg-glow-right"></div>
  <div class="left-col">
    <div class="brand-badge">
      <img src="$iconPath" style="width:20px; height:20px; border-radius:4px;">
      Chrome Web Store Header
    </div>
    <div class="headline">The Native Shortcut <span>LinkedIn Forgot.</span></div>
    <div class="subhead">Highlight text, press Ctrl+B or Cmd+B, and format bold text instantly in posts, comments, and messages. No external font websites required.</div>
    <div class="shortcut-showcase">
      <div class="keycap-pair">
        <span class="key-label">PC:</span>
        <span class="key">Ctrl</span>
        <span style="color:#94A3B8; font-weight:700;">+</span>
        <span class="key">B</span>
      </div>
      <div class="keycap-pair">
        <span class="key-label">Mac:</span>
        <span class="key">Cmd</span>
        <span style="color:#94A3B8; font-weight:700;">+</span>
        <span class="key">B</span>
      </div>
    </div>
    <div class="badges-row">
      <span class="badge-item">✓ 100% Native Bold</span>
      <span class="badge-item">✓ Screen Reader Accessible</span>
      <span class="badge-item">✓ Zero Data Tracking</span>
    </div>
  </div>
  <div class="right-col">
    <div class="editor-card">
      <div class="card-top">
        <div class="card-user">
          <div class="card-avatar">AR</div>
          <div>
            <div class="card-name">Alex Rivera · 1st</div>
            <div class="card-sub">Creator & Strategist · Public</div>
          </div>
        </div>
        <div style="font-size: 12px; font-weight: 700; color: #0A66C2;">LinkedIn Feed</div>
      </div>
      <div class="card-text">
        Clear emphasis makes the difference between scrolling past and reading every word.<br><br>
        <span class="bold-snippet">Format your best ideas with native bold shortcuts.</span><br><br>
        Fast, accessible, and works right inside your editor.
      </div>
      <div class="card-footer">
        <div style="display:flex; gap:12px; color:#64748B; font-size:16px;">
          <span>📷</span><span>🎥</span><span>📊</span><span>🎉</span>
        </div>
        <div class="post-btn">Post</div>
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "marquee-banner-1400x560" -Width 1400 -Height 560 -HtmlContent $html_marquee -OutputDir $promoDir

Write-Host "=== Generating Store Screenshots (1280x800) ==="

# Screenshot 1: Hero LinkedIn Editor
$html_s1 = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1280px; height: 800px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FB 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 36px 50px 30px 50px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.18);
  }
  .header-meta {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;
  }
  .num-pill {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2; font-size: 12px;
    font-weight: 800; padding: 4px 12px; border-radius: 20px;
    text-transform: uppercase; letter-spacing: 0.6px;
  }
  .headline-group {
    margin-bottom: 16px;
  }
  .headline {
    font-size: 34px; font-weight: 800; color: #1B1F23; letter-spacing: -0.6px; line-height: 1.2;
  }
  .headline span {
    color: #0A66C2;
  }
  .subheadline {
    font-size: 16px; color: #5E6E7E; font-weight: 500; margin-top: 4px;
  }
  .browser-window {
    background: #FFFFFF; border-radius: 16px;
    border: 1px solid rgba(10, 102, 194, 0.22);
    box-shadow: 0 20px 48px rgba(10, 102, 194, 0.14), 0 4px 12px rgba(0, 0, 0, 0.05);
    display: flex; flex-direction: column; overflow: hidden; flex: 1;
  }
  .browser-bar {
    background: #F8FAFC; padding: 10px 18px; border-bottom: 1px solid #E2E8F0;
    display: flex; align-items: center; gap: 14px;
  }
  .dots {
    display: flex; gap: 6px;
  }
  .dot {
    width: 10px; height: 10px; border-radius: 50%;
  }
  .url-box {
    background: #FFFFFF; border: 1px solid #CBD5E1; border-radius: 6px;
    padding: 4px 12px; font-size: 12px; color: #64748B; flex: 1; max-width: 420px;
  }
  .editor-content {
    padding: 24px 32px; display: flex; flex-direction: column; justify-content: space-between; flex: 1;
  }
  .user-bar {
    display: flex; align-items: center; gap: 14px;
  }
  .avatar {
    width: 48px; height: 48px; border-radius: 50%;
    background: linear-gradient(135deg, #0A66C2 0%, #004182 100%);
    color: #FFF; font-weight: 700; font-size: 16px;
    display: flex; align-items: center; justify-content: center;
  }
  .post-body {
    font-size: 18px; line-height: 1.6; color: #1E293B; margin-top: 16px;
  }
  .highlight-box {
    background: rgba(10, 102, 194, 0.12);
    color: #0A66C2; font-weight: 800; padding: 4px 8px; border-radius: 6px;
    border-left: 4px solid #0A66C2; display: inline-block;
  }
  .action-bubble {
    display: inline-flex; align-items: center; gap: 8px;
    background: #1B1F23; color: #FFFFFF; padding: 8px 16px; border-radius: 20px;
    font-size: 13px; font-weight: 700; box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    margin-top: 14px; width: fit-content;
  }
  .bottom-toolbar {
    display: flex; align-items: center; justify-content: space-between;
    padding-top: 16px; border-top: 1px solid #F1F5F9;
  }
  .post-btn {
    background: #0A66C2; color: #FFFFFF; font-weight: 700; font-size: 15px;
    padding: 10px 28px; border-radius: 24px; border: none;
  }
</style>
</head>
<body>
  <div class="header-meta">
    <div class="num-pill">Screenshot 01 / Core Feature</div>
    <div style="font-size: 13px; font-weight: 700; color: #0A66C2;">LinkedIn Rich Text Shortcuts</div>
  </div>
  <div class="headline-group">
    <div class="headline">The Native Shortcut <span>LinkedIn Forgot</span></div>
    <div class="subheadline">Press Ctrl+B or Cmd+B to format bold text directly inside LinkedIn's editor.</div>
  </div>
  <div class="browser-window">
    <div class="browser-bar">
      <div class="dots">
        <div class="dot" style="background:#EF4444;"></div>
        <div class="dot" style="background:#F59E0B;"></div>
        <div class="dot" style="background:#10B981;"></div>
      </div>
      <div class="url-box">https://www.linkedin.com/feed/</div>
    </div>
    <div class="editor-content">
      <div>
        <div class="user-bar">
          <div class="avatar">AR</div>
          <div>
            <div style="font-size: 16px; font-weight: 700; color: #1B1F23;">Alex Rivera · 1st</div>
            <div style="font-size: 13px; color: #64748B;">Founder & Content Strategist · Anyone 🌐</div>
          </div>
        </div>
        <div class="post-body">
          Most LinkedIn posts get lost in the feed within minutes.<br><br>
          <span class="highlight-box">Here is the simple truth about high-performing posts:</span><br><br>
          Clear formatting guides your reader's eyes directly to the core insight.<br>
          No font generator websites. No broken unicode characters.
        </div>
        <div class="action-bubble">
          <span style="color: #60A5FA;">⚡ Shortcut Fired:</span>
          <span>Ctrl+B / Cmd+B Applied Native Bold</span>
        </div>
      </div>
      <div class="bottom-toolbar">
        <div style="display:flex; gap:16px; color:#64748B; font-size:18px;">
          <span>📷</span><span>🎥</span><span>📊</span><span>🎉</span><span>💼</span>
        </div>
        <div class="post-btn">Post</div>
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "screenshot-1-hero-editor" -Width 1280 -Height 800 -HtmlContent $html_s1 -OutputDir $screenDir

# Screenshot 2: How It Works in 3 Steps
$html_s2 = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1280px; height: 800px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FB 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 36px 50px 30px 50px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.18);
  }
  .header-meta {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;
  }
  .num-pill {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2; font-size: 12px;
    font-weight: 800; padding: 4px 12px; border-radius: 20px;
    text-transform: uppercase; letter-spacing: 0.6px;
  }
  .headline-group {
    margin-bottom: 16px;
  }
  .headline {
    font-size: 34px; font-weight: 800; color: #1B1F23; letter-spacing: -0.6px; line-height: 1.2;
  }
  .headline span {
    color: #0A66C2;
  }
  .subheadline {
    font-size: 16px; color: #5E6E7E; font-weight: 500; margin-top: 4px;
  }
  .steps-grid {
    display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; flex: 1; align-items: stretch;
  }
  .step-card {
    background: #FFFFFF; border-radius: 16px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 16px 32px rgba(10, 102, 194, 0.1), 0 2px 8px rgba(0, 0, 0, 0.04);
    padding: 26px 22px; display: flex; flex-direction: column; justify-content: space-between;
  }
  .step-number {
    font-size: 13px; font-weight: 800; color: #0A66C2; letter-spacing: 1px;
    text-transform: uppercase; margin-bottom: 6px;
  }
  .step-title {
    font-size: 20px; font-weight: 800; color: #1B1F23; margin-bottom: 14px;
  }
  .step-box {
    background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 12px;
    padding: 20px 16px; min-height: 200px; display: flex; flex-direction: column;
    align-items: center; justify-content: center; text-align: center; margin-bottom: 14px;
  }
  .step-desc {
    font-size: 14px; color: #475569; line-height: 1.45; font-weight: 500;
  }
  .key {
    background: linear-gradient(180deg, #FFFFFF 0%, #EDF2F7 100%);
    border: 1px solid #CBD5E1; border-bottom: 4px solid #94A3B8;
    border-radius: 8px; padding: 8px 16px; font-size: 16px; font-weight: 800;
    color: #1E293B; box-shadow: 0 4px 8px rgba(0,0,0,0.06);
  }
  .selection-pill {
    background: #BFDBFE; color: #1E3A8A; font-weight: 600; padding: 4px 10px;
    border-radius: 4px; font-size: 15px; border: 1px dashed #3B82F6;
  }
  .bold-pill {
    background: #DCFCE7; color: #166534; font-weight: 800; padding: 6px 14px;
    border-radius: 6px; font-size: 16px; border: 1px solid #86EFAC;
  }
</style>
</head>
<body>
  <div class="header-meta">
    <div class="num-pill">Screenshot 02 / Workflow</div>
    <div style="font-size: 13px; font-weight: 700; color: #0A66C2;">LinkedIn Rich Text Shortcuts</div>
  </div>
  <div class="headline-group">
    <div class="headline">How It Works in <span>3 Simple Steps</span></div>
    <div class="subheadline">No copy-pasting. No external converter tabs. Just pure muscle memory.</div>
  </div>
  <div class="steps-grid">
    <div class="step-card">
      <div>
        <div class="step-number">Step 01</div>
        <div class="step-title">Select Your Text</div>
        <div class="step-box">
          <div style="font-size:12px; color:#64748B; margin-bottom:12px;">LinkedIn Post Editor</div>
          <div class="selection-pill">Highlight this sentence</div>
          <div style="font-size:11px; color:#94A3B8; margin-top:14px;">Cursor selects text</div>
        </div>
      </div>
      <div class="step-desc">Highlight any word, phrase, or sentence in your post, comment, reply, or DM.</div>
    </div>
    <div class="step-card">
      <div>
        <div class="step-number">Step 02</div>
        <div class="step-title">Press Ctrl+B or Cmd+B</div>
        <div class="step-box">
          <div style="display:flex; align-items:center; gap:8px;">
            <span class="key">Ctrl</span>
            <span style="font-size:18px; font-weight:700; color:#64748B;">+</span>
            <span class="key">B</span>
          </div>
          <div style="font-size:12px; color:#64748B; margin: 12px 0 4px 0;">or on Mac:</div>
          <div style="display:flex; align-items:center; gap:8px;">
            <span class="key">Cmd</span>
            <span style="font-size:18px; font-weight:700; color:#64748B;">+</span>
            <span class="key">B</span>
          </div>
        </div>
      </div>
      <div class="step-desc">Works with standard keyboard shortcuts you already use in Word, Google Docs, and Notion.</div>
    </div>
    <div class="step-card">
      <div>
        <div class="step-number">Step 03</div>
        <div class="step-title">Instant Native Bold</div>
        <div class="step-box">
          <div style="font-size:24px; margin-bottom:8px;">✓</div>
          <div class="bold-pill">Highlight this sentence</div>
          <div style="font-size:11px; color:#15803D; font-weight:700; margin-top:12px;">Real HTML Strong Element</div>
        </div>
      </div>
      <div class="step-desc">Formatted directly via LinkedIn's native editor engine. Stays bold on mobile and desktop.</div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "screenshot-2-how-it-works" -Width 1280 -Height 800 -HtmlContent $html_s2 -OutputDir $screenDir

# Screenshot 3: Native Bold vs Broken Unicode Fonts
$html_s3 = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1280px; height: 800px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FB 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 36px 50px 30px 50px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.18);
  }
  .header-meta {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;
  }
  .num-pill {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2; font-size: 12px;
    font-weight: 800; padding: 4px 12px; border-radius: 20px;
    text-transform: uppercase; letter-spacing: 0.6px;
  }
  .headline-group {
    margin-bottom: 16px;
  }
  .headline {
    font-size: 34px; font-weight: 800; color: #1B1F23; letter-spacing: -0.6px; line-height: 1.2;
  }
  .headline span {
    color: #0A66C2;
  }
  .subheadline {
    font-size: 16px; color: #5E6E7E; font-weight: 500; margin-top: 4px;
  }
  .compare-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 28px; flex: 1; align-items: stretch;
  }
  .compare-card {
    border-radius: 16px; padding: 26px 28px; display: flex; flex-direction: column; justify-content: space-between;
  }
  .bad-card {
    background: #FFF5F5; border: 1px solid #FECACA;
    box-shadow: 0 12px 28px rgba(239, 68, 68, 0.08);
  }
  .good-card {
    background: #F0FDF4; border: 1px solid #BBF7D0;
    box-shadow: 0 12px 28px rgba(34, 197, 94, 0.1);
  }
  .badge-tag {
    font-size: 12px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.8px;
    padding: 4px 10px; border-radius: 20px; width: fit-content; margin-bottom: 10px;
  }
  .bad-tag { background: #FEE2E2; color: #B91C1C; }
  .good-tag { background: #DCFCE7; color: #15803D; }
  .card-header-title {
    font-size: 20px; font-weight: 800; margin-bottom: 14px;
  }
  .preview-box {
    background: #FFFFFF; border-radius: 10px; padding: 14px 18px; margin-bottom: 18px;
    font-size: 15px; font-weight: 600;
  }
  .bad-preview {
    border: 1px dashed #F87171; color: #991B1B;
  }
  .good-preview {
    border: 1px dashed #4ADE80; color: #166534; font-weight: 800;
  }
  .points-list {
    display: flex; flex-direction: column; gap: 12px;
  }
  .point-item {
    display: flex; align-items: flex-start; gap: 10px; font-size: 14px; line-height: 1.4;
  }
  .point-icon {
    font-size: 16px; flex-shrink: 0; margin-top: 1px;
  }
</style>
</head>
<body>
  <div class="header-meta">
    <div class="num-pill">Screenshot 03 / Accessibility & Reach</div>
    <div style="font-size: 13px; font-weight: 700; color: #0A66C2;">LinkedIn Rich Text Shortcuts</div>
  </div>
  <div class="headline-group">
    <div class="headline">Native Bold vs. <span>Broken Unicode Fonts</span></div>
    <div class="subheadline">Why third-party font generators hurt your reach, reputation, and accessibility.</div>
  </div>
  <div class="compare-grid">
    <div class="compare-card bad-card">
      <div>
        <div class="badge-tag bad-tag">Third-Party Generators (LingoJam, YayText)</div>
        <div class="card-header-title" style="color:#991B1B;">Broken Unicode Math Symbols</div>
        <div class="preview-box bad-preview">
          ?????? ???????????? ???????? ?????? ????????????
        </div>
        <div class="points-list">
          <div class="point-item">
            <span class="point-icon">❌</span>
            <span style="color:#7F1D1D;"><strong>Breaks Screen Readers:</strong> Spells out each character code or skips words entirely.</span>
          </div>
          <div class="point-item">
            <span class="point-icon">❌</span>
            <span style="color:#7F1D1D;"><strong>Invisible to Search:</strong> LinkedIn search and hashtag indexing cannot match math symbols.</span>
          </div>
          <div class="point-item">
            <span class="point-icon">❌</span>
            <span style="color:#7F1D1D;"><strong>Tofu Box Errors:</strong> Renders as blank rectangles (tofu boxes) on older phones.</span>
          </div>
          <div class="point-item">
            <span class="point-icon">❌</span>
            <span style="color:#7F1D1D;"><strong>Spam Penalty:</strong> Excessive unicode symbol density triggers spam filters.</span>
          </div>
        </div>
      </div>
      <div style="font-size:12px; color:#991B1B; font-weight:700; padding-top:10px; border-top:1px solid #FECACA;">
        Hurts organic visibility and accessibility
      </div>
    </div>
    <div class="compare-card good-card">
      <div>
        <div class="badge-tag good-tag">Our Extension</div>
        <div class="card-header-title" style="color:#166534;">True Native Bold Formatting</div>
        <div class="preview-box good-preview">
          Real Native Bold (Standard Characters)
        </div>
        <div class="points-list">
          <div class="point-item">
            <span class="point-icon">✅</span>
            <span style="color:#14532D;"><strong>100% Screen Reader Safe:</strong> Reads naturally as words to all visually impaired readers.</span>
          </div>
          <div class="point-item">
            <span class="point-icon">✅</span>
            <span style="color:#14532D;"><strong>Fully Indexed:</strong> Keywords and hashtags remain 100% searchable in LinkedIn's feed.</span>
          </div>
          <div class="point-item">
            <span class="point-icon">✅</span>
            <span style="color:#14532D;"><strong>Universal Rendering:</strong> Looks crisp and perfect across all iOS, Android, and PC screens.</span>
          </div>
          <div class="point-item">
            <span class="point-icon">✅</span>
            <span style="color:#14532D;"><strong>Algorithmic Safe:</strong> Native HTML formatting favored by LinkedIn's algorithm.</span>
          </div>
        </div>
      </div>
      <div style="font-size:12px; color:#15803D; font-weight:700; padding-top:10px; border-top:1px solid #BBF7D0;">
        Built on LinkedIn's native contenteditable engine
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "screenshot-3-native-vs-unicode" -Width 1280 -Height 800 -HtmlContent $html_s3 -OutputDir $screenDir

# Screenshot 4: Universal LinkedIn Support
$html_s4 = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1280px; height: 800px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FB 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 36px 50px 30px 50px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.18);
  }
  .header-meta {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;
  }
  .num-pill {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2; font-size: 12px;
    font-weight: 800; padding: 4px 12px; border-radius: 20px;
    text-transform: uppercase; letter-spacing: 0.6px;
  }
  .headline-group {
    margin-bottom: 16px;
  }
  .headline {
    font-size: 34px; font-weight: 800; color: #1B1F23; letter-spacing: -0.6px; line-height: 1.2;
  }
  .headline span {
    color: #0A66C2;
  }
  .subheadline {
    font-size: 16px; color: #5E6E7E; font-weight: 500; margin-top: 4px;
  }
  .quad-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 20px; flex: 1; align-items: stretch;
  }
  .quad-card {
    background: #FFFFFF; border-radius: 14px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 10px 24px rgba(10, 102, 194, 0.08);
    padding: 20px 22px; display: flex; flex-direction: column; justify-content: space-between;
  }
  .quad-title-bar {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px;
  }
  .quad-title {
    font-size: 16px; font-weight: 800; color: #1B1F23; display: flex; align-items: center; gap: 8px;
  }
  .quad-tag {
    font-size: 11px; font-weight: 700; color: #0A66C2; background: rgba(10, 102, 194, 0.1);
    padding: 3px 8px; border-radius: 12px;
  }
  .snippet-box {
    background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 8px;
    padding: 12px 14px; font-size: 13.5px; line-height: 1.5; color: #334155; margin-bottom: 10px;
  }
  .bold-text {
    font-weight: 800; color: #0F172A;
  }
  .platform-bar {
    background: #FFFFFF; border: 1px solid rgba(10, 102, 194, 0.2); border-radius: 12px;
    padding: 12px 24px; display: flex; align-items: center; justify-content: space-between;
    margin-top: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.03);
  }
  .platform-item {
    display: flex; align-items: center; gap: 10px; font-size: 13px; font-weight: 700; color: #334155;
  }
  .key-sm {
    background: linear-gradient(180deg, #FFFFFF 0%, #EDF2F7 100%);
    border: 1px solid #CBD5E1; border-bottom: 3px solid #94A3B8;
    border-radius: 4px; padding: 2px 7px; font-size: 11px; font-weight: 800; color: #1E293B;
  }
</style>
</head>
<body>
  <div class="header-meta">
    <div class="num-pill">Screenshot 04 / Universal Support</div>
    <div style="font-size: 13px; font-weight: 700; color: #0A66C2;">LinkedIn Rich Text Shortcuts</div>
  </div>
  <div class="headline-group">
    <div class="headline">Universal <span>LinkedIn Support</span></div>
    <div class="subheadline">One shortcut works everywhere you write on LinkedIn, across Mac, Windows, and Linux.</div>
  </div>
  <div class="quad-grid">
    <div class="quad-card">
      <div>
        <div class="quad-title-bar">
          <div class="quad-title"><span>📝</span> Feed Posts & Articles</div>
          <div class="quad-tag">Creator Mode</div>
        </div>
        <div class="snippet-box">
          <span class="bold-text">3 Lessons from building in public:</span><br>
          1. Consistency compounds faster than perfection.<br>
          2. <span class="bold-text">Emphasize your main takeaway</span> so readers remember it.
        </div>
      </div>
      <div style="font-size: 11px; color: #64748B;">Supported in main post composer and article editor</div>
    </div>
    <div class="quad-card">
      <div>
        <div class="quad-title-bar">
          <div class="quad-title"><span>💬</span> Post Comments</div>
          <div class="quad-tag">Viral Reach</div>
        </div>
        <div class="snippet-box">
          <span class="bold-text">Spot on insight!</span> Here is why this matters: When your comment leads with formatted bold text, it grabs immediate attention in a 300-comment thread.
        </div>
      </div>
      <div style="font-size: 11px; color: #64748B;">Format bold text directly inside comment boxes</div>
    </div>
    <div class="quad-card">
      <div>
        <div class="quad-title-bar">
          <div class="quad-title"><span>↩️</span> Threaded Replies</div>
          <div class="quad-tag">Discussions</div>
        </div>
        <div class="snippet-box">
          Agree completely. <span class="bold-text">Point #2 is the game-changer</span> for early-stage founders who need rapid feedback.
        </div>
      </div>
      <div style="font-size: 11px; color: #64748B;">Works in nested comment replies and author threads</div>
    </div>
    <div class="quad-card">
      <div>
        <div class="quad-title-bar">
          <div class="quad-title"><span>✉️</span> Direct Messages & InMail</div>
          <div class="quad-tag">Private Chat</div>
        </div>
        <div class="snippet-box">
          Hi Sarah, loved your latest presentation. Would you be open for a quick chat <span class="bold-text">this Thursday at 3 PM EST</span>?
        </div>
      </div>
      <div style="font-size: 11px; color: #64748B;">Format important meeting dates and action items in DMs</div>
    </div>
  </div>
  <div class="platform-bar">
    <div class="platform-item">
      <span>Windows & Linux:</span>
      <span class="key-sm">Ctrl</span> + <span class="key-sm">B</span>
    </div>
    <div class="platform-item">
      <span>macOS:</span>
      <span class="key-sm">Cmd</span> + <span class="key-sm">B</span>
    </div>
    <div style="font-size: 12px; color: #64748B; font-weight: 600;">
      Compatible with Chrome, Brave, Edge, Opera, and Arc
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "screenshot-4-universal-support" -Width 1280 -Height 800 -HtmlContent $html_s4 -OutputDir $screenDir

# Screenshot 5: Built for Privacy
$html_s5 = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1280px; height: 800px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FB 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 36px 50px 30px 50px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.18);
  }
  .header-meta {
    display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;
  }
  .num-pill {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2; font-size: 12px;
    font-weight: 800; padding: 4px 12px; border-radius: 20px;
    text-transform: uppercase; letter-spacing: 0.6px;
  }
  .headline-group {
    margin-bottom: 16px;
  }
  .headline {
    font-size: 34px; font-weight: 800; color: #1B1F23; letter-spacing: -0.6px; line-height: 1.2;
  }
  .headline span {
    color: #0A66C2;
  }
  .subheadline {
    font-size: 16px; color: #5E6E7E; font-weight: 500; margin-top: 4px;
  }
  .trust-banner {
    background: #FFFFFF; border-radius: 16px;
    border: 1px solid rgba(10, 102, 194, 0.22);
    box-shadow: 0 16px 36px rgba(10, 102, 194, 0.1);
    padding: 24px 30px; display: flex; align-items: center; gap: 24px; margin-bottom: 20px;
  }
  .shield-icon {
    width: 72px; height: 72px; border-radius: 18px;
    background: linear-gradient(135deg, #0A66C2 0%, #004182 100%);
    color: #FFFFFF; font-size: 34px; display: flex; align-items: center; justify-content: center;
    box-shadow: 0 8px 20px rgba(10, 102, 194, 0.3); flex-shrink: 0;
  }
  .trust-title {
    font-size: 20px; font-weight: 800; color: #1B1F23;
  }
  .trust-desc {
    font-size: 14.5px; color: #475569; margin-top: 4px; line-height: 1.45;
  }
  .assurance-grid {
    display: grid; grid-template-columns: 1fr 1fr; gap: 20px; flex: 1; align-items: stretch;
  }
  .card-item {
    background: #FFFFFF; border: 1px solid rgba(10, 102, 194, 0.16);
    border-radius: 14px; padding: 20px 22px; display: flex; flex-direction: column; justify-content: space-between;
    box-shadow: 0 4px 12px rgba(10, 102, 194, 0.05);
  }
  .item-top {
    display: flex; align-items: center; gap: 12px; margin-bottom: 8px;
  }
  .item-icon {
    font-size: 20px;
  }
  .item-title {
    font-size: 16px; font-weight: 800; color: #1B1F23;
  }
  .item-desc {
    font-size: 13.5px; color: #475569; line-height: 1.45; font-weight: 500;
  }
  .footer-seal {
    background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 10px;
    padding: 10px 20px; display: flex; align-items: center; justify-content: space-between;
    font-size: 12px; font-weight: 700; color: #0A66C2; margin-top: 16px;
  }
</style>
</head>
<body>
  <div class="header-meta">
    <div class="num-pill">Screenshot 05 / Privacy First</div>
    <div style="font-size: 13px; font-weight: 700; color: #0A66C2;">LinkedIn Rich Text Shortcuts</div>
  </div>
  <div class="headline-group">
    <div class="headline">Built for Privacy. <span>Zero Tracking.</span></div>
    <div class="subheadline">We do not want your data. We just want your bold shortcut to work.</div>
  </div>
  <div class="trust-banner">
    <div class="shield-icon">🛡️</div>
    <div>
      <div class="trust-title">100% Client-Side Architecture</div>
      <div class="trust-desc">This extension runs completely in your local browser sandbox. It intercepts keyboard events, applies bold formatting to the active contenteditable element, and does nothing else.</div>
    </div>
  </div>
  <div class="assurance-grid">
    <div class="card-item">
      <div>
        <div class="item-top">
          <span class="item-icon">🌐</span>
          <span class="item-title">Zero Remote Servers</span>
        </div>
        <div class="item-desc">No external API endpoints, backend servers, or cloud dependencies. The extension never connects to the internet.</div>
      </div>
      <div style="font-size:11px; font-weight:700; color:#166534;">Verified: 0 network requests</div>
    </div>
    <div class="card-item">
      <div>
        <div class="item-top">
          <span class="item-icon">📊</span>
          <span class="item-title">Zero Analytics or Telemetry</span>
        </div>
        <div class="item-desc">No Google Analytics, tracking pixels, or telemetry scripts. We never log what you type or when you post.</div>
      </div>
      <div style="font-size:11px; font-weight:700; color:#166534;">Verified: 0 tracking scripts</div>
    </div>
    <div class="card-item">
      <div>
        <div class="item-top">
          <span class="item-icon">💾</span>
          <span class="item-title">Zero Stored Data</span>
        </div>
        <div class="item-desc">We never read, store, or transmit your drafts, messages, profile, or post content. Nothing is ever saved to disk.</div>
      </div>
      <div style="font-size:11px; font-weight:700; color:#166534;">Verified: 0 storage usage</div>
    </div>
    <div class="card-item">
      <div>
        <div class="item-top">
          <span class="item-icon">🔒</span>
          <span class="item-title">Minimal Permissions</span>
        </div>
        <div class="item-desc">Manifest V3 scoped strictly to linkedin.com. The extension cannot access any other browser tabs or your browsing history.</div>
      </div>
      <div style="font-size:11px; font-weight:700; color:#166534;">Verified: Strict host match</div>
    </div>
  </div>
  <div class="footer-seal">
    <span>Lightweight Extension (~5KB Codebase)</span>
    <span>Manifest V3 Compliant</span>
    <span>Zero Data Collection Certified</span>
  </div>
</body>
</html>
"@
Render-Asset -Name "screenshot-5-privacy-first" -Width 1280 -Height 800 -HtmlContent $html_s5 -OutputDir $screenDir

Write-Host "=== Generating Social Media Creatives ==="

# 1. LinkedIn Post Graphic (1200x627, 1.91:1)
$html_social_li = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1200px; height: 627px; overflow: hidden;
    background: linear-gradient(135deg, #EAF3FB 0%, #FFFFFF 55%, #F0F6FD 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; align-items: center; justify-content: space-between;
    padding: 50px 70px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.2);
  }
  .glow {
    position: absolute; width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.12) 0%, rgba(10, 102, 194, 0) 70%);
    top: -100px; right: 0; border-radius: 50%; pointer-events: none;
  }
  .left-side {
    width: 580px; z-index: 2; display: flex; flex-direction: column; gap: 18px;
  }
  .badge {
    display: inline-flex; align-items: center; gap: 8px;
    background: rgba(10, 102, 194, 0.1); color: #0A66C2;
    padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 800;
    width: fit-content; text-transform: uppercase; letter-spacing: 0.6px;
  }
  .headline {
    font-size: 44px; font-weight: 800; color: #1B1F23; line-height: 1.15;
    letter-spacing: -0.8px;
  }
  .headline span {
    color: #0A66C2;
  }
  .desc {
    font-size: 18px; color: #475569; line-height: 1.45; font-weight: 500;
  }
  .keys-row {
    display: flex; align-items: center; gap: 12px; margin-top: 4px;
  }
  .key {
    background: linear-gradient(180deg, #FFFFFF 0%, #EDF2F7 100%);
    border: 1px solid #CBD5E1; border-bottom: 4px solid #94A3B8;
    border-radius: 8px; padding: 6px 14px; font-size: 15px; font-weight: 800;
    color: #1E293B; box-shadow: 0 4px 8px rgba(0,0,0,0.06);
  }
  .trust-chips {
    display: flex; gap: 16px; font-size: 13px; font-weight: 700; color: #0A66C2; margin-top: 4px;
  }
  .right-side {
    width: 440px; z-index: 2;
  }
  .card {
    background: #FFFFFF; border-radius: 20px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 20px 44px rgba(10, 102, 194, 0.15), 0 4px 12px rgba(0,0,0,0.04);
    padding: 28px;
  }
  .card-avatar {
    width: 44px; height: 44px; border-radius: 50%;
    background: #0A66C2; color: #FFF; font-weight: 700; font-size: 16px;
    display: flex; align-items: center; justify-content: center;
  }
</style>
</head>
<body>
  <div class="glow"></div>
  <div class="left-side">
    <div class="badge">Free Chrome Extension</div>
    <div class="headline">LinkedIn forgot Ctrl+B.<br><span>So we fixed it.</span></div>
    <div class="desc">Format native bold text on posts, comments, and messages in 1 second. No font generator websites. Accessible to screen readers.</div>
    <div class="keys-row">
      <span class="key">Ctrl</span>
      <span style="font-size:16px; font-weight:800; color:#64748B;">+</span>
      <span class="key">B</span>
      <span style="font-size:14px; color:#64748B; margin:0 6px;">or</span>
      <span class="key">Cmd</span>
      <span style="font-size:16px; font-weight:800; color:#64748B;">+</span>
      <span class="key">B</span>
    </div>
    <div class="trust-chips">
      <span>✓ 100% Native Bold</span>
      <span>✓ Screen Reader Safe</span>
      <span>✓ Zero Tracking</span>
    </div>
  </div>
  <div class="right-side">
    <div class="card">
      <div style="display:flex; align-items:center; gap:12px; margin-bottom:16px;">
        <div class="card-avatar">AR</div>
        <div>
          <div style="font-size:15px; font-weight:700; color:#1B1F23;">Alex Rivera</div>
          <div style="font-size:12px; color:#64748B;">Founder & Content Strategist</div>
        </div>
      </div>
      <div style="font-size:15px; line-height:1.55; color:#334155; margin-bottom:16px;">
        Stop using broken font generators that hurt your reach.<br><br>
        <span style="background:rgba(10,102,194,0.12); color:#0A66C2; font-weight:800; padding:2px 6px; border-radius:4px;">Native bold formatting is here.</span><br><br>
        Press Ctrl+B or Cmd+B to format at the speed of thought.
      </div>
      <div style="background:#0A66C2; color:#FFF; font-weight:700; font-size:13px; padding:8px 18px; border-radius:18px; width:fit-content;">
        Post to LinkedIn
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "linkedin-post-graphic" -Width 1200 -Height 627 -HtmlContent $html_social_li -OutputDir $socialDir

# 2. Twitter/X Card (1200x675, 16:9)
$html_social_tw = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1200px; height: 675px; overflow: hidden;
    background: #10151C;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; align-items: center; justify-content: space-between;
    padding: 60px 80px; position: relative;
    border: 1px solid rgba(255, 255, 255, 0.1);
  }
  .glow-blue {
    position: absolute; width: 550px; height: 550px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.25) 0%, rgba(10, 102, 194, 0) 70%);
    top: -100px; right: -50px; border-radius: 50%; pointer-events: none;
  }
  .left-col {
    width: 580px; z-index: 2; display: flex; flex-direction: column; gap: 20px;
  }
  .tag {
    display: inline-flex; align-items: center; gap: 8px;
    background: rgba(10, 102, 194, 0.2); color: #38BDF8;
    padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 800;
    width: fit-content; text-transform: uppercase; letter-spacing: 0.6px;
    border: 1px solid rgba(56, 189, 248, 0.3);
  }
  .headline {
    font-size: 46px; font-weight: 800; color: #FFFFFF; line-height: 1.15;
    letter-spacing: -0.8px;
  }
  .headline span {
    color: #38BDF8;
  }
  .desc {
    font-size: 18px; color: #94A3B8; line-height: 1.45; font-weight: 500;
  }
  .key-group {
    display: flex; align-items: center; gap: 12px; margin-top: 4px;
  }
  .key {
    background: linear-gradient(180deg, #1E293B 0%, #0F172A 100%);
    border: 1px solid #334155; border-bottom: 4px solid #0284C7;
    border-radius: 8px; padding: 8px 16px; font-size: 16px; font-weight: 800;
    color: #F8FAFC; box-shadow: 0 4px 12px rgba(0,0,0,0.4);
  }
  .right-col {
    width: 420px; z-index: 2;
  }
  .glass-card {
    background: rgba(30, 41, 59, 0.7); backdrop-filter: blur(12px);
    border: 1px solid rgba(56, 189, 248, 0.25); border-radius: 20px;
    padding: 30px; box-shadow: 0 24px 48px rgba(0, 0, 0, 0.5);
  }
  .compare-row {
    margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  }
  .label-bad { color: #F87171; font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
  .text-bad { color: #FECACA; font-size: 14px; text-decoration: line-through; }
  .label-good { color: #4ADE80; font-size: 12px; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; }
  .text-good { color: #FFFFFF; font-size: 16px; font-weight: 800; }
</style>
</head>
<body>
  <div class="glow-blue"></div>
  <div class="left-col">
    <div class="tag">Chrome Extension</div>
    <div class="headline">Stop using broken Unicode fonts <span>on LinkedIn.</span></div>
    <div class="desc">Format real native bold text with Ctrl+B or Cmd+B in 1 second. Screen-reader accessible and zero tracking.</div>
    <div class="key-group">
      <span class="key">Ctrl</span>
      <span style="font-size:16px; font-weight:800; color:#64748B;">+</span>
      <span class="key">B</span>
      <span style="font-size:14px; color:#64748B; margin:0 6px;">or</span>
      <span class="key">Cmd</span>
      <span style="font-size:16px; font-weight:800; color:#64748B;">+</span>
      <span class="key">B</span>
    </div>
    <div style="font-size:13px; color:#38BDF8; font-weight:700;">
      Free on Chrome Web Store · Open Architecture
    </div>
  </div>
  <div class="right-col">
    <div class="glass-card">
      <div class="compare-row">
        <div class="label-bad">❌ Unicode Font Generators</div>
        <div class="text-bad">?????? ???????????? ????????</div>
        <div style="font-size:11px; color:#94A3B8; margin-top:4px;">Breaks screen readers and hurts search</div>
      </div>
      <div>
        <div class="label-good">✅ LinkedIn Rich Text Shortcuts</div>
        <div class="text-good">Real Native Bold Formatting</div>
        <div style="font-size:11px; color:#94A3B8; margin-top:4px;">100% accessible HTML strong element</div>
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "twitter-card" -Width 1200 -Height 675 -HtmlContent $html_social_tw -OutputDir $socialDir

# 3. Product Hunt Gallery Hero (1270x760)
$html_ph = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1270px; height: 760px; overflow: hidden;
    background: linear-gradient(145deg, #EBF3FA 0%, #FFFFFF 50%, #F0F6FD 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 50px 60px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.2);
  }
  .bg-glow-1 {
    position: absolute; width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.12) 0%, rgba(10, 102, 194, 0) 70%);
    top: -100px; right: -50px; border-radius: 50%; pointer-events: none;
  }
  .top-bar {
    display: flex; align-items: center; justify-content: space-between; z-index: 2;
  }
  .ph-badge {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2;
    font-size: 13px; font-weight: 800; padding: 6px 14px; border-radius: 20px;
    letter-spacing: 0.6px; text-transform: uppercase;
  }
  .hero-main {
    z-index: 2; display: flex; align-items: center; justify-content: space-between; margin-top: 10px;
  }
  .hero-left {
    width: 600px; display: flex; flex-direction: column; gap: 16px;
  }
  .hero-title {
    font-size: 44px; font-weight: 800; color: #1B1F23; line-height: 1.15; letter-spacing: -0.8px;
  }
  .hero-title span {
    color: #0A66C2;
  }
  .hero-subtitle {
    font-size: 18px; color: #475569; line-height: 1.45; font-weight: 500;
  }
  .keys-display {
    display: flex; align-items: center; gap: 10px; margin-top: 4px;
  }
  .key {
    background: linear-gradient(180deg, #FFFFFF 0%, #EDF2F7 100%);
    border: 1px solid #CBD5E1; border-bottom: 4px solid #94A3B8;
    border-radius: 8px; padding: 6px 14px; font-size: 15px; font-weight: 800;
    color: #1E293B; box-shadow: 0 4px 8px rgba(0,0,0,0.06);
  }
  .hero-right {
    width: 480px;
  }
  .mockup-card {
    background: #FFFFFF; border-radius: 18px;
    border: 1px solid rgba(10, 102, 194, 0.2);
    box-shadow: 0 20px 44px rgba(10, 102, 194, 0.14);
    padding: 26px;
  }
  .bottom-grid {
    display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; z-index: 2; margin-top: 10px;
  }
  .pill-card {
    background: rgba(255, 255, 255, 0.9); border: 1px solid rgba(10, 102, 194, 0.16);
    border-radius: 12px; padding: 14px 18px; display: flex; align-items: center; gap: 14px;
    box-shadow: 0 4px 10px rgba(10, 102, 194, 0.05);
  }
  .pill-icon {
    font-size: 22px;
  }
  .pill-title {
    font-size: 14px; font-weight: 800; color: #1B1F23;
  }
  .pill-sub {
    font-size: 12px; color: #64748B; margin-top: 2px;
  }
</style>
</head>
<body>
  <div class="bg-glow-1"></div>
  <div class="top-bar">
    <div style="display:flex; align-items:center; gap:12px;">
      <img src="$iconPath" style="width:36px; height:36px; border-radius:8px;">
      <div style="font-size:16px; font-weight:800; color:#1B1F23;">LinkedIn Rich Text Shortcuts</div>
    </div>
    <div class="ph-badge">Product Hunt Gallery Hero</div>
  </div>
  <div class="hero-main">
    <div class="hero-left">
      <div class="hero-title">The Native Bold Shortcut <span>for LinkedIn Creators</span></div>
      <div class="hero-subtitle">Highlight text, hit Ctrl+B or Cmd+B, and format rich bold text in posts, comments, and DMs. Fast, accessible, and completely private.</div>
      <div class="keys-display">
        <span class="key">Ctrl</span>
        <span style="font-weight:800; color:#64748B;">+</span>
        <span class="key">B</span>
        <span style="font-size:13px; color:#64748B; margin:0 6px;">or</span>
        <span class="key">Cmd</span>
        <span style="font-weight:800; color:#64748B;">+</span>
        <span class="key">B</span>
      </div>
    </div>
    <div class="hero-right">
      <div class="mockup-card">
        <div style="font-size:12px; font-weight:800; color:#0A66C2; text-transform:uppercase; margin-bottom:12px;">
          Live Post Editor Mockup
        </div>
        <div style="font-size:16px; line-height:1.55; color:#334155; margin-bottom:18px;">
          "High performing creators write with emphasis.<br><br>
          <span style="background:rgba(10,102,194,0.12); color:#0A66C2; font-weight:800; padding:2px 6px; border-radius:4px;">Native bold formatting stops the scroll</span><br><br>
          without breaking accessibility or hurting search reach."
        </div>
        <div style="display:flex; justify-content:space-between; align-items:center; border-top:1px solid #F1F5F9; padding-top:12px;">
          <span style="font-size:12px; color:#64748B; font-weight:600;">100% Client-Side (~5KB)</span>
          <span style="font-size:12px; font-weight:800; color:#0A66C2;">Free Chrome Extension</span>
        </div>
      </div>
    </div>
  </div>
  <div class="bottom-grid">
    <div class="pill-card">
      <div class="pill-icon">⚡</div>
      <div>
        <div class="pill-title">Native Rich Text</div>
        <div class="pill-sub">Uses LinkedIn's contenteditable</div>
      </div>
    </div>
    <div class="pill-card">
      <div class="pill-icon">♿</div>
      <div>
        <div class="pill-title">Screen Reader Safe</div>
        <div class="pill-sub">Zero broken math symbols</div>
      </div>
    </div>
    <div class="pill-card">
      <div class="pill-icon">🔒</div>
      <div>
        <div class="pill-title">Zero Data Tracking</div>
        <div class="pill-sub">Runs 100% locally on device</div>
      </div>
    </div>
  </div>
</body>
</html>
"@
Render-Asset -Name "product-hunt-hero" -Width 1270 -Height 760 -HtmlContent $html_ph -OutputDir $socialDir

Write-Host "=== Generating LinkedIn Carousel Slides (1080x1350) ==="

$carousel_slides = @(
  @{
    Num = 1
    Tag = "Hook"
    Headline = "Why 90% of LinkedIn creators format bold text completely wrong."
    Desc = "If you use font generator websites to make your text bold, you are hurting your reach and blocking screen readers. Here is why."
    BoxTitle = "The Mistake Most Creators Make"
    BoxContent = "Using external tools like LingoJam or YayText that replace letters with mathematical symbols."
    Footer = "Swipe to see the hidden flaw ->"
  },
  @{
    Num = 2
    Tag = "The Hidden Flaw"
    Headline = "Unicode generators replace real letters with math symbols."
    Desc = "When you copy bold text from a font site, it is not actually bold text. It is a set of mathematical alphanumeric symbols."
    BoxTitle = "What Screen Readers Experience"
    BoxContent = "Screen readers read each character code: 'Mathematical Bold Capital T, Mathematical Bold Small E...' or skip the sentence entirely."
    Footer = "Swipe to discover the secret ->"
  },
  @{
    Num = 3
    Tag = "The Secret"
    Headline = "LinkedIn actually has a native bold engine built in."
    Desc = "LinkedIn's post editor fully supports HTML contenteditable rich text. It just never provided a keyboard shortcut to trigger it."
    BoxTitle = "Native Bold vs Fake Fonts"
    BoxContent = "Native bold uses clean HTML formatting that is 100% accessible, fully indexable by search, and favored by LinkedIn's algorithm."
    Footer = "Swipe to see the fix ->"
  },
  @{
    Num = 4
    Tag = "The Solution"
    Headline = "Press Ctrl+B or Cmd+B to format native bold in 1 second."
    Desc = "With LinkedIn Rich Text Shortcuts, you never have to leave LinkedIn again. Highlight your text and hit the shortcut you already know."
    BoxTitle = "Works Everywhere on LinkedIn"
    BoxContent = "Main feed posts, articles, post comments, comment replies, and direct messages across Windows, Mac, and Linux."
    Footer = "Swipe to grab the extension ->"
  },
  @{
    Num = 5
    Tag = "Get Started"
    Headline = "Format bold text at the speed of thought."
    Desc = "Free on the Chrome Web Store. 100% client-side, zero tracking, and lightweight."
    BoxTitle = "LinkedIn Rich Text Shortcuts"
    BoxContent = "Install once. Use everywhere. Elevate your LinkedIn content without breaking accessibility."
    Footer = "Available now on the Chrome Web Store"
  }
)

foreach ($slide in $carousel_slides) {
    $sNum = $slide.Num
    $sTag = $slide.Tag
    $sHead = $slide.Headline
    $sDesc = $slide.Desc
    $sBoxTitle = $slide.BoxTitle
    $sBoxContent = $slide.BoxContent
    $sFoot = $slide.Footer

    $html_slide = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 1080px; height: 1350px; overflow: hidden;
    background: linear-gradient(155deg, #EAF3FB 0%, #FFFFFF 50%, #F0F6FC 100%);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Inter, Helvetica, Arial, sans-serif;
    display: flex; flex-direction: column; justify-content: space-between;
    padding: 80px 80px 70px 80px; position: relative;
    border: 1px solid rgba(10, 102, 194, 0.2);
  }
  .bg-glow {
    position: absolute; width: 600px; height: 600px;
    background: radial-gradient(circle, rgba(10, 102, 194, 0.12) 0%, rgba(10, 102, 194, 0) 70%);
    top: -100px; right: -50px; border-radius: 50%; pointer-events: none;
  }
  .top-meta {
    display: flex; align-items: center; justify-content: space-between; z-index: 2;
  }
  .slide-pill {
    background: rgba(10, 102, 194, 0.1); color: #0A66C2; font-size: 14px;
    font-weight: 800; padding: 6px 16px; border-radius: 20px;
    letter-spacing: 0.8px; text-transform: uppercase;
  }
  .slide-counter {
    font-size: 15px; font-weight: 800; color: #64748B;
  }
  .middle-content {
    z-index: 2; display: flex; flex-direction: column; gap: 32px; margin: 40px 0;
  }
  .slide-headline {
    font-size: 56px; font-weight: 800; color: #1B1F23; line-height: 1.15;
    letter-spacing: -1.2px;
  }
  .slide-desc {
    font-size: 26px; color: #475569; line-height: 1.45; font-weight: 500;
  }
  .feature-box {
    background: #FFFFFF; border-radius: 20px;
    border: 1px solid rgba(10, 102, 194, 0.22);
    box-shadow: 0 20px 48px rgba(10, 102, 194, 0.12);
    padding: 36px 40px; display: flex; flex-direction: column; gap: 14px;
  }
  .box-label {
    font-size: 14px; font-weight: 800; color: #0A66C2; text-transform: uppercase; letter-spacing: 0.8px;
  }
  .box-text {
    font-size: 22px; font-weight: 600; color: #1E293B; line-height: 1.5;
  }
  .bottom-bar {
    display: flex; align-items: center; justify-content: space-between; z-index: 2;
    padding-top: 24px; border-top: 1px solid rgba(10, 102, 194, 0.15);
  }
  .brand-sign {
    display: flex; align-items: center; gap: 12px; font-size: 15px; font-weight: 700; color: #1B1F23;
  }
  .footer-cta {
    font-size: 15px; font-weight: 800; color: #0A66C2;
  }
</style>
</head>
<body>
  <div class="bg-glow"></div>
  <div class="top-meta">
    <div class="slide-pill">$sTag</div>
    <div class="slide-counter">$sNum / 5</div>
  </div>
  <div class="middle-content">
    <div class="slide-headline">$sHead</div>
    <div class="slide-desc">$sDesc</div>
    <div class="feature-box">
      <div class="box-label">$sBoxTitle</div>
      <div class="box-text">$sBoxContent</div>
    </div>
  </div>
  <div class="bottom-bar">
    <div class="brand-sign">
      <img src="$iconPath" style="width:28px; height:28px; border-radius:6px;">
      <span>LinkedIn Rich Text Shortcuts</span>
    </div>
    <div class="footer-cta">$sFoot</div>
  </div>
</body>
</html>
"@
    Render-Asset -Name "carousel-slide-$sNum" -Width 1080 -Height 1350 -HtmlContent $html_slide -OutputDir $carouselDir
}

Write-Host "`nAll design assets generated successfully!"
