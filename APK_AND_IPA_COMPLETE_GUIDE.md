# 📱 COMPLETE GUIDE: Build APK & IPA via GitHub Actions

**Goal:** Automatically build and deploy to both Android & iOS

**What you'll get:** APK for Android phones + IPA for iPhones

---

## 🚀 QUICK OVERVIEW

```
Every push to GitHub
    ↓
Both workflows run in parallel:
    ├─ Android APK build (15 min) on Ubuntu
    └─ iOS IPA build (20 min) on macOS
    ↓
Download from Artifacts
    ├─ app-release.apk (for Android)
    └─ app.ipa (for iPhone)
    ↓
Install on devices
    ├─ Android: ADB or Sideloadly
    └─ iOS: Sideloadly or Xcode
```

---

## 📋 REQUIREMENTS

### For Android (.apk):
✅ **You already have:**
- Android keystore (generated)
- 4 GitHub secrets (Android credentials)

### For iOS (.ipa):
⏳ **You need:**
- Mac (to generate certificates)
- Apple Developer Account ($99/year)
- iOS Distribution Certificate (.p12)
- Provisioning Profile (.mobileprovision)
- 7 GitHub secrets (iOS credentials)

---

## 🎯 STEP-BY-STEP SETUP

### PHASE 1: Android Setup (Already Done!)

**Status:** ✅ Complete

You have:
- Keystore file: `tongkrongan_app/android/app/upload-keystore.jks`
- 4 secrets ready to add

See: `BUILD_APK_IPA_STEP_BY_STEP.md`

### PHASE 2: iOS Setup (New!)

**Status:** ⏳ In Progress

1. Get certificates on Mac (30 min)
2. Convert to base64 (5 min)
3. Add 7 secrets to GitHub (5 min)
4. Push to trigger build (1 min)

See: `IOS_BUILD_SETUP_COMPLETE.md`

---

## 🔐 ALL 11 GITHUB SECRETS

### Android Secrets (4) - ✅ Ready

```
1. ANDROID_KEYSTORE_BASE64
   Location: keystore-base64.txt
   
2. ANDROID_KEYSTORE_PASSWORD
   Value: Tongkrongan@2024_637729
   
3. ANDROID_KEY_PASSWORD
   Value: Key@2024_236320
   
4. ANDROID_KEY_ALIAS
   Value: tongkrongan
```

### iOS Secrets (7) - ⏳ Need Mac

```
5. IOS_CERTIFICATE_BASE64
   Get from: Mac certificate export
   
6. IOS_CERTIFICATE_PASSWORD
   Password for .p12 file
   
7. IOS_PROVISIONING_PROFILE_BASE64
   Get from: Mac provisioning profile export
   
8. KEYCHAIN_PASSWORD
   Any secure password: KeychainPass123!
   
9. TESTFLIGHT_USERNAME
   Your Apple ID email
   
10. TESTFLIGHT_PASSWORD
    App-specific password from Apple ID
    
11. TESTFLIGHT_APP_ID
    Bundle ID: com.stitch.tongkrongan
```

---

## 📲 INSTALLATION METHODS

### Android (APK)

**Method 1: USB & ADB (Fastest)**
```powershell
# Connect Android phone via USB
adb install app-release.apk
```

**Method 2: Manual (No tools needed)**
```
1. Transfer app-release.apk to phone
2. Open file manager
3. Tap APK
4. Install
```

**Method 3: Sideloadly (GUI)**
```
1. Download: https://sideloadly.io
2. Connect phone
3. Select APK
4. Click Install
```

### iOS (IPA)

**Method 1: Sideloadly (Recommended)**
```
1. Download: https://sideloadly.io
2. Connect iPhone
3. Select app.ipa
4. Enter Apple ID
5. Install
```

**Method 2: Xcode (Mac only)**
```
Open app.ipa with Xcode
Select device
Click Install
```

**Method 3: TestFlight (Official)**
```
Upload IPA to TestFlight
Send link to testers
Download from TestFlight app
```

---

## ⏱️ COMPLETE TIMELINE

### Day 1: Setup (60 minutes)

| Task | Time | Status |
|------|------|--------|
| Android secrets add | 2 min | ✅ Ready |
| iOS certificates (Mac) | 30 min | ⏳ Needs Mac |
| iOS secrets add | 5 min | ⏳ After certs |
| First push | 1 min | ⏳ After secrets |
| **Total** | **~40 min** | - |

### Day 2+: Automatic Builds

Every push triggers:
```
Push → Build starts
t=15min → APK ready
t=25min → IPA ready
t=30min → Install on devices
```

---

## 🔄 BUILD WORKFLOW

```mermaid
User Push
    ↓
GitHub Actions Triggered
    ↓
┌─────────────────────┬──────────────────────┐
│   Android (Ubuntu)  │   iOS (macOS)        │
│   Build APK         │   Build IPA          │
│   Duration: 15min   │   Duration: 20min    │
└──────────┬──────────┴──────────┬───────────┘
           ↓                     ↓
      APK Ready            IPA Ready
           ↓                     ↓
      Artifacts            Artifacts
           ↓                     ↓
      Download APK        Download IPA
           ↓                     ↓
      Install Android      Install iOS
```

---

## 📊 COMPARISON: Android vs iOS

| Feature | Android | iOS |
|---------|---------|-----|
| Build Time | 15 min | 20 min |
| Platform | Ubuntu | macOS |
| Keystore | `.jks` file | Certificate + Profile |
| Installation | ADB, Sideloadly | Sideloadly, Xcode, TestFlight |
| Requirements | Windows | Mac (for certs) |
| Cost | Free | $99/year (Apple Dev) |
| Secrets | 4 | 7 |

---

## ✅ CHECKLIST: What You Need to Do

### Before First Build:

- [ ] Read this guide
- [ ] Read `BUILD_APK_IPA_STEP_BY_STEP.md`
- [ ] Read `IOS_BUILD_SETUP_COMPLETE.md`

### Android Setup:
- [ ] Add 4 Android secrets to GitHub
- [ ] Verify all 4 secrets added

### iOS Setup (requires Mac):
- [ ] Get Apple Developer Account
- [ ] Generate iOS Certificate (.p12)
- [ ] Generate Provisioning Profile (.mobileprovision)
- [ ] Convert to base64
- [ ] Add 7 iOS secrets to GitHub
- [ ] Verify all 7 secrets added

### First Build:
- [ ] Push code to main branch
- [ ] Watch workflows at GitHub Actions
- [ ] Download APK and IPA
- [ ] Test on devices

---

## 🎯 DECISION: What to Build?

### Option A: Android Only (Fastest)
✅ Just add 4 Android secrets
✅ Build starts immediately
✅ APK ready in 15 minutes
⏳ No iOS version yet

### Option B: Both Android & iOS (Complete)
✅ Add 4 Android secrets
✅ Get iOS certificates (need Mac)
✅ Add 7 iOS secrets
✅ Both APK & IPA ready
⏳ Takes longer (Mac access needed)

### Option C: Android Now, iOS Later
✅ Add 4 Android secrets
✅ Build and test APK
✅ Get iOS certificates when you have Mac access
✅ Add 7 iOS secrets
✅ Build and test IPA

**Recommendation:** Start with Android (Option A), then add iOS when ready.

---

## 🚀 QUICK START (Android Only)

If you just want Android APK:

```powershell
# 1. Add 4 Android secrets to GitHub:
# https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

# 2. Push code:
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"
git add .
git commit -m "Build APK"
git push origin main

# 3. Watch build:
# https://github.com/RizqonSagena/tongkrongan-app/actions

# 4. Download APK from Artifacts (~15 min)

# 5. Install on Android phone!
```

---

## 📚 RELATED GUIDES

**For Android:**
- `BUILD_APK_IPA_STEP_BY_STEP.md` - Detailed guide
- `QUICK_BUILD_SETUP.md` - Quick reference
- `ANDROID_BUILD_CREDENTIALS.txt` - Your credentials

**For iOS:**
- `IOS_BUILD_SETUP_COMPLETE.md` - Detailed guide
- `SECRETS_CHECKLIST.md` - All 11 secrets

**General:**
- `CICD_COMPLETE_GUIDE.md` - Full CI/CD info
- `SIDELOADLY_INTEGRATION.md` - Auto-install setup
- `GITHUB_SECRETS_SETUP.md` - Credential generation

---

## 🆘 HELP & TROUBLESHOOTING

### Android APK Won't Build?
1. Check all 4 secrets are added
2. Check secret values match exactly
3. View workflow logs for error

### iOS IPA Won't Build?
1. Make sure you have Mac access
2. Check all 7 secrets are added
3. Verify certificate isn't expired
4. Check provisioning profile is valid

### Can't Get iOS Certificates?
1. You need Mac (not possible on Windows alone)
2. You need Apple Developer Account
3. Alternative: Use online Mac service (macincloud.com)

### Installation Fails?
- Android: Enable unknown sources in settings
- iOS: Use Sideloadly (supports non-App Store installs)

---

## 💡 TIPS

- First build takes longer (caching)
- Parallel builds save time
- Download both files immediately
- Keep credentials safe
- Update certificates when they expire

---

## 🎉 SUCCESS LOOKS LIKE

```
✅ Workflows complete
✅ APK downloaded (150MB)
✅ IPA downloaded (300MB)
✅ APK installed on Android phone
✅ IPA installed on iPhone
✅ Both apps running!
```

---

**Status:** Ready for Complete Setup  
**Date:** September 16, 2026  
**Version:** 1.0

**Next Steps:**
1. Start with Android (easy, fast)
2. Add iOS when you have Mac access
3. Enjoy automatic builds on every push!

