# 📱 Setup Android & iOS - Panduan Lengkap

**Platform:** Windows (untuk development & testing Android), Remote Mac (untuk iOS)  
**Status:** Setup Instructions Ready  
**Duration:** Android 3-4 jam, iOS 2-3 jam  
**Date:** September 16, 2026

---

## 📊 Platform Compatibility Overview

| Aspek | Android | iOS | Windows |
|-------|---------|-----|---------|
| **Development** | ✅ Windows | ❌ Butuh Mac/Remote | ✅ Windows |
| **Testing Emulator** | ✅ Android Studio | ❌ Butuh Mac | ✅ Full Support |
| **Physical Device Test** | ✅ USB Connected | ❌ Butuh Mac | ✅ Via USB |
| **Build APK** | ✅ Windows | ❌ Butuh Mac | ✅ Full Support |
| **Build IPA** | ❌ | ✅ Mac only | ❌ |
| **App Store** | ✅ Play Store | ❌ App Store (Mac) | ✅ Upload via web |
| **Development Time** | 3-4 jam | 2-3 jam (Mac) | - |

---

# 🤖 BAGIAN 1: ANDROID SETUP (Windows)

## Fase A: Verifikasi Persyaratan Sistem

### A.1: Cek Windows Version
```powershell
# Buka PowerShell sebagai Administrator
systeminfo | findstr /C:"OS Name"

# Expected: Windows 10/11
```

### A.2: Cek Flutter Installation
```powershell
# Pastikan Flutter sudah terinstall
flutter --version

# Output example:
# Flutter 3.13.0 • channel stable
# Dart 3.1.0

# Jika belum ada, install dari:
# https://flutter.dev/docs/get-started/install/windows
```

### A.3: Cek Android SDK Installation
```powershell
# Verify Android SDK
flutter doctor -v

# Expected output:
# ✓ Flutter SDK
# ✓ Android SDK
# ✓ Android Studio
# ✓ Android Gradle Plugin version
```

**Jika Android SDK belum terinstall:**
```powershell
# Install via Android Studio atau:
flutter config --android-sdk C:\Users\<YourUsername>\AppData\Local\Android\sdk

# Setup Android licenses
flutter doctor --android-licenses
# Type 'y' untuk semua prompt
```

### A.4: Verify Java Installation
```powershell
# Check Java version (perlu JDK 11+)
java -version

# Jika tidak ada, install:
# https://www.oracle.com/java/technologies/downloads/
# Atau gunakan: choco install openjdk11
```

---

## Fase B: Android Studio Configuration

### B.1: Install/Update Android Studio
```powershell
# Download dari:
# https://developer.android.com/studio

# Atau via Chocolatey:
choco install android-studio

# Tunggu instalasi selesai (~10-15 menit)
```

### B.2: Configure Android Studio SDKs
```
1. Open Android Studio
2. Go to: File → Settings → Appearance & Behavior → System Settings → Android SDK
3. Verify installed SDKs:
   - SDK Platform (API 33+) ✓
   - Build Tools (33.0.0+) ✓
   - Platform Tools ✓
   - Android Emulator ✓
4. Apply & OK

5. Go to: File → Settings → Plugins
   - Search: "Flutter"
   - Install: Flutter, Dart plugins
   - Restart Android Studio
```

### B.3: Create/Update Android Emulator
```
1. Android Studio → Virtual Device Manager
2. Create New Device:
   - Device: Pixel 6 or higher (recommended)
   - API Level: 33 (Android 13) or higher
   - RAM: 4GB minimum, 8GB recommended
   - Storage: 4GB
3. Click "Create Device"
4. Verify emulator appears in list

Alternative via CLI:
```

```powershell
# List available devices
flutter devices

# Or create emulator via CLI:
# emulator -list-avds
# emulator -avd Pixel_6_API_33
```

---

## Fase C: Project Setup untuk Android

### C.1: Navigate to Project
```powershell
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app
```

### C.2: Clean Project
```powershell
# Remove old build artifacts
flutter clean

# Clear Gradle cache
Remove-Item -Recurse -Force android\.gradle
Remove-Item -Recurse -Force android\app\build

# Get fresh dependencies
flutter pub get

# Update dependencies (opsional)
# flutter pub upgrade
```

### C.3: Verify Android Configuration
**File: `pubspec.yaml`** - Pastikan sudah ada:
```yaml
# Check section ini sudah ada:
flutter:
  uses-material-design: true

# Environment section:
environment:
  sdk: ">=2.19.0 <4.0.0"
```

### C.4: Update Android Minimum SDK
**File: `android/app/build.gradle`** - Verify:
```gradle
android {
    compileSdkVersion 33  // atau lebih tinggi
    
    defaultConfig {
        applicationId "com.stitch.tongkrongan"
        minSdkVersion 21      // Android 5.0+
        targetSdkVersion 33   // atau lebih tinggi
        versionCode 1
        versionName "1.0.0"
    }
}
```

### C.5: Configure AndroidManifest Permissions
**File: `android/app/src/main/AndroidManifest.xml`** - Add:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <!-- Camera -->
    <uses-permission android:name="android.permission.CAMERA" />
    
    <!-- Photos/Gallery -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    
    <!-- Location -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    
    <!-- Internet -->
    <uses-permission android:name="android.permission.INTERNET" />
    
    <!-- Network State -->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <application>
        <!-- Activities here -->
    </application>
</manifest>
```

---

## Fase D: Build & Test Android

### D.1: Start Android Emulator
```powershell
# List emulators
flutter devices

# Expected output:
# Android SDK built for x86 (emulator) • emulator-5554 • android

# Jika tidak terlihat, buka via Android Studio:
# Virtual Device Manager → Play button (emulator Anda)

# Or via CLI:
$emulators = Get-ChildItem "C:\Users\ASUS\.android\avd" -Directory
# Lihat nama emulator, misalnya: "Pixel_6_API_33"
```

### D.2: Verify Emulator Running
```powershell
# Check emulator status
flutter devices

# Should show something like:
# Pixel_6 (emulator) • emulator-5554 • android • Android 13 (API 33)
```

### D.3: Debug Build to Emulator
```powershell
# Method 1: Auto-detect emulator
flutter run

# Method 2: Specify device
flutter run -d emulator-5554

# Method 3: Verbose mode (untuk debugging)
flutter run -v -d emulator-5554

# Watch for output:
# ✓ Gradle build complete
# ✓ Installing and launching app
# ✓ I/flutter ( xxxx): App running
```

### D.4: Monitor Console & Logs
```powershell
# While app is running, view logs:
flutter logs

# Filter by app name:
flutter logs -c
```

### D.5: Hot Reload During Development
```powershell
# Saat app sedang running, di terminal:

r          # Hot reload (keep state)
R          # Hot restart (rebuild)
q          # Quit app
h          # Help
```

### D.6: Release Build (APK)
```powershell
# Build production APK
flutter build apk --release

# Output file:
# build\app\outputs\flutter-app\release\app-release.apk (~50MB)

# Verify build
ls build\app\outputs\flutter-app\release\

# To install APK on emulator:
flutter install build\app\outputs\flutter-app\release\app-release.apk
```

---

## Fase E: Physical Android Device Testing

### E.1: Connect Android Device
```powershell
# Requirements:
# - USB cable (USB-C atau Micro-USB)
# - Android 5.0+
# - USB Debugging enabled

# On Android device:
# Settings → About Phone → Tap "Build Number" 7x
# Settings → Developer Options → Enable USB Debugging

# Plug phone into PC via USB
# You'll see: "Allow USB Debugging?" → Tap OK
```

### E.2: Verify Device Recognition
```powershell
# Check device is recognized
flutter devices

# Expected output:
# ASUS Device (android) • adb xxxx • android • Android 12

# Jika tidak muncul:
# 1. Check USB cable (try different cable)
# 2. Restart ADB:
#    adb kill-server
#    adb start-server
# 3. Trust device on phone again
# 4. Re-run: flutter devices
```

### E.3: Deploy to Physical Device
```powershell
# Get device ID
flutter devices

# Deploy debug build
flutter run -d <device_id>

# Example:
flutter run -d adb12345

# Or with verbose:
flutter run -v -d adb12345
```

### E.4: Build Release APK for Device
```powershell
# Build APK (same as emulator)
flutter build apk --release

# Transfer to phone:
$apkPath = "build\app\outputs\flutter-app\release\app-release.apk"

# Option 1: Via adb
adb install $apkPath

# Option 2: Manual - Transfer file ke phone via USB/drive
```

---

## Fase F: Android Testing Checklist

### Pre-Testing
- [ ] Emulator/device running
- [ ] App installed & launched
- [ ] No crashes in console
- [ ] All 5 screens accessible via bottom navigation

### Testing Execution (Follow MOBILE_TESTING_CHECKLIST.md)
- [ ] **Explore Screen** (25 min)
  - [ ] Pulsing status dots ✨
  - [ ] Animations smooth (60 FPS)
  - [ ] Images loading
  - [ ] All filters working
  
- [ ] **Favorites Screen** (15 min)
  - [ ] Filter tabs working
  - [ ] Empty state displays
  
- [ ] **Booking Screen** (20 min)
  - [ ] Form modal opens/closes
  - [ ] Date picker works
  - [ ] Time picker works
  
- [ ] **Chat Screen** (20 min)
  - [ ] Messages display
  - [ ] Bot badge shows
  - [ ] Input works
  
- [ ] **Profile Screen** (15 min)
  - [ ] Toggle switches work
  - [ ] Logout flows correctly

### Performance Metrics
- [ ] FPS: 60 (no drops)
- [ ] Memory: < 200 MB
- [ ] CPU: < 50%
- [ ] Battery: Acceptable drain rate

### Post-Testing Documentation
- [ ] Results documented
- [ ] Issues logged
- [ ] Screenshots captured (if needed)
- [ ] Ready for production

---

# 🍎 BAGIAN 2: iOS SETUP (Butuh Mac/Remote)

## Catatan Penting: iOS Development

**iOS hanya bisa di-develop di macOS!** Ada beberapa opsi:

| Opsi | Kelebihan | Kekurangan | Waktu |
|------|-----------|-----------|-------|
| **Mac Mini/iMac** | Full native | Biaya investasi | Owned |
| **MacBook Air M1** | Portable, powerful | Mahal | Owned |
| **Mac Studio** | Powerful | Biaya tinggi | Owned |
| **Mac Cloud (MacStadium, Equinix)** | Accessible dari Windows | Berlangganan | Scalable |
| **Collaborate dengan Dev Mac** | Share resources | Koordinasi timing | Team |

**Untuk user Windows:** Saya menyediakan instruksi yang bisa di-share ke Mac/kolaborator.

---

## Fase 1: Mac Environment Setup

### 1.1: Verify macOS & Xcode
```bash
# Check macOS version (need 10.15+)
sw_vers

# Install Xcode Command Line Tools
xcode-select --install

# Accept Xcode license
sudo xcodebuild -license accept

# Verify Xcode installation
xcode-select -p
# Expected: /Applications/Xcode.app/Contents/Developer
```

### 1.2: Install CocoaPods
```bash
# Install CocoaPods (iOS dependency manager)
sudo gem install cocoapods

# Update pods repo
pod repo update

# Verify
pod --version
```

### 1.3: Verify Flutter on Mac
```bash
# Check Flutter installation
flutter --version

# Run full doctor check
flutter doctor -v

# Expected all green ✓ for:
# ✓ Flutter SDK
# ✓ Xcode
# ✓ CocoaPods
# ✓ iOS simulator
# ✓ Chrome (for DevTools)
```

---

## Fase 2: iOS Project Setup (On Mac)

### 2.1: Navigate to Project (On Mac)
```bash
# Bisa sinkronisasi dari Windows via:
# 1. Git clone/pull
# 2. Cloud drive (OneDrive, Google Drive)
# 3. Direct folder share (if on network)

cd /path/to/stitch_tongkrongan_hangout_discovery_app/tongkrongan_app
```

### 2.2: Clean & Prepare (On Mac)
```bash
# Remove old builds
flutter clean

# Remove iOS artifacts
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf build/

# Get dependencies
flutter pub get
```

### 2.3: Install iOS Pods (On Mac)
```bash
cd ios

# Update pods repo
pod repo update

# Install pods (bisa butuh 5-10 menit)
pod install --repo-update

# If error, try:
# rm -rf Pods/
# pod deintegrate
# pod install --repo-update --verbose

cd ..
```

### 2.4: Configure iOS Project (On Mac)
```bash
# Open Xcode workspace
open ios/Runner.xcworkspace

# In Xcode UI:
# 1. Select "Runner" → General tab
# 2. Set:
#    - Display Name: "Tongkrongan"
#    - Bundle Identifier: com.stitch.tongkrongan
#    - Minimum Deployments: iOS 12.0
#    - Version: 1.0.0
#    - Build: 1
# 3. Go to Signing & Capabilities
# 4. Select your Apple Team
# 5. Verify provisioning profile setup
```

### 2.5: Update Info.plist (On Mac)
```bash
# Edit ios/Runner/Info.plist
# Add these keys:
```

**File: `ios/Runner/Info.plist`** - Add:
```xml
<!-- Camera Permission -->
<key>NSCameraUsageDescription</key>
<string>Kami memerlukan akses kamera untuk menangkap gambar tempat nongkrong</string>

<!-- Photo Library Permission -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Kami memerlukan akses galeri foto untuk mengunggah gambar tempat</string>

<!-- Location Permission -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Kami memerlukan lokasi untuk menampilkan tempat nongkrong terdekat</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Kami memerlukan lokasi untuk menampilkan tempat nongkrong terdekat</string>

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

## Fase 3: iOS Simulator Setup (On Mac)

### 3.1: List Available Simulators (On Mac)
```bash
# List iOS simulators
xcrun simctl list devices

# Example output:
# iPhone 15 Pro (XXXX-XXXX) (Shutdown)
# iPhone 14 (YYYY-YYYY) (Shutdown)
```

### 3.2: Start Simulator (On Mac)
```bash
# Open default simulator
open -a Simulator

# Or start specific
xcrun simctl boot "iPhone 15 Pro"

# Create new simulator if needed
xcrun simctl create "iPhone 15 Test" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-15 \
  com.apple.CoreSimulator.SimRuntime.iOS-17-0
```

### 3.3: Build & Run on Simulator (On Mac)
```bash
# Get devices
flutter devices

# Expected:
# iPhone 15 Pro (mobile) • XXXX • ios • iOS 17.x

# Run debug build
flutter run

# Or specific device:
flutter run -d "iPhone 15 Pro"

# Verbose mode:
flutter run -v -d "iPhone 15 Pro"
```

### 3.4: Monitor Console (On Mac)
```bash
# View logs
flutter logs

# Or via Xcode:
# Cmd + Shift + C
```

---

## Fase 4: Physical iOS Device (On Mac)

### 4.1: Connect iPhone (On Mac)
```bash
# Requirements:
# - USB-C cable (iPhone 15+) atau Lightning (iPhone 14 and below)
# - Trust the device when prompted

# Verify connection
xcrun simctl list devices | grep -i phone

# Or
flutter devices
```

### 4.2: Code Signing Setup (On Mac)
```bash
# Open Xcode workspace
open ios/Runner.xcworkspace

# In Xcode:
# 1. Select "Runner" → Signing & Capabilities
# 2. Under "Team" dropdown, select your Apple ID
#    (If first time: Xcode → Preferences → Accounts → Add Apple ID)
# 3. Verify provisioning profile shows "Managed by Xcode"
# 4. All should show green checkmarks ✓
```

### 4.3: Deploy to iPhone (On Mac)
```bash
# Check connected devices
flutter devices

# Deploy
flutter run -d "iPhone of User"

# Or verbose:
flutter run -v -d "iPhone of User"
```

### 4.4: Trust Developer Certificate (On iPhone)
```
If app won't launch:
1. On iPhone: Settings → General → Device Management
2. Select your certificate
3. Tap "Trust [Your Name]"
```

### 4.5: Build Release Version (On Mac)
```bash
# Build optimized iOS app
flutter build ios --release -v

# Build IPA for App Store
flutter build ipa --release

# Output:
# build/ios/iphoneos/Runner.app
# build/ios/ipa/Tongkrongan.ipa
```

---

## Fase 5: iOS Testing Checklist

Same as Android - Follow **MOBILE_TESTING_CHECKLIST.md** untuk:
- Explore Screen (25 min)
- Favorites Screen (15 min)
- Booking Screen (20 min)
- Chat Screen (20 min)
- Profile Screen (15 min)

### iOS-Specific Tests
- [ ] SafeArea respected (no notch overlap)
- [ ] Status bar styled correctly
- [ ] Keyboard doesn't cover inputs
- [ ] Gestures work (swipe back, etc.)
- [ ] Haptic feedback (if implemented)
- [ ] Permission dialogs display correctly

---

# 🔄 SYNCHRONIZATION: Android (Windows) ↔ iOS (Mac)

Jika development dilakukan di 2 machine berbeda:

## Option 1: Git Version Control
```powershell
# Windows - Push changes
cd tongkrongan_app
git add .
git commit -m "Android testing changes"
git push origin main

# Mac - Pull changes
git pull origin main

# After changes on Mac:
git add .
git commit -m "iOS testing changes"
git push origin main

# Windows - Pull changes
git pull origin main
```

## Option 2: Cloud Drive Sync
```powershell
# Windows: Save ke OneDrive/Google Drive
# Move entire tongkrongan_app folder

# Mac: Access dari:
# /Users/username/OneDrive/stitch_tongkrongan_hangout_discovery_app/tongkrongan_app
```

## Option 3: Network Share
```powershell
# Windows: Share folder via SMB
# Mac: Mount Windows share via Finder
```

---

# ✅ COMBINED SETUP CHECKLIST

## Pre-Setup
- [ ] Windows machine dengan Flutter & Android tools
- [ ] Mac machine dengan Xcode & CocoaPods (atau remote Mac access)
- [ ] Project repository (Git/Drive)
- [ ] USB cables (Android + iPhone)

## Android Setup (Windows)
- [ ] Flutter installed
- [ ] Android Studio configured
- [ ] Android SDK/Gradle downloaded
- [ ] Emulator created & running
- [ ] Project cleaned & dependencies fetched
- [ ] Permissions configured in AndroidManifest.xml
- [ ] Debug APK builds successfully
- [ ] Release APK builds successfully
- [ ] Can deploy to emulator
- [ ] Can deploy to physical device

## iOS Setup (Mac)
- [ ] Xcode & CLI tools installed
- [ ] CocoaPods installed
- [ ] Flutter running on Mac
- [ ] iOS pods installed
- [ ] Xcode project configured
- [ ] Info.plist permissions set
- [ ] iOS simulator running
- [ ] Project builds for simulator
- [ ] Can deploy to simulator
- [ ] Can deploy to physical device

## Testing
- [ ] Android: All 5 screens tested on emulator ✅
- [ ] Android: All 5 screens tested on physical device ✅
- [ ] iOS: All 5 screens tested on simulator ✅
- [ ] iOS: All 5 screens tested on physical device ✅
- [ ] Performance metrics met (60 FPS, < 200MB memory)
- [ ] No critical issues
- [ ] Documentation complete

---

# 🚀 QUICK START COMMANDS

## Android (Windows)
```powershell
# Setup
flutter clean
flutter pub get
cd android && gradle build && cd ..

# Testing
flutter devices
flutter run -v

# Release
flutter build apk --release
```

## iOS (Mac)
```bash
# Setup
flutter clean
flutter pub get
cd ios && pod install --repo-update && cd ..

# Testing
flutter devices
flutter run -v

# Release
flutter build ios --release
flutter build ipa --release
```

---

# 📊 TESTING TIMELINE

## Android (Windows)
| Phase | Time | Tasks |
|-------|------|-------|
| Setup | 30 min | Flutter, Android Studio, Emulator |
| Config | 30 min | Build.gradle, AndroidManifest, pubspec.yaml |
| Build | 20 min | Clean, pub get, build APK |
| Emulator Test | 60 min | All 5 screens, performance, animations |
| Device Test | 60 min | Connect device, verify on real hardware |
| Documentation | 30 min | Log results, issues, sign-off |
| **TOTAL** | **3-4 hours** | Ready for production |

## iOS (Mac)
| Phase | Time | Tasks |
|-------|------|-------|
| Setup | 30 min | Xcode, CocoaPods, iOS pods |
| Config | 30 min | Xcode project, Info.plist, Bundle ID |
| Build | 15 min | Clean, pub get, iOS build |
| Simulator Test | 45 min | All 5 screens, performance, SafeArea |
| Device Test | 45 min | Connect iPhone, code signing, verify |
| Documentation | 30 min | Log results, issues, sign-off |
| **TOTAL** | **2-3 hours** | Ready for production |

---

# 🎯 SUCCESS CRITERIA

## Android Ready ✅
- ✅ Builds without errors
- ✅ Runs on emulator
- ✅ Runs on physical device
- ✅ All 5 screens functional
- ✅ 60 FPS smooth
- ✅ No crashes
- ✅ APK < 150MB
- ✅ Tested for 2-3 hours

## iOS Ready ✅
- ✅ Builds without errors
- ✅ Runs on simulator
- ✅ Runs on physical device
- ✅ All 5 screens functional
- ✅ 60 FPS smooth
- ✅ SafeArea respected
- ✅ No crashes
- ✅ Tested for 2-3 hours

## Both Platforms Ready ✅
- ✅ Android & iOS feature parity
- ✅ Same visual appearance
- ✅ Same animations/interactions
- ✅ Both platforms tested
- ✅ Performance acceptable
- ✅ No platform-specific issues
- ✅ Documentation complete
- ✅ **READY FOR PRODUCTION RELEASE**

---

**Setup Guide Status:** ✅ READY  
**Last Updated:** September 16, 2026  
**Version:** 1.0  
**Platform Coverage:** Android (Windows) + iOS (Mac)

