---
name: Tongkrongan Modern Lifestyle
colors:
  surface: '#fbf8ff'
  surface-dim: '#dbd9e1'
  surface-bright: '#fbf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f5f2fb'
  surface-container: '#efecf5'
  surface-container-high: '#eae7ef'
  surface-container-highest: '#e4e1ea'
  on-surface: '#1b1b21'
  on-surface-variant: '#594139'
  inverse-surface: '#303036'
  inverse-on-surface: '#f2eff8'
  outline: '#8d7167'
  outline-variant: '#e1bfb4'
  surface-tint: '#a73a00'
  primary: '#a33900'
  on-primary: '#ffffff'
  primary-container: '#ca4b07'
  on-primary-container: '#fffbff'
  inverse-primary: '#ffb599'
  secondary: '#875200'
  on-secondary: '#ffffff'
  secondary-container: '#fdb257'
  on-secondary-container: '#724400'
  tertiary: '#006857'
  on-tertiary: '#ffffff'
  tertiary-container: '#28826f'
  on-tertiary-container: '#f4fffa'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdbce'
  primary-fixed-dim: '#ffb599'
  on-primary-fixed: '#370e00'
  on-primary-fixed-variant: '#7f2b00'
  secondary-fixed: '#ffddba'
  secondary-fixed-dim: '#ffb866'
  on-secondary-fixed: '#2b1700'
  on-secondary-fixed-variant: '#673d00'
  tertiary-fixed: '#9df3db'
  tertiary-fixed-dim: '#81d6c0'
  on-tertiary-fixed: '#002019'
  on-tertiary-fixed-variant: '#005143'
  background: '#fbf8ff'
  on-background: '#1b1b21'
  surface-variant: '#e4e1ea'
typography:
  display:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '800'
    lineHeight: 44px
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 28px
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.4px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system channels the rich, communal ritual of Indonesian youth culture—*nongkrong*—into an intuitive, spirited digital atmosphere. It reflects late-afternoon chats over *es kopi susu*, roadside culinary exploration (*warkop* to specialty roasters), and spontaneous weekend plans with friends.

The tone is warm, lively, candid, and effortless. It avoids cold corporate sterility while rejecting messy chaos, opting instead for a clean, editorialized modern lifestyle aesthetic. The interface induces feelings of comfort, inclusion, and culinary discovery. 

Visual style blends **warm tactile warmth** with **modern humanist minimalism**: generous breathing room, ultra-smooth 18px rounded enclosures, pill micro-elements, and warm-tinted surface layers reminiscent of sun-drenched cafe patios and ceramic mugs.

## Colors

The color palette centers on radiant amber and roasted terracotta tones that evoke warm streetlights, robust Arabica crema, and tropical sunsets.

- **Primary (`#E05A1B`):** Warm Java Terracotta. Used for key call-to-actions, active navigation markers, and vibrant focal points.
- **Secondary (`#D9933B`):** Toasted Amber / Palm Sugar (*Gula Aren*). Used for secondary highlights, badge accents, rating stars, and cozy notification pings.
- **Tertiary (`#1E7B68`):** Pandan Sage / Deep Teal. Acts as an earthy balancing contrast for positive operational signals, eco-badges, verified spots, and "Buka Sekarang" active statuses.
- **Neutral (`#1E1E24`):** Deep Charcoal / Roasted Bean. Provides high-contrast typography without the harshness of pure `#000000`.

### Background & Surface Tiers
- **Base Canvas:** `#FAF7F2` (Warm Oat Milk)—a comfortable, light-reflecting parchment tint.
- **Surface Elevated:** `#FFFFFF`—crisp contrast against the cream background for primary interactive cards.
- **Surface Muted / Well:** `#F2ECE1`—used for search inputs, inactive pill indicators, and divider tracks.
- **Status Tones:**
  - *Buka Sekarang / Dikonfirmasi:* `#0D684E` text on `#E3F5EC` pill fill.
  - *Tutup:* `#9C2A2A` text on `#FCEBEB` pill fill.
  - *Menunggu Konfirmasi:* `#A05E03` text on `#FEF3D6` pill fill.

## Typography

**Plus Jakarta Sans** is the single typeface engine across the product. Born out of modern Indonesian design initiatives, its geometric underpinnings combined with warm humanist terminals create exceptional readability on mobile viewports while retaining a friendly, youthful bounce.

- **Headlines:** Use weights `700` and `800` with tighter tracking (-0.02em) to project welcoming confidence on spot names, curated collections, and welcome greetings (*"Yuk, nongkrong di mana?"*).
- **Body:** Kept at weight `400` with balanced line heights to guarantee effortless skimming of reviews, menu item descriptions, and ambient summaries (e.g., wifi speed, smoking area availability).
- **Labels & Micro-copy:** Leverage weight `600` and `700` for badges, pricing tiers (`$$`), filter counts, and instant status flags.

## Layout & Spacing

The spatial model caters to mobile-first ergonomics with thumb-zone optimization and continuous vertical and horizontal scanning rhythms.

- **Grid Architecture:** 
  - **Mobile (<640px):** Single-column fluid stack with `margin: 1.25rem` (20px) side margins and `gutter: 1rem` (16px) for dual-card feeds. Horizontal carousels bleed to the screen edges with a leading left indent equal to outer margin.
  - **Tablet (640px–1024px):** 6-column fluid structure, 24px outer margin.
  - **Desktop / Web Preview (>1024px):** Centered max-width mobile viewport container (480px) or an expanded 12-column dashboard layout (max-width 1200px).
- **Spacing Rhythm:** Built strictly around a 4px/8px modular scale (`space-xs` = 4px, `space-sm` = 8px, `space-md` = 16px, `space-lg` = 24px, `space-xl` = 32px).
- **Vertical Hierarchy:** Use `space-md` between nested metadata within cards, `space-lg` between feed modules, and `space-xl` between thematic editorial blocks (*"Pilihan Anak Kampus"*, *"Kopi 24 Jam"*).

## Elevation & Depth

Visual depth is communicated through tinted ambient dissipation rather than sterile gray drop shadows, preserving the warm glow of the palette.

- **Level 0 (Flat Base):** `background: #FAF7F2`, no shadow.
- **Level 1 (Feed & Place Cards):** Crisp `#FFFFFF` surface container with warm amber-tinted shadow: `box-shadow: 0 4px 20px -2px rgba(110, 60, 20, 0.06), 0 2px 6px -1px rgba(110, 60, 20, 0.04)`.
- **Level 2 (Floating Action Buttons & Active Chips):** `box-shadow: 0 8px 24px -4px rgba(224, 90, 27, 0.22)`. Elevates primary interactive triggers above card stacks.
- **Level 3 (Modals & Bottom Navigation Bar):** Ultra-smooth diffuse occlusion: `box-shadow: 0 -4px 24px 0 rgba(30, 30, 36, 0.05)`.
- **Borders as Structure:** Low-contrast hairline dividers (`1px solid rgba(30, 30, 36, 0.06)`) are used sparingly on light cards to maintain separation when elevated cards overlap complex photography.

## Shapes

The design system establishes a distinctive, hyper-tactile signature tailored specifically for friendly lifestyle interactions:

- **Cards & Large Panels:** Enforced fixed corner radius of **18px** (`1.125rem`). This curvature softens photography previews, review tiles, and map previews.
- **Chips, Badges & Buttons:** Fully rounded pill shapes (`border-radius: 9999px`) to create natural contrast against the squircle geometry of the cards.
- **Input Fields:** Set at `14px` (`0.875rem`) to feel cohesive with the 18px cards while preserving structured rectangular ergonomics for text input.

## Components

### 1. Cards (Spot Discovery & Nongkrong Hubs)
- **Geometry:** `border-radius: 18px`, `background: #FFFFFF`, Level 1 ambient warm shadow.
- **Layout:** Top 16:10 or 1:1 rounded image container with floating top-left status pill badge and top-right bookmark circle.
- **Content Block:** Padding `1rem`. Spot name in `headline-sm`, followed by a metadata row (e.g., `Bintang 4.8 · Senopati · Kopi & Roti · $$`), and bottom tags (e.g., "Colokan Banyak", "Outdoor Luas").

### 2. Status Badges
Pill components (`rounded-full`, padding: `4px 10px`, typography: `label-sm`):
- **Buka Sekarang:** `#E3F5EC` background with `#0D684E` text and a 6px pulsing emerald dot.
- **Tutup:** `#FCEBEB` background with `#9C2A2A` text.
- **Menunggu Konfirmasi:** `#FEF3D6` background with `#A05E03` text.
- **Dikonfirmasi:** `#E3F5EC` background with `#0D684E` text alongside a checkmark icon.

### 3. Category & Filter Chips
- **Idle State:** Surface `#F2ECE1`, text `#1E1E24`, `label-md`, height 36px, `border-radius: 9999px`.
- **Selected State:** Primary `#E05A1B` background, `#FFFFFF` text, Level 2 amber glow shadow.
- **Variants:** Accompanied by micro-emojis or minimalist dual-tone outline icons (e.g., ☕ *Kopi Santai*, 📶 *WFC Ready*, 🎸 *Live Music*).

### 4. Buttons
- **Primary Action (e.g., "Ajak Teman", "Rute ke Sini"):** Height 48px, solid `#E05A1B`, text `#FFFFFF` in `label-lg`, `border-radius: 9999px`, Level 2 shadow.
- **Secondary Action (e.g., "Lihat Menu"):** Height 48px, outline `1.5px solid #E05A1B`, text `#E05A1B`, transparent background.
- **Tertiary/Ghost:** Height 40px, text `#1E1E24`, zero border.

### 5. Input Fields
- **Search Bar:** Height 50px, `background: #F2ECE1`, `border-radius: 14px`, leading magnifying glass icon in `#D9933B`, placeholder text in `#8C867A` (`"Cari warkop, kafe hits, atau spot sunset..."`).
- **Focus State:** 2px border in `#E05A1B`, `#FFFFFF` background fill.

### 6. Bottom Navigation Bar
- **Positioning:** Fixed bottom, safe-area padded, `background: rgba(255, 255, 255, 0.94)` with `backdrop-filter: blur(12px)`, top hairline border `rgba(30, 30, 36, 0.05)`.
- **Item Config:** 4-5 items (*Eksplor*, *Komunitas*, *Ajakan*, *Tersimpan*, *Profil*).
- **Active State:** `#E05A1B` icon and label with an active soft pill indicator dot beneath. Inactive items use `#8C867A`.

### 7. Lifestyle-Specific Additions
- **"Split Bill" Calculator Sheet:** High-contrast numeric rows with subtle cream dividers and instant copyable payment links.
- **"Status Meja / Keramaian" Indicator:** Real-time crowd gauge (e.g., *Sepi*, *Pas*, *Rame Banget*) utilizing pill meters with Pandan Sage to Terracotta gradient fills.