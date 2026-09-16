# ✅ GitHub Secrets Checklist - 13 Secrets to Add

**URL:** https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

**Total:** 13 secrets  
**Time:** ~10-15 minutes  
**Status:** Ready to add

---

## 📋 ANDROID SECRETS (4/13)

### ☐ #1: ANDROID_KEYSTORE_BASE64
```
Name: ANDROID_KEYSTORE_BASE64
Value: [base64 encoded keystore.jks file]

Get it:
  If you have upload-keystore.jks:
    cd tongkrongan_app/android/app
    (right-click upload-keystore.jks → Open with → Base64 encoder)
    OR on PowerShell:
    $data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
    [Convert]::ToBase64String($data) | Set-Clipboard
```

### ☐ #2: ANDROID_KEYSTORE_PASSWORD
```
Name: ANDROID_KEYSTORE_PASSWORD
Value: [Your keystore password]

Example: MyKeystorePassword123
```

### ☐ #3: ANDROID_KEY_PASSWORD
```
Name: ANDROID_KEY_PASSWORD
Value: [Your key password]

Example: MyKeyPassword456
```

### ☐ #4: ANDROID_KEY_ALIAS
```
Name: ANDROID_KEY_ALIAS
Value: tongkrongan
```

---

## 🍎 iOS SECRETS (7/13)

### ☐ #5: IOS_CERTIFICATE_BASE64
```
Name: IOS_CERTIFICATE_BASE64
Value: [base64 encoded .p12 certificate file]

Get it (on Mac):
  base64 -i /path/to/certificate.p12 | pbcopy

Get it (on Windows):
  $cert = [System.IO.File]::ReadAllBytes("certificate.p12")
  [Convert]::ToBase64String($cert) | Set-Clipboard
```

### ☐ #6: IOS_CERTIFICATE_PASSWORD
```
Name: IOS_CERTIFICATE_PASSWORD
Value: [Password used when exporting .p12]

Example: CertPassword789
```

### ☐ #7: IOS_PROVISIONING_PROFILE_BASE64
```
Name: IOS_PROVISIONING_PROFILE_BASE64
Value: [base64 encoded .mobileprovision file]

Get it (on Mac):
  base64 -i /path/to/profile.mobileprovision | pbcopy

Get it (on Windows):
  $profile = [System.IO.File]::ReadAllBytes("profile.mobileprovision")
  [Convert]::ToBase64String($profile) | Set-Clipboard
```

### ☐ #8: KEYCHAIN_PASSWORD
```
Name: KEYCHAIN_PASSWORD
Value: SecureKeychain123!

(Any secure password - used temporarily during build)
```

### ☐ #9: TESTFLIGHT_USERNAME
```
Name: TESTFLIGHT_USERNAME
Value: your-email@apple.com

(Your Apple ID email address)
```

### ☐ #10: TESTFLIGHT_PASSWORD
```
Name: TESTFLIGHT_PASSWORD
Value: [App-specific password]

Get it:
  1. Go to https://appleid.apple.com
  2. Click Security tab
  3. App-Specific Passwords section
  4. Click "Generate password"
  5. Select "Other" and enter "GitHub Actions"
  6. Generate and copy password
```

### ☐ #11: TESTFLIGHT_APP_ID
```
Name: TESTFLIGHT_APP_ID
Value: com.stitch.tongkrongan
```

---

## 🚀 SIDELOADLY SECRETS (2/13)

### ☐ #12: SIDELOADLY_API_KEY
```
Name: SIDELOADLY_API_KEY
Value: [Your Sideloadly API key]

Get it:
  1. Go to https://sideloadly.io
  2. Login to your account
  3. Settings → API Keys
  4. Click "Generate New Key"
  5. Copy and save the key
```

### ☐ #13: SIDELOADLY_DEVICE_ID
```
Name: SIDELOADLY_DEVICE_ID
Value: [Your device ID]

Get it:
  1. Connect your device (iPhone or Android) via USB
  2. Open Sideloadly
  3. Your device should appear in list
  4. Right-click → Copy Device ID
  
  OR:
  1. In Sideloadly Settings → Devices
  2. Find your device
  3. Copy the ID shown
```

---

## 🎯 STEP-BY-STEP TO ADD EACH SECRET

**For each of the 13 secrets above:**

1. Go to: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

2. Click green **[New repository secret]** button (top right)

3. Fill in:
   - **Name:** Exactly as shown above (case-sensitive)
   - **Value:** Copy-paste the value

4. Click **[Add secret]**

5. Repeat for next secret

---

## ✅ VERIFICATION

After adding all 13 secrets, verify by visiting:
https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

You should see:
```
Repository secrets (13)

✓ ANDROID_KEY_ALIAS
✓ ANDROID_KEY_PASSWORD
✓ ANDROID_KEYSTORE_BASE64
✓ ANDROID_KEYSTORE_PASSWORD
✓ IOS_CERTIFICATE_BASE64
✓ IOS_CERTIFICATE_PASSWORD
✓ IOS_PROVISIONING_PROFILE_BASE64
✓ KEYCHAIN_PASSWORD
✓ SIDELOADLY_API_KEY
✓ SIDELOADLY_DEVICE_ID
✓ TESTFLIGHT_APP_ID
✓ TESTFLIGHT_PASSWORD
✓ TESTFLIGHT_USERNAME
```

---

## 🚀 TEST AFTER ADDING SECRETS

Once all 13 secrets are added, test the CI/CD:

```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Make small change
Add-Content README.md "`n# Test CI/CD"

# Commit and push
git add .
git commit -m "Test CI/CD automation"
git push origin main
```

**Monitor at:** https://github.com/RizqonSagena/tongkrongan-app/actions

**Expected:**
- ✅ Build Android APK workflow starts (~15 min)
- ✅ Build iOS IPA workflow starts (~20 min)
- ✅ Deploy to Sideloadly workflow starts (~5 min)
- ✅ All complete (~40 min total)
- ✅ App installed on device!

---

## 📝 NOTES

### For Android secrets:
- If you don't have `upload-keystore.jks`, generate one:
  ```powershell
  cd tongkrongan_app/android/app
  keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias tongkrongan -storepass PASSWORD1 -keypass PASSWORD2
  ```

### For iOS secrets:
- You need Apple Developer Account
- See GITHUB_SECRETS_SETUP.md for detailed iOS certificate guide

### For Sideloadly secrets:
- Optional but recommended for automatic device installation
- Without it, you'll get APK/IPA but no auto-install

---

## 🆘 HELP

- See **ADD_GITHUB_SECRETS_GUIDE.md** for detailed instructions
- See **GITHUB_SECRETS_SETUP.md** for generating credentials
- Check GitHub Actions logs for errors: https://github.com/RizqonSagena/tongkrongan-app/actions

---

**Status:** Ready to Add Secrets  
**Date:** September 16, 2026  
**Version:** 1.0

Print this page or bookmark for reference while adding secrets!

