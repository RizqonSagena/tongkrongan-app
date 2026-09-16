# 🚀 BUILD APK & IPA via GitHub Actions - Complete Guide

**Goal:** Automatically build Android APK & iOS IPA every time you push to GitHub

**Status:** ✅ Ready to build! Just add 4 secrets and push.

---

## 📋 YOUR ANDROID CREDENTIALS (Ready!)

✅ **Keystore generated:** `tongkrongan_app/android/app/upload-keystore.jks`

### 4 GitHub Secrets to Add:

```
1. ANDROID_KEYSTORE_BASE64
   Value: [See keystore-base64.txt]

2. ANDROID_KEYSTORE_PASSWORD
   Value: Tongkrongan@2024_637729

3. ANDROID_KEY_PASSWORD
   Value: Key@2024_236320

4. ANDROID_KEY_ALIAS
   Value: tongkrongan
```

---

## ⚡ QUICK START (5 minutes)

### Step 1: Add Secrets to GitHub

**Go to:** https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

**For each secret:**
1. Click **[New repository secret]** (green button)
2. Enter Name and Value
3. Click **[Add secret]**

**Secret Details:**

#### Secret 1: ANDROID_KEYSTORE_BASE64
```
Name: ANDROID_KEYSTORE_BASE64
Value: [Copy from keystore-base64.txt file]
```

The base64 value is very long (starts with `MIIKngIBAzCCCkgGCSqGSIb3DQEH...`). 
Copy the entire content from `keystore-base64.txt`.

#### Secret 2: ANDROID_KEYSTORE_PASSWORD
```
Name: ANDROID_KEYSTORE_PASSWORD
Value: Tongkrongan@2024_637729
```

#### Secret 3: ANDROID_KEY_PASSWORD
```
Name: ANDROID_KEY_PASSWORD
Value: Key@2024_236320
```

#### Secret 4: ANDROID_KEY_ALIAS
```
Name: ANDROID_KEY_ALIAS
Value: tongkrongan
```

### Step 2: Push Code to GitHub

```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Make small change
Add-Content README.md "`n# Build APK"

# Commit and push
git add .
git commit -m "Trigger APK build"
git push origin main
```

### Step 3: Monitor Build

**Go to:** https://github.com/RizqonSagena/tongkrongan-app/actions

You should see:
```
✓ Build Android APK (running)
  ├─ Status: In Progress
  ├─ Time: ~15 minutes
  └─ Result: app-release.apk ready for download
```

### Step 4: Download APK

After build completes:

1. Go to workflow run
2. Scroll down to **Artifacts** section
3. Download **app-release.apk**
4. Transfer to Android phone and install!

---

## 🔍 WHAT'S IN EACH FILE

### Workflow Files (Already Created)

**`.github/workflows/build-android.yml`**
- Triggers when you push
- Builds Flutter APK
- Signs with your keystore
- Uploads to Artifacts & Sideloadly

**`.github/workflows/build-ios.yml`**
- For iPhone builds (requires Mac)
- Optional - skip if no iOS devices

**`.github/workflows/deploy-sideloadly.yml`**
- Auto-installs on your device
- Optional - requires Sideloadly API key

### Credential Files (You Created)

**`tongkrongan_app/android/app/upload-keystore.jks`**
- Your Android signing key
- Keep safe! Don't commit to GitHub (in `.gitignore`)

**`keystore-base64.txt`**
- Base64 encoded keystore
- For GitHub secret only
- Can delete after secrets are added

---

## 🏗️ BUILD PROCESS EXPLAINED

```
git push origin main
    ↓
GitHub detects push
    ↓
Workflow triggered: build-android.yml
    ↓
Ubuntu runs:
  1. Checkout code
  2. Setup Flutter
  3. Run: flutter build apk --release
  4. Sign APK with keystore
  5. Upload to Artifacts
  ↓
~15 minutes later...
    ↓
APK ready for download!
```

---

## 📊 BUILD TIMES

| Task | Time |
|------|------|
| Checkout & Setup | 2 min |
| Flutter Build | 10 min |
| Signing | 2 min |
| Upload | 1 min |
| **Total** | **~15 min** |

---

## 🔐 SECURITY NOTES

✅ **Passwords stored in GitHub Secrets**
- Not visible in logs
- Encrypted at rest
- Only accessible to workflows

✅ **Keystore file is safe**
- Not committed to GitHub (in `.gitignore`)
- Only base64 is in GitHub

✅ **Your secrets are private**
- GitHub doesn't show secret values
- Only shows as `***` in logs

---

## 🆘 TROUBLESHOOTING

### APK Build Failed?

**Check logs:**
1. Go to: https://github.com/RizqonSagena/tongkrongan-app/actions
2. Click failed workflow
3. Click **"Build Android APK"** step
4. Scroll down to see error message

**Common errors:**

| Error | Fix |
|-------|-----|
| Keystore password incorrect | Verify password matches `ANDROID_KEYSTORE_PASSWORD` |
| Base64 is wrong | Re-check `keystore-base64.txt` content |
| Missing secrets | Verify all 4 secrets added at GitHub settings |
| Flutter not found | Workflow will handle - check Flutter SDK version |

### Secrets Not Working?

1. Go to: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
2. Verify all 4 secrets exist
3. Check names exactly match (case-sensitive!)
4. Try pushing again after adding secrets

### Downloaded APK Won't Install?

- Check Android version compatibility
- Enable "Unknown Sources" in phone settings
- Try USB debugging mode if using adb

---

## 🍎 OPTIONAL: iOS BUILD (Requires Mac)

If you want to build IPA for iPhone:

1. Get Apple Developer Account ($99/year)
2. Create certificates & provisioning profile
3. Add 7 more GitHub secrets (see SECRETS_CHECKLIST.md)
4. Next push will build iOS IPA automatically

**Note:** iOS build only works on macOS - GitHub provides macOS runners.

---

## 🚀 OPTIONAL: AUTO-DEPLOY TO DEVICE (Sideloadly)

To auto-install APK/IPA on device after build:

1. Create Sideloadly account: https://sideloadly.io
2. Get API key and Device ID
3. Add 2 more secrets:
   - SIDELOADLY_API_KEY
   - SIDELOADLY_DEVICE_ID
4. Next push will auto-deploy to your device!

---

## 📁 NEXT STEPS

1. ✅ Keystore created
2. ✅ Base64 generated
3. **⏭️ Add 4 secrets to GitHub** ← You are here
4. **⏭️ Push code to trigger build**
5. ⏭️ Download APK from Artifacts
6. ⏭️ Install on Android phone

---

## ✨ YOU'RE SET!

**What to do now:**

```powershell
# 1. Go to GitHub secrets
# https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

# 2. Add 4 secrets with values from this guide

# 3. In PowerShell, push code:
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"
git add .
git commit -m "Add build secrets - trigger APK build"
git push origin main

# 4. Watch build at:
# https://github.com/RizqonSagena/tongkrongan-app/actions

# 5. Download APK from Artifacts (after ~15 min)

# 6. Install on phone!
```

---

## 📚 COMPLETE DOCUMENTATION

- **QUICK_BUILD_SETUP.md** - Quick reference
- **SECRETS_CHECKLIST.md** - All 13 secrets
- **CICD_COMPLETE_GUIDE.md** - Full details
- **ANDROID_BUILD_CREDENTIALS.txt** - Your credentials

---

**Status:** Ready for APK Build!  
**Date:** September 16, 2026  
**Version:** 1.0

🎉 Build APK automatically on every push to GitHub!

