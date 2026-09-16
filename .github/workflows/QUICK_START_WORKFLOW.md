# ⚡ Quick Start: Build Flutter Apps Workflow

**Build both Android APK & iOS IPA automatically!**

---

## 🎯 In 3 Steps

### Step 1: Push Code
```bash
git push origin main
# or
git push origin develop
```

### Step 2: Monitor Build
```
GitHub → Actions → Build Flutter Apps (APK & IPA) → Running...
```

### Step 3: Download Artifacts
```
Wait ~40-50 minutes → Actions → Artifacts → Download
```

---

## 🚀 Manual Trigger (Fastest)

**When:** You want to build right now without pushing code

### From GitHub Web:
1. GitHub.com → Your Repository
2. **Actions** tab
3. **Build Flutter Apps (APK & IPA)** (left sidebar)
4. **Run workflow** (blue button)
5. Select `main` or `develop`
6. **Run workflow** (green button)
7. Wait 40-50 minutes

---

## 📥 Download Artifacts

**After build completes:**

1. Go to workflow run page
2. Scroll to **Artifacts** section
3. Download both:
   - ✅ `android-apk` (app-release.apk)
   - ✅ `ios-ipa-unsigned` (Runner.ipa)

**File sizes:**
- APK: 60-80 MB
- IPA: 80-120 MB

---

## ⏱️ Build Timeline

| Step | Time | Status |
|------|------|--------|
| Android Build | 20-25 min | 🔄 Running |
| iOS Build | 30-40 min | 🔄 Running |
| Parallel | 40-50 min | ⏱️ Expected |
| Download | 2-5 min | 📥 Manual |

---

## 🎨 What Gets Generated

```
Result:
├── android-apk/
│   └── app-release.apk .................... ~65 MB
└── ios-ipa-unsigned/
    └── Runner.ipa ......................... ~100 MB

Ready for:
✓ Android testing (install via Sideloadly)
✓ iOS testing (on macOS, iPad, or iPhone)
✓ Distribution (after signing)
```

---

## 🔍 Monitor Build Progress

### Option 1: GitHub UI
```
Actions → Build Flutter Apps (APK & IPA) → [Run ID] → Logs
```

### Option 2: Real-time Updates
- Refresh: `F5` every 30 seconds
- Or: Enable GitHub notifications

### Option 3: Check Status
- 🟡 Yellow = Running
- 🟢 Green = Success
- 🔴 Red = Failed

---

## ✅ Expected Output

### ✅ Success (Both Artifacts)
```
✅ Both Android APK and iOS IPA builds completed successfully!

📥 ARTIFACTS AVAILABLE:
========================
1. android-apk      → app-release.apk
2. ios-ipa-unsigned → Runner.ipa (unsigned)
```

### ⚠️ Partial Success
```
⚠️  Build completed with some issues
  ❌ Android APK: failed
  ✅ iOS IPA: success
```

### ❌ Complete Failure
```
❌ Both builds failed
Check logs for errors
```

---

## 🆘 Troubleshooting

### "Build didn't start"
✓ Check if you have permissions  
✓ Check repository is public (or you have access)  
✓ Wait 30 seconds and refresh

### "Build timed out after 45/60 min"
✓ This is very rare  
✓ Can happen if GitHub is slow  
✓ Try again - usually succeeds 2nd time

### "APK/IPA file not found"
✓ Check Flutter dependencies (pubspec.yaml)
✓ Run locally: `flutter build apk --release`
✓ Check build logs for errors

### "Artifact download failed"
✓ GitHub removes old artifacts after 30 days
✓ Trigger a new build
✓ Download immediately (don't wait)

---

## 📋 Checklist Before Build

- [ ] All code changes committed and pushed
- [ ] `pubspec.yaml` has all required dependencies
- [ ] No uncommitted local changes
- [ ] Main/develop branches are up to date
- [ ] You have GitHub write permissions

---

## 🔐 Security Notes

✅ **Current Setup (Secure):**
- No signing secrets needed
- APK is unsigned (testing only)
- IPA is unsigned (testing only)
- Perfect for development & QA

📌 **Production Setup (Future):**
- Add Android keystore to GitHub Secrets
- Add iOS signing certificates to GitHub Secrets
- Will require one-time setup (~30 min)

---

## 💡 Pro Tips

**Tip 1: Parallel Execution**
- Android and iOS build simultaneously
- Total time = max(45 min, 60 min) = ~50 min
- Not sequential (not 45 + 60 = 105 min)

**Tip 2: Concurrent Builds**
- Only one build per branch at a time
- New push cancels old build on same branch
- Different branches build independently

**Tip 3: Artifact Retention**
- Artifacts kept for 30 days
- Download immediately after build
- Automatic cleanup after 30 days

**Tip 4: Cache Benefits**
- First build: ~50 minutes
- Subsequent builds: ~45 minutes (cached)
- Cache invalidates when dependencies change

---

## 🔗 Useful Commands

### Trigger from Command Line
```bash
# Using GitHub CLI
gh workflow run build_apps.yml --ref main

# Requires GitHub CLI installed
# Install: brew install gh (macOS) or choco install gh (Windows)
```

### Check Workflow Status
```bash
# List recent runs
gh run list --workflow build_apps.yml

# Watch specific run
gh run watch [RUN_ID]

# Download artifact
gh run download [RUN_ID] -n android-apk
```

---

## 📞 Need Help?

1. **Check logs** → Actions → Workflow Run → Logs
2. **Check guide** → `.github/workflows/README_WORKFLOW.md`
3. **Ask team** → Slack or project channel
4. **Flutter issues** → https://flutter.dev/docs

---

## 🎉 Done!

Your Flutter apps are now building automatically! 🚀

**Next:** Download the APK and test on Android, then IPA for iOS.

---

**Workflow File:** `.github/workflows/build_apps.yml`  
**Status:** ✅ Ready to use  
**Updated:** 2024
