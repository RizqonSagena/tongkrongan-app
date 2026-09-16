# 🔐 Setup 11 GitHub Secrets for APK & IPA Build

**Total Secrets:** 11 (4 Android + 7 iOS)

**URL:** https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

---

## ✅ ANDROID SECRETS (4) - YOU HAVE THESE!

### Secret #1: ANDROID_KEYSTORE_BASE64

```
Name: ANDROID_KEYSTORE_BASE64
Value: [Copy entire content from keystore-base64.txt]
```

**How to get value:**
```powershell
# Open file: keystore-base64.txt
# Select All (Ctrl+A)
# Copy (Ctrl+C)
# Paste in GitHub
```

**Value starts with:** `MIIKngIBAzCCCkgGCSqGSIb3DQEH...`

---

### Secret #2: ANDROID_KEYSTORE_PASSWORD

```
Name: ANDROID_KEYSTORE_PASSWORD
Value: Tongkrongan@2024_637729
```

---

### Secret #3: ANDROID_KEY_PASSWORD

```
Name: ANDROID_KEY_PASSWORD
Value: Key@2024_236320
```

---

### Secret #4: ANDROID_KEY_ALIAS

```
Name: ANDROID_KEY_ALIAS
Value: tongkrongan
```

---

## 🍎 iOS SECRETS (7) - NEED MAC TO GET THESE

### Secret #5: IOS_CERTIFICATE_BASE64

**You need:**
- iOS Distribution Certificate file (.p12)
- To be on Mac

**How to get:**

**On Mac Terminal:**
```bash
# Convert .p12 to base64
base64 -i ~/Desktop/certificates.p12 > ~/Desktop/cert-base64.txt

# Display it
cat ~/Desktop/cert-base64.txt

# Or copy to clipboard
base64 -i ~/Desktop/certificates.p12 | pbcopy
```

**On Windows (if you have .p12):**
```powershell
$cert = [System.IO.File]::ReadAllBytes("C:\path\to\certificates.p12")
[Convert]::ToBase64String($cert) | Set-Clipboard
```

**In GitHub:**
```
Name: IOS_CERTIFICATE_BASE64
Value: [Paste base64 from above]
```

---

### Secret #6: IOS_CERTIFICATE_PASSWORD

```
Name: IOS_CERTIFICATE_PASSWORD
Value: [Password you used when exporting .p12]

Example: CertPassword123
```

**Remember:** This is the password you entered when exporting the certificate as .p12 file in Keychain Access.

---

### Secret #7: IOS_PROVISIONING_PROFILE_BASE64

**You need:**
- Provisioning Profile file (.mobileprovision)
- To be on Mac

**How to get:**

**On Mac Terminal:**
```bash
# Convert .mobileprovision to base64
base64 -i ~/Desktop/Tongkrongan.mobileprovision > ~/Desktop/profile-base64.txt

# Display it
cat ~/Desktop/profile-base64.txt

# Or copy to clipboard
base64 -i ~/Desktop/Tongkrongan.mobileprovision | pbcopy
```

**On Windows (if you have .mobileprovision):**
```powershell
$profile = [System.IO.File]::ReadAllBytes("C:\path\to\Tongkrongan.mobileprovision")
[Convert]::ToBase64String($profile) | Set-Clipboard
```

**In GitHub:**
```
Name: IOS_PROVISIONING_PROFILE_BASE64
Value: [Paste base64 from above]
```

---

### Secret #8: KEYCHAIN_PASSWORD

```
Name: KEYCHAIN_PASSWORD
Value: KeychainPass123!
```

**What is this?** Temporary password used during build. Can be any secure password.

---

### Secret #9: TESTFLIGHT_USERNAME

```
Name: TESTFLIGHT_USERNAME
Value: your-email@apple.com
```

**What is this?** Your Apple ID email address.

---

### Secret #10: TESTFLIGHT_PASSWORD

```
Name: TESTFLIGHT_PASSWORD
Value: [App-specific password from Apple ID]
```

**How to get:**

1. Go to: https://appleid.apple.com
2. Login with Apple ID
3. Click "Security" tab
4. Find "App-Specific Passwords" section
5. Click "Generate password"
6. Select "Other" and type: "GitHub Actions"
7. Click "Generate"
8. Copy the 16-character password
9. Paste in GitHub secret

**Example password:** `abcd-efgh-ijkl-mnop`

---

### Secret #11: TESTFLIGHT_APP_ID

```
Name: TESTFLIGHT_APP_ID
Value: com.stitch.tongkrongan
```

**What is this?** Your iOS app bundle ID.

---

## 📝 STEP-BY-STEP TO ADD ALL 11 SECRETS

### Step 1: Go to GitHub Secrets

Visit: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

### Step 2: Add Android Secrets First

For each Android secret (1-4):

1. Click **[New repository secret]** (green button)
2. Enter Name exactly as shown
3. Enter Value
4. Click **[Add secret]**

Example for Secret #1:
```
Name: ANDROID_KEYSTORE_BASE64
Value: MIIKngIBAzCCCkgGCSqGSIb3DQEH... [rest of base64]
Click [Add secret]
```

Repeat for secrets #2, #3, #4.

### Step 3: Add iOS Secrets (if you have Mac access)

Get iOS certificate and profile files on Mac first.

Then add secrets #5-#11 the same way:

1. Click **[New repository secret]**
2. Enter Name
3. Enter Value
4. Click **[Add secret]**

### Step 4: Verify All Added

After adding all secrets, go back to:
https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

You should see all 11 in the list:

```
✓ ANDROID_KEY_ALIAS
✓ ANDROID_KEY_PASSWORD
✓ ANDROID_KEYSTORE_BASE64
✓ ANDROID_KEYSTORE_PASSWORD
✓ IOS_CERTIFICATE_BASE64
✓ IOS_CERTIFICATE_PASSWORD
✓ IOS_PROVISIONING_PROFILE_BASE64
✓ KEYCHAIN_PASSWORD
✓ TESTFLIGHT_APP_ID
✓ TESTFLIGHT_PASSWORD
✓ TESTFLIGHT_USERNAME
```

---

## 🚀 AFTER ADDING ALL SECRETS

Push code to trigger builds:

```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app"

# Make small change
Add-Content README.md "`n# APK and IPA builds"

# Commit
git add .
git commit -m "Build APK and IPA"

# Push to GitHub
git push origin main
```

Monitor at: https://github.com/RizqonSagena/tongkrongan-app/actions

Expected workflows:
- Build Android APK (15 min)
- Build iOS IPA (20 min)

---

## 📊 SECRETS QUICK REFERENCE

| # | Secret | Type | Value |
|---|---|---|---|
| 1 | ANDROID_KEYSTORE_BASE64 | base64 | From keystore-base64.txt |
| 2 | ANDROID_KEYSTORE_PASSWORD | password | Tongkrongan@2024_637729 |
| 3 | ANDROID_KEY_PASSWORD | password | Key@2024_236320 |
| 4 | ANDROID_KEY_ALIAS | text | tongkrongan |
| 5 | IOS_CERTIFICATE_BASE64 | base64 | From Mac .p12 export |
| 6 | IOS_CERTIFICATE_PASSWORD | password | Your .p12 password |
| 7 | IOS_PROVISIONING_PROFILE_BASE64 | base64 | From Mac .mobileprovision |
| 8 | KEYCHAIN_PASSWORD | password | KeychainPass123! |
| 9 | TESTFLIGHT_USERNAME | email | your-apple@email.com |
| 10 | TESTFLIGHT_PASSWORD | password | From Apple ID app password |
| 11 | TESTFLIGHT_APP_ID | bundle ID | com.stitch.tongkrongan |

---

## ⚠️ IMPORTANT REMINDERS

✅ **Case-sensitive:** Secret names must match EXACTLY
✅ **Full value:** Copy entire base64 string, not just part
✅ **No spaces:** Trim any leading/trailing spaces
✅ **Keep safe:** Don't share these secrets
✅ **Passwords secure:** Use strong, unique passwords

---

## 🆘 IF YOU HAVE ISSUES

### Forgot Android Passwords?

They're in: `ANDROID_BUILD_CREDENTIALS.txt`
- ANDROID_KEYSTORE_PASSWORD: Tongkrongan@2024_637729
- ANDROID_KEY_PASSWORD: Key@2024_236320

### Need iOS Files?

You need on Mac:
1. certificates.p12 (iOS Distribution Certificate)
2. Tongkrongan.mobileprovision (Provisioning Profile)

Get from: Apple Developer Portal → Certificates, Identifiers & Profiles

### Secret Value is Wrong?

1. Go to GitHub secrets page
2. Click secret name
3. Click "Update"
4. Correct the value
5. Click "Update secret"

---

**Status:** Secrets Setup Guide  
**Date:** September 16, 2026  
**Version:** 1.0

**Next:** Add secrets → Push code → Build APK & IPA! 🚀

