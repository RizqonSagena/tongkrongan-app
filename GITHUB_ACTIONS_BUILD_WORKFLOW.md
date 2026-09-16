# 🚀 GitHub Actions Build Workflow Documentation
**File:** `.github/workflows/build_apps.yml`  
**Status:** ✅ Active and Configured  
**Purpose:** Automatically build Android APK and iOS IPA artifacts  
**Last Updated:** 2024

---

## 📋 Overview

This GitHub Actions workflow automates the build process for your Flutter app, generating two main artifacts:
1. **android-apk** — Android APK release build
2. **ios-ipa-unsigned** — iOS IPA unsigned build

### Key Features:
- ✅ Parallel builds for faster execution (45-60 minutes total)
- ✅ Automatic on push to `main` and `develop` branches
- ✅ Manual trigger via `workflow_dispatch`
- ✅ Concurrent cancellation to prevent redundant builds
- ✅ Comprehensive error handling and artifact verification
- ✅ Build notifications and status reporting

---

## 🔧 Workflow Structure

### Job 1: Build Android APK
**Runs on:** `ubuntu-latest`  
**Duration:** ~30-45 minutes  
**Artifacts Generated:** `android-apk`

**Process:**
1. Checkout source code
2. Set up Java 17 & Gradle caching
3. Install Flutter (3.24.0)
4. Get Flutter dependencies
5. Run Dart code analysis
6. Build APK (release mode)
7. Verify APK exists and check size
8. Upload artifact with 30-day retention

### Job 2: Build iOS IPA (Unsigned)
**Runs on:** `macos-latest`  
**Duration:** ~45-60 minutes  
**Artifacts Generated:** `ios-ipa-unsigned`

**Process:**
1. Checkout source code
2. Install Flutter (3.24.0)
3. Get Flutter dependencies
4. Run Dart code analysis
5. Build iOS (release mode, unsigned)
6. Package as IPA (Payload structure)
7. Verify IPA exists and check size
8. Upload artifact with 30-day retention

### Job 3: Notify Completion
**Runs after:** Both build jobs complete  
**Purpose:** Summarize build results

---

## 📦 Generated Artifacts

### Android APK
```
Name: android-apk
Location: tongkrongan_app/build/app/outputs/flutter-apk/app-release.apk
Size: ~60-75 MB
Format: Android Package Archive
Retention: 30 days
```

**Download Path in GitHub Actions:**
- Go to: `Actions` → `Build Flutter Apps (APK & IPA)` → Latest run
- Artifacts section → `android-apk` → Download

### iOS IPA (Unsigned)
```
Name: ios-ipa-unsigned
Location: tongkrongan_app/Runner.ipa
Size: ~80-100 MB
Format: iOS Package Archive (unsigned)
Retention: 30 days
```

**Download Path in GitHub Actions:**
- Go to: `Actions` → `Build Flutter Apps (APK & IPA)` → Latest run
- Artifacts section → `ios-ipa-unsigned` → Download

---

## 🔑 Required GitHub Secrets

For Android signing, you need 4 GitHub Secrets configured:

### Android Signing Secrets

**Needed if you use signed APK (optional for testing):**
```
ANDROID_KEYSTORE_BASE64         # Base64-encoded keystore file
ANDROID_KEYSTORE_PASSWORD       # Keystore password
ANDROID_KEY_PASSWORD            # Key password
ANDROID_KEY_ALIAS               # Key alias name
```

**Set up:**
1. Go to Repository Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add each secret

### Current Status
✅ Workflow is pre-configured for **unsigned builds**
- No secrets required for APK generation
- iOS IPA is unsigned (can be signed later with Sideloadly or TestFlight)

---

## ⚙️ Configuration Details

### Environment Variables
```yaml
FLUTTER_VERSION: 3.24.0    # Dart SDK 3.13.2
JAVA_VERSION: 17           # For Android builds
```

### Triggers

**Automatic triggers:**
- Push to `main` branch
- Push to `develop` branch

**Manual trigger:**
- `workflow_dispatch` — Click "Run workflow" in GitHub Actions tab

### Build Concurrency
```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```
**Effect:** Only one build per branch runs at a time. New pushes cancel previous builds.

---

## 🚀 How to Use

### Option 1: Automatic Trigger (On Push)
```bash
# Commit and push to main or develop
git add .
git commit -m "Your changes"
git push origin main
```
✅ Workflow starts automatically

### Option 2: Manual Trigger (Workflow Dispatch)
1. Go to GitHub repository
2. Click `Actions` tab
3. Select `Build Flutter Apps (APK & IPA)` workflow
4. Click `Run workflow` button
5. Choose branch: `main` or `develop`
6. Click green `Run workflow` button
7. Wait for builds to complete (45-60 minutes)

### Option 3: Via GitHub CLI
```bash
gh workflow run build_apps.yml --ref main
```

---

## 📊 Build Status & Monitoring

### Real-time Monitoring
1. Go to `Actions` tab in GitHub
2. Click on the running workflow
3. View logs for each job:
   - Build Android APK
   - Build iOS IPA (Unsigned)
   - Notify Build Completion

### Build Logs Include:
- ✅ Dependency installation status
- ✅ Code analysis results
- ✅ Build step details
- ✅ Artifact verification (file size, integrity)
- ✅ Upload completion confirmation

### Common Outputs
```
✅ Both Android APK and iOS IPA builds completed successfully!
```

---

## 📥 Download Artifacts

### From GitHub Actions UI

**Step 1:** Navigate to Actions
```
Repository → Actions → Build Flutter Apps (APK & IPA)
```

**Step 2:** Select latest workflow run
```
Click on the completed workflow (green checkmark)
```

**Step 3:** Download artifacts
```
Scroll to "Artifacts" section
- Click "android-apk" → Download
- Click "ios-ipa-unsigned" → Download
```

### File Locations After Download
- `android-apk/app-release.apk` — Android app
- `ios-ipa-unsigned/Runner.ipa` — iOS app

### Via GitHub CLI
```bash
# Download Android APK
gh run download <run-id> -n android-apk

# Download iOS IPA
gh run download <run-id> -n ios-ipa-unsigned
```

---

## 🔧 Installation & Deployment

### Android APK Installation

**Option 1: Sideloadly (Recommended)**
```
1. Download APK from artifacts
2. Install Sideloadly (https://sideloadly.io)
3. Connect Android device via USB
4. Enable USB Debugging
5. Open Sideloadly → Select device
6. Drag and drop APK
7. Click Install
8. App installs in 2-5 minutes
```

**Option 2: Direct Transfer**
```bash
adb install -r app-release.apk
```

### iOS IPA Installation

**Option 1: Sideloadly**
```
1. Download IPA from artifacts
2. Install Sideloadly (https://sideloadly.io)
3. Connect iOS device via USB
4. Trust device on iPhone
5. Open Sideloadly → Select device
6. Drag and drop IPA
7. Click Install
8. App installs in 3-7 minutes
```

**Option 2: Apple Configurator 2**
```
1. Download IPA
2. Connect iPad/iPhone
3. Open Apple Configurator 2
4. Drag IPA to device
5. Follow prompts
```

**Option 3: xcode (macOS)**
```bash
xcrun simctl install booted Runner.ipa
```

---

## 🛠️ Troubleshooting

### Build Fails - APK Generation Issue

**Error:** `APK file not found!`

**Solution:**
```bash
# Check if Flutter is properly installed
flutter --version

# Clean and rebuild
cd tongkrongan_app
flutter clean
flutter pub get
flutter build apk --release --verbose
```

### Build Fails - iOS IPA Generation Issue

**Error:** `IPA file not found!`

**Solution:**
```bash
# Check iOS requirements
flutter doctor -v

# Rebuild iOS
cd tongkrongan_app
flutter clean
flutter pub get
flutter build ios --release --no-codesign --verbose
```

### Artifact Upload Fails

**Error:** `if-no-files-found: error`

**Check:**
1. Build logs for actual build failures
2. Verify correct file paths in workflow
3. Ensure build succeeded before upload step

**Fix:**
```yaml
# In workflow, change error handling
if-no-files-found: warn  # Instead of error
```

### Workflow Timeout (>60 minutes)

**Cause:** Large dependencies or slow build

**Solution:**
- Reduce flutter-version complexity
- Use `cache: true` for dependencies
- Split into separate workflows if needed

---

## 📝 Customization Guide

### Change Flutter Version
```yaml
env:
  FLUTTER_VERSION: 3.24.0  # Change this
```

### Change Java Version
```yaml
env:
  JAVA_VERSION: 17  # Change to 11, 17, or 21
```

### Change Artifact Retention
```yaml
retention-days: 30  # Change to 7, 14, 30, 90
```

### Add Email Notifications
```yaml
- name: Send Build Notification
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: ${{ secrets.MAIL_SERVER }}
    server_port: ${{ secrets.MAIL_PORT }}
    username: ${{ secrets.MAIL_USERNAME }}
    password: ${{ secrets.MAIL_PASSWORD }}
    subject: "Build Complete: ${{ job.status }}"
```

### Add Slack Notifications
```yaml
- name: Send Slack Notification
  uses: slackapi/slack-github-action@v1
  with:
    payload: |
      {
        "text": "Build Complete: ${{ job.status }}",
        "blocks": [...]
      }
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

---

## 📊 Workflow Performance Metrics

### Typical Build Times
```
Android APK Build:     25-35 minutes
iOS IPA Build:         35-50 minutes
Parallel Overhead:     10-15 minutes
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total Time:            45-60 minutes
```

### File Sizes
```
app-release.apk:       60-75 MB
Runner.ipa:            80-100 MB (varies by assets)
```

### Resource Usage
```
Android build:         ~4-6 GB storage
iOS build:             ~6-8 GB storage
Total artifacts:       150-180 MB (compressed)
```

---

## ✅ Pre-Flight Checklist

Before running the build workflow:

```
[ ] Flutter version in pubspec.yaml: ^3.13.2
[ ] Kotlin version in android/build.gradle: 1.7.20+
[ ] iOS minimum deployment target: 11.0+
[ ] No uncommitted changes in repository
[ ] All dependencies in pubspec.yaml resolved
[ ] No build warnings in local test build
[ ] GitHub Actions tab enabled in repository
[ ] No secrets missing in GitHub
```

---

## 🔐 Security Best Practices

### Secrets Management
- ✅ Never commit keystore files
- ✅ Store secrets only in GitHub Secrets
- ✅ Rotate credentials regularly
- ✅ Restrict secret access to main branch only

### Build Security
- ✅ Use `--no-codesign` for iOS testing builds
- ✅ Sign APKs only on trusted CI/CD systems
- ✅ Verify artifact checksums before deployment
- ✅ Enable branch protection rules

### Repository Security
```
Settings → Branch protection rules:
- [ ] Require a pull request before merging
- [ ] Require status checks to pass
- [ ] Require code review approvals
```

---

## 📚 Reference Documentation

### Official Resources
- [Flutter CI/CD Best Practices](https://flutter.dev/docs/deployment/cd)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Android Build Guide](https://flutter.dev/docs/deployment/android)
- [iOS Build Guide](https://flutter.dev/docs/deployment/ios)

### Related Documentation (This Project)
- `QUICK_START_APK.md` — Quick setup guide
- `BUILD_AND_TEST_APK.md` — Testing guide
- `INSTALL_APK_SIDELOADLY.md` — Installation instructions
- `GITHUB_SECRETS_ADD.md` — Secret configuration

### Useful Commands
```bash
# List all workflows
gh workflow list

# View workflow runs
gh run list --workflow=build_apps.yml

# Cancel running workflow
gh run cancel <run-id>

# Download specific artifact
gh run download <run-id> -n android-apk
```

---

## 🎯 Next Steps

### To Use This Workflow:

1. **Ensure Flutter Setup**
   ```bash
   cd tongkrongan_app
   flutter pub get
   ```

2. **Test Local Build**
   ```bash
   flutter build apk --release
   flutter build ios --release --no-codesign
   ```

3. **Push to GitHub**
   ```bash
   git push origin main
   ```

4. **Monitor Build**
   - Go to Actions tab
   - Watch build progress (45-60 minutes)
   - Download artifacts when complete

5. **Install on Device**
   - Use Sideloadly or similar tool
   - Test app functionality
   - Gather feedback

---

## 💡 Tips & Best Practices

### For Faster Builds
- Minimize dependencies in pubspec.yaml
- Use `flutter pub cache repair` to clean cache
- Avoid large assets (compress images, videos)
- Use selective code compilation

### For Better Reliability
- Test locally before pushing
- Use branch protection on main
- Monitor build logs regularly
- Keep Flutter version updated

### For Team Collaboration
- Document build requirements
- Share artifact download links
- Create release notes with builds
- Use semantic versioning for releases

---

## 📞 Support & Issues

### Common Questions

**Q: Why does iOS build take longer?**
A: macOS-latest runner is slower than ubuntu-latest. iOS has more build steps (CocoaPods, xcodebuild).

**Q: Can I skip iOS or Android build?**
A: Yes, modify workflow to remove `build-ios` or `build-android` job.

**Q: How do I sign the APK?**
A: Add Android signing secrets and enable signing in the workflow (optional).

**Q: Is the IPA really unsigned?**
A: Yes, it cannot be installed on real devices without signing. Use Sideloadly which handles signing.

**Q: How often can I build?**
A: Unlimited. GitHub Actions has generous free tier (2000 minutes/month for public repos).

---

## 🎉 Summary

Your GitHub Actions workflow is fully configured to:
✅ Build Android APK automatically  
✅ Build iOS IPA automatically  
✅ Generate artifacts ready for download  
✅ Provide detailed build logs  
✅ Notify on completion  

**Status:** Ready to use! Push to `main` branch or manually trigger workflow.

---

**Last Updated:** 2024  
**Workflow File:** `.github/workflows/build_apps.yml`  
**Maintained by:** Development Team
