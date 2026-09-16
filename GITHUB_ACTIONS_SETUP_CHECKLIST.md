# ✅ GitHub Actions Setup Checklist

**Workflow:** `.github/workflows/build_apps.yml`  
**Purpose:** Verify everything is ready to use  
**Time Required:** 10 minutes

---

## 🎯 Pre-Requisites (Before First Use)

### Repository Setup

```
[ ] Repository cloned or created
[ ] Code committed to GitHub
[ ] Branch 'main' exists
[ ] .github/workflows/ directory exists
[ ] .github/workflows/build_apps.yml file present
```

**Verify:**
```bash
# Check if workflow file exists
ls -la .github/workflows/build_apps.yml

# Check if main branch exists
git branch | grep main
```

---

### Local Flutter Setup

```
[ ] Flutter installed (version 3.13.2+)
[ ] Dart SDK installed (version 3.13.2+)
[ ] Android SDK installed
[ ] iOS SDK installed (if on macOS)
[ ] Gradle installed
[ ] Xcode installed (if on macOS)
```

**Verify:**
```bash
# Check Flutter version
flutter --version

# Run diagnostics
flutter doctor -v

# Check Dart version
dart --version
```

---

### Project Configuration

```
[ ] pubspec.yaml exists and is valid
[ ] pubspec.lock generated
[ ] Dependencies resolved (flutter pub get works)
[ ] No version conflicts
[ ] tongkrongan_app/ directory structure correct
[ ] android/ directory contains gradle files
[ ] ios/ directory contains Xcode project
```

**Verify:**
```bash
cd tongkrongan_app

# Check dependencies
flutter pub get

# Check for issues
flutter analyze

# List structure
ls -la android/
ls -la ios/
```

---

## 🔐 GitHub Configuration

### Repository Secrets (Optional for unsigned builds)

```
For unsigned builds (current setup):
[ ] NO SECRETS REQUIRED ✅

For signed builds (optional):
[ ] ANDROID_KEYSTORE_BASE64 (if using signing)
[ ] ANDROID_KEYSTORE_PASSWORD (if using signing)
[ ] ANDROID_KEY_PASSWORD (if using signing)
[ ] ANDROID_KEY_ALIAS (if using signing)
```

**How to verify:**
```
GitHub Repository → Settings → Secrets and variables → Actions
└─ Check configured secrets
```

**Skip if:** You only need unsigned APK/IPA (recommended for testing)

---

### GitHub Actions Enabled

```
[ ] GitHub Actions enabled in repository
[ ] Workflow file readable
[ ] No branch protection blocking workflows
[ ] Sufficient artifact storage (500 MB minimum)
```

**Verify:**
```
GitHub Repository → Actions tab
└─ Can see workflows and runs
```

---

### Repository Visibility

```
[ ] Repository is public OR
[ ] GitHub Actions has access to private repo
[ ] Actions tab visible to team members
```

---

## 📁 File Structure Verification

### Correct Directory Structure

```
Your Repository/
├── .github/
│   └── workflows/
│       └── build_apps.yml ✅
├── tongkrongan_app/
│   ├── android/
│   │   ├── app/
│   │   ├── build.gradle
│   │   └── gradle/
│   ├── ios/
│   │   ├── Runner.xcodeproj
│   │   └── Runner.xcworkspace
│   ├── lib/
│   ├── pubspec.yaml
│   └── pubspec.lock
├── .gitignore
└── README.md
```

**Verify:**
```bash
# List structure
tree -L 3 .

# Or with ls
ls -la .github/workflows/
ls -la tongkrongan_app/
```

---

## 🧪 Pre-Build Testing

### Local Build Test - Android

```
[ ] Local APK build succeeds (flutter build apk --debug)
[ ] Debug APK generates ~60 MB
[ ] APK location: tongkrongan_app/build/app/outputs/flutter-apk/
```

**Test:**
```bash
cd tongkrongan_app
flutter build apk --debug --verbose

# Check output
ls -lh build/app/outputs/flutter-apk/app-debug.apk
```

### Local Build Test - iOS (macOS only)

```
[ ] Local iOS build succeeds (flutter build ios --debug)
[ ] iOS build generates app bundle
[ ] iOS location: tongkrongan_app/build/ios/Debug-iphoneos/
```

**Test:**
```bash
cd tongkrongan_app
flutter build ios --debug --verbose

# Check output
ls -la build/ios/iphoneos/Runner.app/
```

---

## 🔄 Git Configuration

### Git Repository

```
[ ] Git initialized (git init done)
[ ] Remote configured (git remote origin)
[ ] Able to push to GitHub
[ ] Branch 'main' set as default
[ ] No uncommitted changes
```

**Verify:**
```bash
# Check remotes
git remote -v

# Check current branch
git branch -a

# Check uncommitted changes
git status
```

### Commit History

```
[ ] At least one commit in repository
[ ] Main branch has some commits
[ ] No merge conflicts
[ ] Ready to push
```

---

## 📝 Documentation

### Workflow Documentation

```
[ ] GITHUB_ACTIONS_QUICK_REFERENCE.md - Present ✅
[ ] GITHUB_ACTIONS_BUILD_WORKFLOW.md - Present ✅
[ ] GITHUB_ACTIONS_WORKFLOW_GUIDE.md - Present ✅
[ ] GITHUB_ACTIONS_TROUBLESHOOTING.md - Present ✅
[ ] GITHUB_ACTIONS_DOCUMENTATION_INDEX.md - Present ✅
```

**Verify:**
```bash
ls -la GITHUB_ACTIONS_*.md
```

### Documentation Read

```
[ ] Read Quick Reference (5 min)
[ ] Understand basic workflow
[ ] Know how to trigger build
[ ] Know where artifacts go
```

---

## 🚀 Ready to Build Checklist

### Final Checks Before First Build

```
Code Quality:
[ ] No obvious syntax errors
[ ] Code builds locally
[ ] No merge conflicts
[ ] Latest main branch

Repository:
[ ] Latest code committed
[ ] No uncommitted changes
[ ] Able to push to GitHub
[ ] Main branch up to date

Workflow:
[ ] Workflow file exists
[ ] GitHub Actions enabled
[ ] Repository settings correct
[ ] No branch protection issues

Documentation:
[ ] Quick Reference read
[ ] Know how to download artifacts
[ ] Know how to install on device
[ ] Know basic troubleshooting
```

---

## 🎯 First Build Process

### Step 1: Commit & Push

```bash
# Ensure all changes committed
git status

# If changes exist:
git add .
git commit -m "Your changes message"

# Push to main
git push origin main
```

**Verify:** ✅ If push succeeds without errors

---

### Step 2: Trigger Workflow

**Option A: Automatic (recommended)**
```
Workflow triggers automatically after push
Wait 5-10 seconds for GitHub to process
```

**Option B: Manual Trigger**
```
1. GitHub.com → Your Repository
2. Click "Actions" tab
3. Click "Build Flutter Apps (APK & IPA)"
4. Click "Run workflow"
5. Select branch: main
6. Click green "Run workflow"
```

**Verify:** ✅ Workflow status shows "in progress" or "running"

---

### Step 3: Monitor Build

```bash
# Option 1: GitHub Web UI
# Go to Actions tab → Click running workflow → Watch logs

# Option 2: GitHub CLI
gh run list --workflow=build_apps.yml
gh run watch <run-id>

# Option 3: Just wait
# Email notification when complete (if enabled)
```

**Wait:** 45-60 minutes for build to complete

---

### Step 4: Check Results

```
When build completes (green checkmark):

Android Job:
[ ] Status: ✅ success or ⚠️ warning

iOS Job:
[ ] Status: ✅ success or ⚠️ warning

Notify Job:
[ ] Status shows build summary
```

---

### Step 5: Download Artifacts

```bash
# Option 1: GitHub Web UI
# Actions → Latest run → Artifacts section
# Download: android-apk and ios-ipa-unsigned

# Option 2: GitHub CLI
gh run download <run-id> -n android-apk
gh run download <run-id> -n ios-ipa-unsigned

# Verify downloads
ls -la android-apk/
ls -la ios-ipa-unsigned/
```

**Verify:** ✅ Both files downloaded successfully

---

### Step 6: Test Installation

#### Android APK

```
Sideloadly:
[ ] Download Sideloadly from https://sideloadly.io
[ ] Connect Android device via USB
[ ] Enable USB Debugging on device
[ ] Drag & drop APK into Sideloadly
[ ] Click Install
[ ] Wait 2-5 minutes
[ ] App appears on device
```

#### iOS IPA

```
Sideloadly:
[ ] Connect iOS device via USB
[ ] Trust device on iPhone screen
[ ] Drag & drop IPA into Sideloadly
[ ] Click Install
[ ] Wait 3-7 minutes
[ ] App appears on device
```

---

## 📊 Validation Checklist

### Workflow File Validation

```
File: .github/workflows/build_apps.yml

YAML Syntax:
[ ] Valid YAML format (GitHub would reject if invalid)
[ ] No syntax errors
[ ] All required fields present

Jobs:
[ ] build-android job defined
[ ] build-ios job defined
[ ] notify-completion job defined

Steps - Android:
[ ] Checkout step present
[ ] Java setup step present
[ ] Flutter setup step present
[ ] APK build step present
[ ] Artifact upload step present

Steps - iOS:
[ ] Checkout step present
[ ] Flutter setup step present
[ ] iOS build step present
[ ] IPA packaging step present
[ ] Artifact upload step present

Triggers:
[ ] Push trigger: main, develop
[ ] workflow_dispatch: present (manual)
[ ] pull_request: main
```

**Verify:**
```bash
# Check workflow file syntax (in Actions tab)
# If red ❌, there's a syntax error
# If blue ✓, syntax is valid
```

---

### Environment Validation

```
Flutter Version:
[ ] Version 3.24.0 specified
[ ] Compatible with pubspec.yaml (3.13.2+)
[ ] Stable channel used

Java Version:
[ ] Version 17 specified
[ ] Compatible with Android builds
[ ] Gradle compatible

Dependencies:
[ ] pubspec.yaml resolves correctly
[ ] No version conflicts
[ ] All packages available
```

---

### Artifact Validation

```
After first build, verify artifacts:

Android APK:
[ ] File size: 60-75 MB
[ ] Name: app-release.apk
[ ] Installable on Android device
[ ] App runs without crashing

iOS IPA:
[ ] File size: 80-100 MB
[ ] Name: Runner.ipa
[ ] Structure: Payload/Runner.app/
[ ] Installable via Sideloadly
```

---

## ⚡ Quick Start Path

### Fastest Setup (30 minutes)

```
Time: Action
─────────────────────────────────────
5 min : Clone repo and push to GitHub
5 min : Read Quick Reference
10 min: Monitor first build (just started)
5 min : Download artifacts
10 min: Install on device using Sideloadly

Result: ✅ First build complete
```

### Complete Setup (90 minutes)

```
Time: Action
─────────────────────────────────────
5 min : Clone repo and verify setup
10 min: Read Quick Reference
10 min: Read Workflow Guide (visuals)
15 min: Read Build Workflow (complete)
5 min : Trigger first build
30 min: Monitor build
10 min: Download and install artifacts
10 min: Review Troubleshooting guide

Result: ✅ Complete understanding
```

---

## 🐛 If Something Is Wrong

### Workflow Not Triggering

```
Check:
[ ] Code pushed to main branch
[ ] .github/workflows/build_apps.yml exists
[ ] GitHub Actions enabled in repository
[ ] No branch protection blocking

Fix:
1. Check Actions tab
2. If no workflow visible, refresh page
3. If still missing, push code again
4. Try manual trigger: Run workflow
```

### Build Failing

```
Check:
1. Read build logs line by line
2. Find actual error message
3. Check Troubleshooting guide for error type
4. Test locally: flutter build apk/ios --release
5. If local fails, fix code first

Fix:
1. Apply fix from Troubleshooting guide
2. Commit changes
3. Push to main
4. Build will retry automatically
```

### Artifacts Not Appearing

```
Check:
1. Wait full 45-60 minutes
2. Refresh GitHub page
3. Check both android-apk and ios-ipa-unsigned
4. Check build logs for upload step

If missing:
1. Click on build log
2. Search for "Upload Artifact"
3. Check if step shows ✅ or ❌
4. If ❌, check actual error
5. Retry build
```

---

## 📋 Team Onboarding

### For Team Members New to Workflow

```
[ ] Share this checklist
[ ] Share Quick Reference
[ ] Demonstrate manual trigger
[ ] Show where to download artifacts
[ ] Explain installation process
[ ] Provide Troubleshooting guide link
```

### Documentation to Share

```
Level 1 - Quick Users:
└─ GITHUB_ACTIONS_QUICK_REFERENCE.md

Level 2 - Team Leads:
├─ GITHUB_ACTIONS_BUILD_WORKFLOW.md
└─ GITHUB_ACTIONS_WORKFLOW_GUIDE.md

Level 3 - Troubleshooters:
└─ GITHUB_ACTIONS_TROUBLESHOOTING.md
```

---

## 🎉 Success Criteria

### Build is Working When:

```
✅ Code pushed to main triggers workflow
✅ Workflow shows "in progress"
✅ Workflow completes in 45-60 minutes
✅ Both Android and iOS jobs succeed
✅ Artifacts appear in Actions tab
✅ APK can be downloaded and installed
✅ IPA can be downloaded and installed
✅ Apps run on devices without crashing
```

### Team is Ready When:

```
✅ Everyone knows how to trigger build
✅ Everyone knows where to download artifacts
✅ Everyone can install on device
✅ Team understands basic troubleshooting
✅ Questions answered from documentation
```

---

## 📞 Support Path

### If You Get Stuck:

```
Step 1: Check documentation
└─ Quick Reference (basic questions)
└─ Build Workflow (detailed info)
└─ Troubleshooting (errors)

Step 2: Check GitHub Actions logs
└─ Click on failed step
└─ Read actual error message
└─ Search Troubleshooting guide for error type

Step 3: Test locally
└─ Run: flutter build apk --release --verbose
└─ Run: flutter build ios --release --no-codesign --verbose
└─ Check if same error occurs locally

Step 4: Refer to Troubleshooting
└─ Find error section
└─ Follow root cause analysis
└─ Apply solution steps
└─ Retry workflow

Step 5: Escalate if needed
└─ Document exact error
└─ Share workflow logs
└─ Share local build logs
└─ Ask for expert review
```

---

## ✅ Final Verification

### Before Declaring "Ready":

```
Build System:
[ ] Workflow file exists
[ ] GitHub Actions enabled
[ ] First build successful
[ ] Artifacts generated
[ ] Both APK and IPA created

Testing:
[ ] APK installed and runs
[ ] IPA installed and runs
[ ] No obvious crashes
[ ] All features accessible

Documentation:
[ ] Team has access
[ ] Team has read overview
[ ] Team knows how to use
[ ] Troubleshooting available

Automation:
[ ] Builds trigger on push
[ ] Can manually trigger
[ ] Status visible in Actions
[ ] Notifications working
```

---

## 🎯 Next Steps

### Immediate (Today)

```
[ ] Complete this checklist
[ ] Run first build
[ ] Download artifacts
[ ] Install on test device
[ ] Verify app works
```

### Short Term (This Week)

```
[ ] Read all documentation
[ ] Understand workflow
[ ] Test troubleshooting steps
[ ] Optimize build if needed
```

### Medium Term (This Month)

```
[ ] Set up team training
[ ] Share artifacts with testers
[ ] Gather feedback
[ ] Make any adjustments
```

### Long Term (Ongoing)

```
[ ] Monitor build times
[ ] Optimize as needed
[ ] Keep documentation updated
[ ] Train new team members
```

---

## 📝 Sign-Off

### Checklist Completion

```
Name: ________________________
Date: ________________________
Status: ✅ COMPLETE

All items verified:
[ ] Yes, everything works
[ ] Yes, with minor issues (document)
[ ] No, needs more work (document issues)

Notes:
_________________________________
_________________________________
```

---

**Status:** ✅ Complete Setup Checklist  
**Last Updated:** 2024  
**Total Steps:** 50+  
**Estimated Time:** 30-90 minutes  

**Next Action:** Begin with "Pre-Requisites" section above!

