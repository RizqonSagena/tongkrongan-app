# 🍎 iOS IPA Build via GitHub Actions - Complete Setup

**Goal:** Build iOS IPA automatically and install on iPhone using Sideloadly

**Status:** Ready to setup (requires Mac or remote Mac access)

---

## ⚠️ IMPORTANT: iOS Build Requirements

iOS builds on GitHub Actions use **macOS runners** which are available, BUT you need:

1. **Apple Developer Account** ($99/year) - for signing certificates
2. **iOS Distribution Certificate** (.p12 file)
3. **Provisioning Profile** (.mobileprovision file)
4. **Mac (or remote access)** - to generate certificates

---

## 📋 iOS WORKFLOW (How It Works)

```
You push code
    ↓
GitHub Actions (macOS runner) triggers
    ↓
Build iOS IPA:
  1. Checkout code
  2. Setup iOS certificates from secrets
  3. Run: flutter build ipa --release
  4. Sign IPA with certificate
  5. Upload to Artifacts
    ↓
~20 minutes later...
    ↓
IPA ready for download
    ↓
Install on iPhone via Sideloadly
```

---

## 🔐 STEP 1: GET iOS CERTIFICATES (On Mac)

You need to do this on a **Mac computer** (or macOS VM).

### On Mac Terminal:

**Step 1: Create Certificate Signing Request (CSR)**

```bash
# Open Keychain Access
open /Applications/Utilities/Keychain\ Access.app

# In menu: Keychain Access → Certificate Assistant → Request a Certificate from a Certificate Authority
# Email: your-email@apple.com
# Common Name: Tongkrongan Production
# Save to: ~/Desktop/CertificateSigningRequest.certSigningRequest
```

**Step 2: Create Certificate in Apple Developer Portal**

1. Go to: https://developer.apple.com/account
2. Login with Apple ID
3. Go to: Certificates, Identifiers & Profiles → Certificates
4. Click "+" to create new
5. Select: "iOS Distribution"
6. Upload: CertificateSigningRequest.certSigningRequest
7. Download certificate → save as `ios_distribution.cer`

**Step 3: Export as .p12 File**

```bash
# In Keychain Access:
# 1. Right-click downloaded certificate
# 2. Select "Export"
# 3. Format: Personal Information Exchange (.p12)
# 4. Password: [Create strong password]
# 5. Save as: ~/Desktop/certificates.p12

# Or via terminal:
openssl x509 -inform DER -outform PEM -in ios_distribution.cer -out ios_distribution.pem
```

**Step 4: Create Provisioning Profile**

```bash
# Go to: https://developer.apple.com/account
# Profiles → Create New Profile
# Type: App Store
# App ID: com.stitch.tongkrongan
# Certificate: [Select your new certificate]
# Download profile: save as `Tongkrongan.mobileprovision`
```

**Result:**
- `certificates.p12` (iOS Distribution Certificate)
- `Tongkrongan.mobileprovision` (Provisioning Profile)

---

## 🔄 STEP 2: CONVERT iOS FILES TO BASE64

**On Mac Terminal:**

```bash
# Convert certificate
base64 -i ~/Desktop/certificates.p12 > ~/Desktop/cert-base64.txt
cat ~/Desktop/cert-base64.txt

# Convert provisioning profile
base64 -i ~/Desktop/Tongkrongan.mobileprovision > ~/Desktop/profile-base64.txt
cat ~/Desktop/profile-base64.txt
```

**On Windows (if you have the .p12 file):**

```powershell
# Convert certificate
$cert = [System.IO.File]::ReadAllBytes("C:\path\to\certificates.p12")
[Convert]::ToBase64String($cert) | Set-Clipboard

# Save to file
$cert = [System.IO.File]::ReadAllBytes("C:\path\to\certificates.p12")
[Convert]::ToBase64String($cert) | Out-File "cert-base64.txt"
```

---

## 📝 STEP 3: PREPARE 11 GitHub SECRETS (7 iOS + 4 Android)

### ANDROID SECRETS (Already have these!) - 4 Total

```
1. ANDROID_KEYSTORE_BASE64 = [from keystore-base64.txt]
2. ANDROID_KEYSTORE_PASSWORD = Tongkrongan@2024_637729
3. ANDROID_KEY_PASSWORD = Key@2024_236320
4. ANDROID_KEY_ALIAS = tongkrongan
```

### iOS SECRETS (New!) - 7 Total

```
5. IOS_CERTIFICATE_BASE64
   Value: [from cert-base64.txt]

6. IOS_CERTIFICATE_PASSWORD
   Value: [Password used when exporting .p12]
   Example: CertPassword123

7. IOS_PROVISIONING_PROFILE_BASE64
   Value: [from profile-base64.txt]

8. KEYCHAIN_PASSWORD
   Value: KeychainPass123!
   (Any secure password for build keychain)

9. TESTFLIGHT_USERNAME
   Value: your-email@apple.com
   (Your Apple ID)

10. TESTFLIGHT_PASSWORD
    Value: [App-specific password from Apple ID]
    
    How to get:
    Go to: https://appleid.apple.com
    → Security → App-Specific Passwords
    → Generate new password
    → Copy it

11. TESTFLIGHT_APP_ID
    Value: com.stitch.tongkrongan
```

---

## ✅ STEP 4: ADD ALL 11 SECRETS TO GITHUB

**Go to:** https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

**Add 11 secrets total:**

### Android (4) - If not added yet:
```
□ ANDROID_KEYSTORE_BASE64
□ ANDROID_KEYSTORE_PASSWORD
□ ANDROID_KEY_PASSWORD
□ ANDROID_KEY_ALIAS
```

### iOS (7) - New:
```
□ IOS_CERTIFICATE_BASE64 .......... [from cert-base64.txt]
□ IOS_CERTIFICATE_PASSWORD ....... [Your .p12 password]
□ IOS_PROVISIONING_PROFILE_BASE64  [from profile-base64.txt]
□ KEYCHAIN_PASSWORD .............. KeychainPass123!
□ TESTFLIGHT_USERNAME ............ your-email@apple.com
□ TESTFLIGHT_PASSWORD ............ [App-specific password]
□ TESTFLIGHT_APP_ID .............. com.stitch.tongkrongan
```

---

## 🚀 STEP 5: TRIGGER BUILD

Push code to GitHub:

```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Make change
Add-Content README.md "`n# Build APK and IPA"

# Commit and push
git add .
git commit -m "Trigger APK and IPA builds"
git push origin main
```

---

## 📊 STEP 6: MONITOR BUILDS

**Go to:** https://github.com/RizqonSagena/tongkrongan-app/actions

You should see **2 workflows running in parallel:**

```
Workflow 1: Build Android APK
  Status: Running
  Time: ~15 minutes
  Output: app-release.apk

Workflow 2: Build iOS IPA
  Status: Running
  Time: ~20 minutes
  Output: app.ipa
```

---

## 📱 STEP 7: DOWNLOAD FILES

After both builds complete:

### Android APK:
1. Go to workflow run
2. Click "Build Android APK" 
3. Scroll to Artifacts
4. Download: `app-release.apk`
5. Transfer to Android phone
6. Install!

### iOS IPA:
1. Click "Build iOS IPA"
2. Scroll to Artifacts
3. Download: `app.ipa`
4. Use Sideloadly to install on iPhone

---

## 📲 STEP 8: INSTALL ON DEVICES

### Android Installation:

**Option A: USB Cable**
```
1. Connect Android phone to PC
2. Enable USB debugging
3. Run: adb install app-release.apk
```

**Option B: Manual Install**
```
1. Transfer app-release.apk to phone
2. Open file manager
3. Tap APK to install
4. Allow unknown sources if prompted
```

**Option C: Sideloadly**
```
1. Download Sideloadly: https://sideloadly.io
2. Connect Android phone
3. Select app-release.apk
4. Click Install
```

### iOS Installation:

**Using Sideloadly:**
```
1. Get Sideloadly: https://sideloadly.io
2. Create account
3. Connect iPhone via USB
4. Select app.ipa file
5. Enter Apple ID & password
6. Click Install
7. App installed on iPhone!
```

**Using Xcode (Mac only):**
```bash
# On Mac:
xcode-select --install
open app.ipa
# Then in Xcode: Window → Devices and Simulators
# Select device → Add app
```

---

## 🔑 COMPLETE SECRETS REFERENCE

| # | Secret Name | Type | Status |
|---|---|---|---|
| 1 | ANDROID_KEYSTORE_BASE64 | base64 | ✅ Ready |
| 2 | ANDROID_KEYSTORE_PASSWORD | password | ✅ Ready |
| 3 | ANDROID_KEY_PASSWORD | password | ✅ Ready |
| 4 | ANDROID_KEY_ALIAS | text | ✅ Ready |
| 5 | IOS_CERTIFICATE_BASE64 | base64 | ⏳ Need Mac |
| 6 | IOS_CERTIFICATE_PASSWORD | password | ⏳ Need Mac |
| 7 | IOS_PROVISIONING_PROFILE_BASE64 | base64 | ⏳ Need Mac |
| 8 | KEYCHAIN_PASSWORD | password | ⏳ Need Mac |
| 9 | TESTFLIGHT_USERNAME | email | ⏳ Need Apple |
| 10 | TESTFLIGHT_PASSWORD | password | ⏳ Need Apple |
| 11 | TESTFLIGHT_APP_ID | bundle ID | ✅ Ready |

---

## ⏱️ BUILD TIMELINE

```
Total time: ~40 minutes

t=0:00   Push code
t=0:05   Android build starts (Ubuntu)
         iOS build starts (macOS)
t=0:15   Android APK ready ✅
t=0:25   iOS IPA ready ✅
t=0:30   Both available in Artifacts
t=0:40   Install on devices!
```

---

## 🆘 TROUBLESHOOTING

### Don't have Mac?

**Option 1: Use online Mac service**
- https://macincloud.com (cloud Mac)
- Generate certificates there
- Get .p12 and .mobileprovision files

**Option 2: Skip iOS**
- Only build Android APK
- Skip iOS secrets

**Option 3: Manual on Mac later**
- Just build Android now
- Add iOS certificates when you have Mac access

### iOS Build Failed?

Check error log:
1. Go to: https://github.com/RizqonSagena/tongkrongan-app/actions
2. Click "Build iOS IPA" workflow
3. View logs for error message

Common issues:
- Certificate password wrong → Verify TESTFLIGHT_PASSWORD
- Provisioning profile expired → Generate new one
- Certificate not matching → Re-export .p12

### Certificate Already Exists Error?

You may have old certificate. Either:
1. Use existing certificate (get .p12 file from Keychain)
2. Revoke old certificate and create new one

---

## 📚 DOCUMENTS YOU NEED

1. **This file:** IOS_BUILD_SETUP_COMPLETE.md
2. **Android guide:** BUILD_APK_IPA_STEP_BY_STEP.md
3. **All secrets:** SECRETS_CHECKLIST.md
4. **Quick ref:** QUICK_BUILD_SETUP.md

---

## ✨ WORKFLOW FILES (Already Created)

### `.github/workflows/build-android.yml`
- Builds Android APK
- Runs on Ubuntu
- Signs with keystore
- Uploads to Artifacts

### `.github/workflows/build-ios.yml`
- Builds iOS IPA
- Runs on macOS
- Signs with certificate
- Uploads to Artifacts

### `.github/workflows/deploy-sideloadly.yml` (Optional)
- Auto-installs APK/IPA on device
- Requires Sideloadly API key
- Requires device ID

---

## 🎯 QUICK DECISION TREE

```
Do you have a Mac?
├─ YES → Proceed with iOS setup (this guide)
└─ NO
   ├─ Can you access Mac later? → Do iOS then
   └─ Mac access not possible? → Android only for now

Have Apple Developer Account?
├─ YES → Get certificates & profiles
└─ NO → Need to create ($99/year)

Want auto-install on device?
├─ YES → Setup Sideloadly (2 more secrets)
└─ NO → Manual download and install
```

---

## 📊 WHAT YOU GET

✅ Android APK (for Android phones)
✅ iOS IPA (for iPhones)
✅ Both built automatically on every push
✅ Downloadable from GitHub Artifacts
✅ Optional auto-install via Sideloadly

---

**Status:** Ready for iOS Setup  
**Date:** September 16, 2026  
**Version:** 1.0

Next: Get certificates on Mac → Add 7 iOS secrets → Push to build APK & IPA!

