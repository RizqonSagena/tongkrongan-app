# 📱 Sideloadly Integration Guide

**Purpose:** Auto-install APK & IPA setelah GitHub Actions build selesai  
**Date:** September 16, 2026  
**Integration:** GitHub Actions + Sideloadly API

---

## 📊 Alur Kerja

```
Push to GitHub (main branch)
    ↓
GitHub Actions Trigger
    ├─ Android Build (build-android.yml)
    │  └─ Generate APK
    │
    └─ iOS Build (build-ios.yml)
       └─ Generate IPA
    ↓
Deploy Workflow Triggered (deploy-sideloadly.yml)
    ├─ Download artifacts
    ├─ Install Sideloadly CLI
    ├─ Upload to Sideloadly API
    └─ Auto-install on device
    ↓
App installed on your iPhone/Android! ✅
```

---

# 🔧 SETUP SIDELOADLY

## Step 1: Create Sideloadly Account

1. Go to [Sideloadly.io](https://sideloadly.io)
2. Sign up (free or premium)
3. Download Sideloadly desktop app

**Supported Platforms:**
- macOS
- Windows
- Linux

## Step 2: Connect Device

### For iPhone (iOS):
1. Connect iPhone to computer via USB
2. Trust the computer on iPhone
3. Open Sideloadly desktop app
4. iPhone should appear in device list
5. Note the Device ID

### For Android:
1. Connect Android via USB
2. Enable USB Debugging (Settings → Developer Options)
3. Open Sideloadly desktop app
4. Android should appear in device list
5. Note the Device ID

## Step 3: Generate API Key

1. Login to Sideloadly account
2. Go to **Settings → API Keys**
3. Click **"Generate New Key"**
4. Name it: `GitHub Actions`
5. Copy and save the API key

## Step 4: Get Device ID

In Sideloadly desktop app:
```
Select your device
Right-click → Copy Device ID

Or:
Settings → Devices → [Your Device] → Copy ID
```

---

# 🔐 ADD SECRETS TO GITHUB

Go to GitHub Repository:
```
Settings → Secrets and variables → Actions
```

### Secret 1: SIDELOADLY_API_KEY
```
Name: SIDELOADLY_API_KEY
Value: [Your API key from Step 3]
```

### Secret 2: SIDELOADLY_DEVICE_ID
```
Name: SIDELOADLY_DEVICE_ID
Value: [Your device ID from Step 4]
```

---

# 🚀 TEST WORKFLOW

## Method 1: Automatic Trigger

Push to main branch:
```bash
git add .
git commit -m "Test CI/CD deployment"
git push origin main
```

The workflow will:
1. Build APK (Ubuntu, ~15 min)
2. Build IPA (macOS, ~20 min)
3. Deploy both to Sideloadly (~2 min)

Monitor:
```
GitHub → Actions → [Workflow] → deploy-sideloadly
```

## Method 2: Manual Trigger

Go to GitHub:
```
Actions → Deploy to Sideloadly → Run workflow
```

Choose artifact type:
- Android
- iOS
- Both

---

# 📋 DEPLOYMENT WORKFLOW BREAKDOWN

## Stage 1: Build APK (build-android.yml)

**Runs on:** Ubuntu Latest  
**Time:** 10-15 minutes  
**Output:** `app-release.apk`

Steps:
1. Checkout code
2. Setup Java 11
3. Setup Flutter
4. Get dependencies
5. Decode Android keystore
6. Build APK (release)
7. Upload artifact
8. Create GitHub release

## Stage 2: Build IPA (build-ios.yml)

**Runs on:** macOS Latest  
**Time:** 15-20 minutes  
**Output:** `Tongkrongan.ipa`

Steps:
1. Checkout code
2. Setup Flutter
3. Get dependencies
4. Install pods
5. Decode certificate & provisioning profile
6. Import to keychain
7. Build iOS archive
8. Export to IPA
9. Upload artifact
10. Create GitHub release

## Stage 3: Deploy to Sideloadly (deploy-sideloadly.yml)

**Runs on:** Ubuntu Latest  
**Time:** 2-5 minutes  
**Trigger:** After build-android.yml or build-ios.yml completes

Steps:
1. Download APK/IPA artifacts
2. Install Sideloadly CLI
3. Deploy via Sideloadly API:
   ```
   curl -X POST https://api.sideloadly.io/v1/upload \
     -H "Authorization: Bearer $API_KEY" \
     -F "file=@app.apk" \
     -F "device_id=$DEVICE_ID" \
     -F "auto_install=true"
   ```
4. Notify completion

---

# 🎯 API INTEGRATION DETAILS

## Sideloadly API Endpoint

```
POST https://api.sideloadly.io/v1/upload
```

### Request Headers
```
Authorization: Bearer YOUR_API_KEY
Content-Type: multipart/form-data
```

### Request Body
```
file (binary)           - APK or IPA file
device_id (string)      - Target device ID
auto_install (boolean)  - true = auto install, false = ask
app_type (string)       - "android" or "ios"
```

### Example (using curl)

**Android:**
```bash
curl -X POST https://api.sideloadly.io/v1/upload \
  -H "Authorization: Bearer $SIDELOADLY_API_KEY" \
  -F "file=@app-release.apk" \
  -F "device_id=$SIDELOADLY_DEVICE_ID" \
  -F "auto_install=true" \
  -F "app_type=android"
```

**iOS:**
```bash
curl -X POST https://api.sideloadly.io/v1/upload \
  -H "Authorization: Bearer $SIDELOADLY_API_KEY" \
  -F "file=@Tongkrongan.ipa" \
  -F "device_id=$SIDELOADLY_DEVICE_ID" \
  -F "auto_install=true" \
  -F "app_type=ios"
```

### Response

**Success (200 OK):**
```json
{
  "status": "success",
  "message": "App installed successfully",
  "app_id": "com.stitch.tongkrongan",
  "device_id": "your_device_id",
  "installation_time": "45 seconds"
}
```

**Error (400 Bad Request):**
```json
{
  "status": "error",
  "message": "Invalid API key",
  "error_code": "INVALID_AUTH"
}
```

---

# 🔍 MONITORING & LOGS

## View Workflow Logs

Go to GitHub:
```
Actions → [Workflow Name] → [Run] → Logs
```

Each step shows:
- ✅ Step succeeded
- ❌ Step failed
- ⏭️ Step skipped

## Download Artifacts

After successful build:
```
Actions → [Workflow] → Artifacts
```

Download:
- `app-release-YYYYMMDD_HHMMSS.apk`
- `Tongkrongan-YYYYMMDD_HHMMSS.ipa`

## Check Device Installation

**On iPhone:**
```
Settings → General → iPhone Storage
→ Look for "Tongkrongan" app
```

**On Android:**
```
Settings → Apps
→ Look for "Tongkrongan" app
```

---

# 🐛 TROUBLESHOOTING

### Issue: "Invalid API key"

**Solution:**
1. Verify API key in GitHub Secrets
2. Regenerate new API key in Sideloadly
3. Update secret in GitHub

```bash
# Check API key format (should not have spaces)
echo "${{ secrets.SIDELOADLY_API_KEY }}"
```

### Issue: "Device not found"

**Solution:**
1. Verify device ID is correct
2. Device must be connected and trusted
3. Check Sideloadly desktop app has device listed

```bash
# List connected devices (if CLI available)
sideloadly --list-devices
```

### Issue: "Installation failed"

**Solution:**
1. Check app isn't already installed
2. Verify enough storage on device
3. Check app signing certificate is valid
4. For iOS: Check provisioning profile isn't expired

### Issue: "Workflow doesn't trigger"

**Solution:**
1. Check workflow file is in `.github/workflows/`
2. Verify branch name matches (main or develop)
3. Check workflow syntax (YAML format)
4. Manually trigger: Actions → Run workflow

### Issue: "Build artifacts not found"

**Solution:**
1. Ensure build completed successfully
2. Check artifact retention (30 days default)
3. Verify artifact upload step in workflow

---

# 📊 WORKFLOW STATUS DASHBOARD

Create custom dashboard in GitHub:

```
Repository → Settings → Actions
```

View:
- Last 30 days of workflows
- Success/failure rate
- Average build time
- Total time spent

---

# 💡 BEST PRACTICES

1. **Test locally first**
   ```bash
   flutter build apk --release
   flutter build ipa --release
   ```

2. **Keep secrets secure**
   - Never commit secrets to repo
   - Rotate API keys monthly
   - Use GitHub CODEOWNERS for approval

3. **Monitor builds**
   - Set up email notifications
   - Create custom alerts
   - Track build times

4. **Optimize for speed**
   - Cache dependencies
   - Use parallel jobs
   - Cleanup old artifacts

5. **Version management**
   - Increment build number for each release
   - Tag releases in Git
   - Keep changelog updated

---

# 📝 DEPLOYMENT CHECKLIST

Before first deployment:

- [ ] Sideloadly account created
- [ ] Device connected and recognized
- [ ] API key generated
- [ ] Device ID copied
- [ ] GitHub secrets configured
- [ ] Workflows in `.github/workflows/`
- [ ] YAML syntax validated
- [ ] Test build locally successful
- [ ] Manual workflow trigger tested
- [ ] Artifacts downloaded successfully
- [ ] Device installation verified

---

# 🚀 NEXT STEPS

1. ✅ Setup Sideloadly account
2. ✅ Generate API key
3. ✅ Add GitHub secrets
4. ✅ Push code to GitHub
5. ✅ Monitor workflow execution
6. ✅ Verify app installation
7. ✅ Setup monitoring (optional)

---

# 📞 SUPPORT

**Sideloadly Issues:** https://sideloadly.io/support  
**GitHub Actions:** https://docs.github.com/actions  
**Flutter Build:** https://flutter.dev/docs/deployment

---

**Sideloadly Integration Status:** ✅ READY  
**Last Updated:** September 16, 2026  
**Version:** 1.0

