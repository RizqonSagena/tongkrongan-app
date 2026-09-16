# Tongkrongan Flutter App - Asset Documentation

**Generated:** September 16, 2026  
**Project:** Tongkrongan Hangout Discovery App  
**Asset Management Strategy:** Cloud-hosted (Unsplash CDN)

---

## Overview

The Tongkrongan Flutter app uses a **cloud-first asset strategy** with Unsplash CDN for images, eliminating the need for local asset management while ensuring high availability and performance.

### Benefits
- ✅ No local asset file bloat
- ✅ Global CDN distribution
- ✅ Automatic caching
- ✅ Free high-quality images
- ✅ Responsive image delivery
- ✅ No build size increase

---

## Asset Categories & References

### 1. Images - Network URLs

All images are served from **Unsplash CDN** with query parameters for optimization:
- `w={width}` - Image width in pixels
- `h={height}` - Image height in pixels
- `fit=crop` - Crop to fit specified dimensions
- `crop=face` - Auto-crop to face for avatars

#### Place Card Images
Used in: Explore, Favorites, Booking screens

**Image URLs:**
```
https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400&h=250&fit=crop
https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=250&fit=crop
https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=250&fit=crop
https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400&h=250&fit=crop
```

**Implementation:**
```dart
Image.network(
  place['image'],
  width: double.infinity,
  height: 176,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      color: AppTheme.surfaceContainer,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return Container(
      color: AppTheme.surfaceContainer,
      child: const Icon(
        Icons.image_not_supported,
        size: 48,
        color: AppTheme.outline,
      ),
    );
  },
)
```

#### Avatar Images
Used in: Profile, Chat, Booking screens

**Image URL (User Avatar):**
```
https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop&crop=face
```

**Implementation:**
```dart
CircleAvatar(
  radius: 20,
  backgroundImage: NetworkImage(
    'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop&crop=face',
  ),
)
```

---

### 2. Icons - Material Design 3

The app uses **Material Symbols Outlined** from Google Fonts (included in Flutter Material package).

#### Icon Reference Guide

| Icon Name | Used In | Context |
|-----------|---------|---------|
| `explore` | Customer Bottom Nav | Browse places |
| `favorite` / `favorite_outline` | Customer Bottom Nav | Saved favorites |
| `event_note` / `event_note_outlined` | Customer Bottom Nav | Schedule bookings |
| `chat_bubble` / `chat_bubble_outline` | Customer Bottom Nav | Messages |
| `person` / `person_outline` | Bottom Nav (All roles) | Profile menu |
| `dashboard` / `dashboard_outlined` | Owner/Admin Nav | Dashboard |
| `analytics` / `analytics_outlined` | Owner Nav | Business metrics |
| `receipt_long` / `receipt_long_outlined` | Owner Nav | Order history |
| `admin_panel_settings` / `admin_panel_settings_outlined` | Admin Nav | Admin panel |
| `store` / `store_outlined` | Admin Nav | Store management |
| `content_paste` / `content_paste_outlined` | Admin Nav | Content CRUD |
| `support_agent` / `support_agent_outlined` | Admin Nav | Support tickets |
| `search` | Search bar | Find places |
| `near_me` | Location indicator | Current location |
| `star` / `star_outline` | Rating display | Place ratings |
| `local_offer` | Promo indicator | Promotions |
| `wifi` | Amenity filter | WiFi availability |
| `smoking_rooms` | Amenity filter | Smoking area |
| `power` | Amenity filter | Power outlets |
| `check_circle` | Status indicator | Open status |
| `image_not_supported` | Image error fallback | Missing image |
| `clear` | Clear button | Reset search |
| `edit` | Action button | Edit content |
| `delete` | Action button | Remove item |
| `check` | Confirmation | Action complete |
| `close` | Close dialog | Dismiss |
| `expand_more` | Dropdown | Show options |

**Implementation Pattern:**
```dart
Icon(
  Icons.place_name,
  color: AppTheme.primary,
  size: 24,
)
```

---

### 3. Fonts

#### Primary Font: Plus Jakarta Sans
Source: Google Fonts (embedded via CDN in Stitch design)

Font weights used:
- `FontWeight.w400` - Regular (body text)
- `FontWeight.w600` - SemiBold (labels, captions)
- `FontWeight.w700` - Bold (headlines)
- `FontWeight.w800` - ExtraBold (display)

**Note:** Currently using Flutter's default Roboto. To use Plus Jakarta Sans, add to pubspec.yaml:

```yaml
google_fonts: ^6.0.0
```

Then in theme:
```dart
fontFamily: GoogleFonts.plusJakartaSans().fontFamily
```

#### Material Symbols Outlined
Source: Google Fonts (Material Design 3 icons)

Already included via Flutter Material package:
```dart
// Already available in Flutter
Icon(Icons.place) // Uses Material Symbols
```

---

### 4. Theme Colors & Design System

#### Color Palette (Material Design 3)
Located in: `lib/core/themes/app_theme.dart`

**Primary Colors:**
```dart
primary: Color(0xFFA33900)           // Orange
secondary: Color(0xFF875200)          // Brown
tertiary: Color(0xFF006857)           // Green
error: Color(0xFFBA1A1A)              // Red
```

**Surface Colors:**
```dart
surface: Color(0xFFFBF8FF)            // Almost white
surfaceContainer: Color(0xFFEFECF5)   // Light gray
surfaceDim: Color(0xFFDBD9E1)         // Medium gray
```

**Text Colors:**
```dart
onSurface: Color(0xFF1B1B21)          // Dark (text)
onSurfaceVariant: Color(0xFF594139)   // Medium gray (secondary text)
outline: Color(0xFF8D7167)            // Muted gray
```

#### Spacing System
```dart
const margin = 1.25;     // Main padding/margin
const spaceSm = 0.5;     // Small gaps
const spaceMd = 1.0;     // Medium gaps
const spaceLg = 1.5;     // Large gaps
const spaceXl = 2.0;     // Extra large gaps
```

#### Border Radius
```dart
BorderRadius.circular(AppTheme.borderRadiusMd)  // 8px
BorderRadius.circular(AppTheme.borderRadiusLg)  // 12px
BorderRadius.circular(9999)                      // Fully rounded
```

---

## File Structure & Organization

```
lib/
├── main.dart                              # App entry point
├── core/
│   ├── themes/
│   │   └── app_theme.dart                # Color, spacing, typography
│   ├── router/
│   │   └── app_router.dart               # Route definitions
│   └── widgets/
│       └── main_layout.dart              # Bottom nav shell
└── features/
    ├── customer/                         # Customer features (5 screens)
    │   ├── explore/
    │   │   ├── views/
    │   │   │   └── explore_screen.dart
    │   │   └── widgets/
    │   │       ├── place_card.dart
    │   │       ├── filter_chips.dart
    │   │       ├── search_bar_widget.dart
    │   │       └── location_header.dart
    │   ├── favorites/
    │   │   └── views/
    │   │       └── favorites_screen.dart
    │   ├── booking/
    │   │   └── views/
    │   │       └── booking_screen.dart
    │   ├── chat/
    │   │   └── views/
    │   │       └── chat_screen.dart
    │   └── profile/
    │       └── views/
    │           └── profile_screen.dart
    ├── owner/                            # Owner features (5 screens)
    │   ├── dashboard/
    │   │   └── views/
    │   │       └── owner_dashboard_screen.dart
    │   ├── analytics/
    │   │   └── views/
    │   │       └── analytics_screen.dart
    │   ├── orders/
    │   │   └── views/
    │   │       └── orders_screen.dart
    │   ├── chat_management/
    │   │   └── views/
    │   │       └── owner_chat_screen.dart
    │   └── profile/
    │       └── views/
    │           └── owner_profile_screen.dart
    ├── admin/                            # Admin features (4 screens)
    │   ├── dashboard/
    │   │   └── views/
    │   │       └── admin_dashboard_screen.dart
    │   ├── store_management/
    │   │   └── views/
    │   │       └── store_management_screen.dart
    │   ├── content_management/
    │   │   └── views/
    │   │       └── content_management_screen.dart
    │   ├── chat_management/
    │   │   └── views/
    │   │       └── admin_chat_screen.dart
    │   └── profile/
    │       └── views/
    │           └── admin_profile_screen.dart
    └── shared/
        ├── auth/
        │   └── views/
        │       ├── splash_screen.dart
        │       └── login_screen.dart
        └── models/
```

---

## Image Asset Configuration

### Current Configuration
**pubspec.yaml:**
```yaml
flutter:
  uses-material-design: true
  # assets: (commented out - using network images)
  #   - assets/images/
  #   - assets/icons/
```

### Network Image Configuration
All images are fetched from Unsplash CDN with proper error handling:

```dart
Image.network(
  url,
  width: 400,
  height: 250,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    // Show loading indicator during fetch
  },
  errorBuilder: (context, error, stackTrace) {
    // Show fallback UI if image fails
  },
)
```

### To Use Local Assets (Future Enhancement)

1. Create assets folder:
```bash
mkdir -p assets/images
mkdir -p assets/icons
```

2. Add to pubspec.yaml:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
```

3. Reference in code:
```dart
Image.asset('assets/images/placeholder.png')
```

---

## Design Reference Files

### Original Stitch Designs
Located at: `../stitch_tongkrongan_hangout_discovery_app/`

**Customer Screens:**
- `explore_tongkrongan/code.html` → `explore_screen.dart`
- `favorit_tongkrongan/code.html` → `favorites_screen.dart`
- `buat_janji_tongkrongan/code.html` → `booking_screen.dart`
- `chat_management_tongkrongan/code.html` → `chat_screen.dart`
- `akun_tongkrongan/code.html` → `profile_screen.dart`

**Owner Screens:**
- `dashboard_owner_tongkrongan/code.html` → `owner_dashboard_screen.dart`
- `analitik_bisnis_tongkrongan_owner/code.html` → `analytics_screen.dart`
- `janji_temu_tongkrongan_owner/code.html` → `orders_screen.dart`
- `chat_manajemen_tongkrongan_owner/code.html` → `owner_chat_screen.dart`
- Profile screen mapping to owner profile

**Admin Screens:**
- `dashboard_admin_tongkrongan/code.html` → `admin_dashboard_screen.dart`
- `detail_kedai_tongkrongan_admin/code.html` → `store_management_screen.dart`
- `kelola_event_tongkrongan_admin/code.html` → `content_management_screen.dart`
- `chat_manajemen_tongkrongan_admin/code.html` → `admin_chat_screen.dart`

---

## Design System Implementation

### Typography Reference

| Style | Font | Size | Weight | Usage |
|-------|------|------|--------|-------|
| Display | Plus Jakarta Sans | 36px | 800 | Hero titles |
| Headline Large | Plus Jakarta Sans | 28px | 700 | Screen titles |
| Headline Medium | Plus Jakarta Sans | 20px | 700 | Section headers |
| Headline Small | Plus Jakarta Sans | 18px | 600 | Card titles |
| Body Large | Plus Jakarta Sans | 16px | 400 | Main body text |
| Body Medium | Plus Jakarta Sans | 14px | 400 | Description text |
| Body Small | Plus Jakarta Sans | 12px | 400 | Helper text |
| Label Large | Plus Jakarta Sans | 14px | 600 | Button labels |
| Label Medium | Plus Jakarta Sans | 12px | 600 | Chips, tags |
| Label Small | Plus Jakarta Sans | 11px | 700 | Captions |

### Component Library

**Buttons:**
```dart
// Primary Button
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppTheme.primary,
    foregroundColor: AppTheme.onPrimary,
    padding: EdgeInsets.symmetric(
      horizontal: AppTheme.spaceMd * 2,
      vertical: AppTheme.spaceMd,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () {},
  child: Text('Button'),
)

// Secondary Button
OutlinedButton(...)

// Tertiary/Text Button
TextButton(...)
```

**Cards:**
```dart
Card(
  elevation: 0,
  child: Padding(
    padding: EdgeInsets.all(AppTheme.spaceMd),
    child: Column(...),
  ),
)
```

**Chips:**
```dart
Chip(
  label: Text('Label'),
  backgroundColor: AppTheme.surfaceContainer,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
)

FilterChip(
  label: Text('Label'),
  selected: isSelected,
  onSelected: (selected) {},
  selectedColor: AppTheme.primary,
)
```

---

## Performance Optimization

### Image Loading Strategy
1. **Network Images:** Cached by Flutter's ImageCache
2. **Error Handling:** Fallback UI for failed loads
3. **Loading Indicator:** Visible during fetch
4. **URL Parameters:** Query strings for size optimization

### Code Optimization
- Static const values for colors and spacing
- Material Design 3 theme inheritance
- Proper widget rebuild prevention with const constructors
- Efficient list rendering with ListView.separated

### Build Optimization
```bash
# Web build with tree-shaking
flutter build web --release --no-tree-shake-icons

# Analyze for unused imports
flutter analyze
```

---

## Asset Migration Checklist

If migrating from network to local assets:

- [ ] Create `assets/` directory structure
- [ ] Copy/download image files from Unsplash
- [ ] Update `pubspec.yaml` with asset declarations
- [ ] Replace `Image.network()` with `Image.asset()`
- [ ] Update error handling for local assets
- [ ] Test all image loads locally
- [ ] Rebuild app and verify UI
- [ ] Measure app size difference

---

## Troubleshooting

### Images Not Loading
1. **Check URL:** Verify Unsplash link is accessible
2. **Network:** Ensure internet connectivity
3. **CORS:** Unsplash CDN supports CORS
4. **Timeout:** Increase timeout if network is slow

### Icon Not Found
1. Verify icon name in `Icons` class
2. Check Material Symbols library for correct name
3. Use Material Icons reference: https://fonts.google.com/icons

### Theme Not Applied
1. Check `AppTheme` is imported
2. Verify theme passed to `MaterialApp`
3. Use `Theme.of(context)` to access theme values
4. Check for hardcoded color overrides

---

## Future Enhancements

### 1. Icon Assets
```yaml
assets:
  - assets/icons/custom_logo.svg
```

### 2. Custom Fonts
```yaml
fonts:
  - family: PlusJakartaSans
    fonts:
      - asset: assets/fonts/PlusJakartaSans-Regular.ttf
        weight: 400
      - asset: assets/fonts/PlusJakartaSans-Bold.ttf
        weight: 700
```

### 3. Lottie Animations
```dart
Lottie.network('https://lottie.host/...')
```

### 4. Image Caching
```dart
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(imageUrl: url)
```

---

## Summary

**Asset Strategy:** Cloud-first with Unsplash CDN  
**Status:** ✅ Verified and documented  
**All 14 screens:** ✅ Using proper image handling  
**Error handling:** ✅ Implemented across all screens  
**Theme system:** ✅ Centralized in app_theme.dart  
**Icons:** ✅ Material Design 3 via Flutter Material package  

---

**Document Version:** 1.0  
**Last Updated:** September 16, 2026  
**Maintained By:** Development Team
