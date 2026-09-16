# 🚀 GitHub Actions Build Workflow - Quick Reference

**File:** `.github/workflows/build_apps.yml`  
**Status:** ✅ Production Ready  
**Time:** ~50 minutes per build

---

## ⚡ 30-Second Quick Start

### To Build APK & IPA:

```bash
# 1. Push to main branch
git push origin main

# 2. Go to GitHub Actions
# https://github.com/RizqonSagena/tongkrongan-app/actions

# 3. Wait ~50 minutes

# 4. Download artifacts
# Artifacts section → android-apk & ios-ipa-unsigned
```

---

## 📦 What You Get

```
✅ android-apk       → app-release.apk (65-80 MB)
✅ ios-ipa-unsigned  → Runner.ipa (100-120 MB)
```

Both files ready for testing in ~50 minutes

---

## 🎯 3 Ways to Trigger Build

### Method 1: Push to Repository
```bash
git push origin main
```

### Method 2: Manual UI Trigger
```
Actions → Build Flutter Apps → Run workflow → main → Run workflow
```

### Method 3: GitHub CLI
```bash
gh workflow run build_apps.yml -f branch=main
```

---

## 📥 Download Artifacts

```
1. Go to GitHub Actions page
2. Click workflow run (should be green/yellow)
3. Scroll to "Artifacts" section
4. Download both zip files
5. Extract APK and IPA
```

---

## 💾 Install APK (Android)

### Easiest: Sideloadly
```
1. Download: https://sideloadly.io
2. Connect Android device (USB)
3. Enable USB Debugging on device
4. Open Sideloadly
5. Select device + app-release.apk
6. Click "Install"
```

### Alternative: Command Line
```bash
adb install -r app-release.apk
```

### Alternative: Android Studio
```
Android Studio → Device Manager → Run APK → Select file
```

---

## 💾 Install IPA (iOS)

### Simulator (Recommended)
```bash
xcrun simctl install "iPhone 15 Pro" Runner.ipa
```

### Physical Device
```
Use Xcode to build & sign directly
(Unsigned IPA requires signing first)
```

---

## ⏱️ Timeline

```
Trigger → Ubuntu (20-25 min) → APK Ready
       ↘ macOS (30-40 min) ↗ IPA Ready
                    ↓
           Both artifacts ready
                    ↓
              Download & Install
```

**Total:** ~50 minutes

---

## 🔧 Configuration

**Flutter:** 3.24.0  
**Java:** 17  
**iOS Deployment:** 11.0+  
**Android Target:** API 21+

---

## ✅ Troubleshooting Quick Check

| Issue | Check | Fix |
|-------|-------|-----|
| Build fails | Logs | Run locally first |
| APK not found | Build error | Check Android config |
| IPA not found | Build error | Check iOS config |
| Can't install APK | USB Debug | Enable on device |
| Can't install IPA | Simulator | Use simulator not device |

---

## 📚 Full Docs

- **Detailed:** `README_WORKFLOW.md`
- **Index:** `INDEX.md`
- **Install Help:** `ARTIFACT_GUIDE.md`
- **Troubleshooting:** `TROUBLESHOOTING.md`

---

## 🎉 That's It!

Push code → Wait 50 min → Download APK/IPA → Install → Test

**Status:** ✅ Ready to use!

