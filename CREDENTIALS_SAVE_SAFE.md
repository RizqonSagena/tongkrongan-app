# 🔐 CREDENTIALS - SAVE THIS SAFELY!

**⚠️ IMPORTANT: Keep this file secure and never share!**

---

## 🤖 ANDROID CREDENTIALS

### Keystore Information
```
File Location: tongkrongan_app/android/app/upload-keystore.jks
Alias: tongkrongan
Validity: 10000 days
```

### Passwords (SAVE THESE!)
```
ANDROID_KEYSTORE_PASSWORD: [YOUR KEYSTORE PASSWORD]
ANDROID_KEY_PASSWORD: [YOUR KEY PASSWORD]
ANDROID_KEY_ALIAS: tongkrongan
```

**Where to use:**
- GitHub Secret: ANDROID_KEYSTORE_PASSWORD
- GitHub Secret: ANDROID_KEY_PASSWORD
- GitHub Secret: ANDROID_KEY_ALIAS

---

## 🍎 iOS CREDENTIALS

### Certificate Information
```
Certificate File: [YOUR .p12 FILE]
Location: [SAVE LOCATION]
Type: iOS Distribution Certificate
```

### Passwords (SAVE THESE!)
```
IOS_CERTIFICATE_PASSWORD: [YOUR CERTIFICATE PASSWORD]
IOS_PROVISIONING_PROFILE: [YOUR .mobileprovision FILE]
```

**Where to use:**
- GitHub Secret: IOS_CERTIFICATE_BASE64
- GitHub Secret: IOS_CERTIFICATE_PASSWORD
- GitHub Secret: IOS_PROVISIONING_PROFILE_BASE64

### Apple ID Credentials
```
TESTFLIGHT_USERNAME: [YOUR APPLE ID EMAIL]
TESTFLIGHT_PASSWORD: [APP-SPECIFIC PASSWORD from Apple ID]
TESTFLIGHT_APP_ID: com.stitch.tongkrongan
```

**Where to use:**
- GitHub Secret: TESTFLIGHT_USERNAME
- GitHub Secret: TESTFLIGHT_PASSWORD
- GitHub Secret: TESTFLIGHT_APP_ID

---

## 🚀 SIDELOADLY CREDENTIALS

### API Key
```
SIDELOADLY_API_KEY: [YOUR API KEY]
```

### Device Information
```
SIDELOADLY_DEVICE_ID: [YOUR DEVICE ID]
Device Type: [iPhone / Android]
Device Name: [YOUR DEVICE NAME]
```

---

## 💾 HOW TO SAVE SAFELY

### Option 1: Local File (Most Secure)
1. Save this file with your passwords filled in
2. **DO NOT commit to GitHub**
3. Store in secure location on your computer
4. Add to `.gitignore`:
   ```
   CREDENTIALS_SAVE_SAFE.md
   ```

### Option 2: Password Manager
- Use 1Password, LastPass, Bitwarden, or KeePass
- Store all 13 secrets securely
- Generate backup codes

### Option 3: Encrypted Drive
- Use BitLocker (Windows), FileVault (Mac)
- Store encrypted file on separate drive

---

## 🔑 ALL 13 SECRETS REFERENCE

Fill in your actual values below:

```
ANDROID_KEYSTORE_BASE64: [base64 of .jks file]
ANDROID_KEYSTORE_PASSWORD: ___________________
ANDROID_KEY_PASSWORD: ___________________
ANDROID_KEY_ALIAS: tongkrongan

IOS_CERTIFICATE_BASE64: [base64 of .p12 file]
IOS_CERTIFICATE_PASSWORD: ___________________
IOS_PROVISIONING_PROFILE_BASE64: [base64 of .mobileprovision file]
KEYCHAIN_PASSWORD: SecureKeychain123!
TESTFLIGHT_USERNAME: ___________________
TESTFLIGHT_PASSWORD: ___________________
TESTFLIGHT_APP_ID: com.stitch.tongkrongan

SIDELOADLY_API_KEY: ___________________
SIDELOADLY_DEVICE_ID: ___________________
```

---

## ⚠️ SECURITY TIPS

1. **Never share passwords** - Not even with team members
2. **Rotate credentials** - Change passwords every 6 months
3. **Backup safely** - Keep encrypted backup
4. **Monitor access** - Check GitHub for unauthorized actions
5. **Use strong passwords** - Mix uppercase, lowercase, numbers, symbols

---

## 🔄 GENERATING BASE64 VALUES

### For Android Keystore:

**Windows PowerShell:**
```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app"

$data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
$base64 = [Convert]::ToBase64String($data)
$base64 | Set-Clipboard

# Now paste from clipboard to GitHub secret
```

### For iOS Certificate & Profile:

**On Mac:**
```bash
# Certificate
base64 -i certificate.p12 | pbcopy

# Provisioning Profile
base64 -i profile.mobileprovision | pbcopy
```

**On Windows (if you have the files):**
```powershell
$cert = [System.IO.File]::ReadAllBytes("certificate.p12")
[Convert]::ToBase64String($cert) | Set-Clipboard
```

---

## 📝 NEXT STEPS

1. Generate/Gather all credentials
2. Fill in the values above
3. Save this file securely (NOT in GitHub)
4. Use values to add GitHub secrets
5. Delete this file after secrets are added to GitHub

---

**Status:** Credentials Template Ready  
**Date:** September 16, 2026  
**Version:** 1.0

⚠️ **DO NOT COMMIT THIS FILE TO GITHUB!**

