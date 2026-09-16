# 🔐 How to Add 13 GitHub Secrets - Step by Step

**URL:** https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

**Time:** ~10 minutes

---

## 📋 Quick Overview

You need to add 13 secrets total:
- Android: 4 secrets
- iOS: 7 secrets  
- Sideloadly: 2 secrets

---

## 🔑 ANDROID SECRETS (4)

### Secret 1: ANDROID_KEYSTORE_BASE64

**Step 1:** Go to https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

**Step 2:** Click **"New repository secret"** button (green button, top right)

**Step 3:** Fill in:
```
Name: ANDROID_KEYSTORE_BASE64

Value: [See below for value]
```

**WHERE TO GET VALUE:**

You need the Android keystore file (`.jks`). 

**Option A: If you already have upload-keystore.jks**
```powershell
# Windows PowerShell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app"

# Convert to base64
$keystore = Get-Content -Path "upload-keystore.jks" -Encoding Byte
$base64 = [Convert]::ToBase64String($keystore)
$base64 | Set-Clipboard

# Now paste from clipboard to GitHub secret
```

**Option B: Generate new keystore**
```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app"

# Generate new keystore
keytool -genkey -v -keystore android/app/upload-keystore.jks `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias tongkrongan `
  -storepass MyKeystorePassword123 `
  -keypass MyKeyPassword456 `
  -dname "CN=Tongkrongan,O=Stitch,L=Jakarta,ST=Indonesia,C=ID"

# Then convert to base64 (from Option A above)
```

**Step 4:** Paste base64 value into GitHub secret Value field

**Step 5:** Click **"Add secret"** button

---

### Secret 2: ANDROID_KEYSTORE_PASSWORD

**Step 1:** Click **"New repository secret"** again

**Step 2:** Fill in:
```
Name: ANDROID_KEYSTORE_PASSWORD

Value: MyKeystorePassword123
```

(Use the same password from `keytool` command above, or your existing keystore password)

**Step 3:** Click **"Add secret"**

---

### Secret 3: ANDROID_KEY_PASSWORD

**Step 1:** Click **"New repository secret"**

**Step 2:** Fill in:
```
Name: ANDROID_KEY_PASSWORD

Value: MyKeyPassword456
```

(Use the same key password from `keytool` command)

**Step 3:** Click **"Add secret"**

---

### Secret 4: ANDROID_KEY_ALIAS

**Step 1:** Click **"New repository secret"**

**Step 2:** Fill in:
```
Name: ANDROID_KEY_ALIAS

Value: tongkrongan
```

**Step 3:** Click **"Add secret"**

---

## 🍎 iOS SECRETS (7)

### Secret 5: IOS_CERTIFICATE_BASE64

**Prerequisites:** You need:
1. Apple Developer Account (https://developer.apple.com)
2. Certificate in `.p12` format

**Step 1:** Click **"New repository secret"**

**Step 2:** Get certificate value:

**On Mac Terminal:**
```bash
# Convert .p12 to base64
base64 -i /path/to/certificate.p12 > cert_base64.txt

# Copy content
cat cert_base64.txt
```

**On Windows (if you have .p12 file):**
```powershell
$cert = Get-Content -Path "path\to\certificate.p12" -Encoding Byte
$base64 = [Convert]::ToBase64String($cert)
$base64 | Set-Clipboard
```

**Step 3:** Fill in GitHub secret:
```
Name: IOS_CERTIFICATE_BASE64

Value: [Paste base64 certificate here]
```

**Step 4:** Click **"Add secret"**

---

### Secret 6: IOS_CERTIFICATE_PASSWORD

**Step 1:** Click **"New repository secret"**

**Step 2:** Fill in:
```
Name: IOS_CERTIFICATE_PASSWORD

Value: [Password used when exporting .p12]
```

**Step 3:** Click **"Add secret"**

---

### Secret 7: IOS_PROVISIONING_PROFILE_BASE64

**Prerequisites:** Provisioning profile (`.mobileprovision` file)

**Step 1:** Click **"New repository secret"**

**Step 2:** Get provisioning profile value:

**On Mac:**
```bash
base64 -i /path/to/profile.mobileprovision > profile_base64.txt
cat profile_base64.txt
```

**On Windows:**
```powershell
$profile = Get-Content -Path "path\to\profile.mobileprovision" -Encoding Byte
$base64 = [Convert]::ToBase64String($profile)
$base64 | Set-Clipboard
```

**Step 3:** Fill in GitHub secret:
```
Name: IOS_PROVISIONING_PROFILE_BASE64

Value: [Paste base64 profile here]
```

**Step 4:** Click **"Add secret"**

---

### Secret 8: KEYCHAIN_PASSWORD

**Step 1:** Click **"New repository secret"**

**Step 2:** Fill in:
```
Name: KEYCHAIN_PASSWORD

Value: SecureKeychain123!
```

(Can be any secure password you choose - used only during build)

**Step 3:** Click **"Add secret"**

---

### Secret 9: TESTFLIGHT_USERNAME

**Step 1:** Click **"New repository secret"**

**Step 2:** Fill in:
```
Name: TESTFLIGHT_USERNAME

Value: your-apple-id@email.com
```

(Your Apple ID email address)

**Step 3:** Click **"Add secret"**

---

### Secret 10: TESTFLIGHT_PASSWORD

**Step 1:** Click **"New repository secret"**

**Step 2:** Get app-specific password:
- Go to https://appleid.apple.com
- Security → App-Specific Passwords
- Generate password, copy it

**Step 3:** Fill in GitHub secret:
```
Name: TESTFLIGHT_PASSWORD

Value: [App-specific password from Apple ID]
```

**Step 4:** Click **"Add secret"**

---

### Secret 11: TESTFLIGHT_APP_ID

**Step 1:** Click **"New repository secret"**

**Step 2:** Fill in:
```
Name: TESTFLIGHT_APP_ID

Value: com.stitch.tongkrongan
```

**Step 3:** Click **"Add secret"**

---

## 🚀 SIDELOADLY SECRETS (2)

### Secret 12: SIDELOADLY_API_KEY

**Prerequisites:** 
1. Sideloadly account at https://sideloadly.io
2. Generate API key

**Step 1:** Click **"New repository secret"**

**Step 2:** Get API key:
- Go to https://sideloadly.io
- Login
- Settings → API Keys
- Click "Generate New Key"
- Copy the key

**Step 3:** Fill in GitHub secret:
```
Name: SIDELOADLY_API_KEY

Value: [Your Sideloadly API key]
```

**Step 4:** Click **"Add secret"**

---

### Secret 13: SIDELOADLY_DEVICE_ID

**Step 1:** Click **"New repository secret"**

**Step 2:** Get device ID:
- Connect your device (iPhone or Android) to computer
- Open Sideloadly
- Your device should appear in list
- Right-click device → Copy ID

Or in Sideloadly Settings → Devices, find your device ID

**Step 3:** Fill in GitHub secret:
```
Name: SIDELOADLY_DEVICE_ID

Value: [Your device ID]
```

**Step 4:** Click **"Add secret"**

---

## ✅ VERIFICATION CHECKLIST

After adding all 13 secrets, verify:

Go to https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

You should see all 13 secrets listed:

**Android (4):**
- [ ] ANDROID_KEY_ALIAS
- [ ] ANDROID_KEY_PASSWORD
- [ ] ANDROID_KEYSTORE_BASE64
- [ ] ANDROID_KEYSTORE_PASSWORD

**iOS (7):**
- [ ] IOS_CERTIFICATE_BASE64
- [ ] IOS_CERTIFICATE_PASSWORD
- [ ] IOS_PROVISIONING_PROFILE_BASE64
- [ ] KEYCHAIN_PASSWORD
- [ ] TESTFLIGHT_APP_ID
- [ ] TESTFLIGHT_PASSWORD
- [ ] TESTFLIGHT_USERNAME

**Sideloadly (2):**
- [ ] SIDELOADLY_API_KEY
- [ ] SIDELOADLY_DEVICE_ID

---

## 🚀 AFTER ADDING SECRETS

### Test the workflows:

```powershell
# Make small change to trigger build
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Edit any file (example: add comment to README)
Add-Content README.md "`n# Test CI/CD"

# Commit and push
git add .
git commit -m "Test CI/CD workflows"
git push origin main
```

### Monitor workflows:

Go to: https://github.com/RizqonSagena/tongkrongan-app/actions

You should see:
- ✅ Build Android APK (starts, ~15 min)
- ✅ Build iOS IPA (starts, ~20 min)
- ✅ Deploy to Sideloadly (starts after builds, ~5 min)

---

## 📝 SECRETS REFERENCE TABLE

| # | Name | Value Type | Example |
|---|------|-----------|---------|
| 1 | ANDROID_KEYSTORE_BASE64 | base64 file | [long base64 string] |
| 2 | ANDROID_KEYSTORE_PASSWORD | password | MyKeystorePassword123 |
| 3 | ANDROID_KEY_PASSWORD | password | MyKeyPassword456 |
| 4 | ANDROID_KEY_ALIAS | text | tongkrongan |
| 5 | IOS_CERTIFICATE_BASE64 | base64 file | [long base64 string] |
| 6 | IOS_CERTIFICATE_PASSWORD | password | CertPassword789 |
| 7 | IOS_PROVISIONING_PROFILE_BASE64 | base64 file | [long base64 string] |
| 8 | KEYCHAIN_PASSWORD | password | SecureKeychain123! |
| 9 | TESTFLIGHT_USERNAME | email | user@apple.com |
| 10 | TESTFLIGHT_PASSWORD | app-specific pwd | [Apple app password] |
| 11 | TESTFLIGHT_APP_ID | bundle ID | com.stitch.tongkrongan |
| 12 | SIDELOADLY_API_KEY | API key | [Sideloadly API key] |
| 13 | SIDELOADLY_DEVICE_ID | device ID | device-uuid-here |

---

## 🆘 TROUBLESHOOTING

### Secret shows asterisks after adding
✅ **Normal** - GitHub masks secrets for security

### Can't find "New repository secret" button
1. Make sure you're logged in
2. Go to correct repo: https://github.com/RizqonSagena/tongkrongan-app
3. Click Settings tab
4. Click "Secrets and variables" → "Actions"
5. Look for green "New repository secret" button

### Base64 conversion not working
**Windows:**
```powershell
# Try this simpler command:
certutil -encode "path\to\file" "output.txt"
# Then copy content of output.txt
```

### Don't have iOS certificates yet?
You need:
1. Apple Developer Account ($99/year)
2. Create certificate & provisioning profile
3. See GITHUB_SECRETS_SETUP.md for detailed guide

---

## ✨ YOU'RE ALL SET!

After adding all 13 secrets:
1. ✅ Workflows will auto-run on next push
2. ✅ APK built in ~15 minutes
3. ✅ IPA built in ~20 minutes
4. ✅ Auto-installed via Sideloadly in ~5 minutes

**Total time:** ~40 minutes from push to device installation! 🎉

---

**Status:** Ready for Secrets Setup  
**Date:** September 16, 2026  
**Version:** 1.0

