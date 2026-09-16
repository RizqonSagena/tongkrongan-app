# 🔐 GitHub Secrets Setup - Android & iOS Signing

**Purpose:** Configure credentials untuk GitHub Actions workflows  
**Date:** September 16, 2026  
**Platform:** GitHub Actions (Ubuntu + macOS)

---

## 📋 Secrets Yang Dibutuhkan

### Android Secrets (3 required)
```
ANDROID_KEYSTORE_BASE64          - Base64 encoded keystore file
ANDROID_KEYSTORE_PASSWORD        - Keystore password
ANDROID_KEY_PASSWORD             - Key password
ANDROID_KEY_ALIAS                - Key alias name
```

### iOS Secrets (5 required)
```
IOS_CERTIFICATE_BASE64           - Base64 encoded .p12 certificate
IOS_CERTIFICATE_PASSWORD         - Certificate password
IOS_PROVISIONING_PROFILE_BASE64  - Base64 encoded .mobileprovision
KEYCHAIN_PASSWORD                - Temporary keychain password
TESTFLIGHT_USERNAME              - Apple ID email
TESTFLIGHT_PASSWORD              - App-specific password
TESTFLIGHT_APP_ID                - App ID in App Store Connect
```

### Sideloadly Secrets (Optional)
```
SIDELOADLY_API_KEY               - Sideloadly API key
SIDELOADLY_DEVICE_ID             - Your device ID
```

---

# 🤖 ANDROID SETUP

## Step 1: Generate Android Keystore

### 1.1: Create Signing Key
```powershell
# Windows PowerShell
cd tongkrongan_app

# Create keystore (valid for 10000 days)
keytool -genkey -v -keystore upload-keystore.jks `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias tongkrongan `
  -storepass your_keystore_password `
  -keypass your_key_password `
  -dname "CN=Tongkrongan,O=Stitch,L=Jakarta,ST=Indonesia,C=ID"

# Verify keystore created
ls -la upload-keystore.jks
```

**Keep these safe:**
- Keystore file: `upload-keystore.jks`
- Keystore password: `your_keystore_password`
- Key password: `your_key_password`
- Key alias: `tongkrongan`

### 1.2: Encode Keystore to Base64
```powershell
# Convert to Base64 (Windows PowerShell)
$keystore = Get-Content -Path "upload-keystore.jks" -Encoding Byte
$base64 = [Convert]::ToBase64String($keystore)
$base64 | Set-Content -Path "keystore-base64.txt"

# Then copy content of keystore-base64.txt
Get-Content keystore-base64.txt | Set-Clipboard
```

## Step 2: Add Android Secrets to GitHub

Go to GitHub Repository:
```
Settings → Secrets and variables → Actions → New repository secret
```

Add these secrets one by one:

### Secret 1: ANDROID_KEYSTORE_BASE64
```
Name: ANDROID_KEYSTORE_BASE64
Value: [Paste base64 content from keystore-base64.txt]
```

### Secret 2: ANDROID_KEYSTORE_PASSWORD
```
Name: ANDROID_KEYSTORE_PASSWORD
Value: your_keystore_password
```

### Secret 3: ANDROID_KEY_PASSWORD
```
Name: ANDROID_KEY_PASSWORD
Value: your_key_password
```

### Secret 4: ANDROID_KEY_ALIAS
```
Name: ANDROID_KEY_ALIAS
Value: tongkrongan
```

**Status:** ✅ Android secrets ready

---

# 🍎 iOS SETUP

## Step 1: Create Code Signing Certificate & Profile

### 1.1: Request Certificate from Apple

Go to [Apple Developer Account](https://developer.apple.com):

1. **Certificates, Identifiers & Profiles → Certificates**
2. Click **"+"** to create new certificate
3. Select **"iOS App Distribution"**
4. Follow wizard to create CSR (Certificate Signing Request)
5. Download certificate as `.cer`
6. Save as: `ios_distribution.cer`

### 1.2: Export Certificate as .p12

```bash
# On Mac, in Terminal:

# 1. Find the certificate in Keychain
# Keychain Access → Certificates → iOS Distribution

# 2. Right-click → Export
# Save as: ios_distribution.p12

# Or use command line:
openssl x509 -in ios_distribution.cer -inform DER -out ios_distribution.pem
openssl pkcs12 -export -out ios_distribution.p12 -in ios_distribution.pem -inkey private_key.pem
```

### 1.3: Create Provisioning Profile

Go to [Apple Developer Account](https://developer.apple.com):

1. **Provisioning Profiles → Distribution**
2. Click **"+"** to create new profile
3. Select **"Ad Hoc"** (for testing via Sideloadly)
4. Select App ID: `com.stitch.tongkrongan`
5. Select certificate (created in 1.1)
6. Select devices (your iPhone)
7. Name it: `Tongkrongan Ad Hoc`
8. Download `.mobileprovision` file

**Files needed:**
- `ios_distribution.p12` - Certificate
- `Tongkrongan Ad Hoc.mobileprovision` - Provisioning profile

### 1.4: Encode Certificate to Base64

```bash
# On Mac, in Terminal:

# Certificate to base64
base64 -i ios_distribution.p12 > cert_base64.txt

# Provisioning profile to base64
base64 -i "Tongkrongan Ad Hoc.mobileprovision" > profile_base64.txt

# Copy content
cat cert_base64.txt
cat profile_base64.txt
```

## Step 2: Create App-Specific Password for TestFlight

1. Go to [Apple ID Account](https://appleid.apple.com)
2. **Security → App-Specific Passwords**
3. Click **"Generate password"**
4. Select **"Other (specify...)"**
5. Enter: `GitHub Actions`
6. Generate and save password
7. Use this for `TESTFLIGHT_PASSWORD`

## Step 3: Get TestFlight App ID

Go to [App Store Connect](https://appstoreconnect.apple.com):

1. **My Apps → Select Tongkrongan**
2. **App Information → Bundle ID**
3. Note the identifier (e.g., `com.stitch.tongkrongan`)

## Step 4: Add iOS Secrets to GitHub

Go to GitHub Repository:
```
Settings → Secrets and variables → Actions → New repository secret
```

### Secret 1: IOS_CERTIFICATE_BASE64
```
Name: IOS_CERTIFICATE_BASE64
Value: [Paste base64 content from cert_base64.txt]
```

### Secret 2: IOS_CERTIFICATE_PASSWORD
```
Name: IOS_CERTIFICATE_PASSWORD
Value: [Password used when exporting .p12]
```

### Secret 3: IOS_PROVISIONING_PROFILE_BASE64
```
Name: IOS_PROVISIONING_PROFILE_BASE64
Value: [Paste base64 content from profile_base64.txt]
```

### Secret 4: KEYCHAIN_PASSWORD
```
Name: KEYCHAIN_PASSWORD
Value: [Any secure password you choose, e.g., "SecureKeychain123!"]
```

### Secret 5: TESTFLIGHT_USERNAME
```
Name: TESTFLIGHT_USERNAME
Value: your_apple_id@email.com
```

### Secret 6: TESTFLIGHT_PASSWORD
```
Name: TESTFLIGHT_PASSWORD
Value: [App-specific password from Step 2]
```

### Secret 7: TESTFLIGHT_APP_ID
```
Name: TESTFLIGHT_APP_ID
Value: com.stitch.tongkrongan
```

**Status:** ✅ iOS secrets ready

---

# 📱 SIDELOADLY SETUP (Optional)

## Step 1: Get Sideloadly API Key

1. Go to [Sideloadly.io](https://sideloadly.io)
2. Login to your account
3. Go to **Settings → API Keys**
4. Generate new API key
5. Copy and save

## Step 2: Find Your Device ID

```bash
# On Mac/Linux with Sideloadly installed:
sideloadly --list-devices

# Or connect via USB and note device ID shown in Sideloadly
```

## Step 3: Add Sideloadly Secrets

### Secret 1: SIDELOADLY_API_KEY
```
Name: SIDELOADLY_API_KEY
Value: [Your Sideloadly API key]
```

### Secret 2: SIDELOADLY_DEVICE_ID
```
Name: SIDELOADLY_DEVICE_ID
Value: [Your device ID from Step 2]
```

**Status:** ✅ Sideloadly secrets ready (optional)

---

# ✅ VERIFY ALL SECRETS

Go to GitHub Repository:
```
Settings → Secrets and variables → Actions
```

You should see:

**Android (4 secrets):**
- [ ] ANDROID_KEYSTORE_BASE64
- [ ] ANDROID_KEYSTORE_PASSWORD
- [ ] ANDROID_KEY_PASSWORD
- [ ] ANDROID_KEY_ALIAS

**iOS (7 secrets):**
- [ ] IOS_CERTIFICATE_BASE64
- [ ] IOS_CERTIFICATE_PASSWORD
- [ ] IOS_PROVISIONING_PROFILE_BASE64
- [ ] KEYCHAIN_PASSWORD
- [ ] TESTFLIGHT_USERNAME
- [ ] TESTFLIGHT_PASSWORD
- [ ] TESTFLIGHT_APP_ID

**Sideloadly (2 secrets - optional):**
- [ ] SIDELOADLY_API_KEY
- [ ] SIDELOADLY_DEVICE_ID

---

# 🚀 TEST WORKFLOW

## Step 1: Trigger Build

Push to main branch:
```bash
git add .
git commit -m "Trigger CI/CD builds"
git push origin main
```

## Step 2: Monitor Build

Go to GitHub Repository:
```
Actions → [Latest workflow]
```

Watch the workflow run:
- Android build (Ubuntu, ~15 min)
- iOS build (macOS, ~20 min)

## Step 3: Download Artifacts

After build completes:
```
Actions → [Workflow] → Artifacts

Download:
- app-release-YYYYMMDD_HHMMSS.apk
- Tongkrongan-YYYYMMDD_HHMMSS.ipa
```

## Step 4: Install with Sideloadly

1. Open Sideloadly
2. Drag & drop APK or IPA
3. Select device
4. Click "Install"

---

# 🔒 SECURITY BEST PRACTICES

1. **Never commit secrets** - Use GitHub Secrets, not in code
2. **Rotate passwords** - Change every 6 months
3. **Limited access** - Only necessary people can access repo
4. **Audit logs** - GitHub logs all secret access
5. **Base64 encode** - Files should be base64 encoded before storing
6. **Secure repository** - Make repo private if sensitive

---

# 📝 TROUBLESHOOTING

### Android Build Fails: "Keystore not found"
```
Solution:
1. Check ANDROID_KEYSTORE_BASE64 is properly encoded
2. Verify file decodes to valid .jks file
3. Test locally first:
   flutter build apk --release
```

### iOS Build Fails: "Certificate not trusted"
```
Solution:
1. Re-export certificate from Keychain
2. Verify password in IOS_CERTIFICATE_PASSWORD
3. Ensure certificate is valid (not expired)
```

### iOS Build Fails: "Provisioning profile doesn't include..."
```
Solution:
1. Check App ID in provisioning profile matches bundle ID
2. Add all devices to profile
3. Regenerate provisioning profile
```

### Sideloadly Upload Fails
```
Solution:
1. Verify API key is valid
2. Check device ID is correct
3. Ensure device is connected and trusted
4. Check Sideloadly API rate limits
```

---

# 🎯 NEXT STEPS

1. ✅ Generate Android keystore
2. ✅ Create iOS certificates & profiles
3. ✅ Add all secrets to GitHub
4. ✅ Trigger test workflow
5. ✅ Download and test APK/IPA
6. ✅ Setup Sideloadly auto-install (optional)

---

**Secrets Setup Status:** ✅ READY  
**Last Updated:** September 16, 2026  
**Version:** 1.0

