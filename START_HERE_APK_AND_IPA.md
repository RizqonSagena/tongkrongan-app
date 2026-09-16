# 🚀 START HERE: Build APK & IPA via GitHub Actions

**Welcome!** This guide gets you from 0 to running builds in ~30 minutes.

---

## 🎯 What You're About to Build

```
Every git push to main
    ↓
GitHub Actions builds BOTH:
    ├─ Android APK (15 min)
    └─ iOS IPA (20 min)
    ↓
Download from GitHub
    ├─ app-release.apk
    └─ app.ipa
    ↓
Install on your devices
    ├─ Android phone
    └─ iPhone
```

---

## ⚡ QUICK START (Choose Your Path)

### 🤖 Path A: Android Only (20 min) - START HERE!

**Fastest way to get APK on your Android phone**

1. ✅ Add 4 Android secrets (2 min)
2. ✅ Push code (1 min)
3. ✅ Wait for build (15 min)
4. ✅ Download APK (1 min)
5. ✅ Install on phone (1 min)

**Read:** `BUILD_APK_IPA_STEP_BY_STEP.md`

Secrets needed:
```
ANDROID_KEYSTORE_BASE64 (from keystore-base64.txt)
ANDROID_KEYSTORE_PASSWORD (Tongkrongan@2024_637729)
ANDROID_KEY_PASSWORD (Key@2024_236320)
ANDROID_KEY_ALIAS (tongkrongan)
```

---

### 🍎 Path B: Both Android & iOS (60 min) - COMPLETE

**Build for both Android and iPhone**

1. ✅ Add 4 Android secrets (2 min)
2. ⏳ Get iOS certificates on Mac (30 min)*
3. ✅ Add 7 iOS secrets (5 min)
4. ✅ Push code (1 min)
5. ✅ Wait for builds (20 min)
6. ✅ Download APK & IPA (1 min)
7. ✅ Install on devices (1 min)

**Read:** `APK_AND_IPA_COMPLETE_GUIDE.md`

**Note:** *Requires Mac or remote Mac access to get iOS certificates

---

## 📋 YOUR CREDENTIALS

### ✅ Android (Already Generated!)

**Keystore File:** `tongkrongan_app/android/app/upload-keystore.jks`

**Passwords:**
```
ANDROID_KEYSTORE_PASSWORD: Tongkrongan@2024_637729
ANDROID_KEY_PASSWORD: Key@2024_236320
ANDROID_KEY_ALIAS: tongkrongan
```

**Base64:** See `keystore-base64.txt`

### ⏳ iOS (Need Mac to Generate)

You need to get:
- iOS Distribution Certificate (.p12)
- Provisioning Profile (.mobileprovision)
- Apple ID app-specific password

**Guide:** `IOS_BUILD_SETUP_COMPLETE.md`

---

## 📚 DOCUMENTATION

| Document | Purpose | Read When |
|----------|---------|-----------|
| **BUILD_APK_IPA_STEP_BY_STEP.md** | Android guide | Starting Android |
| **IOS_BUILD_SETUP_COMPLETE.md** | iOS guide | Adding iOS |
| **APK_AND_IPA_COMPLETE_GUIDE.md** | Combined guide | Want both |
| **SETUP_11_GITHUB_SECRETS.md** | Secrets reference | Adding secrets |
| **SECRETS_CHECKLIST.md** | All 11 secrets | Quick checklist |
| **QUICK_BUILD_SETUP.md** | Quick reference | Need quick info |
| **CICD_COMPLETE_GUIDE.md** | Full CI/CD info | Deep dive |

---

## 🚀 NEXT 5 MINUTES

### If You're Doing Android Only:

```powershell
# 1. Go to GitHub secrets:
# https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

# 2. Add 4 secrets (use values above)

# 3. Then come back and run:
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"
git add .
git commit -m "Build APK"
git push origin main

# 4. Watch at: https://github.com/RizqonSagena/tongkrongan-app/actions
```

### If You're Doing Both:

```powershell
# 1. Do Android setup first (above)
# 2. Get iOS certificates on Mac (see IOS_BUILD_SETUP_COMPLETE.md)
# 3. Add 7 iOS secrets
# 4. Same push command as above
```

---

## 📊 WORKFLOW OVERVIEW

```
GitHub Repository
├─ .github/workflows/build-android.yml
│  └─ Builds APK on Ubuntu (15 min)
│
├─ .github/workflows/build-ios.yml
│  └─ Builds IPA on macOS (20 min)
│
└─ .github/workflows/deploy-sideloadly.yml (optional)
   └─ Auto-installs on device
```

---

## ✨ WHAT HAPPENS WHEN YOU PUSH

```
1. You: git push origin main
   ↓
2. GitHub detects push
   ↓
3. Workflows trigger automatically
   ├─ build-android.yml starts on Ubuntu
   └─ build-ios.yml starts on macOS (if iOS secrets added)
   ↓
4. Both build in parallel
   ├─ Android: 15 minutes
   └─ iOS: 20 minutes
   ↓
5. Build artifacts available for download
   ├─ app-release.apk
   └─ app.ipa (if iOS)
   ↓
6. You download and install on devices
```

---

## 🎯 DECISION TIME

**Have a Mac right now?**
- YES → Do Path B (Both Android & iOS)
- NO → Do Path A (Android only), add iOS later

**Have Apple Developer Account?**
- YES → Ready for iOS
- NO → ($99/year) or do Android only

**Want auto-install on device?**
- YES → Add Sideloadly setup (2 more secrets)
- NO → Manual download and install

---

## 📱 INSTALLATION OPTIONS

### Android (APK)

✅ **USB Cable + ADB**
```powershell
adb install app-release.apk
```

✅ **Manual** (No tools)
- Transfer APK to phone
- Tap to install
- Allow unknown sources if prompted

✅ **Sideloadly** (Easiest)
- Download: https://sideloadly.io
- Connect phone
- Select APK → Install

### iOS (IPA)

✅ **Sideloadly** (Recommended)
- Download: https://sideloadly.io
- Connect iPhone
- Select IPA → Install
- Enter Apple ID

✅ **Xcode** (Mac only)
- Open app.ipa
- Select device
- Install

✅ **TestFlight** (Official)
- Upload to App Store
- Send link to testers
- Download from app

---

## 🆘 QUICK HELP

### "I don't have a Mac"
→ Do Android only, add iOS later when you have Mac

### "I don't have Apple Developer Account"
→ Do Android only, or get dev account ($99/year)

### "APK build failed"
→ Check all 4 secrets are correct
→ View logs: https://github.com/RizqonSagena/tongkrongan-app/actions

### "Can't find downloaded files"
→ Check Artifacts in workflow run (scroll down)
→ Only appears after build succeeds

### "Certificate password wrong"
→ See `ANDROID_BUILD_CREDENTIALS.txt` for Android
→ Get iOS password from Mac when you export certificate

---

## ✅ SUCCESS CHECKLIST

### First Build (Android):

- [ ] Read `BUILD_APK_IPA_STEP_BY_STEP.md`
- [ ] Add 4 Android secrets to GitHub
- [ ] git push to main
- [ ] Watch workflow: https://github.com/RizqonSagena/tongkrongan-app/actions
- [ ] Download app-release.apk from Artifacts
- [ ] Install on Android phone
- [ ] App runs! ✅

### Second Build (iOS) - Optional:

- [ ] Get iOS certificate & profile on Mac
- [ ] Read `IOS_BUILD_SETUP_COMPLETE.md`
- [ ] Add 7 iOS secrets to GitHub
- [ ] git push to main
- [ ] Watch workflow (builds both now)
- [ ] Download app.ipa from Artifacts
- [ ] Install on iPhone
- [ ] App runs! ✅

---

## 💡 TIPS FOR SUCCESS

1. **Start Simple:** Android first, iOS later
2. **Save Credentials:** Keep passwords safe
3. **Read Guides:** They have detailed steps
4. **Watch Logs:** GitHub shows errors clearly
5. **First Build Slower:** Caching makes 2nd build faster
6. **Keep Updated:** Update certificates when they expire

---

## 🎉 YOU'RE READY!

**Next Step:** Choose your path above and follow the guide.

**Path A (Android):** ~20 minutes  
**Path B (Both):** ~60 minutes

---

## 📞 SUPPORT

All guides are in GitHub repo or local:
- https://github.com/RizqonSagena/tongkrongan-app
- Look for .md files in root directory

**Any questions?** Check CICD_COMPLETE_GUIDE.md for troubleshooting.

---

**Status:** Ready to Build!  
**Date:** September 16, 2026  
**Version:** 1.0

🚀 **Let's build your app!**

