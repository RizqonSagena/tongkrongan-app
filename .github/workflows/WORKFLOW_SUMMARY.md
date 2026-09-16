# GitHub Actions Workflow Setup Summary

## ✅ Status: READY

File alur kerja GitHub Actions telah dikonfigurasi dan siap digunakan untuk membangun aplikasi Flutter secara otomatis.

---

## 📦 Output Artifacts

Workflow `build_apps.yml` menghasilkan **2 file artefak** secara otomatis:

### 1. **android-apk**
- **File:** `app-release.apk`
- **Platform:** Android
- **Ukuran:** ~50-100 MB
- **Waktu Build:** ~45 menit
- **Status:** Release (unsigned)
- **Runner:** Ubuntu Latest

### 2. **ios-ipa-unsigned**
- **File:** `Runner.ipa`
- **Platform:** iOS
- **Ukuran:** ~100-200 MB
- **Waktu Build:** ~60 menit
- **Status:** Release (unsigned)
- **Runner:** macOS Latest

---

## 🚀 Cara Menggunakan

### **Automatic Build** (Recommended)
Push ke branch `main` atau `develop`:
```bash
git commit -m "Your message"
git push origin main
```
Build akan otomatis dimulai.

### **Manual Build**
1. Buka repository di GitHub
2. Klik tab **Actions**
3. Pilih **"Build Flutter Apps (APK & IPA)"**
4. Klik **"Run workflow"**
5. Klik **"Run workflow"** di dropdown

### **Via Pull Request**
Buat PR ke branch `main` dan workflow akan berjalan otomatis.

---

## 📊 Build Timeline

```
Triggers (Push/PR/Manual)
         ↓
   Checkout Code
         ↓
    ┌────┴────┐
    ↓         ↓
  Android   iOS
  (45 min) (60 min)
    ↓         ↓
    └────┬────┘
         ↓
    Completion Report
         ↓
   Artifacts Ready
```

**Total waktu:** ~60 menit (dijalankan paralel)

---

## 📥 Download Artifacts

1. **Buka:** GitHub → Actions
2. **Cari:** Latest "Build Flutter Apps (APK & IPA)" workflow run
3. **Download:**
   - `android-apk` - APK file untuk Android
   - `ios-ipa-unsigned` - IPA file untuk iOS (unsigned)

**Retention:** 30 hari

---

## 🔧 Configuration

### Environment Variables
```yaml
FLUTTER_VERSION: 3.24.0
JAVA_VERSION: 17
APP_NAME: tongkrongan_app
ARTIFACT_RETENTION_DAYS: 30
```

### Build Settings
- **Flutter Channel:** Stable
- **Build Mode:** Release (optimized)
- **Code Analysis:** Enabled (non-blocking)
- **Artifact Compression:** Disabled (untuk performa)
- **Cache:** Enabled (Gradle, Flutter, Pod)

---

## 📋 Jobs dalam Workflow

### 1. **build-android**
```
✅ Checkout code
✅ Setup Java 17
✅ Setup Flutter
✅ Get dependencies (pub get + clean)
✅ Analyze code
✅ Build APK Release
✅ Verify APK artifact
✅ Generate metadata
✅ Upload artifact
```

### 2. **build-ios**
```
✅ Checkout code
✅ Setup Flutter
✅ Get dependencies (pub get + clean)
✅ Analyze code
✅ Build iOS Release (no-codesign)
✅ Package as IPA
✅ Verify IPA artifact
✅ Generate metadata
✅ Upload artifact
```

### 3. **notify-completion**
```
✅ Check build status
✅ Report summary
✅ Show artifact info
```

---

## 🎯 Features

✅ **Parallel Builds** - Android & iOS dijalankan bersamaan
✅ **Automatic Artifacts** - File APK & IPA dihasilkan otomatis
✅ **Build Verification** - Validasi file sebelum upload
✅ **Metadata Tracking** - Timestamp & commit SHA tercatat
✅ **Error Handling** - Error handling komprehensif
✅ **Code Analysis** - Flutter analyze (non-blocking)
✅ **Caching** - Gradle, Flutter, dan Pod cache
✅ **Status Reporting** - Completion notification
✅ **Artifact Retention** - 30 hari penyimpanan
✅ **Environment Variables** - Mudah dikustomisasi

---

## 🔐 Security Notes

### Unsigned Builds
Kedua APK dan IPA dihasilkan dalam mode **unsigned**. Ini cocok untuk:
- Testing & development
- Internal distribution
- Pre-release builds

### Untuk Production Signing
Tambahkan secrets ke GitHub:
- `ANDROID_KEYSTORE_BASE64` - Android keystore
- `ANDROID_KEYSTORE_PASSWORD` - Keystore password
- `ANDROID_KEY_PASSWORD` - Key password
- `ANDROID_KEY_ALIAS` - Key alias
- `IOS_PROVISIONING_PROFILE_BASE64` - iOS profile
- `IOS_CERTIFICATE_BASE64` - iOS certificate
- `IOS_CERTIFICATE_PASSWORD` - Certificate password
- `KEYCHAIN_PASSWORD` - Keychain password

Lihat: `GITHUB_SECRETS_SETUP.md`

---

## 📂 Related Files

```
.github/workflows/
├── build_apps.yml                    ← Main workflow
├── BUILD_APPS_DOCUMENTATION.md       ← Full documentation
├── QUICK_BUILD_REFERENCE.md          ← Quick guide
├── WORKFLOW_SUMMARY.md               ← This file
├── build-android.yml                 ← Dedicated Android
├── build-ios.yml                     ← Dedicated iOS
└── TROUBLESHOOTING.md
```

---

## 📈 Build Performance

| Metric | Value |
|--------|-------|
| Android Build Time | ~45 minutes |
| iOS Build Time | ~60 minutes |
| Total Time (Parallel) | ~60 minutes |
| Artifact Retention | 30 days |
| Disk Space (APK) | ~50-100 MB |
| Disk Space (IPA) | ~100-200 MB |
| Cache Enabled | Yes |
| Timeout Protection | Yes |

---

## 🧪 Testing

### Test APK Locally
```bash
# Download artifact
# Install ke Android device
adb install -r app-release.apk
```

### Test IPA Locally
```bash
# Download artifact
# Use Sideloadly atau TestFlight untuk install
```

---

## 🆘 Troubleshooting

### Build Failed?
1. Cek logs di GitHub Actions
2. Scroll ke bawah untuk error messages
3. Common issues:
   - Dependencies not installed
   - Flutter version mismatch
   - Missing secrets (if signing enabled)
   - Timeout (increase timeout-minutes)

### Artifact Not Found?
1. Tunggu job selesai
2. Cek apakah ada error di step sebelumnya
3. Manual re-run workflow

### Need More Help?
- Baca: `BUILD_APPS_DOCUMENTATION.md`
- Cek: `TROUBLESHOOTING.md`
- Review: Workflow logs di GitHub Actions

---

## 📞 Quick Links

- **View Workflows:** https://github.com/YOUR_ORG/YOUR_REPO/actions
- **Workflow File:** `.github/workflows/build_apps.yml`
- **Full Docs:** `.github/workflows/BUILD_APPS_DOCUMENTATION.md`
- **Setup Guide:** `.github/workflows/GITHUB_SECRETS_SETUP.md`

---

## ✨ Next Steps

1. **Commit & Push** workflow files ke GitHub
2. **Verify** di Actions tab
3. **Download** artifacts setelah build selesai
4. **Test** APK & IPA di devices
5. **Setup Signing** (optional) untuk production builds

---

**Workflow Status:** ✅ READY TO USE
**Last Updated:** 2024
**Version:** 1.0
