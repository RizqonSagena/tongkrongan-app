# 🚀 GitHub Setup Instructions for Tongkrongan App

**Your GitHub Account:** RizqonSagena  
**Task:** Setup new GitHub repository for Tongkrongan App CI/CD

---

## ✅ STEP-BY-STEP SETUP

### STEP 1: Create New GitHub Repository

1. Go to https://github.com/new
2. Fill in:
   - **Repository name:** `tongkrongan-app`
   - **Description:** "Hangout discovery app with Flutter - Android & iOS"
   - **Visibility:** Private (if sensitive) or Public
   - **Initialize:** Leave unchecked (we have code already)
3. Click **"Create repository"**

You'll see a page like:
```
git remote add origin https://github.com/RizqonSagena/tongkrongan-app.git
git branch -M main
git push -u origin main
```

---

### STEP 2: Update Local Repository (Windows PowerShell)

Copy-paste these commands one by one:

```powershell
# Navigate to project
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Remove old remote
git remote remove origin

# Add new remote (replace with YOUR username/repo)
git remote add origin https://github.com/RizqonSagena/tongkrongan-app.git

# Verify remote updated
git remote -v

# Expected output:
# origin  https://github.com/RizqonSagena/tongkrongan-app.git (fetch)
# origin  https://github.com/RizqonSagena/tongkrongan-app.git (push)
```

---

### STEP 3: Add & Commit Files

```powershell
# Check what will be committed
git status

# Stage only project files (NOT system files)
git add ".github/"
git add "tongkrongan_app/"
git add "stitch_tongkrongan_hangout_discovery_app/"
git add "*.md"

# Check staged files
git status

# Commit with message
git commit -m "Initial commit: Flutter app with CI/CD workflows"
```

---

### STEP 4: Push to GitHub

```powershell
# Push to main branch
git push -u origin main

# Monitor push progress
# When done, you'll see:
# branch 'main' set up to track 'origin/main'.
```

---

### STEP 5: Verify on GitHub

1. Go to https://github.com/RizqonSagena/tongkrongan-app
2. You should see:
   - ✅ All files uploaded
   - ✅ `.github/workflows/` folder with 3 YAML files
   - ✅ `tongkrongan_app/` folder
   - ✅ All markdown files

---

## 🔐 STEP 6: Add GitHub Secrets

After files are pushed:

1. Go to repository → **Settings**
2. Left sidebar → **Secrets and variables** → **Actions**
3. Click **"New repository secret"** for each:

**Android Secrets (4):**
```
Name: ANDROID_KEYSTORE_BASE64
Value: [base64 encoded keystore]

Name: ANDROID_KEYSTORE_PASSWORD
Value: [your keystore password]

Name: ANDROID_KEY_PASSWORD
Value: [your key password]

Name: ANDROID_KEY_ALIAS
Value: tongkrongan
```

**iOS Secrets (7):**
```
Name: IOS_CERTIFICATE_BASE64
Value: [base64 encoded .p12]

Name: IOS_CERTIFICATE_PASSWORD
Value: [certificate password]

Name: IOS_PROVISIONING_PROFILE_BASE64
Value: [base64 encoded .mobileprovision]

Name: KEYCHAIN_PASSWORD
Value: [any secure password]

Name: TESTFLIGHT_USERNAME
Value: [your Apple ID email]

Name: TESTFLIGHT_PASSWORD
Value: [app-specific password]

Name: TESTFLIGHT_APP_ID
Value: com.stitch.tongkrongan
```

**Sideloadly Secrets (2 - Optional):**
```
Name: SIDELOADLY_API_KEY
Value: [your Sideloadly API key]

Name: SIDELOADLY_DEVICE_ID
Value: [your device ID]
```

---

## 🚀 STEP 7: Test CI/CD Pipeline

After secrets are added:

1. Make a small change to project (e.g., edit README)
2. Push to GitHub:
   ```powershell
   git add .
   git commit -m "Test CI/CD pipeline"
   git push origin main
   ```

3. Go to repository → **Actions** tab
4. You should see workflows starting:
   - ✅ Build Android APK (15 min)
   - ✅ Build iOS IPA (20 min)
   - ✅ Deploy to Sideloadly (5 min)

---

## ✅ COMPLETE CHECKLIST

Before CI/CD is ready:

- [ ] New GitHub repository created
- [ ] Local remote updated to new repo
- [ ] All files committed
- [ ] Push to GitHub successful
- [ ] Files visible on GitHub
- [ ] `.github/workflows/` folder visible
- [ ] 13 GitHub secrets added
- [ ] Secrets have correct values
- [ ] Test push triggered workflows
- [ ] Workflows executed successfully

---

## 📍 YOUR REPOSITORY INFO

After setup, your repo will be at:
```
https://github.com/RizqonSagena/tongkrongan-app
```

View workflows at:
```
https://github.com/RizqonSagena/tongkrongan-app/actions
```

View secrets at:
```
https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
```

---

## 🆘 TROUBLESHOOTING

### "Could not resolve host"
```
Solution: Check internet connection
```

### "fatal: Not a git repository"
```
Solution: Make sure you're in correct directory:
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"
```

### "Permission denied (publickey)"
```
Solution: Configure Git credentials
git config --global user.email "your-email@example.com"
git config --global user.name "Your Name"
```

### Workflows don't run
```
Solution:
1. Check workflow YAML syntax
2. Verify secrets are added
3. Check branch name is "main"
4. Review workflow logs for errors
```

---

## 📞 QUICK REFERENCE

**Your account:** RizqonSagena  
**New repo:** tongkrongan-app  
**Workflows:** build-android.yml, build-ios.yml, deploy-sideloadly.yml  
**Total setup time:** ~1 hour (secrets generation) + 15 min (push)

---

**Status:** Ready for GitHub Setup
**Date:** September 16, 2026

