# ⚡ Quick Start - APK Setup (Android Only)
**Status:** Fresh Start - Ready to Go!  
**Tanggal:** September 16, 2026  
**Durasi:** ~30 menit setup + 20 menit build = 50 menit

---

## 📚 4 Files - Follow These in Order:

```
1. ANDROID_KEYSTORE_SETUP.md        (5 min)   - Generate keystore baru
2. GITHUB_SECRETS_ADD.md            (10 min)  - Add 4 secrets ke GitHub
3. BUILD_AND_TEST_APK.md            (20 min)  - Trigger & monitor build
4. INSTALL_APK_SIDELOADLY.md        (15 min)  - Install APK ke device
```

---

## 🚀 QUICK EXECUTION STEPS:

### Step 1: Generate Keystore (5 min)

**Open PowerShell:**
```powershell
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app"

keytool -genkey -v -keystore upload-keystore.jks `
  -keyalg RSA -keysize 2048 -validity 10000 `
  -alias tongkrongan `
  -storepass "Tongkrongan@2024" `
  -keypass "Tongkrongan@2024" `
  -dname "CN=Tongkrongan,O=Tongkrongan,C=ID"
```

✅ File `upload-keystore.jks` tercipta

---

### Step 2: Encode Base64 (1 min)

**Still in PowerShell:**
```powershell
$data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
$base64 = [Convert]::ToBase64String($data)
$base64 | Set-Clipboard

Write-Host "✓ Base64 copied to clipboard"
```

✅ Base64 string siap di-copy

---

### Step 3: Add GitHub Secrets (10 min)

**Buka:**
```
https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
```

**Add 4 secrets:**
```
1. ANDROID_KEYSTORE_BASE64 = [paste base64 dari clipboard]
2. ANDROID_KEYSTORE_PASSWORD = Tongkrongan@2024
3. ANDROID_KEY_PASSWORD = Tongkrongan@2024
4. ANDROID_KEY_ALIAS = tongkrongan
```

✅ 4 secrets ditambah

---

### Step 4: Trigger APK Build (20 min)

**Buka:**
```
https://github.com/RizqonSagena/tongkrongan-app/actions
```

**Run workflow:**
```
1. Click "Build Android APK" workflow
2. Click "Run workflow"
3. Branch: main
4. Click green "Run workflow"
5. Wait 15-20 minutes untuk build selesai
```

✅ APK tercipta

---

### Step 5: Download APK (2 min)

**Setelah build completed:**
```
1. Workflow page → scroll ke Artifacts section
2. Download: app-release-[timestamp].apk
3. File size: ~60 MB
4. Save ke Downloads folder
```

✅ APK downloaded

---

### Step 6: Install ke Android (10 min)

**Requirements:**
- Sideloadly installed (https://sideloadly.io)
- Android device connected via USB
- USB Debugging enabled

**Install:**
```
1. Open Sideloadly
2. Select Android device
3. Select APK file (app-release-*.apk)
4. Click "Install"
5. Wait 2-5 minutes
6. Status: "✓ Installation Completed"
```

✅ APK installed di device

---

### Step 7: Test App (5 min)

**Open app di device:**
```
✓ App opens tanpa crash
✓ 5 tabs visible (Explore, Favorites, Booking, Chat, Profile)
✓ Scrolling smooth
✓ Buttons responsive

Status: ✅ TESTING READY
```

---

## 📊 CREDENTIALS (Catat Ini):

```
📌 ANDROID KEYSTORE CREDENTIALS FOR TESTING
═══════════════════════════════════════════

File: upload-keystore.jks
Location: tongkrongan_app/android/app/

Keystore Password:  Tongkrongan@2024
Key Password:       Tongkrongan@2024
Key Alias:          tongkrongan

Status: ✅ Testing only (change for production later)
```

---

## ✅ CHECKLIST:

```
[ ] PowerShell command run → upload-keystore.jks created
[ ] Base64 encoded → string in clipboard
[ ] GitHub Secrets added → 4 secrets visible
[ ] Build triggered → workflow running
[ ] Build completed → APK in Artifacts
[ ] APK downloaded → file in Downloads
[ ] Sideloadly installed → ready to use
[ ] Android device connected → USB debugging on
[ ] APK installed → app visible on device
[ ] App tested → all 5 screens working
[ ] Status → ✅ READY FOR TESTING
```

---

## 🎯 NEXT STEPS:

### Share ke Klien:

1. **APK file** → tangkrongan_app/build/app/outputs/flutter-app/release/app-release.apk
2. **Dokumentasi:** SETUP_UNTUK_KLIEN.md (ada di root folder)
3. **Instruksi:** Follow SETUP_UNTUK_KLIEN.md untuk install dengan Sideloadly

### Untuk iOS (Later):

- Butuh Apple Developer Account ($99/tahun)
- Or skip untuk sekarang

---

## 📞 REFERENCE DOCS:

```
1. ANDROID_KEYSTORE_SETUP.md      - Generate keystore
2. GITHUB_SECRETS_ADD.md          - Add GitHub Secrets
3. BUILD_AND_TEST_APK.md          - Build & test
4. INSTALL_APK_SIDELOADLY.md      - Install to device
5. SETUP_UNTUK_KLIEN.md           - Share ke klien

All files di root folder project!
```

---

## 🚀 Let's Go!

**Start with ANDROID_KEYSTORE_SETUP.md** → Follow steps → Done in 50 minutes!

**Ready?** 👇
