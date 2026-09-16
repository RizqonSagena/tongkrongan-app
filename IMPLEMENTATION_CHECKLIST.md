# ✅ Implementation Checklist - Tongkrongan App Testing Setup
**Versi:** 1.0  
**Tanggal:** September 16, 2026  
**Status:** Final Checklist untuk Go-Live

---

## 🎯 Tujuan

Dokumen ini adalah **final checklist** untuk memastikan aplikasi Tongkrongan sudah siap untuk:
- ✅ Build otomatis via GitHub Actions
- ✅ Testing oleh klien via APK & IPA
- ✅ Installation via Sideloadly
- ✅ Continuous testing & updates

---

## 📚 Dokumentasi yang Sudah Dibuat

Sebelum lanjut, pastikan Anda sudah punya 4 dokumen utama:

| # | Dokumen | Tujuan | Status |
|---|---------|--------|--------|
| 1 | **SETUP_UNTUK_KLIEN.md** | Panduan lengkap untuk klien setup & testing | ✅ |
| 2 | **SIDELOADLY_LENGKAP.md** | Panduan detail Sideloadly install APK/IPA | ✅ |
| 3 | **GITHUB_SECRETS_SETUP_LENGKAP.md** | Panduan setup GitHub Secrets | ✅ |
| 4 | **WORKFLOW_VERIFICATION.md** | Panduan verify & troubleshoot workflow | ✅ |

---

## 🔧 PHASE 1: Preparation (Hari 1)

### Task 1.1: Persiapkan Credential Files

**Untuk Android:**
```
☐ Cek file: tongkrongan_app/android/app/upload-keystore.jks
  Jika tidak ada → Generate baru (lihat GITHUB_SECRETS_SETUP_LENGKAP.md)
  
☐ Catat passwords:
  - Keystore password: ___________
  - Key password: ___________
  - Key alias: tongkrongan
```

**Untuk iOS:**
```
☐ Cek file: certificate.p12
  Jika tidak ada → Generate dari Apple Developer account
  Referensi: https://developer.apple.com
  
☐ Cek file: profile.mobileprovision
  
☐ Catat passwords:
  - Certificate password: ___________
  - Keychain password (bisa dibuat): ___________
  
⚠️ CATATAN: Jika tidak punya credentials iOS, contact Apple Developer
           atau hire developer dengan Mac access
```

---

### Task 1.2: Encode Credentials ke Base64

**Android:**
```
☐ Encode upload-keystore.jks ke base64
  Caranya: GITHUB_SECRETS_SETUP_LENGKAP.md → STEP 2
  Tool: PowerShell atau online base64encoder
  Result: String yang sangat panjang (~5000+ chars)
  
  ⚠️ JANGAN share di public! Base64 bisa di-decode kembali
```

**iOS:**
```
☐ Encode certificate.p12 ke base64
☐ Encode profile.mobileprovision ke base64
```

---

### Task 1.3: Verify Workflow Files Exists

```
☐ Check GitHub Actions workflows ada:
  Repository path: .github/workflows/
  
  File harus ada:
  ✓ build-android.yml  (APK build)
  ✓ build-ios.yml       (IPA build)
  ✓ deploy-sideloadly.yml (optional, auto-install)
  
  Jika tidak ada → Copy dari template atau create manual
```

---

## 🔐 PHASE 2: GitHub Secrets Setup (Hari 1-2)

### Task 2.1: Add GitHub Secrets

**Akses GitHub Secrets:**
```
☐ Buka: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
☐ Verifikasi Anda punya akses (Settings tab visible)
☐ Siap menambahkan secrets
```

**Add 8 Secrets WAJIB (Android + iOS):**

```
☐ #1: ANDROID_KEYSTORE_BASE64
      Value: [base64 dari upload-keystore.jks]

☐ #2: ANDROID_KEYSTORE_PASSWORD
      Value: [password keystore]

☐ #3: ANDROID_KEY_PASSWORD
      Value: [password key]

☐ #4: ANDROID_KEY_ALIAS
      Value: tongkrongan

☐ #5: IOS_CERTIFICATE_BASE64
      Value: [base64 dari certificate.p12]

☐ #6: IOS_CERTIFICATE_PASSWORD
      Value: [password certificate]

☐ #7: IOS_PROVISIONING_PROFILE_BASE64
      Value: [base64 dari profile.mobileprovision]

☐ #8: KEYCHAIN_PASSWORD
      Value: [any secure password]
```

**Add Optional Secrets (Sideloadly):**

```
☐ #9: SIDELOADLY_API_KEY (OPSIONAL)
      Value: [API key dari Sideloadly account]
      
☐ #10: SIDELOADLY_DEVICE_ID (OPSIONAL)
       Value: [device ID dari Sideloadly]
```

---

### Task 2.2: Verify Secrets di GitHub

```
☐ Buka Secrets page lagi
☐ Verify EXACT naming (case-sensitive):
   ✓ ANDROID_KEYSTORE_BASE64
   ✓ ANDROID_KEYSTORE_PASSWORD
   ✓ ANDROID_KEY_PASSWORD
   ✓ ANDROID_KEY_ALIAS
   ✓ IOS_CERTIFICATE_BASE64
   ✓ IOS_CERTIFICATE_PASSWORD
   ✓ IOS_PROVISIONING_PROFILE_BASE64
   ✓ KEYCHAIN_PASSWORD

☐ Count: Minimal 8 secrets (bisa 10 dengan Sideloadly)
☐ Tidak ada typo atau missing
```

---

## 🧪 PHASE 3: Test Build Workflows (Hari 2)

### Task 3.1: Test Android APK Build

**Trigger Manual Build:**
```
☐ Actions tab → "Build Android APK"
☐ Click "Run workflow"
☐ Branch: main
☐ Click "Run workflow" button
```

**Monitor Build Progress:**
```
☐ Status: Queued (1-2 min)
☐ Status: In Progress (ubuntu runner executing)
☐ Steps berjalan secara sequence:
  - Set up Java
  - Set up Flutter
  - Get dependencies
  - Decode signing key
  - Build APK (Release) ← LONGEST PART (5-10 min)
  - Upload to Artifacts

☐ Total time: ~15 menit
```

**Check Result:**
```
☐ Status: ✅ Completed
  
☐ Artifacts section:
  - File: app-release-[timestamp].apk
  - Size: 50-80 MB
  - Download: Click dan simpan

☐ Alternative (jika tidak di Artifacts):
  - Check Releases page: /releases
  - File harus di sini dengan tag: android-[timestamp]
```

**If Failed ❌:**
```
☐ Check error message di logs:
  Common: Missing secret, invalid base64, wrong password
  
☐ Fix secret yang bermasalah
☐ Retry build
☐ Document error untuk referensi
```

---

### Task 3.2: Test iOS IPA Build

**Trigger Manual Build:**
```
☐ Actions tab → "Build iOS IPA"
☐ Click "Run workflow"
☐ Branch: main
☐ Click "Run workflow"
```

**Monitor Progress:**
```
☐ Similar dengan Android, tapi lebih lama
☐ Steps:
  - Install pods (2-5 min)
  - Decode certificates
  - Build iOS (Release) (10-15 min) ← LONGEST
  - Export to Archive & IPA (3-5 min)
  - Upload Artifacts

☐ Total time: ~25 menit
```

**Check Result:**
```
☐ Status: ✅ Completed
☐ Artifacts: Tongkrongan-[timestamp].ipa (~100 MB)
☐ Download dan simpan
```

---

### Task 3.3: Verify Download Files

**Check APK:**
```
☐ File ada di Downloads folder
☐ Filename: app-release-[timestamp].apk
☐ Size: 50-80 MB (normal)
☐ File tidak corrupt (try open dengan 7-zip)
```

**Check IPA:**
```
☐ File ada di Downloads folder
☐ Filename: Tongkrongan-[timestamp].ipa
☐ Size: 80-120 MB (normal)
☐ File tidak corrupt
```

---

## 📱 PHASE 4: Sideloadly Installation Testing (Hari 2-3)

### Task 4.1: Setup Sideloadly

**Install Sideloadly:**
```
☐ Download dari: https://sideloadly.io
☐ Install di PC/Mac
☐ Jalankan aplikasi
☐ Verify UI terbuka dengan tombol "Install"
```

**Setup Android Device:**
```
☐ Connect Android ke PC via USB cable
☐ Enable USB Debugging di phone (Settings → Developer Options)
☐ Device muncul di Sideloadly dropdown
☐ Status: Ready untuk install
```

**Setup iOS Device:**
```
☐ Connect iPhone ke PC/Mac via USB cable
☐ Tap "Trust" di iPhone (jika muncul)
☐ Enable Developer Mode (iOS 15+): Settings → Privacy & Security
☐ Device muncul di Sideloadly dropdown
☐ Status: Ready untuk install
```

---

### Task 4.2: Test APK Installation (Android)

**Install:**
```
☐ Sideloadly → Select Device: Android phone
☐ Click "Select App"
☐ Browse ke app-release.apk
☐ Click "Install"
☐ Progress: 0% → 100% (2-5 min)
☐ Status: ✅ Installation Completed
```

**Verify on Device:**
```
☐ Buka home screen
☐ App "Tongkrongan" visible
☐ Tap app
☐ App launches tanpa crash
☐ UI visible dan responsive
```

**Check Functionality:**
```
☐ Navigation bar works (5 tabs: Explore, Favorites, Booking, Chat, Profile)
☐ Can tap buttons
☐ Scrolling smooth
☐ Images load (atau fallback visible)
☐ No freeze atau crash
```

---

### Task 4.3: Test IPA Installation (iOS)

**Install:**
```
☐ Sideloadly → Select Device: iPhone
☐ Click "Select App"
☐ Browse ke Tongkrongan.ipa
☐ Enter Apple ID: [email]
☐ Enter Password: [app-specific password]
☐ Click Install
☐ Progress: 0% → 100% (3-8 min)
☐ Status: ✅ Installation Completed
```

**Trust Certificate (di iPhone):**
```
☐ Jika muncul "Untrusted Developer":
☐ Settings → General → Device Management
☐ Tap developer name → Trust
☐ Buka app lagi
```

**Verify on Device:**
```
☐ App visible di home screen
☐ Tap app
☐ App launches tanpa crash
☐ UI matches Android version
☐ All features accessible
```

---

## 🧠 PHASE 5: Functional Testing (Hari 3)

### Task 5.1: Basic App Testing (Android)

**Screen 1: Explore**
```
☐ Halaman load dengan smooth
☐ Header terlihat dengan logo
☐ Location bar: "Di sekitarmu: [location]"
☐ Search bar functional
☐ Filter chips (jarak, kategori, status) berfungsi
☐ Place cards ditampilkan dengan image
☐ Status dot berkedip (pulsing animation)
☐ Favorite button bisa di-tap (heart icon)
☐ "Lihat" button bisa di-tap
```

**Screen 2: Favorites**
```
☐ Tab "Favorit Saya" accessible
☐ Jika sudah favorite, tempat ditampilkan
☐ Filter tabs: "Semua", "Buka", "Tutup" bekerja
☐ Empty state jika belum ada favorit
```

**Screen 3: Booking**
```
☐ Tab "Jadwal Nongkrongan" accessible
☐ FAB "Buat Janji" visible
☐ Modal form buka saat klik FAB
☐ Form fields: Title, Place, Date, Time, Purpose, Guests
☐ Date picker berfungsi
☐ Time picker berfungsi
☐ Submit button berfungsi
```

**Screen 4: Chat**
```
☐ Tab "Chat" accessible
☐ Conversation list ditampilkan
☐ Tap conversation membuka chat detail
☐ Messages terlihat
☐ Message input field functional
☐ Send button works
```

**Screen 5: Profile**
```
☐ Tab "Profil" accessible
☐ Profile info ditampilkan (nama, avatar)
☐ Menu items: Edit, Security, Notifications
☐ Logout button visible
☐ Toggle switches berfungsi (jika ada)
```

---

### Task 5.2: Basic App Testing (iOS)

**Sama seperti Android:**
```
☐ Verify all 5 screens
☐ Check UI consistency dengan Android version
☐ Verify all buttons dan navigation
☐ Check animations smooth
☐ No crashes atau freezes
```

---

### Task 5.3: Performance Check

**Android:**
```
☐ Scrolling smooth (tidak lag)
☐ Tap response time: <200ms
☐ Image loading: <2 detik
☐ No memory leaks (test dengan DevTools)
☐ Battery consumption reasonable
```

**iOS:**
```
☐ Scrolling smooth
☐ Tap response: <200ms
☐ No crash on background/foreground
☐ No battery drain
```

---

## 📋 PHASE 6: Documentation & Client Handover (Hari 3-4)

### Task 6.1: Prepare Client Documentation

**Package untuk Klien (semua dokumen sudah ready):**
```
☐ SETUP_UNTUK_KLIEN.md
  → Panduan lengkap client testing
  → Step-by-step APK/IPA download
  → Sideloadly installation
  → Testing checklist

☐ SIDELOADLY_LENGKAP.md
  → Detailed Sideloadly guide
  → Troubleshooting
  → Setup untuk Android & iOS

☐ GITHUB_SECRETS_SETUP_LENGKAP.md
  → (Optional, for developer/admin reference)

☐ WORKFLOW_VERIFICATION.md
  → (Optional, untuk internal verification)
```

---

### Task 6.2: Client Kickoff

**Komunikasi dengan Klien:**
```
☐ Send dokumentasi: SETUP_UNTUK_KLIEN.md
☐ Send link ke GitHub repository
☐ Invite klien sebagai "Viewer" di GitHub (opsional)
☐ Explain workflow:
  1. Developer push → GitHub Actions build (15-25 min)
  2. Klien download APK/IPA dari Actions
  3. Install dengan Sideloadly
  4. Test di device
  5. Report issues
  6. Developer fix → Repeat

☐ Schedule kickoff call dengan klien
☐ Demo APK/IPA installation step-by-step
☐ Q&A sesi
```

---

### Task 6.3: Setup Testing Process

**Establish Regular Testing Cycle:**
```
☐ Frequency: [Sesuaikan dengan sprint/development pace]
  Contoh: Daily / 2x per week / Weekly

☐ Process:
  1. Developer notifies: "New build ready"
  2. Klien logs GitHub Actions
  3. Download APK/IPA
  4. Install dengan Sideloadly
  5. Test sesuai checklist
  6. Report findings di: [Issue tracker / Email / Slack]
  
☐ Issue tracking:
  - Use GitHub Issues untuk track bugs
  - Atau: Excel / Google Sheet untuk log testing
  - Format: Screen, Issue, Steps, Expected, Actual, Device
  
☐ Update frequency:
  - Next build: [Kapan?]
  - Testing deadline: [Kapan?]
  - Feedback deadline: [Kapan?]
```

---

## ✅ FINAL VERIFICATION CHECKLIST

Sebelum declare "READY FOR PRODUCTION", verify:

### Technical Setup:
```
☐ GitHub Actions workflows: ✅ Working
☐ Android APK build: ✅ Success, ~60 MB
☐ iOS IPA build: ✅ Success, ~100 MB
☐ GitHub Secrets: ✅ All 8+ present, correct names
☐ APK installation: ✅ Success with Sideloadly
☐ IPA installation: ✅ Success with Sideloadly
☐ App launch: ✅ No crash on both platforms
```

### Functional Testing:
```
☐ Explore Screen: ✅ All features working
☐ Favorites Screen: ✅ All features working
☐ Booking Screen: ✅ All features working
☐ Chat Screen: ✅ All features working
☐ Profile Screen: ✅ All features working
☐ Navigation: ✅ Smooth between screens
☐ Performance: ✅ 60 FPS, no lag
```

### Documentation:
```
☐ SETUP_UNTUK_KLIEN.md: ✅ Complete & clear
☐ SIDELOADLY_LENGKAP.md: ✅ Complete & clear
☐ GITHUB_SECRETS_SETUP_LENGKAP.md: ✅ Complete
☐ WORKFLOW_VERIFICATION.md: ✅ Complete
☐ Client communication: ✅ Clear & documented
```

### Client Readiness:
```
☐ Client has documentation
☐ Client understands process
☐ Client can access GitHub repository
☐ Client can download APK/IPA
☐ Client can install with Sideloadly
☐ Client knows how to report issues
```

---

## 🚀 GO-LIVE CRITERIA

Project siap untuk GO-LIVE jika:

```
✅ ALL TECHNICAL SETUP COMPLETE
✅ ALL TESTS PASSING (APK & IPA)
✅ ALL DOCUMENTATION READY
✅ CLIENT COMMUNICATION DONE
✅ TESTING PROCESS ESTABLISHED

Status: 🟢 READY FOR PRODUCTION
```

---

## 📊 Sign-Off Form

```
Developer Name: _________________
Date Completed: _________________
Device Tested (Android): _________________
Device Tested (iOS): _________________

Android Build Status: ✅ PASS / ❌ FAIL
iOS Build Status: ✅ PASS / ❌ FAIL
App Functionality: ✅ PASS / ❌ FAIL
Documentation: ✅ COMPLETE / ❌ INCOMPLETE

Approved for Client Testing: ✅ YES / ❌ NO

Notes:
_________________________________________
_________________________________________
_________________________________________
```

---

## 🔄 Maintenance & Updates

### Setelah Go-Live:

**Weekly Checklist:**
```
☐ Monitor GitHub Actions for build failures
☐ Review client issue reports
☐ Respond to client questions
☐ Update documentation jika ada changes
☐ Maintain credential security (rotate if needed)
```

**When New Build Ready:**
```
☐ Push code → GitHub Actions build
☐ Verify build passes
☐ Download APK/IPA
☐ Quick smoke test
☐ Notify client: "New build available"
☐ Client tests
☐ Feedback → Fix → Repeat
```

---

## 📞 Support & Escalation

**If Issues Arise:**

| Issue | Action |
|-------|--------|
| Build fails | Check logs, verify secrets, debug |
| App crashes | Check logs, fix code, rebuild |
| Client can't install | Verify Sideloadly setup, USB connection |
| Certificate expired | Generate new, update secrets |
| Workflow timeout | Optimize build, check infrastructure |

---

## 🎉 Congratulations!

Jika semua checklist ✅, Anda sudah siap untuk:

1. ✅ **Automated Build System** - GitHub Actions working
2. ✅ **Easy Distribution** - APK/IPA ready for download
3. ✅ **Streamlined Testing** - Sideloadly installation
4. ✅ **Clear Documentation** - Klien bisa follow mudah
5. ✅ **Continuous Delivery** - Setiap push → build otomatis
6. ✅ **Professional Setup** - Enterprise-grade testing pipeline

---

## 📚 Quick Reference Links

| Dokumen | Tujuan |
|---------|--------|
| SETUP_UNTUK_KLIEN.md | 👉 START HERE untuk klien |
| SIDELOADLY_LENGKAP.md | Sideloadly installation guide |
| GITHUB_SECRETS_SETUP_LENGKAP.md | GitHub Secrets setup |
| WORKFLOW_VERIFICATION.md | Verify & troubleshoot |
| IMPLEMENTATION_CHECKLIST.md | Final checklist (Anda di sini) |

---

## 📝 Final Notes

```
1. Dokumentasi ini adalah "living document"
   → Update seiring dengan perubahan process
   → Share feedback dari client untuk improvement

2. Credentials adalah SENSITIVE data
   → Never commit ke repository
   → Safely store offline
   → Rotate jika ada concern

3. Continuous monitoring adalah KEY
   → Monitor build failures
   → Monitor app crashes
   → Quick response untuk issues

4. Client communication adalah CRITICAL
   → Clear expectations
   → Timely updates
   → Professional support
```

---

**Status:** ✅ READY FOR IMPLEMENTATION  
**Created:** September 16, 2026  
**Version:** 1.0  
**Next Step:** Execute checklist & declare GO-LIVE

---

**Good luck with your testing setup! 🚀**
