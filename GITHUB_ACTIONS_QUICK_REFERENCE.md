# ⚡ GitHub Actions Build Workflow - Quick Reference

**File:** `.github/workflows/build_apps.yml`

---

## 🚀 How to Build (Choose One)

### Option 1: Automatic (On Push)
```bash
git push origin main
# Workflow triggers automatically ✅
```

### Option 2: Manual (Via GitHub UI)
1. Go to `Actions` tab
2. Click `Build Flutter Apps (APK & IPA)`
3. Click `Run workflow` → Select branch → `Run`

### Option 3: Command Line
```bash
gh workflow run build_apps.yml --ref main
```

---

## ⏱️ Timeline

| Step | Duration | What's Happening |
|------|----------|-----------------|
| Android Build | 25-35 min | Java setup, Flutter build, APK generation |
| iOS Build | 35-50 min | macOS setup, Flutter build, IPA packaging |
| **Total** (parallel) | **45-60 min** | Both run simultaneously |

---

## 📦 What You Get

| Artifact | Size | Location |
|----------|------|----------|
| **android-apk** | 60-75 MB | `build/app/outputs/flutter-apk/app-release.apk` |
| **ios-ipa-unsigned** | 80-100 MB | `Runner.ipa` (unsigned, for Sideloadly) |

---

## 📥 Download Artifacts

**After build completes (green checkmark):**

1. Click the workflow run
2. Scroll to "Artifacts" section
3. Download:
   - `android-apk` → app-release.apk
   - `ios-ipa-unsigned` → Runner.ipa

---

## 💻 Install on Device

### Android (APK)
```
Sideloadly:
1. Open Sideloadly
2. Connect phone via USB
3. Drag & drop APK
4. Click Install ✅
```

### iOS (IPA)
```
Sideloadly:
1. Open Sideloadly
2. Connect iPhone via USB
3. Trust on device
4. Drag & drop IPA
5. Click Install ✅
```

---

## 🔍 Monitor Build

**In real-time:**
- Go to `Actions` → Select workflow
- View logs for each job
- See artifact verification steps

**Build logs show:**
- ✅ Dependencies installed
- ✅ Code analyzed
- ✅ Build completed
- ✅ Artifact uploaded

---

## ⚠️ If Build Fails

### Check:
1. **Build logs** — Click on failed step
2. **Local test** — Run `flutter build apk/ios` locally
3. **Secrets** — (If using signing)
4. **Dependencies** — Run `flutter pub get`

### Quickest Fix:
```bash
cd tongkrongan_app
flutter clean
flutter pub get
git push origin main  # Retry build
```

---

## 🔧 Configuration

### Edit Workflow File
**Location:** `.github/workflows/build_apps.yml`

**Common changes:**
```yaml
env:
  FLUTTER_VERSION: 3.24.0    # Change Flutter version
  JAVA_VERSION: 17            # Change Java version

retention-days: 30            # Change artifact retention
```

---

## 📊 Status Badges

**Add to README.md:**
```markdown
[![Build Flutter Apps](https://github.com/RizqonSagena/tongkrongan-app/workflows/Build%20Flutter%20Apps%20%28APK%20%26%20IPA%29/badge.svg)](https://github.com/RizqonSagena/tongkrongan-app/actions/workflows/build_apps.yml)
```

---

## ✅ Pre-Flight Check

Before building:
```
[ ] Code committed and pushed
[ ] No merge conflicts
[ ] All tests passing locally
[ ] Flutter version compatible
[ ] No breaking changes
```

---

## 📞 Troubleshooting

| Issue | Solution |
|-------|----------|
| Build timeout | Reduce Flutter version complexity |
| APK not found | Check logs, verify build succeeded |
| IPA not found | Ensure iOS build steps completed |
| Artifact upload fails | Check file paths, rebuild |

---

## 💡 Pro Tips

- ✅ Builds run **in parallel** (faster)
- ✅ Failed builds are **auto-logged** (easy debug)
- ✅ Artifacts kept **30 days** (plenty of time)
- ✅ No secrets needed (unsigned builds)

---

## 🔗 Related Docs

- **Full Details:** `GITHUB_ACTIONS_BUILD_WORKFLOW.md`
- **APK Setup:** `QUICK_START_APK.md`
- **Installation:** `INSTALL_APK_SIDELOADLY.md`

---

**Status:** ✅ Ready to use  
**Last Updated:** 2024
