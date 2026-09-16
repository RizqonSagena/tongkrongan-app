# ⚡ QUICK BUILD SETUP - APK & IPA di GitHub Actions

**Goal:** Build APK & IPA otomatis saat push ke GitHub

**Time:** 5-10 minutes  
**Status:** Ready to setup

---

## 🚀 STEP 1: SETUP CREDENTIALS (5 MIN)

### Android Keystore
Keystore sudah di-generate di:
```
tongkrongan_app/android/app/upload-keystore.jks
```

Passwords untuk keystore:
```
ANDROID_KEYSTORE_PASSWORD: [SAVE IN STEP 3]
ANDROID_KEY_PASSWORD: [SAVE IN STEP 3]
ANDROID_KEY_ALIAS: tongkrongan
```

### iOS Certificates (OPTIONAL - Mac Only)
Untuk iOS, Anda butuh:
- Apple Developer Account ($99/year)
- .p12 certificate (dari Apple)
- .mobileprovision profile (dari Apple)
- Apple ID password

**Jika tidak ada iOS:** Bisa skip iOS secrets, hanya Android akan build.

---

## 📋 STEP 2: PREPARE 13 GITHUB SECRETS

Go to: **https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions**

### Minimum (Android Only) - 4 Secrets:

```
1. ANDROID_KEYSTORE_BASE64
   Value: [base64 of upload-keystore.jks]
   
   Get it:
   cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app"
   
   PowerShell:
   $data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
   [Convert]::ToBase64String($data) | Set-Clipboard

2. ANDROID_KEYSTORE_PASSWORD
   Value: [Your keystore password]

3. ANDROID_KEY_PASSWORD
   Value: [Your key password]

4. ANDROID_KEY_ALIAS
   Value: tongkrongan
```

### Optional (iOS) - 7 More Secrets:
See SECRETS_CHECKLIST.md for full list

---

## 🔄 STEP 3: GENERATE BASE64 FOR KEYSTORE

**Windows PowerShell:**

```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app"

# Generate base64
$data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
$base64 = [Convert]::ToBase64String($data)

# Copy to clipboard
$base64 | Set-Clipboard

# Now paste in GitHub secret ANDROID_KEYSTORE_BASE64
```

---

## ✅ STEP 4: ADD 4 SECRETS TO GITHUB (MINIMUM FOR ANDROID)

1. Go to: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

2. Click **[New repository secret]**

3. Add these 4:

| Secret Name | Value |
|---|---|
| ANDROID_KEYSTORE_BASE64 | [Paste base64 from clipboard] |
| ANDROID_KEYSTORE_PASSWORD | [Your keystore password] |
| ANDROID_KEY_PASSWORD | [Your key password] |
| ANDROID_KEY_ALIAS | tongkrongan |

---

## 🚀 STEP 5: TRIGGER BUILD (Push to GitHub)

```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Make small change
Add-Content README.md "`n# Build Test"

# Commit and push
git add .
git commit -m "Trigger APK build"
git push origin main
```

---

## 📊 STEP 6: MONITOR BUILD (Watch Workflows)

Go to: **https://github.com/RizqonSagena/tongkrongan-app/actions**

You should see:

```
✓ Build Android APK (running)
  ✓ Started: 2 min ago
  ✓ Time: ~15 minutes total
  ✓ Status: In progress...

Then after Android done:

✓ Deploy to Sideloadly (ready when APK done)
```

---

## 📱 STEP 7: DOWNLOAD APK

After build completes:

1. Go to: https://github.com/RizqonSagena/tongkrongan-app/actions

2. Click on latest **"Build Android APK"** workflow

3. Scroll down to **Artifacts** section

4. Download: **app-release.apk**

5. Transfer to Android phone and install!

---

## 🍎 FOR iOS BUILD (Optional)

If you have Mac:

1. Add 7 iOS secrets (see SECRETS_CHECKLIST.md)
2. Next push will build iOS IPA automatically
3. Download from Artifacts: **app.ipa**
4. Use Xcode or Sideloadly to install on iPhone

---

## 🎯 FULL WORKFLOW (What Happens Automatically)

```
You push to GitHub
    ↓
GitHub Actions triggers
    ↓
Build Android APK (15 min)
+ Build iOS IPA (20 min) [if secrets added]
    ↓
Both ready for download in Artifacts
    ↓
Auto-deploy to Sideloadly [if Sideloadly secrets added]
    ↓
App installed on your device!
```

---

## 🆘 TROUBLESHOOTING

### APK Build Failed?
- Check if ANDROID_KEYSTORE_BASE64 is correct
- Check if passwords match
- View error: https://github.com/RizqonSagena/tongkrongan-app/actions (click workflow → Logs)

### Can't find Artifacts?
- Scroll down in workflow run page
- Artifacts only appear after build succeeds
- If not there, build may have failed (check logs)

### Want to download APK without GitHub?
- Android: in repo folder: `flutter build apk --release`
- iOS: in repo folder: `flutter build ios --release` (Mac only)

---

## ✨ WHAT YOU GET

✅ Automatic APK every push to main
✅ Download from GitHub Artifacts
✅ Ready to install on Android phone
✅ (Optional) Automatic IPA for iPhone
✅ (Optional) Auto-install via Sideloadly

---

## 📚 REFERENCE

- Full Guide: CICD_COMPLETE_GUIDE.md
- Secrets Details: GITHUB_SECRETS_SETUP.md
- Sideloadly Info: SIDELOADLY_INTEGRATION.md

---

**Status:** Ready to Setup & Build  
**Date:** September 16, 2026  
**Version:** 1.0

