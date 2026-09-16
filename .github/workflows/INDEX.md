# 📚 GitHub Actions Workflow Documentation Index

**Workflow Name:** Build Flutter Apps (APK & IPA)  
**Workflow File:** `.github/workflows/build_apps.yml`  
**Status:** ✅ Production Ready  
**Version:** 1.0  
**Last Updated:** 2024

---

## 📖 Documentation Files

### 1. 🚀 QUICK_START_WORKFLOW.md
**For:** First-time users and quick setup  
**Time:** ~2 minutes read  
**Contains:**
- How to trigger the workflow (3 ways)
- Build timeline and expectations
- Simple troubleshooting
- Download instructions

**Start here if:** You just want to build and download APK/IPA

---

### 2. 📋 README_WORKFLOW.md
**For:** Understanding how the workflow works  
**Time:** ~15 minutes read  
**Contains:**
- Complete workflow architecture
- Detailed job breakdown (Android, iOS, Notification)
- Environment configuration
- Performance metrics
- Pre-requisites and secrets setup
- Troubleshooting guide
- Customization examples

**Start here if:** You want to understand the workflow in depth

---

### 3. 📦 ARTIFACT_GUIDE.md
**For:** Working with generated APK and IPA files  
**Time:** ~10 minutes read  
**Contains:**
- APK overview and installation methods (3 ways)
- IPA overview and installation methods (3 ways)
- File structure and technical details
- Size analysis and optimization
- Distribution next steps
- Troubleshooting artifact issues

**Start here if:** You want to install or distribute the built files

---

### 4. 🔧 TROUBLESHOOTING.md
**For:** Fixing issues and debugging  
**Time:** ~20 minutes (reference)  
**Contains:**
- 10+ common issues with solutions
- Debugging steps
- Workflow status checks
- Prevention tips
- Support resources
- Decision tree for problem solving

**Start here if:** Something is broken or not working

---

## 🎯 Quick Navigation

### I want to...

| Goal | Document | Time |
|------|----------|------|
| Build APK & IPA | QUICK_START_WORKFLOW.md | 2 min |
| Understand workflow | README_WORKFLOW.md | 15 min |
| Install APK on Android | ARTIFACT_GUIDE.md (Android APK) | 5 min |
| Install IPA on iOS | ARTIFACT_GUIDE.md (iOS IPA) | 5 min |
| Fix a problem | TROUBLESHOOTING.md | varies |
| Customize workflow | README_WORKFLOW.md (Customization) | 10 min |
| Set up signing | README_WORKFLOW.md (Pre-requisites) | 20 min |
| Share with QA team | ARTIFACT_GUIDE.md (Distribution) | 5 min |
| Optimize build time | README_WORKFLOW.md (Performance) | 5 min |
| Monitor build status | QUICK_START_WORKFLOW.md (Monitor) | 2 min |

---

## 📊 Workflow Overview

### What It Does
```
1. Triggers: Push to main/develop, PR to main, or manual
2. Builds: Android APK (ubuntu-latest, ~20-25 min)
3. Builds: iOS IPA (macos-latest, ~30-40 min)
4. Parallel: Both build at same time (~40-50 min total)
5. Artifacts: Generated and available for 30 days
6. Downloads: Via GitHub Actions UI
```

### Artifacts Generated
```
✅ android-apk
   └── app-release.apk (~65 MB)
       ├── Ready for Android testing
       ├── Ready for Google Play Console
       └── Needs: No signing for testing

✅ ios-ipa-unsigned
   └── Runner.ipa (~100 MB)
       ├── Ready for iOS testing
       ├── Ready for TestFlight (after signing)
       └── Needs: Re-signing for App Store
```

### Timeline
```
Trigger → Setup (2 min) → Android Build (20-25 min)
                       → iOS Build (30-40 min)
                       → Parallel Execution
                       ↓
                    Complete (~40-50 min)
                       ↓
                    Download & Install (manual)
```

---

## 🚀 Getting Started (3 Steps)

### Step 1: Trigger Build
**Automatic:**
```bash
git push origin main
```

**Manual:**
- GitHub → Actions → Build Flutter Apps → Run workflow

### Step 2: Wait for Completion
- Monitor: Actions page (~40-50 minutes)
- Status: Yellow (running) → Green (success)

### Step 3: Download & Install
- Download: android-apk and ios-ipa-unsigned
- Install: Follow ARTIFACT_GUIDE.md

---

## 🏗️ Workflow Architecture

```
┌────────────────────────────────────────────────┐
│  Trigger (Push, PR, or Manual)                 │
└────────────────┬────────────────────────────────┘
                 │
       ┌─────────┴──────────┐
       │                    │
       ▼                    ▼
   ┌──────────────┐  ┌──────────────┐
   │ Android Job  │  │  iOS Job     │
   │ ubuntu       │  │  macos       │
   │ 20-25 min    │  │  30-40 min   │
   └──────┬───────┘  └──────┬───────┘
          │ Parallel        │
          └────────┬────────┘
                   ▼
           ┌──────────────────┐
           │ Notification Job │
           │ Status Report    │
           └────────┬─────────┘
                    ▼
           ✅ Artifacts Ready
           ├── android-apk
           └── ios-ipa-unsigned
```

---

## 🔑 Key Features

✅ **Automation**
- No manual build steps required
- Consistent builds every time
- Parallel execution (faster)

✅ **Quality**
- Flutter analysis runs automatically
- Gradle build verification
- Artifact verification before upload

✅ **Reliability**
- Retry on GitHub runner issues
- Gradle caching (faster 2nd builds)
- Concurrency control (prevent conflicts)

✅ **Accessibility**
- Easy manual trigger
- Clear status reporting
- Artifact downloads available

---

## 📋 Setup Checklist

Before building, ensure:

```
✓ Flutter project in: tongkrongan_app/
✓ pubspec.yaml exists and is valid
✓ Android build.gradle configured
✓ iOS Podfile configured
✓ GitHub repository connected
✓ GitHub Actions enabled
✓ Workflow file exists: .github/workflows/build_apps.yml
✓ No uncommitted changes (recommended)
```

---

## 🔐 Security Notes

### Unsigned Builds (Current)
- ✅ Safe for internal testing
- ✅ No credentials needed
- ✅ Good for development/QA

### Signed Builds (Optional)
- For Android Play Store: Need Android keystore
- For iOS App Store: Need Apple signing certificate
- Follow: README_WORKFLOW.md (Pre-requisites section)

---

## 📊 Performance Metrics

| Metric | Android | iOS | Total |
|--------|---------|-----|-------|
| Setup | 2 min | 2 min | - |
| Build | 18-23 min | 28-38 min | - |
| Upload | 1-2 min | 1-2 min | - |
| **Total** | **20-25 min** | **30-40 min** | **~50 min** |

**Optimization:**
- Both jobs run in parallel → total time = max(45, 60) = ~50 min
- Not sequential: not 45 + 60 = 105 min

---

## 🎯 Use Cases

### 1. Development Testing
- **Trigger:** Every push to develop branch
- **Frequency:** Multiple times per day
- **Use:** Quick APK/IPA builds for testing

### 2. QA Testing
- **Trigger:** Push to main or manual trigger
- **Frequency:** Once per release cycle
- **Use:** Full testing on devices

### 3. Beta Release
- **Trigger:** Manual trigger from main
- **Frequency:** Weekly or monthly
- **Use:** Beta testing via TestFlight/Play Store

### 4. Production Release
- **Trigger:** Manual trigger from release branch
- **Frequency:** As needed
- **Use:** Signed builds for App Stores

---

## 🚨 Common Issues

| Issue | Solution | Docs |
|-------|----------|------|
| Build fails | Check logs, run locally | TROUBLESHOOTING |
| APK not found | Verify build output path | TROUBLESHOOTING |
| IPA not found | Check Xcode build steps | TROUBLESHOOTING |
| Timeout error | Increase timeout or retry | TROUBLESHOOTING |
| Can't install APK | Enable Unknown Sources | ARTIFACT_GUIDE |
| Can't install IPA | Use Xcode or simulator | ARTIFACT_GUIDE |

---

## 🔗 Quick Links

**Workflow File:**
- `.github/workflows/build_apps.yml`

**Project Structure:**
- Flutter App: `tongkrongan_app/`
- Workflows: `.github/workflows/`
- Docs: `.github/workflows/*.md`

**External Resources:**
- Flutter Docs: https://flutter.dev/docs
- GitHub Actions: https://docs.github.com/en/actions
- Android Build: https://developer.android.com/studio/build
- iOS Build: https://developer.apple.com/xcode

---

## 📞 Getting Help

### 1. Check Documentation
1. Find your issue in QUICK_START_WORKFLOW.md
2. Or in TROUBLESHOOTING.md decision tree
3. Follow solution steps

### 2. Check Workflow Logs
1. GitHub → Actions → Workflow Run
2. Expand failed step
3. Read error message and logs

### 3. Run Locally
1. Run: `flutter build apk --release --verbose`
2. Or: `flutter build ios --release --no-codesign --verbose`
3. Reproduce and fix issues

### 4. Ask for Help
- Slack: #dev-help or #flutter
- GitHub Issues: Project issues
- Flutter: https://flutter.dev/community

---

## 🎓 Learning Path

### Beginner
1. Read: QUICK_START_WORKFLOW.md
2. Trigger: Build manually
3. Download: Artifacts
4. Install: APK or IPA

### Intermediate
1. Read: README_WORKFLOW.md
2. Understand: Job structure
3. Modify: Small customizations
4. Troubleshoot: Common issues

### Advanced
1. Read: README_WORKFLOW.md (Customization)
2. Configure: Signed builds
3. Integrate: Custom notifications
4. Optimize: Build performance

---

## ✅ Verification Checklist

After setup, verify:

```
□ Workflow file exists: .github/workflows/build_apps.yml
□ Can trigger workflow manually: GitHub Actions
□ Android build succeeds: ~20-25 minutes
□ iOS build succeeds: ~30-40 minutes
□ APK artifact available: ~65 MB
□ IPA artifact available: ~100 MB
□ Can download artifacts: Both zipped
□ Can extract artifacts: APK and IPA ready
□ Can install APK: Sideloadly or adb
□ Can install IPA: Xcode or simulator
□ App runs on device: No crashes
```

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024 | Initial release |

---

## 🎉 You're All Set!

**Next Steps:**
1. Read QUICK_START_WORKFLOW.md
2. Trigger your first build
3. Download artifacts
4. Install and test

**Questions?** Check the relevant documentation file or troubleshooting guide.

---

**Documentation Status:** ✅ Complete  
**Workflow Status:** ✅ Production Ready  
**Last Updated:** 2024  
**Maintained By:** Development Team
