# 📊 GitHub Actions Build Workflow - Complete Guide

## 🎯 Workflow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                  GITHUB ACTIONS WORKFLOW                         │
│              Build Flutter Apps (APK & IPA)                      │
└─────────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┴─────────┐
                    │                   │
            ┌───────▼────────┐  ┌──────▼──────────┐
            │  BUILD ANDROID │  │   BUILD iOS    │
            │      APK       │  │   IPA UNSIGNED │
            │ (25-35 min)    │  │   (35-50 min)  │
            └───────┬────────┘  └──────┬──────────┘
                    │                   │
            ┌───────▼────────┐  ┌──────▼──────────┐
            │  VERIFY APK    │  │  VERIFY IPA    │
            │  ✓ File exists │  │  ✓ File exists │
            │  ✓ Check size  │  │  ✓ Check size  │
            └───────┬────────┘  └──────┬──────────┘
                    │                   │
            ┌───────▼────────┐  ┌──────▼──────────┐
            │ UPLOAD ARTIFACT│  │ UPLOAD ARTIFACT│
            │  android-apk   │  │ ios-ipa-unsigned
            └───────┬────────┘  └──────┬──────────┘
                    │                   │
                    └─────────┬─────────┘
                              │
                    ┌─────────▼─────────┐
                    │ NOTIFY COMPLETION │
                    │  ✅ Both Success  │
                    └───────────────────┘
```

---

## 📋 Step-by-Step Workflow Breakdown

### Phase 1: Initialization (Parallel)

#### Android Track
```
Step 1: Checkout code
        └─ Git clone with full history

Step 2: Setup Java 17
        └─ Install Temurin JDK 17
        └─ Enable Gradle caching

Step 3: Setup Flutter
        └─ Install Flutter 3.24.0
        └─ Install Dart SDK 3.13.2
        └─ Enable Dart package caching
```

#### iOS Track
```
Step 1: Checkout code
        └─ Git clone with full history

Step 2: Setup Flutter
        └─ Install Flutter 3.24.0
        └─ Install Dart SDK 3.13.2
        └─ Enable Dart package caching
```

---

### Phase 2: Dependencies & Analysis

#### Android Track
```
Step 4: Get Flutter dependencies
        └─ flutter clean
        └─ flutter pub get
        └─ ~500 packages resolved

Step 5: Analyze Dart code
        └─ flutter analyze --no-fatal-infos
        └─ Checks for linting issues
        └─ Non-blocking (continues-on-error: true)
```

#### iOS Track
```
Step 3: Get Flutter dependencies
        └─ flutter clean
        └─ flutter pub get
        └─ ~500 packages resolved

Step 4: Analyze Dart code
        └─ flutter analyze --no-fatal-infos
        └─ Checks for linting issues
        └─ Non-blocking (continues-on-error: true)
```

---

### Phase 3: Build

#### Android Build
```
Step 6: Build APK Release
        └─ flutter build apk --release --verbose
        
        Process:
        ├─ Compile Dart to native code (ARM64)
        ├─ Merge resources
        ├─ Create DEX files
        ├─ Package into APK
        └─ Output: app-release.apk (60-75 MB)
        
        Duration: ~20-30 minutes
```

#### iOS Build
```
Step 5: Build iOS Release (Unsigned)
        └─ flutter build ios --release --no-codesign --verbose
        
        Process:
        ├─ Compile Dart to native code (ARM64)
        ├─ Link with iOS frameworks
        ├─ Create Runner.app bundle
        └─ Generate app metadata
        
        Duration: ~30-45 minutes
```

---

### Phase 4: Packaging & Verification

#### Android Verification
```
Step 7: Verify APK artifact
        
        Check:
        ├─ File exists: 
        │  tongkrongan_app/build/app/outputs/flutter-apk/app-release.apk
        ├─ File size: ~60-75 MB
        ├─ File permissions: Readable
        └─ ✓ Pass verification
```

#### iOS Packaging & Verification
```
Step 6: Package iOS Build as IPA
        
        Process:
        ├─ Create Payload/ directory
        ├─ Move Runner.app into Payload/
        ├─ Create ZIP: Runner.ipa
        └─ Output: Payload/Runner.app (packaged)
        
Step 7: Verify IPA artifact
        
        Check:
        ├─ File exists: tongkrongan_app/Runner.ipa
        ├─ File size: ~80-100 MB
        ├─ ZIP structure valid
        ├─ Payload/Runner.app present
        └─ ✓ Pass verification
```

---

### Phase 5: Artifact Upload

#### Android Upload
```
Step 8: Upload APK Artifact
        
        ├─ Artifact Name: android-apk
        ├─ File Path: app-release.apk
        ├─ If No Files: Error (fail build)
        ├─ Retention: 30 days
        ├─ Compression: Off (speed)
        └─ ✅ Uploaded to GitHub Artifacts
```

#### iOS Upload
```
Step 8: Upload IPA Artifact
        
        ├─ Artifact Name: ios-ipa-unsigned
        ├─ File Path: Runner.ipa
        ├─ If No Files: Error (fail build)
        ├─ Retention: 30 days
        ├─ Compression: Off (speed)
        └─ ✅ Uploaded to GitHub Artifacts
```

---

### Phase 6: Completion Notification

```
Step 9: Set build status
        
        Result Check:
        ├─ If Android: Success AND iOS: Success
        │  └─ ✅ Both Android APK and iOS IPA 
        │     builds completed successfully!
        │
        ├─ If Android: Failed OR iOS: Failed
        │  └─ ⚠️  Build completed with status:
        │     ├─ Android APK: success/failed
        │     └─ iOS IPA: success/failed
        │
        └─ Display on Actions page
```

---

## 📥 Download & Install Flow

```
┌──────────────────────────────┐
│  WORKFLOW COMPLETED ✅       │
│  (45-60 minutes)             │
└──────────────────┬───────────┘
                   │
        ┌──────────▼──────────┐
        │ GO TO: GitHub.com   │
        │ Repository →        │
        │ Actions Tab         │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────────────────┐
        │ ARTIFACTS SECTION               │
        │ ├─ android-apk                  │
        │ │  └─ app-release.apk (60MB)    │
        │ └─ ios-ipa-unsigned             │
        │    └─ Runner.ipa (90MB)         │
        └──────────┬──────────────────────┘
                   │
        ┌──────────┴───────────┐
        │                      │
    ┌───▼────────────┐  ┌─────▼─────────┐
    │ ANDROID: APK   │  │ iOS: IPA      │
    │                │  │                │
    │ Download APK   │  │ Download IPA   │
    │ ↓              │  │ ↓              │
    │ Install via    │  │ Install via    │
    │ Sideloadly     │  │ Sideloadly     │
    │ ↓              │  │ ↓              │
    │ Test app       │  │ Test app       │
    │ ✅ READY       │  │ ✅ READY       │
    └────────────────┘  └────────────────┘
```

---

## 🔄 Trigger Methods

### Method 1: Automatic Push Trigger

```bash
# Make changes
$ code lib/main.dart

# Commit
$ git add .
$ git commit -m "Add new feature"

# Push to main or develop
$ git push origin main

# ⏳ Workflow triggers automatically
# 📊 Monitor in Actions tab
```

**Triggers on:** Push to `main` or `develop` branches

---

### Method 2: Manual Workflow Dispatch

```
1. GitHub.com → Your Repository
2. Click "Actions" tab
3. Select "Build Flutter Apps (APK & IPA)"
4. Click "Run workflow" button
5. Select branch: main / develop
6. Click green "Run workflow" button
7. ⏳ Build starts (45-60 minutes)
```

**Advantages:**
- ✅ Trigger on any branch
- ✅ Rebuild without code changes
- ✅ Test workflow updates

---

### Method 3: GitHub CLI

```bash
# Trigger workflow on main branch
$ gh workflow run build_apps.yml --ref main

# Trigger on develop branch
$ gh workflow run build_apps.yml --ref develop

# View workflow runs
$ gh run list --workflow=build_apps.yml

# Download artifacts
$ gh run download <run-id> -n android-apk
$ gh run download <run-id> -n ios-ipa-unsigned

# View logs
$ gh run view <run-id>
```

---

## 📊 Workflow Configuration Details

### File Structure
```
.github/
└── workflows/
    └── build_apps.yml ← Main workflow file
```

### Key Configuration
```yaml
# Trigger conditions
on:
  push:
    branches: [main, develop]
  workflow_dispatch:           # Manual trigger
  pull_request:
    branches: [main]

# Environment variables
env:
  FLUTTER_VERSION: 3.24.0      # Pinned version
  JAVA_VERSION: 17              # For Android

# Concurrency control
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true      # Cancel old builds on new push
```

---

## 🔐 Security Features

### Build Isolation
```
✅ Each job runs on fresh runner
✅ No shared state between jobs
✅ Secrets injected at runtime only
✅ Source code never exposed in logs
```

### Artifact Security
```
✅ Artifacts stored in GitHub-secured storage
✅ 30-day retention (configurable)
✅ Accessible only to repository members
✅ HTTPS download only
```

### Secrets Management
```
✅ Secrets never printed in logs
✅ Masked in workflow output
✅ Only used during build
✅ Separate storage from code
```

---

## 📈 Performance Metrics

### Build Time Breakdown
```
Phase 1: Setup (3-5 min each)
├─ Checkout: 1 min
├─ Java/Flutter setup: 2 min
└─ Dependency cache: 1 min

Phase 2: Dependencies (5-10 min each)
├─ flutter pub get: 3 min
├─ Code analysis: 2-5 min
└─ Cache restoration: 1 min

Phase 3: Build (20-45 min each)
├─ Android compile: 20-30 min
├─ iOS compile: 30-45 min
└─ Parallel = ~35-50 min

Phase 4: Verify & Upload (3-5 min each)
├─ APK verification: 1 min
├─ IPA verification: 1 min
├─ APK upload: 2 min
└─ IPA upload: 2-3 min

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total (Parallel): 45-60 minutes
```

### File Size Comparison
```
Source Code:          ~50 MB
Build Artifacts:     ~150 MB total
  ├─ android-apk:     60-75 MB
  └─ ios-ipa:         80-100 MB

Compiled Size:       ~35-50% of iOS, ~30-40% of Android
```

### Resource Usage
```
GitHub Actions Runner:
├─ CPU: 2-core (shared)
├─ RAM: 7 GB available
├─ Storage: 14 GB (SSD)
└─ Network: High-speed fiber

Per-build estimates:
├─ CPU time: ~80-120 min (parallel)
├─ Storage: ~200 MB peak
└─ Network: ~1-2 GB download
```

---

## 🐛 Common Issues & Solutions

### Issue 1: Build Timeout

**Symptom:**
```
Workflow cancelled after 6 hours (GitHub limit)
or 60 minutes (configured timeout)
```

**Cause:**
- Slow dependency download
- Large build artifacts
- Network issues

**Solution:**
```bash
# Clear cache and retry
$ git push origin main

# Or increase timeout (in workflow):
timeout-minutes: 120  # Instead of 60
```

---

### Issue 2: APK Not Found

**Symptom:**
```
Error: APK file not found!
```

**Causes:**
- Build failed (check logs)
- Wrong output path
- Gradle error

**Solution:**
```bash
# Test locally
$ cd tongkrongan_app
$ flutter build apk --release --verbose

# Check logs for actual error
# Fix issue locally
$ git push origin main
```

---

### Issue 3: IPA Packaging Failed

**Symptom:**
```
Error: IPA file not found!
```

**Causes:**
- iOS build failed
- Payload directory issue
- Zip failed

**Solution:**
```bash
# Test iOS build locally
$ flutter build ios --release --no-codesign --verbose

# Verify structure
$ ls -la build/ios/iphoneos/

# Fix issue, retry build
```

---

### Issue 4: Artifact Upload Fails

**Symptom:**
```
Error: Artifact upload failed
```

**Causes:**
- File not found
- Storage quota exceeded
- Network timeout

**Solution:**
```yaml
# Change to warning instead of error
- name: Upload APK Artifact
  uses: actions/upload-artifact@v4
  with:
    if-no-files-found: warn  # Instead of error
```

---

## 📚 Workflow File Location

```
Project Root:
c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\
    ├── .github/
    │   └── workflows/
    │       └── build_apps.yml ← THIS FILE
    ├── tongkrongan_app/
    ├── .gitignore
    ├── README.md
    └── [other files]
```

---

## ✅ Verification Checklist

Before each build:

```
Code Quality:
[ ] No uncommitted changes
[ ] Latest version of main branch
[ ] All tests passing locally
[ ] No obvious errors in code

Dependencies:
[ ] pubspec.yaml updated
[ ] flutter pub get runs successfully
[ ] No dependency conflicts

Flutter Project:
[ ] Flutter version: 3.13.2+
[ ] Dart SDK: 3.13.2+
[ ] Minimum iOS: 11.0
[ ] Minimum Android: 21 (API 21)

GitHub:
[ ] Actions tab accessible
[ ] No prior failed builds blocking
[ ] Sufficient artifact storage (150 MB)
[ ] Branch protection rules not blocking
```

---

## 🎯 Best Practices

### Before Each Build
```
1. Commit all changes
2. Push to main or develop
3. Verify branch has latest code
4. Check no local uncommitted changes
```

### During Build
```
1. Monitor workflow in Actions tab
2. Check logs for warnings
3. Verify all steps complete
4. Note any yellow warnings
```

### After Build
```
1. Download both artifacts
2. Test APK on Android device
3. Test IPA on iOS device
4. Verify app functionality
5. Document any issues
```

---

## 🚀 Next Steps

### To Start Using This Workflow:

**Step 1:** Ensure Flutter is installed
```bash
flutter --version
```

**Step 2:** Push code to main
```bash
git push origin main
```

**Step 3:** Go to Actions tab
```
GitHub.com → Repository → Actions
```

**Step 4:** Monitor build
```
Click workflow → View logs → Wait for completion
```

**Step 5:** Download artifacts
```
Artifacts section → Download android-apk and ios-ipa-unsigned
```

**Step 6:** Install on devices
```
Use Sideloadly or similar tool to install APK and IPA
```

---

## 📞 Support Resources

| Resource | Location |
|----------|----------|
| This guide | `GITHUB_ACTIONS_WORKFLOW_GUIDE.md` |
| Quick ref | `GITHUB_ACTIONS_QUICK_REFERENCE.md` |
| Full docs | `GITHUB_ACTIONS_BUILD_WORKFLOW.md` |
| APK setup | `QUICK_START_APK.md` |
| Installation | `INSTALL_APK_SIDELOADLY.md` |

---

## 📝 Summary

**Your GitHub Actions workflow automatically:**
- ✅ Builds Android APK (60-75 MB)
- ✅ Builds iOS IPA unsigned (80-100 MB)
- ✅ Verifies all artifacts
- ✅ Uploads to GitHub Artifacts
- ✅ Notifies on completion

**Total time:** 45-60 minutes  
**Triggers:** Push to main/develop or manual  
**Downloads:** Via GitHub Actions tab  
**Installation:** Sideloadly or similar tool  

---

**Status:** ✅ Ready to use  
**Last Updated:** 2024  
**File:** `.github/workflows/build_apps.yml`
