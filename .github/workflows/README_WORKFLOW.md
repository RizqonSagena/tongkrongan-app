# GitHub Actions Workflow: Build Flutter Apps (APK & IPA)

**File:** `.github/workflows/build_apps.yml`  
**Status:** ✅ Production Ready  
**Last Updated:** 2024  
**Artifacts Generated:** 2 (android-apk, ios-ipa-unsigned)

---

## 📋 Overview

This GitHub Actions workflow automatically builds and generates Flutter applications for both Android and iOS platforms. It produces two distributable artifacts:

1. **android-apk** → `app-release.apk` (Android APK file)
2. **ios-ipa-unsigned** → `Runner.ipa` (iOS IPA file, unsigned)

The workflow runs on:
- Push to `main` or `develop` branches
- Manual trigger (workflow_dispatch)
- Pull requests to `main` branch

---

## 🏗️ Workflow Architecture

```
┌─────────────────────────────────────────────────────────┐
│          GitHub Actions Workflow Triggered              │
│  (push/PR to main|develop or manual trigger)            │
└──────────────┬──────────────────────────────────────────┘
               │
        ┌──────┴──────┐
        │             │
        ▼             ▼
   ┌─────────┐   ┌──────────┐
   │ Android │   │   iOS    │
   │ APK Job │   │ IPA Job  │
   └────┬────┘   └────┬─────┘
        │             │
        │ (runs in    │ (runs in
        │ parallel)   │  parallel)
        │             │
        ▼             ▼
   APK Built     IPA Built
   (ubuntu)      (macos)
        │             │
        └────┬────────┘
             │
             ▼
    ┌────────────────────┐
    │ Notification Job   │
    │ (always runs)      │
    └────────────────────┘
             │
             ▼
    ✅ Build Status Report
```

---

## 📦 Artifacts Generated

### 1. Android APK
- **File Name:** `app-release.apk`
- **Location:** `tongkrongan_app/build/app/outputs/flutter-apk/app-release.apk`
- **Size:** ~60-80 MB (typical)
- **Platform:** `ubuntu-latest`
- **Timeout:** 45 minutes
- **Retention:** 30 days

### 2. iOS IPA (Unsigned)
- **File Name:** `Runner.ipa`
- **Location:** `tongkrongan_app/Runner.ipa`
- **Size:** ~80-120 MB (typical)
- **Platform:** `macos-latest`
- **Timeout:** 60 minutes
- **Retention:** 30 days
- **Note:** Unsigned - requires additional signing before App Store distribution

---

## 🔧 Environment Configuration

```yaml
FLUTTER_VERSION: 3.24.0    # Flutter SDK version
JAVA_VERSION: 17           # Java version for Android builds
```

**Customization:**
To change versions, edit the `env` section in `build_apps.yml`:
```yaml
env:
  FLUTTER_VERSION: 3.25.0  # Change to desired version
  JAVA_VERSION: 21         # Change to desired version
```

---

## 📍 Detailed Job Breakdown

### Job 1: Build Android APK (`build-android`)

**Runner:** `ubuntu-latest`  
**Timeout:** 45 minutes

#### Steps:
1. **Checkout code** - Clone repository
2. **Set up Java** - Install Java 17 (temurin distribution)
3. **Set up Flutter** - Install Flutter 3.24.0
4. **Get Flutter dependencies** - Run `flutter clean` and `flutter pub get`
5. **Analyze Dart code** - Run static analysis (non-blocking)
6. **Build APK Release** - Compile APK with `flutter build apk --release`
7. **Verify APK artifact** - Confirm APK file exists and display size
8. **Upload APK Artifact** - Store APK for download

#### Key Features:
- ✅ Gradle caching enabled (faster builds)
- ✅ Flutter pub caching enabled
- ✅ Artifact verification before upload
- ✅ Error handling with exit codes

---

### Job 2: Build iOS IPA (`build-ios`)

**Runner:** `macos-latest`  
**Timeout:** 60 minutes

#### Steps:
1. **Checkout code** - Clone repository
2. **Set up Flutter** - Install Flutter 3.24.0
3. **Get Flutter dependencies** - Run `flutter clean` and `flutter pub get`
4. **Analyze Dart code** - Run static analysis (non-blocking)
5. **Build iOS Release (unsigned)** - Compile iOS app with `--no-codesign`
6. **Package iOS Build as IPA** - Create IPA file from Runner.app
7. **Verify IPA artifact** - Confirm IPA file exists and display size
8. **Upload IPA Artifact** - Store IPA for download

#### Key Features:
- ✅ Flutter pub caching enabled
- ✅ No code signing (unsigned IPA)
- ✅ IPA packaging from xcarchive output
- ✅ Artifact verification with zip testing

---

### Job 3: Build Completion Notification (`notify-completion`)

**Runner:** `ubuntu-latest`  
**Depends On:** Both Android and iOS jobs  
**Runs:** Always (success, failure, or partial)

#### Steps:
1. **Check build status** - Verify both job results
2. **Generate status report** - Display build results
3. **Summary** - List available artifacts

#### Output Example:
```
📋 BUILD STATUS REPORT
======================
Android APK: success
iOS IPA:    success

✅ Both Android APK and iOS IPA builds completed successfully!

📥 ARTIFACTS AVAILABLE:
========================
1. android-apk      → app-release.apk
2. ios-ipa-unsigned → Runner.ipa (unsigned)
```

---

## 🚀 How to Trigger the Workflow

### Method 1: Automatic Trigger (Push)
```bash
# Push to main or develop branches
git push origin main
# or
git push origin develop
```

### Method 2: Automatic Trigger (Pull Request)
```bash
# Create PR to main branch
# Workflow triggers automatically
```

### Method 3: Manual Trigger
1. Navigate to GitHub repository
2. Go to **Actions** tab
3. Select **Build Flutter Apps (APK & IPA)** workflow
4. Click **Run workflow**
5. Select branch (main/develop)
6. Click green **Run workflow** button

**Expected wait time:**
- Android APK: ~20-25 minutes
- iOS IPA: ~30-40 minutes
- Total: ~40-50 minutes (parallel execution)

---

## 📥 Downloading Artifacts

### Step 1: Navigate to Artifacts
```
GitHub → Repository → Actions → Workflow Run → Artifacts
```

### Step 2: Download
- Download `android-apk` folder (contains app-release.apk)
- Download `ios-ipa-unsigned` folder (contains Runner.ipa)

### Step 3: Extract if Needed
```bash
# Artifacts are zipped, extract them:
unzip android-apk.zip
unzip ios-ipa-unsigned.zip
```

---

## 🔐 Pre-requisites & Secrets

### For Android APK (Signing):
If you want signed APKs, configure:
- `ANDROID_KEYSTORE_BASE64` (keystore file encoded)
- `ANDROID_KEYSTORE_PASSWORD` (keystore password)
- `ANDROID_KEY_PASSWORD` (key password)
- `ANDROID_KEY_ALIAS` (key alias)

**Current Status:** Uses `--release` flag without signing  
**Note:** Add secrets to GitHub → Settings → Secrets and variables → Actions

### For iOS IPA (Signing):
If you want signed IPAs, configure:
- `APPLE_CERTIFICATE_BASE64` (signing certificate)
- `APPLE_CERTIFICATE_PASSWORD` (certificate password)
- `APPLE_PROVISIONING_PROFILE_BASE64` (provisioning profile)
- `APPLE_KEYCHAIN_PASSWORD` (keychain password)

**Current Status:** Unsigned (`--no-codesign`)  
**Note:** Requires Apple Developer Account ($99/year)

---

## ✅ Troubleshooting

### Issue 1: APK Build Fails
**Symptoms:** "gradle build failed"
```
Solution:
1. Check if pubspec.yaml has all dependencies
2. Run locally: flutter build apk --release
3. Check Java version compatibility
```

### Issue 2: IPA Build Fails
**Symptoms:** "iOS build failed" or "Runner.app not found"
```
Solution:
1. Check iOS deployment target (11+)
2. Run locally: flutter build ios --release --no-codesign
3. Verify CocoaPods dependencies: cd ios && pod install
```

### Issue 3: Artifact Not Found
**Symptoms:** "if-no-files-found: error"
```
Solution:
1. Check workflow logs for build errors
2. Verify output paths match (check build.gradle or Runner.app location)
3. Re-run workflow manually after fixing
```

### Issue 4: Timeout
**Symptoms:** "Timeout after 45/60 minutes"
```
Solution:
1. Check GitHub Actions runner availability
2. Clear Flutter cache: flutter clean
3. Increase timeout-minutes in workflow file
```

### Issue 5: Cache Not Working
**Symptoms:** "gradle/flutter cache miss"
```
Solution:
1. Cache keys use branch ref automatically
2. Force cache clear by pushing to new branch
3. Or manually clear Actions cache in GitHub
```

---

## 📊 Performance Metrics

| Metric | Android | iOS | Total |
|--------|---------|-----|-------|
| Runner | ubuntu-latest | macos-latest | - |
| Setup | ~2 min | ~2 min | - |
| Build | ~15-20 min | ~25-35 min | - |
| Upload | ~2 min | ~2 min | - |
| Total | ~20-25 min | ~30-40 min | **~40-50 min** |
| Artifact Size | 60-80 MB | 80-120 MB | ~150-200 MB |

**Optimization Tips:**
- Both jobs run in parallel → total time is max of both
- Caching reduces setup time on subsequent runs
- Compression disabled for artifacts (faster upload)

---

## 🔄 Workflow Concurrency

**Current Setting:**
```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

**Behavior:**
- Only one workflow runs per branch
- New triggers cancel in-progress builds on same branch
- Main and develop can build simultaneously
- Prevents resource waste

---

## 📝 File Structure Expected

```
tongkrongan_app/
├── android/
│   ├── app/
│   │   ├── build.gradle.kts
│   │   ├── src/
│   │   └── upload-keystore.jks (optional)
│   ├── build.gradle.kts
│   └── settings.gradle.kts
├── ios/
│   ├── Runner/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   ├── Podfile
│   └── ExportOptions.plist
├── lib/
├── pubspec.yaml
├── pubspec.lock
└── build/
    ├── app/
    │   └── outputs/flutter-apk/app-release.apk (generated)
    └── ios/
        └── iphoneos/Runner.app/ (generated)
```

---

## 🛠️ Customization Guide

### Modify Workflow Triggers
```yaml
on:
  push:
    branches:
      - main
      - develop
      - staging  # Add new branch
  pull_request:
    branches:
      - main
```

### Add Signed APK
Replace build step with:
```yaml
- name: Build Signed APK
  working-directory: tongkrongan_app
  env:
    KEYSTORE_BASE64: ${{ secrets.ANDROID_KEYSTORE_BASE64 }}
    KEYSTORE_PASSWORD: ${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
    KEY_PASSWORD: ${{ secrets.ANDROID_KEY_PASSWORD }}
    KEY_ALIAS: ${{ secrets.ANDROID_KEY_ALIAS }}
  run: |
    echo $KEYSTORE_BASE64 | base64 -d > android/app/upload-keystore.jks
    flutter build apk --release \
      --build-name=1.0.0 \
      --build-number=${{ github.run_number }}
```

### Add Slack Notification
```yaml
- name: Notify Slack
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    text: 'Build ${{ job.status }}: Android APK ready'
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

### Add Version Numbers
```yaml
- name: Build with Version
  working-directory: tongkrongan_app
  run: |
    flutter build apk --release \
      --build-name=1.0.${{ github.run_number }} \
      --build-number=${{ github.run_number }}
```

---

## 📚 References

- [Flutter Build Commands](https://flutter.dev/docs/deployment)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter Version Management](https://flutter.dev/docs/release/archive)
- [Android Build Configuration](https://developer.android.com/studio/build)
- [iOS Build Configuration](https://developer.apple.com/documentation/xcode)

---

## ✨ Best Practices

✅ **Do:**
- Use stable Flutter versions (3.x+)
- Enable caching for faster builds
- Verify artifacts before uploading
- Set appropriate timeouts (45+ min for Android, 60+ min for iOS)
- Use `--verbose` flag for debugging
- Store credentials as GitHub Secrets

❌ **Don't:**
- Use development versions of Flutter
- Run both Android and iOS sequentially (use parallel)
- Commit sensitive files to repository
- Ignore build failures in CI/CD
- Use untested Flutter versions
- Store plaintext credentials in code

---

## 📞 Support

For issues with the workflow:
1. Check GitHub Actions logs
2. Run locally to reproduce
3. Check Flutter documentation
4. Review Android/iOS build configs
5. Check GitHub Status page

---

**Workflow Status:** ✅ Production Ready  
**Last Verification:** 2024  
**Maintainer:** Development Team
