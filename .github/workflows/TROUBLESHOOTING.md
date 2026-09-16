# 🔧 Troubleshooting Guide

**Workflow:** `.github/workflows/build_apps.yml`  
**Status Page:** GitHub Status (https://www.githubstatus.com)

---

## 🚨 Common Issues & Solutions

### 1. Android Build Fails - Gradle Error

**Error Message:**
```
FAILURE: Build failed with an exception.
* What went wrong:
Execution failed for task ':app:compileReleaseKotlin'
```

**Causes:**
- Dependency conflicts
- Java version mismatch
- Kotlin version issues
- Memory limitations

**Solutions:**

**Option A: Update Dependencies**
```bash
cd tongkrongan_app
flutter clean
flutter pub get
flutter pub upgrade
```

**Option B: Check Gradle**
```bash
# Check build.gradle.kts
cat android/app/build.gradle.kts | grep -E "compileSdk|targetSdk|minSdk"

# Expected:
# compileSdk 34
# targetSdk 34
# minSdk 21
```

**Option C: Run Locally**
```bash
cd tongkrongan_app
flutter build apk --release --verbose

# See detailed error output
```

**Option D: Clear Caches**
```bash
flutter clean
rm -rf build/
rm -rf ~/.gradle  # On macOS/Linux
# or for Windows:
# rmdir /s %USERPROFILE%\.gradle
```

---

### 2. iOS Build Fails - Xcode Error

**Error Message:**
```
Xcode build failed with error code 1
or
Unable to boot simulator
```

**Causes:**
- Pod dependency issues
- iOS deployment target mismatch
- Memory/storage issues
- Xcode version incompatibility

**Solutions:**

**Option A: Clean CocoaPods**
```bash
cd tongkrongan_app/ios
rm -rf Pods/
rm Podfile.lock
pod install --repo-update
cd ..
```

**Option B: Check Deployment Target**
```bash
# Check ios/Podfile
cat ios/Podfile | grep "platform"

# Should be: platform :ios, '11.0' or higher
```

**Option C: Run Locally**
```bash
cd tongkrongan_app
flutter build ios --release --no-codesign --verbose

# See detailed error output
```

**Option D: Rebuild IPA**
```bash
cd tongkrongan_app
rm -rf build/
flutter build ios --release --no-codesign
cd build/ios/iphoneos
mkdir -p Payload
mv Runner.app Payload/
zip -r -q ../../../Runner.ipa Payload
```

---

### 3. APK Artifact Not Found

**Error Message:**
```
Error: Artifact file not found at path
tongkrongan_app/build/app/outputs/flutter-apk/app-release.apk
```

**Causes:**
- Build didn't complete successfully
- Build output path changed
- Insufficient storage

**Solutions:**

**Option A: Check Build Logs**
1. GitHub → Actions → Workflow Run
2. Expand "Build APK Release" step
3. Scroll through logs for errors

**Option B: Verify Paths**
```bash
# Check if build directory exists
ls -la tongkrongan_app/build/app/outputs/

# Expected structure:
# flutter-apk/
#   ├── app-release.apk
#   └── app-release.apk.sha1
```

**Option C: Increase Timeout**
Edit `build_apps.yml`:
```yaml
build-android:
  timeout-minutes: 60  # Increased from 45
```

---

### 4. IPA Artifact Not Found

**Error Message:**
```
Error: Artifact file not found at path
tongkrongan_app/Runner.ipa
```

**Causes:**
- iOS build incomplete
- IPA packaging failed
- Runner.app not found

**Solutions:**

**Option A: Check Packaging Step**
1. GitHub → Actions → Workflow Run
2. Expand "Package iOS Build as IPA" step
3. Look for error messages

**Option B: Verify iOS Build**
```bash
cd tongkrongan_app
flutter build ios --release --no-codesign
ls -la build/ios/iphoneos/Runner.app/
```

**Option C: Manual IPA Creation**
```bash
cd tongkrongan_app/build/ios/iphoneos
mkdir -p Payload
cp -r Runner.app Payload/
zip -r Runner.ipa Payload
ls -lh Runner.ipa
```

---

### 5. Build Timeout

**Error Message:**
```
The job running on runner has exceeded the maximum execution time of
45 minutes (Android) or 60 minutes (iOS)
```

**Causes:**
- GitHub runner busy
- Network issues
- Very large project
- Cache miss

**Solutions:**

**Option A: Increase Timeout**
```yaml
jobs:
  build-android:
    timeout-minutes: 60  # Increased
  build-ios:
    timeout-minutes: 75  # Increased
```

**Option B: Retry**
1. GitHub → Actions → Workflow Run
2. Click "Re-run failed jobs"
3. Usually succeeds on retry

**Option C: Check Concurrency**
If multiple builds running on same branch, they may be queued:
```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

**Option D: Run Locally**
```bash
# Measure local build time
cd tongkrongan_app
time flutter build apk --release
time flutter build ios --release --no-codesign

# If locally faster, GitHub may have resource constraints
```

---

### 6. Insufficient Disk Space

**Error Message:**
```
No space left on device
or
Disk quota exceeded
```

**Causes:**
- GitHub runner storage full
- Large build artifacts
- Cache taking too much space

**Solutions:**

**Option A: Clear Unnecessary Files**
```yaml
- name: Clean before build
  run: |
    flutter clean
    rm -rf build/
    rm -rf .dart_tool/
```

**Option B: Reduce Artifact Retention**
```yaml
retention-days: 7  # Reduced from 30
```

**Option C: Skip Tests/Analysis**
```yaml
# Comment out if not needed:
# - name: Analyze Dart code
#   run: flutter analyze
```

---

### 7. Dependency Resolution Failed

**Error Message:**
```
Error resolving dependencies
pub get failed with an error
```

**Causes:**
- Internet connection issues
- pub.dev unavailable
- Version conflicts
- Locked dependency versions

**Solutions:**

**Option A: Update Pub Cache**
```yaml
- name: Clear pub cache
  run: |
    rm -rf ~/.pub-cache/
    flutter pub cache repair
```

**Option B: Check pubspec.lock**
```bash
# Delete lock file and regenerate
cd tongkrongan_app
rm pubspec.lock
flutter pub get
```

**Option C: Pin Specific Versions**
```yaml
dependencies:
  flutter:
    sdk: flutter
  # Specify exact versions instead of ranges
  package_name: 1.2.3  # Instead of ^1.2.0
```

---

### 8. Permissions Denied

**Error Message:**
```
Permission denied
or
Cannot execute binary
```

**Causes:**
- File permissions not set
- Script execution disabled
- Cache issues

**Solutions:**

**Option A: Fix File Permissions**
```bash
chmod +x tongkrongan_app/android/gradlew
chmod +x tongkrongan_app/ios/Pods/CocoaPods/bin/*
```

**Option B: Clear Cache**
```yaml
- name: Clear cache
  run: |
    rm -rf ~/.gradle
    rm -rf ~/Library/Developer/Xcode/DerivedData
```

---

### 9. Version Mismatch Errors

**Error Message:**
```
Flutter version [X.Y.Z] is incompatible with Dart [A.B.C]
or
Kotlin version mismatch
```

**Causes:**
- Flutter version out of sync
- Dart version incompatible
- Build tools version mismatch

**Solutions:**

**Option A: Update Flutter Version in Workflow**
```yaml
env:
  FLUTTER_VERSION: 3.24.0  # Update to latest stable
```

**Check latest stable:**
```bash
flutter --version
# or visit: https://flutter.dev/docs/release/archive
```

**Option B: Check Local Versions**
```bash
flutter --version
dart --version
java -version
```

**Option C: Pin Compatible Versions**
```yaml
env:
  FLUTTER_VERSION: 3.24.0   # Stable
  JAVA_VERSION: 17          # LTS
```

---

### 10. Network Connection Issues

**Error Message:**
```
Failed to fetch from internet
or
Connection timeout
```

**Causes:**
- GitHub runner network issues
- pub.dev rate limiting
- ISP/firewall blocking

**Solutions:**

**Option A: Retry with Exponential Backoff**
```yaml
- name: Get Flutter dependencies
  run: |
    for i in {1..3}; do
      flutter pub get && break
      echo "Attempt $i failed, retrying..."
      sleep $((i * 10))
    done
```

**Option B: Use Pub Mirror**
```bash
# In ~/.pub-cache/pubspec.lock or use environment variable
PUB_HOSTED_URL=https://pub.flutter-io.cn/
```

---

## 🔍 Debugging Steps

### Step 1: Check Workflow Logs
```
GitHub → Repository → Actions 
  → Workflow Run → Expand step → View logs
```

### Step 2: Enable Verbose Output
```yaml
- name: Build with verbose
  run: flutter build apk --release --verbose
```

### Step 3: Run Locally
```bash
cd tongkrongan_app

# Test Android
flutter build apk --release --verbose

# Test iOS
flutter build ios --release --no-codesign --verbose
```

### Step 4: Check Dependencies
```bash
flutter doctor -v
flutter pub get
flutter packages pub outdated
```

### Step 5: Inspect Artifacts
```bash
# Check if files exist
ls -lh build/app/outputs/flutter-apk/app-release.apk
ls -lh Runner.ipa

# Check file integrity
file app-release.apk
file Runner.ipa
```

---

## 📊 Workflow Status Checks

### Check GitHub Status
```
https://www.githubstatus.com/
Look for: "Actions" service status
```

### Check Runner Availability
```
GitHub → Settings → Actions → Runners
View: Available runners and their status
```

### Monitor Logs in Real-time
```bash
# If using GitHub CLI
gh run watch [RUN_ID] --log
```

---

## 🆘 If All Else Fails

### 1. Reset Everything
```bash
cd tongkrongan_app
flutter clean
rm -rf build/
rm -rf ios/Pods
rm ios/Podfile.lock
rm pubspec.lock
flutter pub get
flutter pub cache repair
```

### 2. Try Different Runner
Edit `build_apps.yml`:
```yaml
# Try different OS versions
build-android:
  runs-on: ubuntu-22.04  # Instead of latest

build-ios:
  runs-on: macos-13      # Instead of latest
```

### 3. Rebuild from Scratch
```yaml
- name: Complete clean
  run: |
    flutter clean
    git clean -fdx  # WARNING: Deletes untracked files
    flutter pub get
```

### 4. Check Repository Settings
1. GitHub → Settings → Actions → General
2. Verify "Allow all actions" is selected
3. Check workflow permissions

### 5. Ask for Help
- GitHub Issues: Project issues
- Flutter Community: https://flutter.dev/community
- StackOverflow: Tag with `flutter` and `github-actions`

---

## 📋 Pre-build Checklist

Before building, verify:

- [ ] `pubspec.yaml` is valid YAML
- [ ] All dependencies exist and are available
- [ ] `pubspec.lock` is up to date
- [ ] Android `build.gradle` has correct SDK versions
- [ ] iOS `Podfile` is valid
- [ ] No uncommitted changes (for reproducibility)
- [ ] Repository permissions are set correctly
- [ ] GitHub Actions are enabled for repository

---

## 🚀 Prevention Tips

✅ **Do:**
- Keep Flutter updated
- Regular dependency updates
- Test locally before pushing
- Use stable Flutter versions
- Monitor GitHub status page
- Keep adequate storage space

❌ **Don't:**
- Use development Flutter versions in CI/CD
- Commit sensitive files
- Ignore build warnings
- Mix version managers (flutter + brew)
- Run too many concurrent builds

---

## 📞 Support Resources

| Resource | Link |
|----------|------|
| Flutter Docs | https://flutter.dev/docs |
| Flutter GitHub Issues | https://github.com/flutter/flutter/issues |
| GitHub Actions Docs | https://docs.github.com/en/actions |
| Android Build Docs | https://developer.android.com/studio/build |
| iOS Build Docs | https://developer.apple.com/xcode |

---

## 🎯 Quick Decision Tree

```
Build Failed?
  ├─ Android Failed?
  │  ├─ Gradle Error → gradle clean, pub get, rebuild
  │  └─ Build Output Not Found → check logs, increase timeout
  ├─ iOS Failed?
  │  ├─ Pod Error → pod install --repo-update
  │  └─ Build Output Not Found → check logs, rebuild manually
  └─ Both Failed?
     ├─ Check logs → fix errors
     ├─ Run locally → reproduce issue
     └─ Test isolated → Android without iOS or vice versa

Artifacts Not Found?
  ├─ Check build logs for errors
  ├─ Verify output paths
  ├─ Check file storage
  └─ Increase timeout and retry

Still Not Working?
  ├─ Check GitHub status
  ├─ Verify runner availability
  ├─ Try different runner OS
  └─ Ask for help
```

---

**Troubleshooting Guide Version:** 1.0  
**Last Updated:** 2024  
**Status:** ✅ Complete
