# ✅ GitHub Actions Workflow Verification & Testing
**Versi:** 1.0  
**Tanggal:** September 16, 2026  
**Status:** Siap untuk Verification

---

## 🎯 Objective

Dokumen ini memandu untuk:
1. ✅ Verify semua GitHub Secrets sudah correct
2. ✅ Test GitHub Actions workflow (APK & IPA build)
3. ✅ Download hasil build (APK & IPA)
4. ✅ Test dengan Sideloadly di device
5. ✅ Troubleshoot jika build gagal

---

## 📋 Pre-Verification Checklist

Sebelum mulai, pastikan:

- [ ] GitHub Secrets sudah ditambahkan (8 minimum: 4 Android + 4 iOS)
- [ ] Semua nama secrets EXACT match (case-sensitive)
- [ ] Base64 encoding sudah valid (cek di step sebelumnya)
- [ ] Repository sudah terikat dengan GitHub Actions workflows
- [ ] Anda punya akses ke repository (Owner atau Collaborator)

**Jika ada yang belum, complete di GITHUB_SECRETS_SETUP_LENGKAP.md dulu.**

---

## 🚀 STEP 1: Verify GitHub Secrets

### 1A: Buka GitHub Secrets Page

1. **Buka GitHub Settings:**
   ```
   https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
   ```

2. **Verify list secrets:**
   ```
   Anda harus melihat minimal:
   
   ✓ ANDROID_KEY_ALIAS
   ✓ ANDROID_KEY_PASSWORD
   ✓ ANDROID_KEYSTORE_BASE64
   ✓ ANDROID_KEYSTORE_PASSWORD
   ✓ IOS_CERTIFICATE_BASE64
   ✓ IOS_CERTIFICATE_PASSWORD
   ✓ IOS_PROVISIONING_PROFILE_BASE64
   ✓ KEYCHAIN_PASSWORD
   ```

3. **Count total:**
   ```
   Minimal 8 secrets untuk Android + iOS build
   Optional: SIDELOADLY_API_KEY, SIDELOADLY_DEVICE_ID
   ```

---

### 1B: Verify Secret Names (Critical!)

**Check EXACT spelling (case-sensitive):**

Jika ada typo, build akan FAIL. Contoh:

```
❌ WRONG:
- android_keystore_base64 (lowercase)
- ANDROID_KEYSTORE (missing _BASE64)
- IOS_CERTIFICATE (missing _BASE64)
- KEYCHAIN_PASSWORD (typo jadi KEYCHAIN_PASS)

✅ CORRECT:
- ANDROID_KEYSTORE_BASE64
- ANDROID_KEYSTORE_PASSWORD
- ANDROID_KEY_PASSWORD
- ANDROID_KEY_ALIAS
- IOS_CERTIFICATE_BASE64
- IOS_CERTIFICATE_PASSWORD
- IOS_PROVISIONING_PROFILE_BASE64
- KEYCHAIN_PASSWORD
```

---

### 1C: Verify Secret Values

Untuk memverifikasi value (tanpa melihat isinya):

1. **Klik nama secret (contoh: ANDROID_KEYSTORE_BASE64)**

2. **Click "Update":**
   ```
   Value field akan muncul (tapi value hidden sebagai dots)
   Jangan di-edit, hanya check ada value atau tidak
   ```

3. **Back tanpa save:**
   ```
   Klik back atau close
   Jangan klik "Update secret"
   ```

4. **Repeat untuk semua secrets**

---

## 🧪 STEP 2: Test Android APK Build

### 2A: Trigger Build Manual

1. **Buka GitHub Actions:**
   ```
   Repository → Actions tab
   https://github.com/RizqonSagena/tongkrongan-app/actions
   ```

2. **Cari workflow "Build Android APK":**
   ```
   Di list sebelah kiri: "Build Android APK"
   Klik nama workflow
   ```

3. **Klik "Run workflow":**
   ```
   Button "Run workflow" muncul (top-right area)
   Click tombol tersebut
   ```

4. **Select branch dan run:**
   ```
   Branch dropdown: Pilih "main"
   Klik green button "Run workflow"
   ```

5. **Monitor build dimulai:**
   ```
   Status: "Queued"
   Tunggu 1-2 menit sampai status berubah
   ```

---

### 2B: Monitor Android Build Progress

1. **Klik workflow run yang sedang berjalan:**
   ```
   Halaman jobs muncul
   Status: 🟡 In Progress atau ✅ Completed atau ❌ Failed
   ```

2. **Monitor step-by-step:**
   ```
   Workflow akan jalankan step:
   
   ✓ Checkout code
   ✓ Set up Java
   ✓ Set up Flutter
   ✓ Get dependencies
   ✓ Run analysis
   ✓ Decode Android signing key
   ✓ Create Android keystore properties
   🔄 Build APK (Release) ← LONGEST STEP (5-10 min)
   ✓ Generate version tag
   ✓ Upload APK to Artifacts
   ✓ Post Build Status
   ```

3. **Watch logs di tengah:**
   ```
   Scroll di logs untuk lihat detail execution
   Look untuk "green" checkmarks = success
   Look untuk "red" X = failed step
   ```

4. **Estimated time:**
   ```
   Total: 15-20 menit
   Tidak perlu tunggu di halaman, bisa close
   ```

---

### 2C: Check Android Build Result

#### Jika ✅ SUCCESS:

1. **Klik workflow run yang selesai**

2. **Scroll ke bawah "Artifacts" section:**
   ```
   Section "Artifacts" muncul
   Di dalamnya: file "app-release-*.apk" (size ~60 MB)
   ```

3. **Download APK:**
   ```
   Klik nama artifact
   Browser akan download file .apk
   Simpan di folder yang mudah diakses (contoh: Downloads)
   ```

4. **Verify APK file:**
   ```
   File size: 50-80 MB (should be reasonable)
   Filename: app-release-[timestamp].apk
   Bisa langsung digunakan untuk Sideloadly install
   ```

---

#### Jika ❌ FAILED:

1. **Klik workflow run yang failed**

2. **Scroll ke atas, cari step yang merah/failed:**
   ```
   Find "❌" mark atau "Failed" step
   Click nama step untuk expand
   ```

3. **Read error message:**
   ```
   Common errors:
   
   ERROR 1: "Cannot find secret ANDROID_KEYSTORE_BASE64"
   → SOLUSI: Check secret name, mungkin typo
   
   ERROR 2: "Bad decrypt. Could not be decrypted."
   → SOLUSI: Base64 encoding invalid, re-encode
   
   ERROR 3: "keytool error: java.io.IOException"
   → SOLUSI: Keystore password salah
   
   ERROR 4: "Build of /build/app failed"
   → SOLUSI: Check log, mungkin dependency issue
   
   ERROR 5: "Task bundleRelease not found"
   → SOLUSI: Flutter version, update atau downgrade
   ```

4. **Screenshot error message**

5. **Fix dan retry:**
   ```
   Sesuaikan secret yang bermasalah
   Klik "Run workflow" lagi
   ```

---

## 🍎 STEP 3: Test iOS IPA Build

Sama seperti Android, tapi iOS lebih lama (~25 menit):

### 3A: Trigger iOS Build

1. **Actions → "Build iOS IPA" workflow**
2. **Klik "Run workflow"**
3. **Pilih branch: main**
4. **Klik "Run workflow"**

---

### 3B: Monitor iOS Build

Workflow steps:

```
✓ Checkout code
✓ Set up Flutter
✓ Get dependencies
✓ Run analysis
✓ Install pods (2-5 min)
✓ Decode provisioning profile
✓ Decode signing certificate
✓ Build iOS (Release) ← LONGEST (10-15 min)
✓ Export iOS App to Archive (3-5 min)
✓ Export iOS App to IPA (2-3 min)
✓ Upload IPA to Artifacts
✓ Post Build Status

Total: 20-30 menit
```

---

### 3C: Download iOS IPA

Sama seperti Android:

1. **Workflow completed ✅**
2. **Scroll ke Artifacts section**
3. **Download file: "Tongkrongan-*.ipa" (~80-120 MB)**
4. **Simpan di folder mudah diakses**

---

#### Jika iOS Build Failed:

Common iOS errors:

```
ERROR: "Pods integration not found"
→ SOLUSI: Pod install gagal, rerun workflow

ERROR: "Code signing error"
→ SOLUSI: Certificate atau provisioning profile invalid

ERROR: "xcodebuild: error"
→ SOLUSI: Check iOS minimum deployment target
          atau Xcode version mismatch

ERROR: "Device support not found"
→ SOLUSI: iOS SDK version issue, contact Apple
```

---

## 💾 STEP 4: Download & Verify APK/IPA

### 4A: Verify Download

Setelah download APK dan IPA:

```
Checklist:
- [ ] File APK: app-release-*.apk (~60 MB) ✓
- [ ] File IPA: Tongkrongan-*.ipa (~100 MB) ✓
- [ ] File dapat di-locate di Downloads
- [ ] File size reasonable (not 0 bytes, not 500KB)
- [ ] File tidak corrupt (coba open dengan 7-zip/WinRAR)
```

---

### 4B: Verify APK File (Windows)

```powershell
# Check APK file size
Get-Item "path\to\app-release.apk" | Select-Object Length

# Output contoh:
# Length: 68435456 (65 MB - good)
```

---

### 4C: Verify IPA File (Windows/Mac)

```bash
# Check IPA file size
ls -lh "path/to/Tongkrongan.ipa"

# Output contoh:
# -rw-r--r-- 1 user staff 105M Sep 16 12:34 Tongkrongan.ipa
```

---

## 📱 STEP 5: Test Install dengan Sideloadly

### 5A: Prepare Devices

**Android:**
```
✓ USB cable terhubung ke PC
✓ USB Debugging enabled
✓ Device muncul di Sideloadly
✓ Sideloadly sudah buka
```

**iOS:**
```
✓ USB cable terhubung ke Mac/PC
✓ Trust computer (di iPhone)
✓ Device muncul di Sideloadly
✓ Sideloadly sudah buka
✓ Apple ID ready untuk login
```

---

### 5B: Install APK

1. **Buka Sideloadly**

2. **Select Device:**
   ```
   Dropdown → Pilih Android phone
   ```

3. **Select App:**
   ```
   Klik "Select App" button
   Browse ke app-release.apk
   Click Open
   ```

4. **Install:**
   ```
   Klik "Install" button
   Progress bar: 0% → 100% (2-5 min)
   ```

5. **Success:**
   ```
   Status: "✓ Installation Completed"
   Notification: "Successfully installed"
   ```

6. **Verify di Phone:**
   ```
   Home screen → Tap "Tongkrongan" icon
   App harus buka tanpa error
   ```

---

### 5C: Install IPA

Sama seperti APK, tapi perlu Apple ID:

1. **Buka Sideloadly**

2. **Select Device:**
   ```
   Dropdown → Pilih iPhone
   ```

3. **Select App:**
   ```
   Klik "Select App"
   Browse ke Tongkrongan.ipa
   ```

4. **Enter Apple ID:**
   ```
   Popup muncul, masukkan email & password
   ```

5. **Install:**
   ```
   Klik "Install"
   Progress: 0% → 100% (3-8 min)
   ```

6. **Trust Certificate (di iPhone):**
   ```
   Jika muncul "Untrusted Developer"
   Settings → General → Device Management
   Tap developer name → Trust
   ```

7. **Verify:**
   ```
   App muncul di home screen
   Tap untuk buka
   ```

---

## 🧠 STEP 6: First App Launch Testing

### 6A: Basic Functionality Check

Setelah app terbuka:

```
Android & iOS - Check:

✓ App launches without crash
✓ Home screen / Explore screen visible
✓ Can scroll tempat list
✓ Images loading (atau loading spinner)
✓ Tab navigation works (Explore, Favorites, Booking, Chat, Profile)
✓ Dapat tap buttons (no freeze)
✓ Animations smooth (filter chips, etc.)
```

---

### 6B: Check Console for Errors

**Android Logcat:**
```
adb logcat | grep "Tongkrongan"

Look untuk red errors:
- null pointer exception
- firebase error
- permission denied
```

**iOS Console (Mac):**
```
Xcode → Window → Devices and Simulators
Select iPhone
View Device Logs
Search "Tongkrongan"
```

---

## ✅ Verification Checklist

Setelah semua step selesai:

### GitHub Actions:
- [ ] 8+ secrets sudah di GitHub
- [ ] Semua secret names correct (no typo)
- [ ] Android build ✅ completed
- [ ] iOS build ✅ completed
- [ ] APK file downloaded (~60 MB)
- [ ] IPA file downloaded (~100 MB)

### Device Installation:
- [ ] APK installed ke Android via Sideloadly ✓
- [ ] IPA installed ke iOS via Sideloadly ✓
- [ ] Android app opens without crash ✓
- [ ] iOS app opens without crash ✓
- [ ] App UI visible and responsive ✓

### Testing:
- [ ] Can navigate between screens
- [ ] Images load properly
- [ ] Animations smooth (60 FPS)
- [ ] Buttons responsive
- [ ] No freeze or crash during testing

---

## 🐛 Advanced Troubleshooting

### Issue: Build Success tapi APK/IPA tidak di Artifacts

**Penyebab:** Export step failed

**Solusi:**
1. Klik workflow
2. Cari step "Upload APK to Artifacts" atau "Upload IPA to Artifacts"
3. Lihat error message
4. Common: Path salah atau file tidak digenerate

---

### Issue: APK Install Success tapi App Crash

**Penyebab:** Code error atau missing dependency

**Solusi:**
1. Check logcat untuk error detail
2. Screenshot error dan kirim ke developer
3. Developer fix code → push → rebuild

---

### Issue: iOS Certificate Error

**Penyebab:** Certificate sudah expired atau revoked

**Solusi:**
1. Generate certificate baru di Apple Developer
2. Update IOS_CERTIFICATE_BASE64 secret
3. Rerun build

---

### Issue: GitHub Actions Timeout

**Penyebab:** Build terlalu lama (> 1 jam)

**Solusi:**
1. GitHub Actions free tier: max 6 jam per job
2. Jika build > 1 jam, ada masalah
3. Check logs untuk long-running step
4. Optimize build atau contact support

---

## 📊 Success Indicators

Jika ini semua ✓, maka setup BERHASIL:

```
✅ GitHub Secrets all set
✅ Android build passes
✅ iOS build passes
✅ APK downloads successfully
✅ IPA downloads successfully
✅ APK installs on Android device
✅ IPA installs on iOS device
✅ Apps launch without crash
✅ UI responsive and smooth
✅ Ready untuk client testing!
```

---

## 📅 Next Steps: Continuous Testing

Setelah verification selesai:

### Untuk setiap update:

```
1. Developer push code ke 'main' branch
2. GitHub Actions build otomatis (15-25 min)
3. APK & IPA ready di Artifacts
4. Download files
5. Install dengan Sideloadly
6. Test di device
7. Report issues / approve release
```

---

## 🎉 You're Ready!

Jika checklist semua ✅, Anda sudah siap untuk:

1. ✅ Automated build setiap push
2. ✅ Download APK/IPA from GitHub
3. ✅ Install dengan Sideloadly
4. ✅ Continuous testing dengan client
5. ✅ Release management

**Workflow berhasil disetup dan terverifikasi!**

---

## 📞 Quick Support

| Problem | Check |
|---------|-------|
| Build failed | GitHub Actions logs |
| Secrets missing | Settings → Secrets tab |
| APK not in Artifacts | Scroll down Artifacts section |
| App crashes | Check device logs (logcat/console) |
| Sideloadly error | Reconnect USB, restart app |
| Install slow | Normal, wait 5-10 minutes |

---

**Status:** Ready for Production  
**Last Updated:** September 16, 2026  
**Version:** 1.0

**Next:** Lihat SETUP_UNTUK_KLIEN.md untuk client testing guide!
