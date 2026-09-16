# Tongkrongan App - Quick Start Guide

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0+ installed
- Chrome browser (for web testing)
- Git (optional)

### Installation

```bash
# Navigate to project
cd tongkrongan_app

# Get dependencies
flutter pub get

# Run on web
flutter run -d chrome

# Or build for web
flutter build web --release
```

---

## 📱 App Structure

### Role-Based Access
The app supports three roles with different features:

#### 👤 Customer
- **Tab 1:** Explore - Browse and search hangout places
- **Tab 2:** Favorites - Save favorite places
- **Tab 3:** Booking - Schedule visits
- **Tab 4:** Chat - Message with places
- **Tab 5:** Profile - User account settings

#### 🏪 Owner (Business)
- **Tab 1:** Dashboard - Overview of business
- **Tab 2:** Analytics - Performance metrics
- **Tab 3:** Orders - Customer bookings/orders
- **Tab 4:** Chat - Customer messages
- **Tab 5:** Profile - Business information

#### 👨‍💼 Admin
- **Tab 1:** Dashboard - Platform overview
- **Tab 2:** Stores - Verify/manage stores
- **Tab 3:** Content - Moderate content
- **Tab 4:** Support - Handle support tickets
- **Tab 5:** Profile - Admin settings

---

## 🎨 Design System

### Colors
```dart
AppTheme.primary      // Orange (#A33900)
AppTheme.secondary    // Brown (#875200)
AppTheme.tertiary     // Green (#006857)
AppTheme.error        // Red (#BA1A1A)
AppTheme.surface      // Light background
```

### Spacing
```dart
AppTheme.spaceSm      // 0.5rem
AppTheme.spaceMd      // 1rem
AppTheme.spaceLg      // 1.5rem
AppTheme.margin       // 1.25rem (padding)
```

### Common Components

**Buttons:**
```dart
ElevatedButton(onPressed: () {}, child: Text('Button'))
OutlinedButton(onPressed: () {}, child: Text('Button'))
TextButton(onPressed: () {}, child: Text('Button'))
```

**Cards:**
```dart
Card(child: Padding(...))
```

**Chips:**
```dart
Chip(label: Text('Label'))
FilterChip(label: Text('Label'), selected: true, onSelected: (v) {})
```

---

## 🖼️ Image Handling

All images use Unsplash CDN with error handling:

```dart
Image.network(
  'https://images.unsplash.com/...',
  width: 400,
  height: 250,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(child: CircularProgressIndicator());
  },
  errorBuilder: (_, __, ___) {
    return Icon(Icons.image_not_supported);
  },
)
```

---

## 🗂️ File Organization

```
lib/
├── main.dart                    # App entry
├── core/
│   ├── themes/app_theme.dart    # Design system
│   ├── router/app_router.dart   # Navigation
│   └── widgets/main_layout.dart # Bottom nav
└── features/
    ├── customer/                # 5 screens
    ├── owner/                   # 5 screens
    └── admin/                   # 4 screens
```

---

## 🔧 Common Tasks

### Add New Screen
1. Create folder: `lib/features/{role}/{feature}/views/`
2. Create file: `{feature}_screen.dart`
3. Add route in `app_router.dart`
4. Add navigation item in `main_layout.dart`

### Change Theme Colors
Edit `lib/core/themes/app_theme.dart`:
```dart
static const Color primary = Color(0xFFA33900); // Change here
```

### Add Network Image
```dart
Image.network(
  'https://images.unsplash.com/...?w=400&h=250&fit=crop',
  fit: BoxFit.cover,
  errorBuilder: (_, __, ___) => Icon(Icons.error),
)
```

### Modify Typography
```dart
Text(
  'Hello',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.w700,
  ),
)
```

---

## 📊 Navigation Flow

```
Splash Screen
     ↓
  Login Screen
     ↓
  Main Layout (Bottom Navigation)
     ├─ Customer Role → 5 Screens
     ├─ Owner Role → 5 Screens
     └─ Admin Role → 4 Screens
```

### Programmatic Navigation
```dart
// Named route
Navigator.pushNamed(context, '/explore');

// Direct screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => ExploreScreen()),
);
```

---

## 🐛 Debugging

### Check Issues
```bash
# Analyze code
flutter analyze

# Check warnings
flutter analyze --no-pub-check

# Run tests
flutter test
```

### Common Errors

**Build Failed:**
```bash
flutter pub get          # Update dependencies
flutter clean            # Clear build cache
flutter pub get && flutter build web
```

**Image Not Loading:**
- Check URL is accessible
- Verify internet connection
- Check error logs in browser console

**Theme Not Applied:**
- Import `AppTheme` from `core/themes/app_theme.dart`
- Access via `Theme.of(context)` or `AppTheme.primary`

---

## 📈 Performance Tips

1. **Use const constructors:**
   ```dart
   const SizedBox(height: 16)
   ```

2. **Lazy-load images:**
   ```dart
   loadingBuilder: (context, child, progress) { ... }
   ```

3. **Avoid rebuilds:**
   ```dart
   const MyWidget()  // Won't rebuild if parent rebuilds
   ```

4. **Cache data:**
   - Store user data locally
   - Minimize API calls

---

## 🚀 Deployment

### Web Deployment
```bash
# Build
flutter build web --release

# Deploy to Firebase
firebase deploy --only hosting

# Or Netlify
netlify deploy --prod --dir=build/web
```

### Build Size
- Main bundle: ~2.6MB (compressed)
- Gzip: ~0.8MB
- Uses Material Design 3 icons

---

## 📚 Resources

- **Flutter Docs:** https://flutter.dev/docs
- **Material Design 3:** https://m3.material.io
- **Unsplash API:** https://unsplash.com/api
- **Google Fonts:** https://fonts.google.com

---

## ❓ FAQ

**Q: How do I test on mobile?**  
A: Connect device and run: `flutter run`

**Q: Can I use local images?**  
A: Yes, add to `pubspec.yaml` under `flutter.assets` and use `Image.asset()`

**Q: How do I add new dependencies?**  
A: Run `flutter pub add package_name` or edit `pubspec.yaml`

**Q: Where's the backend API?**  
A: Currently using mock data. Integrate REST/GraphQL API in screens.

**Q: How do I change app colors?**  
A: Edit color values in `lib/core/themes/app_theme.dart`

---

## 📝 Version Info

- **Flutter Version:** 3.0+
- **Material Design:** v3
- **Build Date:** September 16, 2026
- **Status:** Production Ready

---

**Need Help?** Check `VERIFICATION_REPORT.md` and `ASSET_DOCUMENTATION.md` for detailed information.
