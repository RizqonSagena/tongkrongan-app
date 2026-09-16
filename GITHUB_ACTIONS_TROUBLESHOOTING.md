# 🔧 GitHub Actions Workflow - Troubleshooting & Optimization

**File:** `.github/workflows/build_apps.yml`

---

## 🚨 Build Failures - Complete Troubleshooting Guide

### ERROR 1: "APK file not found!"

**Workflow Step:** "Verify APK artifact"

**Full Error:**
```
Error: APK file not found!
Expected: tongkrongan_app/build/app/outputs/flutter-apk/app-release.apk
```

#### Root Cause Analysis

```
┌─ APK File Missing
│  ├─ Build failed silently
│  ├─ Gradle error
│  ├─ Dart compilation error
│  ├─ ProGuard/R8 issue
│  └─ Output path changed
│
├─ Build logs show error in:
│  ├─ "Build APK Release" step
│  ├─ Java compilation
│  ├─ Kotlin compilation
│  └─ ProGuard/R8 shrinking
│
└─ Next: Check workflow logs
```

#### Solution - Step by Step

**Step 1: Check workflow logs**
```
GitHub → Actions → Build Flutter Apps → Click failed run
Scroll to "Build APK Release" step → View output
Look for error message like:
  - "error: ..."
  - "FAILURE: Build failed"
  - "Could not find ..."
```

**Step 2: If local issue - test locally**
```bash
cd tongkrongan_app

# Clean everything
flutter clean

# Get latest dependencies
flutter pub get

# Attempt debug build (faster)
flutter build apk --debug --verbose

# If debug works, try release
flutter build apk --release --verbose

# Check output
ls -la build/app/outputs/flutter-apk/
```

**Step 3: Fix the issue**

```
If Error Type A: "Could not find "
  └─ Missing dependency
     - Check pubspec.yaml
     - Run: flutter pub get
     - Try: flutter pub upgrade

If Error Type B: "Compilation failed"
  └─ Dart/Kotlin error
     - Check error message for line number
     - Open file and fix syntax
     - Test: flutter analyze
     - Push again

If Error Type C: "ProGuard/R8 failed"
  └─ Obfuscation issue
     - Edit android/app/proguard-rules.pro
     - Add rules for failing package
     - Rebuild

If Error Type D: "Gradle build failed"
  └─ Build tools issue
     - Check Android gradle plugin version
     - Update gradle: gradlew wrapper --gradle-version X.Y.Z
     - Clear: rm -rf android/build
```

**Step 4: Commit and retry**
```bash
# Commit fix
git add .
git commit -m "Fix APK build issue"

# Push to trigger workflow
git push origin main

# Or manually trigger
# GitHub → Actions → Build Flutter Apps → Run workflow
```

#### Prevention

```yaml
# Add to workflow to fail early:
- name: Build APK (Debug First)
  working-directory: tongkrongan_app
  run: flutter build apk --debug --verbose
  
- name: Build APK Release
  working-directory: tongkrongan_app
  run: flutter build apk --release --verbose
```

---

### ERROR 2: "IPA file not found!"

**Workflow Step:** "Verify IPA artifact"

**Full Error:**
```
Error: IPA file not found!
Expected: tongkrongan_app/Runner.ipa
```

#### Root Cause Analysis

```
┌─ IPA File Missing
│  ├─ iOS build failed
│  ├─ Xcode error
│  ├─ CocoaPods issue
│  ├─ Runner.app not created
│  └─ ZIP packaging failed
│
├─ Build logs show error in:
│  ├─ "Build iOS Release" step
│  ├─ Xcode build command
│  ├─ Runner.app generation
│  └─ "Package iOS Build as IPA" step
│
└─ Next: Check workflow logs
```

#### Solution - Step by Step

**Step 1: Check workflow logs**
```
GitHub → Actions → Build Flutter Apps → Click failed run
Scroll to iOS steps → Find error
```

**Step 2: Test iOS build locally (macOS only)**
```bash
cd tongkrongan_app

# Clean
flutter clean

# Get dependencies
flutter pub get

# Update pods
cd ios
pod repo update
pod install --repo-update
cd ..

# Build debug first
flutter build ios --debug --verbose

# If debug works, try release unsigned
flutter build ios --release --no-codesign --verbose

# Check output
ls -la build/ios/iphoneos/Runner.app/
```

**Step 3: Fix common iOS issues**

```
If Error Type A: "Pod install failed"
  └─ CocoaPods issue
     - Remove: rm -rf ios/Pods ios/Podfile.lock
     - Retry: pod install --repo-update

If Error Type B: "Xcode build failed"
  └─ Build settings issue
     - Check iOS minimum deployment target
     - Ensure iOS 11.0 minimum
     - Check app code signing identity

If Error Type C: "Runner.app not found"
  └─ Build output issue
     - Check derivedDataPath
     - Clear DerivedData: rm -rf ~/Library/Developer/Xcode/DerivedData/*
     - Rebuild

If Error Type D: "Payload packaging failed"
  └─ ZIP issue
     - Check if Payload/ created
     - Verify Runner.app exists
     - Check file permissions
```

**Step 4: Commit and retry**
```bash
git add ios/
git commit -m "Fix iOS build issue"
git push origin main
```

#### Prevention

```yaml
# Add diagnostics to workflow:
- name: List iOS build output
  working-directory: tongkrongan_app
  run: |
    ls -la build/ios/iphoneos/
    file build/ios/iphoneos/Runner.app
```

---

### ERROR 3: "Workflow timeout exceeded"

**Symptom:**
```
Workflow cancelled after 60 minutes (or earlier)
No build output shown
```

#### Root Cause Analysis

```
Possible Causes:
├─ Slow dependency download (network)
├─ Large gradle compilation
├─ iOS pod installation takes too long
├─ Build cache not working
├─ Large dependencies being recompiled
└─ macOS runner slower than expected
```

#### Solution

**Option 1: Increase timeout**
```yaml
# In .github/workflows/build_apps.yml

jobs:
  build-android:
    timeout-minutes: 90  # Instead of 45
    
  build-ios:
    timeout-minutes: 120  # Instead of 60
```

**Option 2: Optimize dependencies**
```bash
# Check which dependencies are largest
cd tongkrongan_app
flutter pub deps

# Remove unused dependencies
# Update problematic packages
flutter pub upgrade

# Clear pub cache if needed
flutter pub cache clean
```

**Option 3: Split workflows**
```yaml
# Separate Android and iOS workflows
# build_android.yml (30 min timeout)
# build_ios.yml (45 min timeout)
```

**Option 4: Enable aggressive caching**
```yaml
- name: Cache Flutter pub
  uses: actions/cache@v3
  with:
    path: ~/.pub-cache
    key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
```

---

### ERROR 4: "Insufficient disk space"

**Symptom:**
```
Disk space full during build
Build fails with I/O error
```

#### Solution

```bash
# Reduce disk usage:

1. Disable compression in build
   └─ Don't compress APK/IPA (already compressed)

2. Delete intermediate files
   └─ Use flutter clean before build

3. Reduce build output retention
   └─ Change retention-days: 7 (instead of 30)

4. Split large builds
   └─ Build on separate workflows

# In workflow:
retention-days: 7  # Save space
compression-level: 0  # Don't compress
```

---

### ERROR 5: "Gradle sync failed"

**Symptom:**
```
Android build fails in gradle sync step
Cannot find Android SDK or gradle
```

#### Solution

```bash
# Ensure gradle wrapper exists
ls -la tongkrongan_app/android/gradle/wrapper/gradle-wrapper.jar

# If missing, regenerate
cd tongkrongan_app/android
./gradlew wrapper --gradle-version 7.6.1
cd ../..

# Commit gradle files
git add tongkrongan_app/android/gradle
git commit -m "Update gradle wrapper"
git push origin main
```

---

### ERROR 6: "Pod install failed (iOS)"

**Symptom:**
```
iOS build fails at pod install step
[!] Couldn't find compatible versions for pod
```

#### Solution

```bash
# Fix locally first
cd tongkrongan_app/ios

# Update CocoaPods
sudo gem install cocoapods

# Update pod repo
pod repo update

# Clean and reinstall
rm -rf Pods
rm Podfile.lock
pod install --repo-update

cd ../..

# Commit if needed
git add ios/Podfile.lock
git commit -m "Update iOS dependencies"
git push origin main
```

---

## ⚡ Optimization Tips

### Optimization 1: Faster Builds

**Current Build Time:** 45-60 minutes

**Possible Improvements:**

```yaml
# 1. Use cache aggressively
- name: Restore Flutter cache
  uses: actions/cache@v3
  with:
    path: |
      ${{ runner.tool_cache }}/flutter/*
      ~/.pub-cache/*
      android/.gradle/*
    key: ${{ runner.os }}-flutter-${{ env.FLUTTER_VERSION }}

# 2. Build in parallel (already done)
# Jobs run simultaneously on separate runners

# 3. Use smaller Flutter version
# Current: 3.24.0 (reasonable)

# 4. Skip code analysis (optional)
- name: Analyze (Skip on push)
  if: github.event_name == 'pull_request'
  run: flutter analyze
```

**Expected Improvement:** 10-15 minutes saved

---

### Optimization 2: Reduce Artifact Size

**Current Sizes:**
- APK: 60-75 MB
- IPA: 80-100 MB

**How to reduce:**

```bash
# 1. Compress images in assets/
# Use tools: ImageOptim, TinyPNG, etc.
# Target: Reduce to WEBP format if possible

# 2. Remove unused dependencies
flutter pub deps --style=list
# Review unused packages

# 3. Enable ProGuard/R8 obfuscation
# android/app/build.gradle:
# shrinkResources true
# minifyEnabled true

# 4. Split APK by architecture (advanced)
# Build separate APKs for arm64, armeabi-v7a

# 5. Optimize Dart code
# Tree-shake unused code during build
flutter build apk --release --split-per-abi
```

**Expected Reduction:** 5-15 MB per artifact

---

### Optimization 3: Faster Android Build

**Current Time:** 25-35 minutes

```yaml
# Option 1: Use cache for gradle
- name: Setup Gradle cache
  uses: gradle/gradle-build-action@v2

# Option 2: Skip ProGuard on PR builds
- name: Build APK (Debug)
  if: github.event_name == 'pull_request'
  run: flutter build apk --debug

# Option 3: Use larger runner (paid feature)
runs-on: ubuntu-latest-xl  # More CPU/RAM

# Option 4: Build only one architecture
run: flutter build apk --release --target-platform android-arm64
```

**Expected Improvement:** 5-10 minutes

---

### Optimization 4: Faster iOS Build

**Current Time:** 35-50 minutes

```yaml
# Option 1: Use cache for pods
- name: Cache Pods
  uses: actions/cache@v3
  with:
    path: |
      tongkrongan_app/ios/Pods
      ~/.cocoapods
    key: ${{ runner.os }}-pods-${{ hashFiles('**/Podfile.lock') }}

# Option 2: Skip pod repo update
- name: Install pods
  run: |
    pod install  # Skip: pod repo update

# Option 3: Use larger runner
runs-on: macos-latest-xl  # More resources

# Option 4: Build only arm64 (no simulator)
run: flutter build ios --release --no-codesign
```

**Expected Improvement:** 10-15 minutes

---

## 🔍 Debugging Workflow Issues

### Enable Verbose Logging

```yaml
env:
  FLUTTER_VERBOSE: "true"

- name: Build APK (Verbose)
  run: |
    flutter build apk --release --verbose 2>&1 | tee build.log
    
- name: Upload Build Log
  if: always()
  uses: actions/upload-artifact@v4
  with:
    name: build-log-android
    path: build.log
```

### Add Diagnostic Steps

```yaml
- name: Diagnose Environment
  run: |
    echo "=== Flutter Info ==="
    flutter --version
    flutter doctor -v
    
    echo "=== Java Info ==="
    java -version
    
    echo "=== Gradle Info ==="
    which gradle
    
    echo "=== Disk Space ==="
    df -h /
    
    echo "=== Memory ==="
    free -h
```

### Save Build Artifacts for Analysis

```yaml
- name: Save build artifacts on failure
  if: failure()
  uses: actions/upload-artifact@v4
  with:
    name: build-failure-logs
    path: |
      tongkrongan_app/build/
      android/.gradle/
```

---

## 📊 Monitoring & Health Checks

### Check Workflow Health

```bash
# List recent runs
gh run list --workflow=build_apps.yml --limit 10

# View failed runs
gh run list --workflow=build_apps.yml --status failure

# Get details of specific run
gh run view <run-id> --log

# Download artifacts from run
gh run download <run-id> -n android-apk
```

### Set up Status Badge

```markdown
# Add to README.md
[![Build Flutter Apps](https://github.com/RizqonSagena/tongkrongan-app/actions/workflows/build_apps.yml/badge.svg)](https://github.com/RizqonSagena/tongkrongan-app/actions/workflows/build_apps.yml)
```

### Email Notifications

```yaml
- name: Send Email on Failure
  if: failure()
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: "Build Failed: ${{ github.workflow }}"
    to: your-email@example.com
    body: |
      Build failed!
      Repository: ${{ github.repository }}
      Branch: ${{ github.ref }}
      Run: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

---

## 🚀 Performance Benchmarks

### Build Time Tracking

```bash
# View build durations over time
gh run list --workflow=build_apps.yml --json conclusion,durationMinutes
```

### Expected Times (Baseline)
```
Android APK:     25-35 min (first run)
                 20-25 min (with cache)
                 
iOS IPA:         35-50 min (first run)
                 25-35 min (with cache)
                 
Total:           45-60 min (parallel)
```

### Red Flags - When to Investigate
```
If any single job exceeds:
├─ Android: 40+ minutes → Check gradle
├─ iOS: 60+ minutes → Check pods
└─ Either: 90+ minutes → Something is wrong
```

---

## 🧪 Testing Workflow Changes

### Test Workflow Locally (using act)

```bash
# Install act (GitHub Actions local runner)
# https://github.com/nektos/act

# Run workflow locally
act push -j build-android

act push -j build-ios

# Test specific event
act workflow_dispatch
```

### Manual Testing Process

```
1. Create test branch
   git checkout -b test/workflow-change
   
2. Edit workflow file
   vim .github/workflows/build_apps.yml
   
3. Commit changes
   git add .github/workflows/build_apps.yml
   git commit -m "Test workflow change"
   
4. Push to test branch
   git push origin test/workflow-change
   
5. Create PR to trigger workflow
   # Or manually run: GitHub → Actions → Run workflow
   
6. Monitor results
   # Check Actions tab
   
7. If successful, merge to main
   # Delete test branch
   
8. If failed, diagnose and retry
```

---

## 📚 Reference & Resources

### GitHub Actions Documentation
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Context and Expression Syntax](https://docs.github.com/en/actions/learn-github-actions/contexts)
- [Environment Variables](https://docs.github.com/en/actions/learn-github-actions/environment-variables)

### Flutter Documentation
- [Build APK](https://flutter.dev/docs/deployment/android)
- [Build IPA](https://flutter.dev/docs/deployment/ios)
- [CI/CD](https://flutter.dev/docs/deployment/cd)

### Related Documentation
- `GITHUB_ACTIONS_BUILD_WORKFLOW.md` — Full documentation
- `GITHUB_ACTIONS_WORKFLOW_GUIDE.md` — Visual guide
- `GITHUB_ACTIONS_QUICK_REFERENCE.md` — Quick ref

---

## ✅ Troubleshooting Checklist

Before reporting issues, verify:

```
[ ] Local build works: flutter build apk/ios --release
[ ] Workflow file syntax is valid (YAML)
[ ] All secrets are configured
[ ] Branch has latest code
[ ] No uncommitted changes
[ ] GitHub Actions enabled in repository
[ ] Sufficient artifact storage (150 MB)
[ ] Runner specifications met
[ ] Build timeout increased if needed
[ ] Cache is not corrupted (clear if needed)
```

---

## 🆘 Getting Help

### If Build Still Fails:

1. **Check logs thoroughly**
   - Expand each failed step
   - Look for actual error message
   - Not just the step name

2. **Test locally first**
   - Run `flutter build apk --release --verbose`
   - Run `flutter build ios --release --no-codesign --verbose`
   - Fix issues locally before pushing

3. **Check common mistakes**
   - Syntax errors in workflow file
   - Missing secrets
   - Wrong file paths
   - Insufficient permissions

4. **Isolate the problem**
   - Is it Android or iOS?
   - Is it build or artifact upload?
   - Is it in initialization or compilation?

5. **Document findings**
   - Exact error message
   - Steps to reproduce locally
   - Latest workflow logs
   - All configuration

---

**Status:** ✅ Complete Troubleshooting Guide  
**Last Updated:** 2024  
**File:** `.github/workflows/build_apps.yml`
