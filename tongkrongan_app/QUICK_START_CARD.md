# 🚀 Tongkrongan App - Quick Start Card

**Print this or pin in editor for quick reference**

---

## 📱 SETUP OVERVIEW

**Android (Windows):** 3-4 hours  
**iOS (Mac):** 2-3 hours  
**Cross-Platform Testing:** 3-4 hours  
**Total:** 8-11 hours

---

## 🤖 ANDROID (Windows) - Quick Steps

### 1. Verify Environment (30 min)
```powershell
flutter doctor -v
# Check: Flutter ✓, Android SDK ✓, Java ✓
```

### 2. Create Emulator (30 min)
```
Android Studio → Virtual Device Manager → Create:
- Device: Pixel 6
- API: 33 (Android 13)
- RAM: 4GB
```

### 3. Project Prep (30 min)
```powershell
flutter clean
flutter pub get
```

### 4. Build & Test (60 min)
```powershell
flutter run -v
# ← Debug build on emulator
```

### 5. Physical Device (60 min)
```powershell
flutter devices
flutter run -d <device_id>
```

### 6. Release Build
```powershell
flutter build apk --release
# Output: build/app/outputs/flutter-app/release/app-release.apk
```

**✅ Android Done** - APK ready for Play Store

---

## 🍎 iOS (Mac) - Quick Steps

### 1. Verify Environment (30 min)
```bash
flutter doctor -v
# Check: Xcode ✓, CocoaPods ✓
```

### 2. Install Pods (20 min)
```bash
cd ios
pod install --repo-update
cd ..
```

### 3. Configure Xcode (30 min)
```bash
open ios/Runner.xcworkspace
# Set: Bundle ID, Version, Signing team
```

### 4. Build & Test (45 min)
```bash
flutter run -v
# ← Debug build on simulator
```

### 5. Physical Device (45 min)
```bash
flutter run -d "iPhone of User" -v
```

### 6. Release Build
```bash
flutter build ipa --release
# Output: build/ios/ipa/Tongkrongan.ipa
```

**✅ iOS Done** - IPA ready for App Store

---

## 🔄 CROSS-PLATFORM TESTING

### Test All 5 Screens (Both Platforms)

| Screen | Android | iOS | Time | Status |
|--------|---------|-----|------|--------|
| Explore | ✅ | ✅ | 25 min | |
| Favorites | ✅ | ✅ | 15 min | |
| Booking | ✅ | ✅ | 20 min | |
| Chat | ✅ | ✅ | 20 min | |
| Profile | ✅ | ✅ | 15 min | |

### Verify

- ✅ Same visuals
- ✅ Same animations (60 FPS)
- ✅ Same performance
- ✅ Pulsing dots working ✨

---

## 🔧 COMMON ISSUES (QUICK FIX)

| Issue | Fix | Time |
|-------|-----|------|
| Gradle fail | `flutter clean` + `flutter pub get` | 2 min |
| Pod fail | `pod repo update` + `pod install --repo-update` | 5 min |
| Emulator stuck | Kill process + restart | 3 min |
| Device not found | Check USB cable + `adb devices` | 2 min |
| App crashes | Check logs: `flutter logs` | 5 min |

**See TROUBLESHOOTING_GUIDE.md for more**

---

## 📊 SUCCESS CRITERIA

### Android ✅
- [ ] Builds without errors
- [ ] Runs on emulator & device
- [ ] All 5 screens work
- [ ] 60 FPS smooth
- [ ] Memory < 200 MB

### iOS ✅
- [ ] Builds without errors
- [ ] Runs on simulator & device
- [ ] All 5 screens work
- [ ] 60 FPS smooth
- [ ] SafeArea respected

### BOTH ✅
- [ ] Same visuals
- [ ] Same performance
- [ ] Same animations
- [ ] Ready for production

---

## 📁 KEY FILES

| File | Purpose | Read Time |
|------|---------|-----------|
| README_SETUP.md | Overview & quick start | 15 min |
| SETUP_ANDROID_IOS.md | Main setup guide | Follow steps |
| CROSS_PLATFORM_TESTING.md | Comparative testing | 30 min |
| TROUBLESHOOTING_GUIDE.md | Problem solving | On demand |
| MOBILE_TESTING_CHECKLIST.md | QA checklist | As needed |

---

## 🚀 QUICK COMMANDS

### Android
```powershell
flutter clean
flutter pub get
flutter devices
flutter run -v
flutter build apk --release
```

### iOS (Mac)
```bash
flutter clean
flutter pub get
cd ios && pod install --repo-update && cd ..
flutter devices
flutter run -v
flutter build ipa --release
```

---

## ⏱️ TIMELINE

```
Day 1 (3-4 hrs):  Android setup + testing
Day 2 (2-3 hrs):  iOS setup + testing
Day 3 (3-4 hrs):  Cross-platform testing

✅ Production Ready
```

---

## 📞 HELP

1. Check: README_SETUP.md
2. Read: SETUP_ANDROID_IOS.md
3. Search: TROUBLESHOOTING_GUIDE.md
4. Test: MOBILE_TESTING_CHECKLIST.md
5. Verify: CROSS_PLATFORM_TESTING.md

---

## 🎯 NEXT STEP

**→ Open: README_SETUP.md**

Then follow step-by-step in SETUP_ANDROID_IOS.md

**Estimated time to production:** 2-3 days

---

**Good luck! 🚀**

