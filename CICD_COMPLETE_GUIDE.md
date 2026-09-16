# 🚀 GitHub Actions CI/CD Complete Guide

**Complete automation for Android APK & iOS IPA build and deployment**  
**Date:** September 16, 2026  
**Platform:** GitHub Actions + Sideloadly  
**Time to Setup:** 1-2 hours

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Quick Start](#quick-start)
4. [Step-by-Step Setup](#step-by-step-setup)
5. [Workflows Explained](#workflows-explained)
6. [Monitoring & Debugging](#monitoring--debugging)
7. [Troubleshooting](#troubleshooting)
8. [Best Practices](#best-practices)
9. [Advanced Configuration](#advanced-configuration)
10. [FAQ](#faq)

---

## 🎯 Overview

This CI/CD pipeline automates:

✅ **Building**
- Android APK (release + debug)
- iOS IPA (release via archive)
- App Bundle for Play Store

✅ **Signing**
- Android with keystore
- iOS with certificate & provisioning profile

✅ **Testing**
- Flutter analysis
- Build validation

✅ **Deployment**
- GitHub Releases
- Sideloadly auto-install
- TestFlight upload (iOS)

✅ **Monitoring**
- Workflow logs
- Artifact retention
- Build status notifications

---

## 🏗️ Architecture

### Workflow Files

```
.github/workflows/
├── build-android.yml           # Builds APK & AAB
├── build-ios.yml               # Builds IPA
└── deploy-sideloadly.yml       # Auto-deploys to devices
```

### Secrets Storage

```
GitHub Repository Secrets:
├── Android (4 secrets)
│   ├── ANDROID_KEYSTORE_BASE64
│   ├── ANDROID_KEYSTORE_PASSWORD
│   ├── ANDROID_KEY_PASSWORD
│   └── ANDROID_KEY_ALIAS
├── iOS (7 secrets)
│   ├── IOS_CERTIFICATE_BASE64
│   ├── IOS_CERTIFICATE_PASSWORD
│   ├── IOS_PROVISIONING_PROFILE_BASE64
│   ├── KEYCHAIN_PASSWORD
│   ├── TESTFLIGHT_USERNAME
│   ├── TESTFLIGHT_PASSWORD
│   └── TESTFLIGHT_APP_ID
└── Sideloadly (2 secrets - optional)
    ├── SIDELOADLY_API_KEY
    └── SIDELOADLY_DEVICE_ID
```

### Execution Flow

```
┌─────────────────────┐
│  Push to GitHub     │
│  (main / develop)   │
└──────────┬──────────┘
           │
           ├─────────────────────────────┐
           │                             │
           ↓                             ↓
    ┌─────────────────┐        ┌─────────────────┐
    │ Build Android   │        │  Build iOS      │
    │ (Ubuntu)        │        │  (macOS)        │
    │ ~15 minutes     │        │  ~20 minutes    │
    └────────┬────────┘        └────────┬────────┘
             │                         │
             ├─ APK                    ├─ IPA
             ├─ AAB                    └─ Archive
             └─ Artifacts
                        │
                        ↓
            ┌─────────────────────────┐
            │ Deploy to Sideloadly    │
            │ (Ubuntu)                │
            │ ~2-5 minutes            │
            └────────────┬────────────┘
                         │
                         ↓
            ┌─────────────────────────┐
            │ Auto-Install on Device  │
            │ ✅ APK on Android       │
            │ ✅ IPA on iPhone        │
            └─────────────────────────┘
```

---

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/tongkrongan_app
cd tongkrongan_app
```

### 2. Create Signing Keys (See GITHUB_SECRETS_SETUP.md)
```bash
# Android
keytool -genkey -v -keystore upload-keystore.jks ...

# iOS
# Create certificate & provisioning profile in Apple Developer
```

### 3. Add Secrets to GitHub
```
Settings → Secrets and variables → Actions
Add all 13 secrets (see GITHUB_SECRETS_SETUP.md)
```

### 4. Trigger Build
```bash
git add .
git commit -m "Trigger CI/CD"
git push origin main
```

### 5. Monitor
```
Actions → [Workflow] → Watch build progress
```

### 6. Check Device
```
Look for app on your iPhone/Android! ✅
```

**Total time:** ~40 minutes for first complete build

---

## 📝 Step-by-Step Setup

### Step 1: Prepare Repository Structure

Ensure project structure:
```
tongkrongan_app/
├── .github/
│   └── workflows/
│       ├── build-android.yml
│       ├── build-ios.yml
│       └── deploy-sideloadly.yml
├── android/
│   ├── app/
│   ├── build.gradle
│   └── (other Android files)
├── ios/
│   ├── Runner.xcworkspace
│   ├── ExportOptions.plist
│   └── (other iOS files)
├── lib/
└── pubspec.yaml
```

### Step 2: Configure Android

**File: `android/app/build.gradle`**

```gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        applicationId "com.stitch.tongkrongan"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 1
        versionName "1.0.0"
    }
}
```

**File: `android/gradle.properties`**

```properties
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
```

### Step 3: Configure iOS

**File: `ios/Runner.xcodeproj/project.pbxproj`**

Set Bundle ID: `com.stitch.tongkrongan`  
Set Team ID: [Your Apple Team ID]

**File: `ios/ExportOptions.plist`**

Already created - uses Ad Hoc distribution

### Step 4: Generate Signing Credentials

See `GITHUB_SECRETS_SETUP.md` for:
- Android keystore generation
- iOS certificate creation
- Provisioning profile setup

### Step 5: Add GitHub Secrets

Go to: `Settings → Secrets and variables → Actions`

Add these 13 secrets:

**Android (4):**
```
ANDROID_KEYSTORE_BASE64
ANDROID_KEYSTORE_PASSWORD
ANDROID_KEY_PASSWORD
ANDROID_KEY_ALIAS
```

**iOS (7):**
```
IOS_CERTIFICATE_BASE64
IOS_CERTIFICATE_PASSWORD
IOS_PROVISIONING_PROFILE_BASE64
KEYCHAIN_PASSWORD
TESTFLIGHT_USERNAME
TESTFLIGHT_PASSWORD
TESTFLIGHT_APP_ID
```

**Sideloadly (2 - Optional):**
```
SIDELOADLY_API_KEY
SIDELOADLY_DEVICE_ID
```

### Step 6: Test Workflow

Push to main:
```bash
git add .
git commit -m "Enable CI/CD"
git push origin main
```

Monitor at: `Actions → [Workflow Name]`

---

## 🔍 Workflows Explained

### Workflow 1: Build Android (build-android.yml)

**Trigger:** Push to main/develop or manual  
**Runner:** Ubuntu Latest  
**Duration:** 10-15 minutes  
**Outputs:** APK, AAB, Artifacts

**Steps:**
1. Checkout code
2. Setup Java 11 (for Gradle)
3. Setup Flutter 3.13.0
4. Get Flutter dependencies
5. Run Flutter analysis
6. Decode Android keystore (from secret)
7. Create key.properties file
8. Build APK (Debug if PR, Release if push)
9. Build App Bundle (Release)
10. Generate version tag
11. Upload artifacts (30-day retention)
12. Create GitHub Release
13. Upload to Sideloadly (optional)

**Key Environment Variables:**
```yaml
ANDROID_KEYSTORE_PASSWORD: ${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
ANDROID_KEY_PASSWORD: ${{ secrets.ANDROID_KEY_PASSWORD }}
ANDROID_KEY_ALIAS: ${{ secrets.ANDROID_KEY_ALIAS }}
```

---

### Workflow 2: Build iOS (build-ios.yml)

**Trigger:** Push to main/develop or manual  
**Runner:** macOS Latest  
**Duration:** 15-20 minutes  
**Outputs:** IPA, Archive, Artifacts

**Steps:**
1. Checkout code
2. Setup Flutter 3.13.0
3. Get Flutter dependencies
4. Install iOS pods (CocoaPods)
5. Decode provisioning profile
6. Decode signing certificate
7. Import certificate to keychain
8. Build iOS (Debug if PR, Release if push)
9. Archive with xcodebuild
10. Export archive to IPA
11. Generate version tag
12. Upload artifacts (30-day retention)
13. Create GitHub Release
14. Upload to Sideloadly (optional)
15. Upload to TestFlight (optional)
16. Cleanup keychain

**Key Environment Variables:**
```yaml
IOS_CERTIFICATE_PASSWORD: ${{ secrets.IOS_CERTIFICATE_PASSWORD }}
KEYCHAIN_PASSWORD: ${{ secrets.KEYCHAIN_PASSWORD }}
TESTFLIGHT_USERNAME: ${{ secrets.TESTFLIGHT_USERNAME }}
TESTFLIGHT_PASSWORD: ${{ secrets.TESTFLIGHT_PASSWORD }}
```

---

### Workflow 3: Deploy Sideloadly (deploy-sideloadly.yml)

**Trigger:** After build workflows complete or manual  
**Runner:** Ubuntu Latest  
**Duration:** 2-5 minutes  
**Outputs:** Device installation status

**Steps:**
1. Checkout code
2. Download APK/IPA artifacts
3. Find APK/IPA file
4. Install Sideloadly CLI
5. Deploy via Sideloadly API:
   ```bash
   curl -X POST https://api.sideloadly.io/v1/upload \
     -H "Authorization: Bearer $API_KEY" \
     -F "file=@app.apk" \
     -F "device_id=$DEVICE_ID" \
     -F "auto_install=true"
   ```
6. Notify completion

**API Integration:**
```yaml
Authorization: Bearer ${{ secrets.SIDELOADLY_API_KEY }}
device_id: ${{ secrets.SIDELOADLY_DEVICE_ID }}
auto_install: true
```

---

## 📊 Monitoring & Debugging

### View Workflow Status

Go to: `Actions` tab in GitHub

Status indicators:
- 🟢 **Success** - Build completed
- 🔴 **Failed** - Build error
- ⏳ **In Progress** - Currently building
- ⏭️ **Skipped** - Conditions not met

### View Logs

Click workflow run → View logs for each step

Example logs show:
```
✓ Checkout code
✓ Setup Java
✓ Setup Flutter
✓ Get dependencies
✓ Build APK
✓ Upload artifacts
✓ Create release
✅ Complete
```

### Download Artifacts

Click workflow → Artifacts → Download

Files available:
- `app-release-YYYYMMDD_HHMMSS.apk`
- `app-release-YYYYMMDD_HHMMSS.aab`
- `Tongkrongan-YYYYMMDD_HHMMSS.ipa`

### Monitor Build Times

Check:
- Android build time (target: <15 min)
- iOS build time (target: <20 min)
- Deploy time (target: <5 min)

Optimize if exceeding targets

---

## 🐛 Troubleshooting

### Android Build Fails

**Error: "Keystore not found"**
```
Solution:
1. Verify ANDROID_KEYSTORE_BASE64 is in secrets
2. Check secret value isn't truncated
3. Verify base64 encoding is valid
4. Test locally: flutter build apk --release
```

**Error: "Invalid keystore format"**
```
Solution:
1. Re-encode keystore to base64
2. Verify keystore file is valid (.jks)
3. Check password is correct
4. Generate new keystore if corrupted
```

**Error: "Gradle build failed"**
```
Solution:
1. Check build.gradle syntax
2. Verify Flutter version compatibility
3. Clear gradle cache:
   rm -rf android/.gradle
4. Update gradle wrapper:
   ./gradlew --version
```

### iOS Build Fails

**Error: "Certificate not trusted"**
```
Solution:
1. Re-export certificate from Keychain
2. Verify password in secret
3. Check certificate not expired
4. Regenerate certificate if needed
```

**Error: "Provisioning profile doesn't match"**
```
Solution:
1. Verify bundle ID matches (com.stitch.tongkrongan)
2. Ensure profile includes all devices
3. Regenerate provisioning profile
4. Check App ID in profile
```

**Error: "Pod install failed"**
```
Solution:
1. Update CocoaPods: pod repo update
2. Clean pods: rm -rf ios/Pods
3. Reinstall: cd ios && pod install
4. Check Flutter plugin compatibility
```

### Deployment Fails

**Error: "Device not found"**
```
Solution:
1. Verify device ID in SIDELOADLY_DEVICE_ID
2. Ensure device connected to Sideloadly
3. Check device is trusted
4. Verify Sideloadly desktop app is running
```

**Error: "Invalid API key"**
```
Solution:
1. Regenerate API key in Sideloadly
2. Update SIDELOADLY_API_KEY secret
3. Verify no extra spaces in key
4. Check API key permissions
```

---

## ✅ Best Practices

### 1. Secrets Management

✅ **DO:**
- Store all credentials in GitHub Secrets
- Rotate credentials every 6 months
- Use strong passwords (20+ chars)
- Keep keystore files secure

❌ **DON'T:**
- Commit `.jks` files to repo
- Share API keys publicly
- Use simple passwords
- Store secrets in code

### 2. Build Optimization

✅ **DO:**
- Use caching for dependencies
- Build only on main branch for release
- Clean old artifacts regularly
- Monitor build times

❌ **DON'T:**
- Build on every commit
- Keep artifacts forever
- Build with debug settings for release
- Ignore failing builds

### 3. Version Management

✅ **DO:**
- Increment build number for each build
- Use semantic versioning (1.0.0)
- Tag releases in Git
- Keep changelog updated

❌ **DON'T:**
- Reuse same build number
- Deploy untested builds
- Skip version increments
- Ignore release notes

### 4. Testing

✅ **DO:**
- Run Flutter analysis
- Test locally before push
- Verify artifacts before deployment
- Test on real devices

❌ **DON'T:**
- Skip testing in CI/CD
- Deploy without verification
- Ignore warnings
- Rush to production

### 5. Monitoring

✅ **DO:**
- Check workflow logs regularly
- Monitor build times
- Track failure rates
- Archive important builds

❌ **DON'T:**
- Ignore failed builds
- Skip artifact retention
- Disable notifications
- Forget to monitor

---

## 🔧 Advanced Configuration

### Custom Build Parameters

**Build different variants:**
```yaml
- name: Build Debug APK
  run: flutter build apk --debug

- name: Build Release APK
  run: flutter build apk --release

- name: Build Flavors
  run: flutter build apk -t lib/main_production.dart
```

### Dynamic Version Numbers

```yaml
- name: Set Version
  run: |
    VERSION=$(date +'%Y%m%d_%H%M%S')
    echo "version=$VERSION" >> $GITHUB_ENV
```

### Parallel Jobs

```yaml
jobs:
  build_android:
    runs-on: ubuntu-latest
  build_ios:
    runs-on: macos-latest
  # Both run simultaneously
```

### Conditional Execution

```yaml
if: github.event_name == 'push' && github.ref == 'refs/heads/main'
# Only run on main branch push
```

### Slack Notifications

```yaml
- name: Notify Slack
  uses: slackapi/slack-github-action@v1
  with:
    payload: |
      {
        "text": "Build completed: ${{ job.status }}"
      }
```

---

## ❓ FAQ

### Q: How often does it build?

**A:** By default, on every push to main or develop branch. You can change:
```yaml
on:
  push:
    branches: [ main ]  # Or add schedule
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday
```

### Q: Can I build on pull requests?

**A:** Yes, change trigger:
```yaml
on:
  pull_request:
    branches: [ main ]
```

### Q: How long do artifacts stay?

**A:** 30 days by default. Change:
```yaml
retention-days: 60  # Or any number
```

### Q: Can I manual trigger builds?

**A:** Yes, add `workflow_dispatch`:
```yaml
on:
  workflow_dispatch:
    inputs:
      artifact_type:
        description: 'Choose artifact'
        options: [android, ios, both]
```

### Q: How do I test locally?

**A:** Run same commands as workflow:
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

### Q: Can I skip deployment?

**A:** Yes, add `continue-on-error: true` or skip step:
```yaml
- name: Deploy
  if: github.ref == 'refs/heads/main'
  run: # deploy commands
```

### Q: How do I update secrets?

**A:** Go to Settings → Secrets → Edit secret → Update value

### Q: Can I use different runners?

**A:** Yes, but macOS needed for iOS:
```yaml
runs-on: macos-latest       # iOS builds
runs-on: ubuntu-latest      # Android builds
runs-on: windows-latest     # Not recommended
```

### Q: How do I debug failed builds?

**A:** Check logs:
1. Actions → Failed workflow
2. Click failing step
3. View detailed logs
4. Search for error message

---

## 📈 Performance Metrics

### Expected Build Times

| Component | Time | Notes |
|-----------|------|-------|
| Android APK | 10-15 min | First run slower |
| iOS IPA | 15-20 min | First run slower |
| Deployment | 2-5 min | API upload |
| **Total** | **30-40 min** | All three |

### Optimization Tips

1. **Cache dependencies** - Speed up downloads
2. **Parallel builds** - Run Android & iOS together
3. **Skip unnecessary steps** - Remove unused tasks
4. **Use faster runners** - Larger machines cost more

### Cost Considerations

- Free: 2,000 minutes/month (public repos unlimited)
- Private repos: 500-3,000 minutes depending on plan
- Estimate: ~1 hour per day = ~720 minutes/month

---

## 🎓 Learning Resources

**GitHub Actions:**
- https://docs.github.com/actions
- https://github.com/marketplace/actions

**Flutter Build:**
- https://flutter.dev/docs/deployment
- https://flutter.dev/docs/testing

**Sideloadly:**
- https://sideloadly.io/docs
- https://sideloadly.io/support

**CI/CD Best Practices:**
- https://www.atlassian.com/continuous-delivery
- https://www.jenkins.io/doc/

---

## 📞 Support

**GitHub Actions Issues:**
- Check workflow syntax
- Review logs carefully
- Search GitHub community
- Post on Stack Overflow [github-actions]

**Build Issues:**
- Run locally first
- Check Flutter docs
- Search pub.dev
- Check package compatibility

**Sideloadly Issues:**
- Check API documentation
- Verify device connection
- Contact Sideloadly support
- Check Sideloadly community

---

## ✅ Implementation Checklist

Before going live:

- [ ] Workflows in `.github/workflows/`
- [ ] All 13 secrets configured
- [ ] Signing certificates valid
- [ ] Local builds working
- [ ] Test push to develop branch
- [ ] Monitor first build
- [ ] Verify APK on Android device
- [ ] Verify IPA on iPhone device
- [ ] Check artifact retention
- [ ] Setup notifications (optional)
- [ ] Document process for team
- [ ] Test edge cases

---

## 🚀 Next Steps

1. ✅ Read this guide thoroughly
2. ✅ Follow GITHUB_SECRETS_SETUP.md
3. ✅ Add workflows to `.github/workflows/`
4. ✅ Configure all secrets
5. ✅ Test first build
6. ✅ Monitor and optimize
7. ✅ Share with team

---

**CI/CD Setup Status:** ✅ COMPLETE  
**Documentation Version:** 1.0  
**Last Updated:** September 16, 2026

---

## 📌 Quick Reference

### Most Common Commands

```bash
# Trigger build manually
git push origin main

# Check workflow status
gh run list --workflow build-android.yml

# Download artifacts
gh run download <run_id> -n <artifact_name>

# View logs
gh run view <run_id> --log

# Monitor in real-time
gh run watch <run_id>
```

### Most Common Secrets

```
ANDROID_KEYSTORE_BASE64
IOS_CERTIFICATE_BASE64
SIDELOADLY_API_KEY
```

### Most Common Issues

1. Invalid keystore → Re-encode to base64
2. Certificate expired → Generate new one
3. Device not found → Check device ID
4. Build timeout → Increase timeout or optimize

### Most Common Solutions

1. Clear cache: `git clean -fd`
2. Rebuild locally: `flutter build [android|ios] --release`
3. Check logs: Actions → Workflow → Logs
4. Update secrets: Settings → Secrets

---

**Happy CI/CD ing! 🎉**

