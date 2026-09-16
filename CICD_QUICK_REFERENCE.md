# 🚀 CI/CD Quick Reference Card

**Print this or bookmark for quick access**

---

## 📱 WORKFLOW OVERVIEW

```
Push to GitHub (main)
       ↓
Build Android (15 min) + Build iOS (20 min)
       ↓
Deploy to Sideloadly (5 min)
       ↓
App installed on device! ✅
```

---

## 🔐 13 REQUIRED SECRETS

### Android (4)
```
ANDROID_KEYSTORE_BASE64           ← base64 keystore file
ANDROID_KEYSTORE_PASSWORD         ← keystore password
ANDROID_KEY_PASSWORD              ← key password
ANDROID_KEY_ALIAS                 ← usually "tongkrongan"
```

### iOS (7)
```
IOS_CERTIFICATE_BASE64            ← base64 .p12 certificate
IOS_CERTIFICATE_PASSWORD          ← certificate password
IOS_PROVISIONING_PROFILE_BASE64   ← base64 .mobileprovision
KEYCHAIN_PASSWORD                 ← any secure password
TESTFLIGHT_USERNAME               ← your Apple ID
TESTFLIGHT_PASSWORD               ← app-specific password
TESTFLIGHT_APP_ID                 ← app bundle ID
```

### Sideloadly (2 - Optional)
```
SIDELOADLY_API_KEY                ← from Sideloadly account
SIDELOADLY_DEVICE_ID              ← your device ID
```

**Add at:** Settings → Secrets and variables → Actions

---

## 📂 FILES TO CREATE

```
.github/workflows/
├── build-android.yml
├── build-ios.yml
└── deploy-sideloadly.yml

tongkrongan_app/ios/
└── ExportOptions.plist
```

---

## ⚡ QUICK START (5 STEPS)

### 1. Generate Keys
```bash
# Android keystore
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias tongkrongan -storepass PASSWORD1 -keypass PASSWORD2

# iOS: Use Apple Developer + Keychain
```

### 2. Convert to Base64
```bash
# Windows PowerShell
[Convert]::ToBase64String($(Get-Content "upload-keystore.jks" -Encoding Byte)) | Set-Clipboard

# Mac Terminal
base64 -i ios_distribution.p12 > cert_base64.txt
```

### 3. Add Secrets
```
GitHub Settings → Secrets → Add 13 secrets
(See section above for list)
```

### 4. Push Code
```bash
git add .
git commit -m "Enable CI/CD"
git push origin main
```

### 5. Monitor
```
Actions tab → Watch workflow
Estimated: 40 minutes total
```

---

## 🎯 WHAT EACH WORKFLOW DOES

### build-android.yml
- Runs on: Ubuntu
- Duration: 15 min
- Outputs: APK, AAB
- Triggers: Push to main/develop
- Uploads to: GitHub releases

### build-ios.yml
- Runs on: macOS
- Duration: 20 min
- Outputs: IPA
- Triggers: Push to main/develop
- Uploads to: GitHub releases

### deploy-sideloadly.yml
- Runs on: Ubuntu
- Duration: 5 min
- Installs: APK or IPA on device
- Triggers: After build completes
- Uses: Sideloadly API

---

## 📊 BUILD TIMES

| Step | Time | Notes |
|------|------|-------|
| Android build | 15 min | Includes APK + AAB |
| iOS build | 20 min | Includes archive + IPA |
| Deploy | 5 min | Upload + install |
| **Total** | **40 min** | Parallel where possible |

---

## ✅ VERIFICATION CHECKLIST

### Before First Run
- [ ] `.github/workflows/` directory created
- [ ] 3 YAML files in workflows directory
- [ ] `ios/ExportOptions.plist` created
- [ ] 13 GitHub secrets added
- [ ] Secrets not truncated
- [ ] Local builds working first

### After First Run
- [ ] Actions tab shows workflows
- [ ] Build completed (green ✅)
- [ ] Artifacts downloaded successfully
- [ ] App installed on device
- [ ] Device ID verified
- [ ] Sideloadly connection working

---

## 🔧 COMMON ISSUES & FIXES

| Issue | Fix | Time |
|-------|-----|------|
| Build fails | Check logs in Actions | 5 min |
| "Keystore not found" | Verify base64 encoding | 5 min |
| "Certificate expired" | Generate new cert | 15 min |
| "Device not found" | Check device ID | 5 min |
| Deployment fails | Verify API key | 5 min |
| Build timeout | Increase timeout or optimize | 10 min |

---

## 📞 HELP RESOURCES

**GitHub Actions Documentation:**
https://docs.github.com/actions

**Flutter Build Docs:**
https://flutter.dev/docs/deployment

**Sideloadly Support:**
https://sideloadly.io/support

**Stack Overflow:**
[github-actions] [android] [ios]

---

## 🚀 MANUAL TRIGGER (OPTIONAL)

Add to workflow:
```yaml
on:
  workflow_dispatch:
    inputs:
      platform:
        description: 'Platform'
        options: [android, ios, both]
```

Then use: Actions → Run workflow → Select platform

---

## 💾 ARTIFACT RETENTION

Default: 30 days

Change in workflow:
```yaml
retention-days: 60  # or any number
```

---

## 📈 MONITOR BUILDS

**Commands:**
```bash
# List recent runs
gh run list --workflow build-android.yml

# Watch live
gh run watch <run_id>

# Download artifacts
gh run download <run_id> -n <name>

# View logs
gh run view <run_id> --log
```

**Or via UI:**
- Actions → [Workflow] → [Run] → Logs

---

## 🔄 UPDATE SECRETS

1. Go to Settings → Secrets
2. Select secret to edit
3. Click pencil icon
4. Enter new value
5. Save

Next build will use new secret.

---

## 📝 WORKFLOW SYNTAX TIPS

**Only run on main branch:**
```yaml
if: github.ref == 'refs/heads/main'
```

**Only on push (not PR):**
```yaml
if: github.event_name == 'push'
```

**Skip a step:**
```yaml
if: false
```

**Continue on error:**
```yaml
continue-on-error: true
```

---

## 🎯 EXPECTED OUTPUT

### Successful Build
```
✓ Checkout code
✓ Setup Java/Flutter
✓ Get dependencies
✓ Build APK/IPA
✓ Upload artifacts
✓ Create release
✅ Workflow completed successfully
```

### Device Installation
```
✓ Download artifacts
✓ Install Sideloadly CLI
✓ Deploy to device
✅ App installed successfully!
```

---

## 📊 STATUS INDICATORS

- 🟢 **Success** - All steps passed
- 🔴 **Failed** - One or more steps failed
- ⏳ **In Progress** - Currently running
- ⏭️ **Skipped** - Conditions not met
- ⏸️ **Cancelled** - Manually stopped

---

## 💡 PRO TIPS

1. **Test locally first**
   ```bash
   flutter build apk --release
   flutter build ios --release
   ```

2. **Don't commit secrets**
   ```bash
   git add -A
   git status  # Verify no .jks or .p12 files
   ```

3. **Monitor first build**
   Watch Actions tab while building

4. **Save successful artifacts**
   Download APK/IPA immediately after success

5. **Keep changelog updated**
   Document what changed in each build

---

## 🔐 SECURITY CHECKLIST

- [ ] Secrets stored in GitHub, not in code
- [ ] No .jks or .p12 files committed
- [ ] API key not visible in logs
- [ ] Secrets rotated every 6 months
- [ ] Repository private if sensitive
- [ ] Only necessary people have access
- [ ] Audit logs reviewed monthly

---

## 📞 TROUBLESHOOTING FLOW

```
Is workflow running?
    NO → Check triggers in YAML
    YES → ↓

Is build passing?
    NO → Check step that failed
    YES → ↓

Are artifacts downloaded?
    NO → Check retention settings
    YES → ↓

Is app installed?
    NO → Check Sideloadly secrets
    YES → ✅ Success!
```

---

## 🎓 LEARNING PATH

1. Read: CICD_COMPLETE_GUIDE.md (30 min)
2. Read: GITHUB_SECRETS_SETUP.md (20 min)
3. Setup: Generate keys (30 min)
4. Setup: Add secrets (10 min)
5. Test: First build (40 min)
6. Verify: App on device (5 min)

**Total:** ~2.5 hours to full setup

---

## 📌 BOOKMARK THIS!

**Key Files:**
- CICD_COMPLETE_GUIDE.md - Full documentation
- GITHUB_SECRETS_SETUP.md - Secret generation
- SIDELOADLY_INTEGRATION.md - Deployment guide

**GitHub Workflows:**
- .github/workflows/build-android.yml
- .github/workflows/build-ios.yml
- .github/workflows/deploy-sideloadly.yml

**Configuration:**
- tongkrongan_app/ios/ExportOptions.plist

---

**Last Updated:** September 16, 2026  
**Version:** 1.0  
**Status:** ✅ Ready to Use

