# Stitch Design Migration Guide - 100% Match

**Purpose:** Complete blueprint for upgrading all Flutter screens to match Stitch design exactly  
**Status:** Design specification document  
**Last Updated:** September 16, 2026

---

## 📋 Overview

This guide provides EXACT specifications for upgrading each screen from basic functionality to pixel-perfect Stitch design match. Include all colors, spacing, shadows, animations, and component patterns.

---

## 🎯 Screen-by-Screen Upgrade Blueprint

### CUSTOMER SCREENS

#### 1. **EXPLORE SCREEN** (Priority: HIGH - Most complex)

**Key Components to Implement:**

##### A. Header (Fixed)
```
Height: 64px (h-16)
Background: surface.withOpacity(0.85) with backdrop blur
Shadow: BoxShadow(color: black.opacity(0.03), blur: 12, offset: 0,1)
Content: Logo + App name (Tongkrongan) | Profile avatar (right)
```

##### B. Location Bar (Sticky)
```
Background: surface
Content:
  - Icon: near_me (primary color, 16px)
  - Text: "Di sekitarmu: {location}" (label-sm, on-surface-variant)
  - Button: "Ubah" (label-sm, primary, underline hover)
Padding: px-margin, py-space-xs
```

##### C. Search Input
```
Height: 48px (h-12)
Icon left: search (secondary, 22px) - pl-11
Icon right: close button in circle (36x36, bg-surface-container)
Background: bg-surface-container-low on blur: bg-surface-container-lowest
Border: rounded-xl
Placeholder: "Cari kafe, kedai, makanan, suasana..."
Shadow: shadow-sm
```

##### D. Distance Filter (Horizontal Scroll)
```
Layout: Flex, overflow-x-auto, no-scrollbar
Items:
  - Label: "Jarak:" (label-sm, with icon)
  - "Semua Jarak" (inactive chip)
  - "< 1 km" (active: bg-primary, text-on-primary, with check icon)
  - "1-3 km", "3-5 km", "> 5 km" (inactive chips)
Chip style:
  - Padding: px-3.5, py-1.5
  - Border-radius: full (rounded-full)
  - Font: label-md
  - Active: bg-primary shadow-sm, check icon visible
  - Inactive: bg-surface-container text-on-surface-variant
  - Transition: all 0.3s
```

##### E. Category Chips (Horizontal Scroll)
```
Format: "☕ Coffee Shop", "🍜 Warkop & Angkringan", etc.
Active (first): bg-primary-fixed text-on-primary-fixed font-bold
Inactive: bg-surface-container-low text-on-surface-variant
Padding: px-3.5 py-1.5
Font: label-md
Border-radius: full
Interactive: active:scale-95, transition-all
```

##### F. Status Filters (Horizontal Scroll)
```
Type 1 - Live Status (Buka Sekarang):
  - Background: bg-tertiary-fixed text-on-tertiary-fixed-variant
  - Dot: w-1.5 h-1.5 bg-tertiary animate-pulse
  - Padding: px-3 py-1

Type 2 - Rating:
  - Icon: star (filled, secondary)
  - Text: "Rating 4.5+"
  - Background: bg-surface-container-lowest/80
  - Shadow: shadow-sm

Type 3 - Promo:
  - Icon: local_offer (primary)
  - Text: "Ada Promo"

Type 4 - Amenities:
  - Icon: wifi (tertiary) / smoking_rooms (outline) / power (secondary)
  - Text: "WiFi Kencang" / "Smoking Area" / "Colokan Banyak"

All: Padding px-3 py-1, border-radius-full, label-sm, shadow-sm, interactive scale
```

##### G. Place Cards
```
Container Style:
  - Background: bg-surface-container-lowest
  - Border-radius: rounded-xl (18px)
  - Shadow: custom shadow-xl
  - Padding: 0 (internal padding in card sections)
  - On tap: active:scale-[0.99], cursor-pointer
  - Margin bottom: space-md

Image Section (Height: 176px):
  - Background: image (fit: cover)
  - Overlay gradient:
    from-black/40 via-transparent to-black/10
    (top to bottom)
  
  Status Pill (top-left):
    - Content: "Buka s/d 23.00" with pulsing dot
    - Background: bg-tertiary text-on-tertiary
    - Dot: w-1.5 h-1.5 bg-tertiary animate-pulse mr-1
    - Padding: px-2.5 py-1
    - Border-radius: full
    - Position: absolute top-2 left-2
    - Shadow: shadow-md
  
  Favorite Button (top-right):
    - Container: bg-surface-container-lowest/90 backdrop-blur-md
    - Icon: favorite (filled, primary)
    - Size: w-9 h-9
    - Border-radius: full
    - Position: absolute top-2 right-2
    - On tap: active:scale-75, transition scale
    - Shadow: shadow-md
  
  Category Badge (bottom-left):
    - Content: "Specialty Coffee & Eatery"
    - Background: bg-inverse-surface/85 backdrop-blur-sm
    - Text: inverse-on-surface
    - Padding: px-2 py-0.5
    - Border-radius: md
    - Position: absolute bottom-2 left-2
    - Font: label-sm font-bold
```

Content Section (Padding: space-md):
  
  Title:
    - Font: headline-sm
    - Weight: w-700
    - Color: on-surface
    - Truncate: 1 line
  
  Location Row:
    - Icon: location_on (primary, 16px) mr-1
    - Text: "Tebet Barat, Jakarta Selatan"
    - Font: body-sm
    - Color: on-surface-variant
  
  Rating Block:
    - Background: bg-secondary-fixed text-on-secondary-fixed
    - Padding: px-2 py-1
    - Border-radius: lg
    - Content: ⭐ "4.8 (94)"
    - Font: label-sm, first number bold
    - Inline: display inline
  
  Vibe Tags (Horizontal Scroll):
    - Background: bg-surface-container-low
    - Text: on-surface-variant
    - Padding: px-2.5 py-1
    - Border-radius: md
    - Font: label-sm
    - Gap: space-xs between items
    - Scrollable if overflow
  
  Action Row (Bottom):
    - Flex: justify-between
    - Left: Status dot + "Buka Sekarang" (green dot + text)
    - Right: Button with arrow icon
      - Background: bg-primary
      - Text: on-primary
      - Padding: px-4 py-2
      - Border-radius: full
      - Icon: arrow_forward (12px) ml-1
      - On tap: active:scale-95
```

---

#### 2. **FAVORITES SCREEN**

**Changes from Explore:**

```
Header:
  - Title: "Tempat Favorit Saya"
  - Subtitle: "Kompilasi spot nongkrong andalan kamu"
  - Badge: inline-flex items-center gap-1
    - Background: bg-primary-fixed text-on-primary-fixed-variant
    - Icon: bookmark (filled)
    - Count: "5 Disimpan"

Filter Chips:
  - All / Buka Sekarang / Tutup/Terkendala
  - Active: bg-primary text-on-primary shadow-md
  - Inactive: bg-surface-container
  - Count badges beside each option

Card Variations:
  1. Normal (Open): Same as Explore
  2. Closed: 
     - Image: grayscale-35% filter
     - Overlay: bg-inverse-surface/35 backdrop-blur
     - Status badge: bg-error-container text-on-error-container
     - Info box: "Tutup Sementara, buka kembali 09.00"
     - Opacity: reduced to 0.85
  3. Renovation:
     - Status badge: bg-secondary-fixed
     - Icon: construction
     - Info: "Sedang direnovasi, estimasi buka: 15 Oct 2024"

Empty State:
  - Centered layout
  - Icon: favorite_border (48px) in circle
  - Title: "Belum Ada Tempat Favorit"
  - CTA: Button "Mulai Eksplor Sekarang" (bg-primary)

Promo Banner (Bottom):
  - Background: gradient from-primary-container to-primary
  - Padding: p-space-md
  - Text: on-primary / on-primary-container
  - Decorative blobs:
    w-36 h-36 bg-on-primary-container/10 rounded-full blur-xl
    w-20 h-20 bg-secondary-container/20 rounded-full blur-md
  - Content: "Jangan lewatkan penawaran menarik!"
```

---

#### 3. **BOOKING SCREEN**

```
Header:
  - Back button
  - Title: "Buat Janji"
  - Location context card (small)

Form Sections:

A. Place Context:
  - Image: 64x64, rounded-lg
  - Badge: bg-surface-container text-on-surface-variant "Booking"
  - Name, location, category
  - Process flow disclaimer (blue box)

B. Input Fields:
  - Height: h-12 (48px)
  - Icon left: absolute left-3
  - Padding: pl-10 pr-space-md
  - Background: bg-surface-container
  - Focus: bg-surface-container-highest
  - Border-radius: rounded-lg
  - Font: body-md

C. PAX Selection:
  - Layout: grid-cols-2
  - Buttons: h-10, px-3, rounded-full, label-md
  - Active: bg-primary text-on-primary shadow-sm
  - Inactive: bg-surface-container
  - Transition: all 0.3s

D. Date/Time Pickers (Pseudo-inputs):
  - Layout: grid-cols-2
  - Icon left: absolute left-3 (primary or secondary)
  - Label: uppercase tracking-wider, label-sm
  - Value: larger bold text below
  - Cursor: pointer
  - Hover: bg-surface-container-low

E. Purpose Chips:
  - Format: "☕ Nongkrong Santai", "💻 Kerja Kelompok", etc.
  - Active: bg-primary text-on-primary shadow-sm
  - Inactive: bg-surface-container
  - Padding: px-3.5 py-2
  - Font: label-md
  - Gap icon-text: gap-1.5
  - Transition: all 0.2s

F. Notes Textarea:
  - Background: bg-surface-container
  - Padding: p-3
  - Focus: bg-surface-container-highest
  - Placeholder: "Catatan tambahan (opsional)"
  - Resize: none
  - Border-radius: rounded-lg

G. Submit Button:
  - Width: w-full
  - Height: h-12
  - Background: bg-primary shadow-md
  - Text: on-primary
  - Border-radius: rounded-full
  - Icon + text layout: flex gap-2
  - Font: label-lg
  - On tap: active:scale-98

H. Active Appointments (Status Cards):
  - Background: bg-surface-container-lowest shadow-lg
  - Padding: p-space-md
  - Status badge: colored pill with dot
  - Info section: bg-surface-container-low p-2.5 rounded-lg
```

---

#### 4. **CHAT SCREEN**

```
Header Context Card:
  - Background: muted
  - Image: 44x44
  - Category badge: bg-surface-container
  - Name, location, "Lihat Info" button
  - Security banner: bg-secondary-fixed/40
    Icon: lock (secondary)
    Text: "Percakapan diteruskan ke Tim Management"

Message Bubbles:

User Message (Right):
  - Background: bg-primary text-on-primary
  - Border-radius: rounded-2xl rounded-br-none
  - Padding: p-3.5
  - Font: body-md
  - Status: done_all icon (primary) + timestamp
  - Max-width: max-w-[85%]
  - On tap: scale animation

Bot Message (Left):
  - Background: bg-surface-container-lowest
  - Border-radius: rounded-2xl rounded-tl-none
  - Badge: bg-tertiary-fixed text-on-tertiary-fixed
    Icon: smart_toy
    Text: "Bot Tongkrongan (Respon Otomatis)"
  - Padding: p-3.5
  - Timestamp below

Agent Message (Left):
  - Badge color: bg-secondary-fixed
  - Icon: support_agent
  - Name: "Sarah - Tim Management Tongkrongan"
  - May contain embedded action cards

Embedded Action Card (In message):
  - Background: bg-surface-container-low
  - Padding: p-3 rounded-xl
  - Icon circle: w-10 h-10 rounded-lg bg-primary-fixed
  - Button: w-full h-9 bg-primary text-on-primary rounded-full

Date Separator:
  - Background: bg-surface-container
  - Padding: px-3 py-1 rounded-full
  - Font: label-sm on-surface-variant

Loading:
  - inline-flex gap-1.5 px-3 py-1
  - Material icon animate-spin

Input Area (Fixed Bottom):
  - Position: fixed bottom-16
  - Background: bg-surface-container-lowest/95 backdrop-blur-md
  - Padding: p-2
  - Border-radius: rounded-2xl
  - Shadow: shadow-xl
  - Layout: flex gap-space-sm
  
  Attachment button: w-10 h-10 rounded-full (icon: attach_file)
  Input field: flex-1 bg-surface-container-low rounded-xl px-3.5 py-2.5
  Send button: w-10 h-10 rounded-full bg-primary shadow-md
  
  On tap: scale animations
```

---

#### 5. **PROFILE SCREEN**

```
Header/Hero Card:
  - Background: bg-surface-container-lowest
  - Padding: p-space-md
  - Border-radius: rounded-xl
  - Shadow: custom shadow-xl
  - Decorative blobs: (absolutely positioned)
    - w-40 h-40 bg-secondary-fixed/40 blur-2xl
    - w-32 h-32 bg-primary-fixed/30 blur-xl
  - Centered layout: flex flex-col items-center text-center

Avatar:
  - Size: 96px (w-24 h-24)
  - Border: 4px gradient from-primary to-secondary-container
  - Shadow: shadow-md
  - Border-radius: rounded-full
  - Verification badge (bottom-right):
    - Icon: verified (primary)
    - Size: 28px (w-7 h-7)
    - Ring: ring-2 ring-surface-container-lowest

Profile Info:
  - Name: headline-md
  - Email/Phone: body-sm on-surface-variant
  - Badge: px-3 py-1 rounded-full
    - Background: bg-secondary-fixed
    - Text: on-secondary-fixed-variant
    - Icon: local_cafe
    - Content: "Member Pro"

Edit Button:
  - Width: w-full
  - Height: h-10
  - Background: bg-surface-container
  - Text: text-primary
  - Font: label-lg
  - Icon + text: gap-2
  - Hover: hover:bg-primary-fixed/40
  - Transition: all 0.3s

Stats Grid (3 columns):
  - Grid: grid-cols-3 gap-space-sm
  - Each card:
    - Background: bg-surface-container-lowest
    - Shadow: custom shadow
    - Padding: p-space-sm
    - Border-radius: rounded-xl
    - Centered text
  - Icon circle: w-9 h-9 rounded-full (color varies: primary/secondary/tertiary)
  - Number: headline-md (bold)
  - Label: label-sm on-surface-variant

Menu Sections:

Section Header:
  - Font: label-md text-primary font-bold
  - Text: uppercase tracking-wider
  - Optional right label

Menu Container:
  - Background: bg-surface-container-lowest
  - Border-radius: rounded-xl
  - Padding: p-space-xs (gap between items)
  - Shadow: custom shadow

Menu Item:
  - Padding: p-space-sm rounded-lg
  - Hover: bg-surface-container-low
  - Active: bg-surface-container
  - Transition: transition-colors 0.3s
  - Layout: flex items-center justify-between

Menu Item Icon:
  - Size: w-10 h-10
  - Border-radius: rounded-full
  - Background: color-coded (primary-fixed/40, secondary-fixed/50, etc.)
  - Icon size: 22px
  - Icon color: matches background shade

Menu Item Content:
  - Title: headline-sm on-surface truncate
  - Subtitle: body-sm on-surface-variant truncate
  - Optional badge: colored pill with count

Toggle Switch (For notifications):
  - Width: w-11 (44px)
  - Height: h-6 (24px)
  - Active: peer-checked:bg-primary
  - Inactive: bg-surface-variant
  - Smooth transition

Logout Modal (Bottom Sheet):
  - Position: fixed, covers screen with overlay
  - Background: bg-black/50 backdrop-blur-sm
  - Modal: bg-surface-container-lowest rounded-t-2xl
  - Drag handle: w-12 h-1.5 bg-surface-variant rounded-full
  - Icon: w-14 h-14 rounded-full bg-error-container text-error
  - Buttons: primary (error) and secondary (surface)
  - Animation: animate-in fade-in slide-in-from-bottom-6

Toast Notification:
  - Position: fixed bottom-20 left-1/2 -translate-x-1/2
  - Background: bg-inverse-surface text-inverse-on-surface
  - Padding: px-4 py-2.5
  - Border-radius: rounded-full
  - Shadow: shadow-lg
  - Icon: check circle (tertiary-fixed)
  - Animation: fade in/out
```

---

### OWNER SCREENS

#### Dashboard, Analytics, Orders, Chat, Profile

**Apply same principles as Customer screens:**
- Use AppTheme constants for colors, spacing, shadows
- Implement stat cards with custom shadows
- Add animations (scale on tap, transitions)
- Match typography system
- Use proper border radius (xl for cards, full for pills)
- Implement proper spacing system

---

### ADMIN SCREENS

**Similar upgrades as Owner screens with Admin-specific components:**
- Verification badges (tertiary-fixed for approved, error for rejected)
- Priority colors (high=error, medium=secondary, low=tertiary)
- Action buttons with proper styling
- Status indicators

---

## 🎨 Animation Specifications

### 1. Pulsing Status Indicator
```dart
Container(
  child: CircleAvatar(
    radius: 3,
    backgroundColor: AppTheme.tertiary,
    child: Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + (_controller.value * 0.3),
            child: child,
          );
        },
        child: CircleAvatar(radius: 3),
      ),
    ),
  ),
).animate(repeat: true, duration: Duration(milliseconds: 1500));
```

### 2. Scale on Tap
```dart
GestureDetector(
  onTap: () {},
  child: ScaleTransition(
    scale: _scaleAnimation,
    child: Container(...),
  ),
);
```

### 3. Slide In Animation (Bottom Sheet)
```dart
SlideTransition(
  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
    .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
  child: widget,
);
```

---

## ✅ Implementation Checklist

### For Each Screen:
- [ ] Colors match AppTheme exactly
- [ ] Spacing uses constants (spaceSm, spaceMd, etc.)
- [ ] Border radius uses constants (radiusLg, radiusXl, radiusFull)
- [ ] Shadows use custom shadow system
- [ ] Typography uses Theme.of(context).textTheme
- [ ] All interactive elements have proper feedback (scale, color change)
- [ ] Safe area insets applied (SafeArea wrapper)
- [ ] Backdrop blur effects where needed
- [ ] Animations smooth (0.2-0.3s transitions)
- [ ] Responsive design tested on mobile
- [ ] Images load with proper error handling
- [ ] Icons use Material Symbols
- [ ] Gradients where specified
- [ ] Overlays with proper opacity

---

## 📱 Mobile Testing

Before considering screen complete:
1. Run on actual Android/iOS device
2. Check touch responsiveness
3. Verify animations are smooth (60 FPS)
4. Test image loading with slow network
5. Verify text doesn't overflow
6. Check safe area handling (notch, home indicator)
7. Test dark mode (if implemented)
8. Verify color contrast (WCAG AA)

---

## 🔄 Progressive Enhancement Order

1. **Core Structure** - Ensure layout is correct
2. **Colors & Spacing** - Apply theme system
3. **Typography** - Match font sizes and weights
4. **Shadows & Depth** - Add custom shadows
5. **Icons** - Use Material Symbols
6. **Animations** - Add interactive feedback
7. **Polish** - Fine-tune spacing and alignment
8. **Testing** - Mobile verification

---

## 📊 Status Tracking

### CUSTOMER SCREENS
- [ ] Explore - 20% complete
- [ ] Favorites - 15% complete
- [ ] Booking - 10% complete
- [ ] Chat - 5% complete
- [ ] Profile - 10% complete

### OWNER SCREENS
- [ ] Dashboard - 5% complete
- [ ] Analytics - 5% complete
- [ ] Orders - 5% complete
- [ ] Chat - 5% complete
- [ ] Profile - 5% complete

### ADMIN SCREENS
- [ ] Dashboard - 5% complete
- [ ] Store Mgmt - 5% complete
- [ ] Content Mgmt - 5% complete
- [ ] Chat/Support - 5% complete

---

**Total Pages:** 14  
**Est. Time to 100%:** 8-12 hours (with focused implementation)  
**Current Status:** Theme system complete (Task #1 ✅)  
**Next Focus:** Explore screen detailed implementation (Task #2)

---

This guide serves as the blueprint for ALL remaining screen upgrades. Each developer can follow this specification to implement screens that match Stitch design 100%.
