# Mobile Testing Checklist - All 5 Customer Screens

**Project:** Tongkrongan App - Flutter Mobile  
**Date:** September 16, 2026  
**Scope:** Test all 5 customer screens (Explore, Favorites, Booking, Chat, Profile)  
**Test Devices:** Android + iOS (if available)  
**Status:** Ready for Testing

---

## 📱 Test Environment Setup

### Prerequisites
- Android device or emulator (API level 21+, Android 5.0+)
- iOS device or simulator (iOS 11.0+) - optional
- Flutter SDK latest version
- USB debugging enabled (Android)

### Build and Install

```bash
# Navigate to project
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app

# List connected devices
flutter devices

# Run on device/emulator (debug mode for quick testing)
flutter run

# Or build release for production testing
flutter build apk --release  # Android
flutter build ios --release  # iOS (requires macOS)
```

---

## 🎯 Screen-by-Screen Testing Checklist

### SCREEN 1: EXPLORE SCREEN
**File:** `lib/features/customer/explore/views/explore_screen.dart`

#### A. Header with Backdrop Blur
- [ ] Header displays correctly with blur effect
- [ ] Logo "Tongkrongan" with icon visible and readable
- [ ] Profile avatar loads (or shows fallback icon)
- [ ] Header height appropriate for mobile (~60-64px)
- [ ] No overflow or clipping issues

#### B. Location Bar
- [ ] Location bar displays sticky/fixed position
- [ ] Location icon (near_me) visible with primary color
- [ ] Location text: "Di sekitarmu: Tebet, Jakarta Selatan"
- [ ] "Ubah" button clickable and styled correctly
- [ ] Proper spacing and padding

#### C. Search Input
- [ ] Search bar height is 48px
- [ ] Search icon (secondary color) visible
- [ ] Placeholder text displays correctly
- [ ] Close button appears when text entered
- [ ] Focus state changes background color smoothly
- [ ] No keyboard overlap issues

#### D. Distance Filter Chips (Horizontal Scroll)
- [ ] "Jarak:" label visible
- [ ] Can scroll horizontally through distance options
- [ ] Active chip shows primary color + check icon
- [ ] Inactive chips show correct colors
- [ ] Selection animates smoothly (200ms)
- [ ] Touch targets adequate (min 44px)

#### E. Category Chips (Horizontal Scroll)
- [ ] Emojis display correctly (☕ 🍜 🌇 etc.)
- [ ] Can scroll horizontally
- [ ] Active category shows bold text + primaryFixed color
- [ ] Smooth color animation on selection
- [ ] No text overflow

#### F. Status Filter Chips (Horizontal Scroll)
- [ ] "Buka Sekarang" chip shows **pulsing green dot** ✨
- [ ] Pulsing animation smooth and continuous
- [ ] Rating chip shows star icon
- [ ] Promo chip shows offer icon
- [ ] WiFi/Smoking/Power amenity icons display
- [ ] All chips clickable and filterable

#### G. Place Cards
- [ ] Card images load correctly (or show loading spinner)
- [ ] Image has overlay gradient (dark at top/bottom)
- [ ] Status pill (top-left) shows with pulsing dot
- [ ] Favorite button (top-right) is interactive
- [ ] Favorite animation triggers on tap (scale 0.99)
- [ ] Category badge (bottom-left) visible
- [ ] Rating badge (bottom-right) displays correctly

#### H. Place Card Content
- [ ] Title displays (1-2 lines max)
- [ ] Location with icon visible
- [ ] Tags horizontal scrollable
- [ ] Rating with star icon + count (e.g., "4.8 (94)")
- [ ] "Buka Sekarang" status with dot at bottom
- [ ] "Lihat" button clickable

#### I. Responsive Behavior
- [ ] All elements scale properly for different screen sizes
- [ ] No text cutoff or overflow
- [ ] Images maintain aspect ratio
- [ ] Touch targets meet 44px minimum
- [ ] Horizontal scrolling smooth and responsive

#### J. Performance
- [ ] Images load quickly (or fallback shows)
- [ ] Scrolling is smooth (60 FPS)
- [ ] No frame drops during animation
- [ ] App doesn't freeze when scrolling

---

### SCREEN 2: FAVORITES SCREEN
**File:** `lib/features/customer/favorites/views/favorites_screen.dart`

#### A. Header with Backdrop Blur
- [ ] Header displays "Favorit Saya" + subtitle
- [ ] Backdrop blur effect visible
- [ ] Proper spacing and shadow

#### B. Filter Tabs
- [ ] Tab bar displays: "Semua", "Buka Sekarang", "Tutup/Terkendala"
- [ ] Count badges display in each tab (e.g., "3", "2")
- [ ] Active tab shows primary color background
- [ ] Selected filter updates list correctly
- [ ] Animation smooth (200ms)

#### C. Empty State
- [ ] When no favorites exist, empty state displays
- [ ] Heart icon in circle container
- [ ] "Belum Ada Favorit" message
- [ ] "Jelajahi Tempat" button clickable

#### D. Favorite Cards (Similar to Explore)
- [ ] Card layout matches Explore place cards
- [ ] Status pill shows "Buka s/d 23.00" with **pulsing dot** ✨
- [ ] Favorite button shows filled heart (since favorited)
- [ ] Category badge visible
- [ ] Rating displayed

#### E. Card Content
- [ ] Title and distance aligned properly
- [ ] Location with icon
- [ ] Tags visible and scrollable
- [ ] "Buka Sekarang" status at bottom
- [ ] "Edit" and "Lihat" buttons

#### F. Filter Functionality
- [ ] Switching tabs updates card list
- [ ] Only open venues show in "Buka Sekarang" filter
- [ ] Only closed venues show in "Tutup" filter
- [ ] "Semua" shows all favorites

#### G. Responsive
- [ ] Cards stack properly on mobile
- [ ] No horizontal overflow
- [ ] Images scale correctly

---

### SCREEN 3: BOOKING SCREEN
**File:** `lib/features/customer/booking/views/booking_screen.dart`

#### A. Header
- [ ] Header displays "Jadwal Nongkrongan"
- [ ] Subtitle: "Kelola janji nongkrong bareng teman"
- [ ] Backdrop blur visible

#### B. Tab Bar
- [ ] Shows "Akan Datang" and "Riwayat" tabs
- [ ] Active tab underline animates smoothly (300ms) ✨
- [ ] Tab switching works correctly
- [ ] Border color transitions from transparent to primary

#### C. Booking Cards (Active Tab)
- [ ] Card displays with image (height 140px)
- [ ] Status badge (top-right): "Akan Datang" or "Selesai"
- [ ] Title, location with icon
- [ ] Date/time with calendar icon
- [ ] Member count with people icon
- [ ] "Edit" and "Lihat" buttons

#### D. Empty State
- [ ] When no bookings, shows empty state
- [ ] Icon (calendar or history)
- [ ] "Belum Ada Janji" message
- [ ] "Buat Janji" button if on active tab

#### E. FAB (Floating Action Button)
- [ ] "Buat Janji" button visible at bottom-right
- [ ] Clickable and opens modal

#### F. Booking Form Modal
- [ ] Modal opens with smooth animation
- [ ] Draggable handle at top
- [ ] Form fields visible:
  - [ ] Judul Janji (title input with edit icon)
  - [ ] Tempat Nongkrong (location input with location icon)
  - [ ] Tanggal (date picker, shows calendar on tap)
  - [ ] Jam Mulai (time picker)
  - [ ] Jam Selesai (time picker)
  - [ ] Tujuan Nongkrong (chips: Casual, Rapat, Event)
  - [ ] Jumlah Peserta (quantity buttons: minus/plus)
  - [ ] Catatan (optional textarea)

#### G. Form Interactions
- [ ] Date picker opens calendar on tap
- [ ] Time picker shows time picker dialog on tap
- [ ] Purpose chips toggle selection (smooth 200ms animation)
- [ ] Quantity buttons increment/decrement (1-50 range)
- [ ] Submit button highlights properly
- [ ] Form validation works (if implemented)

#### H. Form Submission
- [ ] Clicking "Buat Janji" closes modal
- [ ] Toast notification shows success message
- [ ] New booking appears in list

#### I. Responsive
- [ ] Modal fills screen properly on mobile
- [ ] Form fields have adequate spacing
- [ ] Keyboard doesn't cover input fields
- [ ] Buttons have minimum 44px height

---

### SCREEN 4: CHAT SCREEN
**File:** `lib/features/customer/chat/views/chat_screen.dart`

#### A. Conversation List (Default View)
- [ ] Header displays "Chat" + subtitle
- [ ] Add button (icon) visible
- [ ] Conversations listed:
  - [ ] Avatar (emoji) displays
  - [ ] Name visible (group or individual)
  - [ ] Last message text (truncated if long)
  - [ ] Time of last message
  - [ ] Unread count badge (if unread > 0)

#### B. Conversation List Features
- [ ] Unread badges show for conversations with new messages
- [ ] Group conversations show group icon indicator
- [ ] Avatar circles have proper border/styling
- [ ] Tap on conversation opens chat detail

#### C. Chat Detail View
- [ ] Header with back button, avatar, name
- [ ] Group conversations show "Grup Komunitas" subtitle
- [ ] Call and info buttons (top-right)
- [ ] Messages display in chronological order (oldest at bottom)

#### D. Message Bubbles
- [ ] User messages (sent) align to right
- [ ] Bot/other messages align to left
- [ ] Bubble colors correct (primary for sent, surface for received)
- [ ] Message text readable
- [ ] Timestamps display below message (format: HH:MM)

#### E. Bot Badge
- [ ] Bot messages show "Bot Support" badge
- [ ] Badge color: tertiary-fixed
- [ ] Badge appears below message bubble

#### F. Embedded Cards
- [ ] Embedded message cards display with border
- [ ] Card header: info icon + title + border color
- [ ] Card content: description text
- [ ] "Bagaimana cara..." action with arrow icon
- [ ] Tap card is interactive (clickable area)

#### G. Message Input Area
- [ ] Fixed at bottom of screen
- [ ] Backdrop blur effect visible ✨
- [ ] Input field with placeholder "Tulis pesan..."
- [ ] Attach file button (paperclip icon)
- [ ] Send button (circular with paper plane icon)
- [ ] Input field background: surface-container

#### H. Input Interactions
- [ ] Typing in input field works
- [ ] Attach button clickable (opens file picker or shows menu)
- [ ] Send button clickable
- [ ] Keyboard doesn't cover input field
- [ ] Message input textarea expands if text is long

#### I. Back Button
- [ ] Tapping back arrow returns to conversation list
- [ ] Previous scroll position preserved (if possible)

#### J. Responsive
- [ ] Message bubbles don't exceed 75% screen width
- [ ] Text wraps properly
- [ ] Input field accessible on mobile keyboard
- [ ] All interactive elements have adequate touch targets

---

### SCREEN 5: PROFILE SCREEN
**File:** `lib/features/customer/profile/views/profile_screen.dart`

#### A. Header
- [ ] Header displays "Profil Saya"
- [ ] Subtitle: "Kelola profil dan pengaturan kamu"
- [ ] Edit button (icon) visible
- [ ] Backdrop blur effect visible

#### B. Hero Card (Profile Information)
- [ ] Gradient background (primary color gradient)
- [ ] Avatar image displays (circular, 80px)
- [ ] Avatar has border (on-primary with 0.3 alpha)
- [ ] Name: "Ahmad Pratama"
- [ ] Username: "@ahmadpratama"
- [ ] Location badge: "Jakarta Selatan • 28 Tahun"
- [ ] Tagline: "Pengunjung setia..."
- [ ] Card has shadow and rounded corners

#### C. Stats Grid
- [ ] Three stat cards display: "24 Dikunjungi", "12 Disimpan", "45 Rating"
- [ ] Stat numbers in primary color
- [ ] Stats properly spaced in grid
- [ ] Cards have surface-container background

#### D. Account Section Menu
- [ ] Section header: "Akun"
- [ ] Menu items:
  - [ ] Edit Profil (person icon)
  - [ ] Verifikasi Akun (verified_user icon)
  - [ ] Keamanan & Privasi (security icon)
- [ ] Items separated by divider lines
- [ ] Chevron icons point right
- [ ] All items clickable

#### E. Preferences Section Menu
- [ ] Section header: "Preferensi"
- [ ] Menu items with toggle switches:
  - [ ] Notifikasi Push (toggle switch)
  - [ ] Mode Gelap (toggle switch)
- [ ] Bahasa menu item with badge: "Indonesia"
- [ ] Toggles switch ON/OFF smoothly
- [ ] State persists when scrolling

#### F. Support Section Menu
- [ ] Section header: "Bantuan & Dukungan"
- [ ] Menu items:
  - [ ] Pusat Bantuan
  - [ ] Laporkan Bug
  - [ ] Tentang Aplikasi (badge: "v1.0.0")
- [ ] All items clickable

#### G. Logout Button
- [ ] Large red button at bottom: "Keluar Akun"
- [ ] Logout icon + text
- [ ] Full width button
- [ ] Error color styling

#### H. Logout Confirmation Modal
- [ ] Modal title: "Keluar Akun?"
- [ ] Confirmation message displayed
- [ ] "Batal" button (cancel)
- [ ] "Keluar" button (red/error color)
- [ ] Modal has rounded corners
- [ ] Proper overlay shadow

#### I. Logout Success
- [ ] After confirming logout, toast notification shows
- [ ] Message: "Berhasil keluar dari akun"
- [ ] Toast has rounded corners and shadow
- [ ] Toast floats above screen

#### J. Toggle Switches
- [ ] Switches toggle ON/OFF
- [ ] Active color: primary
- [ ] Inactive color: outline
- [ ] Track colors animate smoothly

#### K. Responsive
- [ ] All sections stack properly vertically
- [ ] Menu cards have proper spacing
- [ ] Avatar displays correctly on all sizes
- [ ] Buttons have minimum 44px height/width

---

## 🎬 Animation Testing

### Pulsing Status Dots
- [ ] **Explore Screen**: Place card status dot pulses (1500ms loop)
- [ ] **Explore Screen**: "Buka Sekarang" filter chip dot pulses (1500ms loop)
- [ ] **Favorites Screen**: Status pill dot pulses (1500ms loop)
- [ ] **All Pulsing**: Animations are smooth and continuous

### Scale Animations
- [ ] **Explore Screen**: Place card scales 0.99 when favorite tapped
- [ ] **Explore Screen**: Animation completes in 200ms
- [ ] Card returns to normal scale smoothly

### Transition Animations
- [ ] **Explore Screen**: Filter chips animate color on selection (200ms)
- [ ] **Booking Screen**: Tab underline animates border color (300ms)
- [ ] **Profile Screen**: Toggle switches animate smoothly

### Overall Animation Quality
- [ ] All animations run at 60 FPS (no janky motion)
- [ ] No frame drops during scrolling + animation
- [ ] Animations feel responsive (not delayed)
- [ ] Curves are smooth (easeInOut used appropriately)

---

## 📊 Performance & Quality Checks

### Image Loading
- [ ] Images load from Unsplash CDN
- [ ] Loading spinners display while loading
- [ ] Error fallback icons display on network errors
- [ ] No blank/white spaces where images should be

### Scrolling Performance
- [ ] Scrolling is smooth (60 FPS minimum)
- [ ] No lag when scrolling long lists
- [ ] No memory leaks (test with DevTools)
- [ ] Battery consumption reasonable

### Touch & Input
- [ ] All buttons responsive to tap (no delay)
- [ ] Touch targets minimum 44x44 pixels
- [ ] Form inputs focus correctly
- [ ] Keyboard shows/hides appropriately
- [ ] No double-tap required for interactions

### Responsiveness
- [ ] Test on multiple screen sizes:
  - [ ] Small phone (4.5") - e.g., iPhone SE
  - [ ] Standard phone (5.5") - e.g., Pixel 5
  - [ ] Large phone (6.5"+) - e.g., iPhone 14 Pro Max
- [ ] No text overflow or clipping
- [ ] No horizontal scrolling (except intentional)
- [ ] Images scale appropriately

### Colors & Contrast
- [ ] All text meets WCAG AA contrast requirements
- [ ] Colors match Stitch design system
- [ ] Dark mode contrast acceptable (if implemented)
- [ ] No color blind accessibility issues (use Coblis simulator)

### Typography
- [ ] Font sizes readable (min 12pt for body text)
- [ ] Font weights render correctly (400, 500, 600, 700)
- [ ] Line spacing comfortable
- [ ] Emojis display correctly

---

## 🔄 Interaction Testing

### Navigation
- [ ] Bottom navigation bar works
- [ ] Switching between screens smooth
- [ ] Back button in Chat returns to conversation list
- [ ] No navigation stuttering

### Form Interactions
- [ ] Date picker opens and closes smoothly
- [ ] Time picker works correctly
- [ ] Quantity buttons increment/decrement properly
- [ ] Modal opens/closes with animation
- [ ] Keyboard doesn't cover form fields

### Modal & Dialog
- [ ] Logout modal center-aligned
- [ ] Modal has proper backdrop
- [ ] Buttons clickable and respond
- [ ] Modal closes on button tap
- [ ] No stuck modals

### Scrolling
- [ ] Horizontal scroll (chips) smooth and responsive
- [ ] Vertical scroll (lists) smooth
- [ ] Pull-to-refresh (if implemented) works
- [ ] Scroll position preserved when navigating back

---

## 📋 Testing Results Template

### Device Info
- **Device Name:** [e.g., Samsung Galaxy S21]
- **OS Version:** [e.g., Android 12]
- **Screen Size:** [e.g., 6.2"]
- **Flutter Version:** [flutter --version]

### Explore Screen
- Header: ✅ / ⚠️ / ❌ - Notes:
- Location Bar: ✅ / ⚠️ / ❌ - Notes:
- Search: ✅ / ⚠️ / ❌ - Notes:
- Filters: ✅ / ⚠️ / ❌ - Notes:
- Cards: ✅ / ⚠️ / ❌ - Notes:
- Animations: ✅ / ⚠️ / ❌ - Notes:

### Favorites Screen
- Overall: ✅ / ⚠️ / ❌ - Notes:
- Animations: ✅ / ⚠️ / ❌ - Notes:

### Booking Screen
- Overall: ✅ / ⚠️ / ❌ - Notes:
- Form: ✅ / ⚠️ / ❌ - Notes:
- Animations: ✅ / ⚠️ / ❌ - Notes:

### Chat Screen
- Overall: ✅ / ⚠️ / ❌ - Notes:
- Messages: ✅ / ⚠️ / ❌ - Notes:
- Input: ✅ / ⚠️ / ❌ - Notes:

### Profile Screen
- Overall: ✅ / ⚠️ / ❌ - Notes:
- Toggles: ✅ / ⚠️ / ❌ - Notes:
- Logout: ✅ / ⚠️ / ❌ - Notes:

### General
- Performance: ✅ / ⚠️ / ❌ - FPS: ___, Issues: ___
- Responsiveness: ✅ / ⚠️ / ❌ - Notes:
- Bugs Found: [List any issues]

---

## 🐛 Issue Reporting

If issues found, document:
1. **Screen:** Which screen?
2. **Issue:** Detailed description
3. **Steps to Reproduce:** 1. ... 2. ... 3. ...
4. **Expected:** What should happen?
5. **Actual:** What actually happened?
6. **Device:** Android/iOS, version, screen size
7. **Severity:** Critical / High / Medium / Low
8. **Screenshot/Video:** (if possible)

---

## ✅ Sign-Off

**Tester Name:** ___________  
**Date:** ___________  
**Device(s) Tested:** ___________  
**Overall Status:** ✅ PASS / ⚠️ PASS WITH NOTES / ❌ FAIL  
**Notes:**

---

## 📱 Quick Test Commands

```bash
# Run debug build on device
flutter run

# Profile performance
flutter run --profile

# Check performance with DevTools
flutter pub global run devtools

# Generate build report
flutter build apk --analyze-size --release

# Test on specific device
flutter devices  # List devices
flutter run -d <device_id>

# Hot reload during testing
r - hot reload
R - hot restart
q - quit
```

---

**Status:** Ready for Mobile Testing  
**Last Updated:** September 16, 2026  
**Version:** 1.0


---

# 🍎 iOS Testing Setup - Complete Guide

**Purpose:** Set up iOS environment for testing Tongkrongan app on simulator and physical devices  
**Target iOS:** iOS 12.0+  
**Duration:** 2-3 hours setup + testing

---

## Phase 1: Environment Verification

### Step 1.1: Check System Requirements
```bash
# Verify you're on macOS (Windows users need to use remote Mac)
uname -s
# Expected output: Darwin

# Check macOS version (need 10.15+)
sw_vers

# Check Xcode installation
xcode-select -p
# Expected: /Applications/Xcode.app/Contents/Developer
```

**If Xcode not installed:**
```bash
# Install Xcode from App Store or:
xcode-select --install

# Accept Xcode license
sudo xcode-select --reset
sudo xcodebuild -license accept
```

### Step 1.2: Verify Flutter Installation
```bash
# Check Flutter version
flutter --version

# Run full doctor check
flutter doctor -v

# Expected output should show:
# ✓ Flutter SDK
# ✓ Xcode (14.0+)
# ✓ CocoaPods
# ✓ iOS simulator (optional but recommended)
# ✓ Chrome (for DevTools)
```

### Step 1.3: Install CocoaPods (if missing)
```bash
# Install CocoaPods
sudo gem install cocoapods

# Update CocoaPods repo
pod repo update

# Verify installation
pod --version
```

---

## Phase 2: Project Preparation

### Step 2.1: Navigate to Project
```bash
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app

# Verify Flutter project structure
ls -la
# Should see: lib/, pubspec.yaml, ios/, android/, etc.
```

### Step 2.2: Clean Project
```bash
# Remove old build artifacts
flutter clean

# Remove iOS build directory
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf build/

# Get dependencies fresh
flutter pub get

# Upgrade packages (optional, only if needed)
# flutter pub upgrade
```

### Step 2.3: Regenerate iOS Project (if corrupted)
```bash
# Only if ios/ folder is broken:
rm -rf ios/

# Regenerate with iOS support
flutter create --platforms ios .

# This will recreate ios/ directory with proper structure
```

---

## Phase 3: iOS-Specific Configuration

### Step 3.1: Update pubspec.yaml
```bash
# Edit pubspec.yaml and ensure these settings:
```

**File: `pubspec.yaml` (verify these sections)**
```yaml
environment:
  sdk: ">=2.19.0 <4.0.0"

flutter:
  uses-material-design: true
```

### Step 3.2: Install iOS Pods
```bash
cd ios

# Update CocoaPods repo
pod repo update

# Install pods with all dependencies
pod install --repo-update

# If issues, try deep clean:
# rm -rf Pods/
# rm Podfile.lock
# pod install --repo-update --verbose

cd ..
```

**Expected output:**
```
Analyzing dependencies
Downloading dependencies
Installing ...
Pod installation complete!
```

### Step 3.3: Configure Xcode Project
```bash
# Open iOS workspace (NOT .xcodeproj)
open ios/Runner.xcworkspace

# In Xcode:
# 1. Select "Runner" in Project Navigator (left sidebar)
# 2. Go to "General" tab
# 3. Set Display Name: "Tongkrongan"
# 4. Set Bundle Identifier: com.stitch.tongkrongan
# 5. Set Minimum Deployments: iOS 12.0
# 6. Set Version: 1.0.0
# 7. Set Build: 1
```

### Step 3.4: Update Info.plist Permissions
```bash
# Edit ios/Runner/Info.plist
# Add these permissions:
```

**Add to `ios/Runner/Info.plist`:**
```xml
<!-- Camera Permission -->
<key>NSCameraUsageDescription</key>
<string>Kami memerlukan akses kamera untuk menangkap gambar tempat nongkrong</string>

<!-- Photo Library Permission -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Kami memerlukan akses galeri foto Anda untuk mengunggah gambar tempat</string>

<!-- Location Permission -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Kami memerlukan lokasi Anda untuk menampilkan tempat nongkrong terdekat</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Kami memerlukan lokasi Anda untuk menampilkan tempat nongkrong terdekat</string>

<!-- App Support -->
<key>UIApplicationSupportsIndirectInputEvents</key>
<true/>

<key>UIStatusBarStyle</key>
<string>UIStatusBarStyleDarkContent</string>

<key>UISupportedInterfaceOrientations</key>
<array>
  <string>UIInterfaceOrientationPortrait</string>
</array>
```

---

## Phase 4: iOS Simulator Setup

### Step 4.1: List Available Simulators
```bash
# List all available iOS simulators
xcrun simctl list devices

# Output example:
# iPhone 15 Pro (XXXX-XXXX-XXXX) (Booted)
# iPhone 14 (YYYY-YYYY-YYYY) (Shutdown)
```

### Step 4.2: Start Simulator
```bash
# Option 1: Open default simulator
open -a Simulator

# Option 2: Start specific simulator
xcrun simctl boot "iPhone 15 Pro"

# Option 3: Create new simulator if needed
xcrun simctl create "iPhone 15 Test" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-15 \
  com.apple.CoreSimulator.SimRuntime.iOS-17-0
```

### Step 4.3: Verify Simulator Status
```bash
# Check simulator is running
xcrun simctl list devices | grep Booted

# Expected: iPhone 15 Pro (XXXX-XXXX-XXXX) (Booted)
```

---

## Phase 5: Build and Deploy to Simulator

### Step 5.1: Initial Build (Debug Mode)
```bash
# Navigate to project directory
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app

# Get latest dependencies
flutter pub get

# List available devices
flutter devices

# Expected output:
# iPhone 15 Pro (mobile) • XXXX • ios • iOS 17.x
```

### Step 5.2: Run App on Simulator
```bash
# Method 1: Auto-select simulator
flutter run

# Method 2: Specify device
flutter run -d "iPhone 15 Pro"

# Method 3: Run in debug mode (verbose)
flutter run -v -d "iPhone 15 Pro"

# Monitor output:
# ✓ Xcode build complete
# ✓ Launching app
# ✓ App running
```

### Step 5.3: Monitor Console Output
```bash
# While app is running, view logs:
flutter logs

# Or view Xcode console:
# Cmd + Shift + C in Xcode
```

### Step 5.4: Hot Reload During Development
```bash
# App must be running first
# Then in terminal:

r       # Hot reload (preserves state)
R       # Hot restart (rebuilds)
q       # Quit app
```

---

## Phase 6: Release Build for Simulator Testing

### Step 6.1: Build Release Version
```bash
# Build iOS app in release mode (optimized)
flutter build ios --release -v

# Expected output shows:
# ✓ ios/build/Release-iphoneos/Runner.app
```

### Step 6.2: Verify Build Output
```bash
# Check build was successful
ls -lah build/ios/iphoneos/Runner.app

# Should be ~50-150 MB
```

### Step 6.3: Run Release Build on Simulator
```bash
# Deploy release build
flutter run --release -d "iPhone 15 Pro"

# Or use Xcode:
# open ios/Runner.xcworkspace
# Product → Scheme → Runner
# Build Configuration → Release
# Product → Run
```

---

## Phase 7: Testing on Physical iOS Device

### Step 7.1: Prerequisites
- iPhone with iOS 12.0+
- USB cable (USB-C or Lightning)
- Xcode installed with development certificate
- Apple Developer Account (free tier OK)

### Step 7.2: Connect Device
```bash
# Plug iPhone into Mac via USB
# Trust the device when prompted on iPhone

# Verify device is recognized
xcrun simctl list devices | grep -i phone

# Or via flutter
flutter devices

# Expected output:
# ASUS iPhone (ios) • XXXX • ios • iOS 16.x
```

### Step 7.3: Set Up Code Signing
```bash
# Open Xcode workspace
open ios/Runner.xcworkspace

# In Xcode:
# 1. Select "Runner" in Project Navigator
# 2. Go to "Signing & Capabilities" tab
# 3. Under "Team" dropdown, select your Apple ID
#    (if first time, you may need to add account in Preferences)
# 4. Verify provisioning profile shows "Managed by Xcode"

# You should see green checkmarks ✓
```

### Step 7.4: Deploy to Physical Device
```bash
# List devices
flutter devices

# Deploy app
flutter run -d "ASUS iPhone"

# Or verbose mode for debugging
flutter run -v -d "ASUS iPhone"

# App should install and launch on device
```

### Step 7.5: Trust Developer Certificate (on iPhone)
```bash
# On iPhone, if you see "Untrusted Enterprise Developer":
# Settings → General → Device Management
# Select your certificate and tap "Trust"
```

---

## Phase 8: iOS Testing Execution

### Step 8.1: Pre-Testing Checklist
```bash
# Before starting tests:

# ✓ Simulator/Device running
flutter devices

# ✓ App installed and running
flutter run

# ✓ Console shows no errors
flutter logs

# ✓ All 5 screens accessible via navigation
```

### Step 8.2: Run Full Test Suite

**Execute checklist in this order:**

1. **Explore Screen** (25 min)
   - [ ] Header with blur
   - [ ] Location bar
   - [ ] Search input
   - [ ] Distance filters (horizontal scroll)
   - [ ] Category chips (horizontal scroll)
   - [ ] Status filters (test pulsing animation ✨)
   - [ ] Place cards with images
   - [ ] Favorite button animations
   - [ ] Bottom navigation to other screens

2. **Favorites Screen** (15 min)
   - [ ] Empty state (if no favorites yet)
   - [ ] Filter tabs (Semua, Buka Sekarang, Tutup)
   - [ ] Favorite cards with pulsing status ✨
   - [ ] Remove favorite functionality
   - [ ] Navigation back to Explore

3. **Booking Screen** (20 min)
   - [ ] "Akan Datang" tab
   - [ ] "Riwayat" tab
   - [ ] Create booking FAB button
   - [ ] Form modal opens/closes smoothly
   - [ ] Date picker works
   - [ ] Time picker works
   - [ ] Purpose chips toggle
   - [ ] Quantity +/- buttons
   - [ ] Form submission

4. **Chat Screen** (20 min)
   - [ ] Conversation list displays
   - [ ] Tap conversation opens chat detail
   - [ ] Message bubbles display correctly
   - [ ] Bot messages show badge
   - [ ] Embedded cards display
   - [ ] Message input field works
   - [ ] Send button works
   - [ ] Back button returns to list

5. **Profile Screen** (15 min)
   - [ ] Header displays
   - [ ] Hero card with gradient background
   - [ ] Stats grid displays
   - [ ] Account section menu (3 items)
   - [ ] Preferences section (toggles work)
   - [ ] Support section menu
   - [ ] Logout button
   - [ ] Logout confirmation modal
   - [ ] Toggle switches animate

### Step 8.3: Performance Monitoring

```bash
# While app is running:

# View performance stats
flutter run --profile

# Or use DevTools:
flutter pub global run devtools

# Then open browser to http://localhost:9100
```

**Key metrics to monitor:**
- Frame rate: 60 FPS (no drops)
- CPU usage: < 50%
- Memory: < 200 MB
- GPU: Smooth rendering

### Step 8.4: Animation Testing (Priority)
- [ ] **Pulsing dots** on status badges (1500ms loop, smooth)
- [ ] **Scale animations** on favorite buttons (200ms, smooth)
- [ ] **Color transitions** on chip selection (200ms, smooth)
- [ ] **Tab underline animation** (300ms, smooth)
- [ ] **All animations at 60 FPS** (no jank)

---

## Phase 9: Handling Common Issues

### Issue 1: Pod Installation Fails
```bash
# Solution:
cd ios
rm -rf Pods/
rm Podfile.lock
pod deintegrate
pod install --repo-update --verbose
cd ..
flutter pub get
flutter run -v
```

### Issue 2: Xcode Build Fails
```bash
# Solution:
flutter clean
rm -rf build/ ios/Pods/ ios/Podfile.lock
flutter pub get
cd ios
pod install --repo-update
cd ..
flutter build ios --release -v

# If still failing, check Xcode:
# open ios/Runner.xcworkspace
# Product → Clean Build Folder (Cmd + Shift + K)
# Product → Build (Cmd + B)
```

### Issue 3: App Crashes on Launch
```bash
# Check logs:
flutter logs

# Common causes:
# - Missing Info.plist permissions
# - Firebase misconfiguration
# - Null pointer exception
# - Plugin incompatibility

# Solution:
# 1. Check Info.plist has all required keys
# 2. Check Firebase GoogleService-Info.plist exists
# 3. Run flutter pub get again
# 4. Clean and rebuild
```

### Issue 4: Simulator Not Starting
```bash
# Solution:
# Quit all simulators
xcrun simctl shutdown all

# Erase simulator
xcrun simctl erase all

# Restart simulator
open -a Simulator
xcrun simctl boot "iPhone 15 Pro"

# Or delete and recreate:
# xcrun simctl delete all
# Then create new simulator via Xcode
```

### Issue 5: Device Not Detected
```bash
# Solution:
# 1. Disconnect and reconnect USB cable
# 2. Trust device on iPhone
# 3. Restart Xcode
# 4. Restart macOS

# Check recognition:
xcrun simctl list devices
flutter devices

# If still not showing:
# System Preferences → Security & Privacy → Developer Tools
# Ensure Xcode appears in list
```

### Issue 6: Permission Errors on iPhone
```bash
# If app won't install or crashes:
# On iPhone:
# Settings → General → Storage & iCloud Usage → Manage Storage
# Delete the app if it exists
# 
# Then redeploy:
flutter run -v -d "device_id"
```

---

## Phase 10: Test Documentation

### Step 10.1: Document Test Results
Create a test report file for each session:

**File: `ios_test_results_DATE.md`**
```markdown
# iOS Testing Results - [DATE]

## Device Information
- Device: [e.g., iPhone 15 Pro Simulator]
- iOS Version: [e.g., iOS 17.0]
- Screen Size: [e.g., 6.1"]
- Build: [e.g., 1.0.0+1]

## Test Summary
- Overall Status: ✅ PASS / ⚠️ PASS WITH NOTES / ❌ FAIL
- Date: [DATE]
- Tester: [NAME]
- Duration: [TIME]

## Screen-by-Screen Results

### Explore Screen
- Status: ✅ PASS
- Issues: None
- FPS: 60
- Notes: All animations smooth, pulsing dots working

### Favorites Screen
- Status: ✅ PASS
- Issues: None
- FPS: 60
- Notes: Filter tabs working, empty state displays

### Booking Screen
- Status: ⚠️ PASS WITH NOTES
- Issues: 
  - [ ] Issue 1: Form doesn't validate email
- FPS: 59
- Notes: Form submission works, minor UI tweak needed

### Chat Screen
- Status: ✅ PASS
- Issues: None
- FPS: 60
- Notes: Message loading smooth, bot badge displays

### Profile Screen
- Status: ✅ PASS
- Issues: None
- FPS: 60
- Notes: Toggle switches animate smoothly

## Performance Metrics
- Average FPS: 60
- Peak Memory: 150 MB
- CPU Usage: 35%
- Battery Drain: Acceptable

## Critical Issues: 0
## High Priority Issues: 0
## Medium Priority Issues: 1
## Low Priority Issues: 0

## Sign-Off
- Tested By: [NAME]
- Date: [DATE]
- Ready for Production: ✅ YES / ❌ NO
```

### Step 10.2: Record Issues Found
```markdown
## Issue Report Template

### Issue #1: [Title]
- **Screen:** [Which screen]
- **Severity:** Critical / High / Medium / Low
- **Reproduction Steps:**
  1. Open [screen]
  2. [Action]
  3. [Expected vs Actual]
- **Expected Behavior:** [What should happen]
- **Actual Behavior:** [What actually happens]
- **Device:** [Device/Simulator]
- **iOS Version:** [iOS X.X]
- **Screenshot:** [Attach if possible]
- **Status:** 🔴 NEW / 🟡 IN PROGRESS / 🟢 FIXED
```

---

## Phase 11: Continuous Testing

### Step 11.1: Automated Testing on Each Build
```bash
# Create test script: test_ios.sh

#!/bin/bash

echo "🧪 iOS Testing Suite Starting..."

# 1. Clean
flutter clean

# 2. Build
flutter build ios --release -v

# 3. Run on simulator
flutter run -d "iPhone 15 Pro" &

# 4. Wait for app to stabilize
sleep 5

# 5. Run tests (if you have test suite)
flutter test

echo "✅ iOS Testing Complete"
```

**Run with:**
```bash
chmod +x test_ios.sh
./test_ios.sh
```

### Step 11.2: Daily Testing Routine
```bash
# Every day before release:

# 1. Update dependencies
flutter pub get
flutter pub upgrade

# 2. Clean build
flutter clean

# 3. Build for simulator
flutter build ios --release

# 4. Test on multiple devices (if available)
flutter run -d "iPhone 15 Pro"      # Large phone
flutter run -d "iPhone SE"          # Small phone
flutter run -d "iPad Pro 12.9"      # Tablet (if available)

# 5. Document results
# (See test documentation section)
```

---

## Phase 12: Pre-Release Checklist

Before considering iOS version ready for production:

### Functional Testing
- [ ] All 5 screens tested on iOS 12.0+
- [ ] All animations smooth (60 FPS)
- [ ] Pulsing status dots working ✨
- [ ] No crashes or errors
- [ ] Navigation between screens smooth
- [ ] Forms submitting correctly
- [ ] Chat messages displaying
- [ ] Images loading from CDN
- [ ] Permissions working (camera, photos, location)

### Responsive Design
- [ ] Tested on iPhone SE (small screen)
- [ ] Tested on iPhone 14 Pro (standard)
- [ ] Tested on iPhone 14 Pro Max (large screen)
- [ ] No horizontal overflow
- [ ] Safe area respected (notch not covered)
- [ ] Bottom navigation accessible
- [ ] Form inputs accessible with keyboard

### Performance
- [ ] App launches in < 2 seconds
- [ ] Screens load in < 1 second
- [ ] Scrolling smooth (60 FPS)
- [ ] Memory usage < 200 MB
- [ ] No memory leaks
- [ ] Battery consumption reasonable

### Accessibility
- [ ] Text contrast meets WCAG AA standard
- [ ] All buttons have minimum 44x44 pt size
- [ ] Touch targets easily tappable
- [ ] VoiceOver compatible (if supported)
- [ ] Font sizes readable
- [ ] Colors not only differentiator

### iOS-Specific
- [ ] Status bar styled correctly
- [ ] Safe area insets handled
- [ ] Keyboard doesn't overlap inputs
- [ ] Notch respected on iPhone X/11/12/13/14
- [ ] Dynamic Island (iPhone 14 Pro) compatible
- [ ] App rotations handled (if portrait-only)
- [ ] Deep linking works (if implemented)

### Build & Distribution
- [ ] Version number correct (1.0.0+1)
- [ ] Bundle ID correct (com.stitch.tongkrongan)
- [ ] Signing certificate valid
- [ ] Provisioning profile active
- [ ] IPA file generated successfully
- [ ] No build warnings or errors

---

## Quick Reference: iOS Testing Commands

```bash
# Environment
flutter doctor -v                    # Check setup
xcode-select -p                      # Check Xcode

# Project Setup
flutter clean                        # Clean build
flutter pub get                      # Get dependencies
cd ios && pod install && cd ..       # Install iOS pods

# Simulator
open -a Simulator                    # Open simulator
xcrun simctl list devices            # List simulators
xcrun simctl boot "iPhone 15 Pro"   # Start simulator

# Build & Run
flutter run                          # Debug on device/simulator
flutter run --release                # Release mode
flutter run -v -d "device_id"       # Verbose + specific device
flutter run --profile                # Profile mode (performance)

# Testing
flutter test                         # Run unit/widget tests
flutter logs                         # View app logs
flutter devices                      # List connected devices

# Build Release
flutter build ios --release -v       # Build optimized app
flutter build ipa --release          # Build IPA for App Store

# DevTools
flutter pub global run devtools      # Start DevTools
# Then open http://localhost:9100

# Physical Device
xcrun simctl list devices            # Verify device connected
flutter devices                      # Confirm device visible
```

---

## Success Criteria - iOS Testing Ready ✅

- ✅ Environment set up (Xcode, CocoaPods, Flutter)
- ✅ Project builds successfully
- ✅ App runs on iOS simulator without crashes
- ✅ App runs on physical iPhone device
- ✅ All 5 screens tested and functional
- ✅ Animations smooth (60 FPS)
- ✅ Pulsing status dots working ✨
- ✅ SafeArea respected (no notch overlap)
- ✅ Images loading correctly
- ✅ Responsive on multiple screen sizes
- ✅ Performance benchmarks met
- ✅ No critical issues found
- ✅ Test documentation complete
- ✅ Ready for TestFlight beta
- ✅ Ready for App Store submission

---

**iOS Testing Setup Status:** ✅ READY  
**Last Updated:** September 16, 2026  
**Version:** 1.0

