# Quick Reference: Build Flutter Apps Workflow

## ⚡ 30-Second Guide

**Want to build Android APK + iOS IPA automatically?**

```bash
# Option 1: Push to main/develop (automatic)
git push origin main

# Option 2: Manual trigger via GitHub UI
# Actions → Build Flutter Apps → Run workflow
```

**Result:** 2 files ready in ~1.5 hours
- ✅ `android-apk` → app-release.apk
- ✅ `ios-ipa-unsigned` → Runner.ipa

---

## 📋 What Gets Built

| Platform | File | Size | Time |
|----------|------|------|------|
| Android | app-release.apk | ~50-100 MB | 45 min |
| iOS | Runner.ipa | ~100-200 MB | 60 min |

**Both run in parallel → Total time: ~60 min**

---

## 🎯 Common Workflows

### ✅ I want to build a new release
```bash
git push origin main
# Automatically triggers build
```

### ✅ I want to test changes manually
1. Go to GitHub Actions
2. Click "Build Flutter Apps (APK & IPA)"
3. Click "Run workflow" button
4. Wait ~60 minutes
5. Download artifacts

### ✅ I want to check build status
1. Go to Actions tab
2. Look for "Build Flutter Apps" workflow
3. Click on running workflow
4. Watch logs in real-time

### ✅ I want to download APK/IPA
1. Actions → Build Flutter Apps workflow run
2. Scroll down to Artifacts
3. Download: `android-apk` or `ios-ipa-unsigned`

---

## 🐛 Quick Troubleshooting

| Problem | Quick Fix |
|---------|-----------|
| Build failed | Check logs in Actions tab |
| APK not found | Wait for Android job to complete |
| IPA not found | Wait for iOS job to complete |
| Timeout error | Increase timeout-minutes in workflow |
| Cache issues | Re-run workflow (cache will refresh) |

---

## 📊 Build Progress

```
START
  ├─ Android Build (45 min) ──┐
  ├─ iOS Build (60 min) ──────┤
  └─ Summary Report ◄─────────┘
END
```

**Total time:** ~60 minutes (parallel)

---

## 📥 Artifact Locations

**In GitHub Actions UI:**
```
GitHub → Actions → Build Flutter Apps (latest run) → Artifacts
```

**File Names:**
- `android-apk` → Contains `app-release.apk`
- `ios-ipa-unsigned` → Contains `Runner.ipa`

---

## 🔗 Links

- **Workflow File:** `.github/workflows/build_apps.yml`
- **Full Docs:** `.github/workflows/BUILD_APPS_DOCUMENTATION.md`
- **GitHub Actions:** https://github.com/YOUR_REPO/actions

---

## 🆘 Need Help?

1. Check Build Status → Actions tab
2. Read Full Documentation → `BUILD_APPS_DOCUMENTATION.md`
3. Check Error Logs → Click workflow run
4. Review TROUBLESHOOTING.md

---

**Pro Tip:** You can run builds on main/develop automatically, or manually trigger them anytime!
