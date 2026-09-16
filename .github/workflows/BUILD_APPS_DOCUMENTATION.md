# GitHub Actions Workflow: Build Flutter Apps (APK & IPA)

**File:** `.github/workflows/build_apps.yml`

## 📋 Overview

Workflow otomatis ini membangun aplikasi Flutter untuk dua platform sekaligus:
- **Android**: Menghasilkan file APK (`android-apk`)
- **iOS**: Menghasilkan file IPA unsigned (`ios-ipa-unsigned`)

Kedua artefak dihasilkan secara paralel untuk mempercepat proses build.

---

## 🚀 Triggers

Workflow berjalan secara otomatis pada:

1. **Push ke branch utama**
   ```
   main, develop
   ```

2. **Pull Request** ke branch `main`

3. **Manual Trigger** (Workflow Dispatch)
   - Di GitHub: Actions → Build Flutter Apps → Run workflow

---

## 📦 Output Artifacts

| Nama Artifact | Platform | Berkas Output | Keterangan |
|---------------|----------|--------------|-----------|
| **android-apk** | Android | `app-release.apk` | APK siap distribusi (unsigned) |
| **ios-ipa-unsigned** | iOS | `Runner.ipa` | IPA unsigned untuk testing |

**Lokasi Download:**
- GitHub → Actions → Build Flutter Apps (workflow run) → Artifacts

**Retensi:** 30 hari

---

## 🔧 Konfigurasi Build

### Environment Variables
```yaml
FLUTTER_VERSION: 3.24.0      # Versi Flutter
JAVA_VERSION: 17              # Versi Java untuk Android
APP_NAME: tongkrongan_app     # Nama folder proyek
ARTIFACT_RETENTION_DAYS: 30   # Penyimpanan artefak
```

### Build Configuration

#### Android APK
- **Runner OS:** Ubuntu Latest
- **Timeout:** 45 menit
- **Build Mode:** Release (optimized)
- **Output Path:** `build/app/outputs/flutter-apk/app-release.apk`

#### iOS IPA
- **Runner OS:** macOS Latest
- **Timeout:** 60 menit
- **Build Mode:** Release (unsigned, no codesign)
- **Output Path:** `build/ios/iphoneos/` → `Runner.ipa`

---

## 📊 Job Flow

```
                    ┌─────────────────────┐
                    │   Code Checkout     │
                    └──────────┬──────────┘
                              │
                    ┌─────────┴────────┐
                    │                  │
        ┌───────────▼──────────┐  ┌───▼──────────────┐
        │   BUILD ANDROID APK  │  │  BUILD iOS IPA   │
        │  (Ubuntu - 45 min)   │  │ (macOS - 60 min) │
        └───────────┬──────────┘  └───┬──────────────┘
                    │                  │
                    │ android-apk      │ ios-ipa-unsigned
                    │                  │
                    └─────────┬────────┘
                              │
                    ┌─────────▼────────┐
                    │ NOTIFY COMPLETION │
                    └──────────────────┘
```

---

## ✅ Build Steps

### Android APK Build Steps
1. ✅ **Checkout code** - Ambil source code
2. ✅ **Setup Java** - Setup Java 17 + Gradle cache
3. ✅ **Setup Flutter** - Install Flutter 3.24.0
4. ✅ **Get dependencies** - `flutter pub get` + clean
5. ✅ **Analyze code** - Static analysis (non-blocking)
6. ✅ **Build APK** - `flutter build apk --release`
7. ✅ **Verify artifact** - Validasi file APK
8. ✅ **Generate metadata** - Timestamp & commit SHA
9. ✅ **Upload artifact** - Save ke GitHub Artifacts

### iOS IPA Build Steps
1. ✅ **Checkout code** - Ambil source code
2. ✅ **Setup Flutter** - Install Flutter 3.24.0
3. ✅ **Get dependencies** - `flutter pub get` + clean
4. ✅ **Analyze code** - Static analysis (non-blocking)
5. ✅ **Build iOS** - `flutter build ios --release --no-codesign`
6. ✅ **Package as IPA** - Buat struktur Payload & zip
7. ✅ **Verify artifact** - Validasi file IPA
8. ✅ **Generate metadata** - Timestamp & commit SHA
9. ✅ **Upload artifact** - Save ke GitHub Artifacts

### Completion Step
- ✅ **Report status** - Recap hasil build
- ✅ **Show artifact info** - Info download artefak

---

## 🛠️ Penggunaan

### Cara 1: Automatic Trigger (Recommended)
Push ke `main` atau `develop`:
```bash
git push origin main
```

### Cara 2: Manual Trigger
Di GitHub:
1. Actions tab
2. Pilih "Build Flutter Apps (APK & IPA)"
3. Klik "Run workflow"
4. Klik "Run workflow" di dropdown

### Cara 3: Pull Request
Buat PR ke `main`:
```bash
git checkout -b feature/xyz
git push -u origin feature/xyz
# Buat PR di GitHub
```

---

## 📥 Download Artifacts

1. **Go to:** GitHub → Repository → Actions
2. **Select:** Latest "Build Flutter Apps (APK & IPA)" workflow
3. **Download:**
   - `android-apk` - APK file
   - `ios-ipa-unsigned` - IPA file

---

## 🔍 Monitoring

### View Build Logs
1. Actions → Workflow Run
2. Lihat job mana yang running
3. Klik job untuk detail logs

### Common Issues & Solutions

| Issue | Solusi |
|-------|--------|
| APK Build Timeout | Increase timeout-minutes atau optimize dependencies |
| IPA Build Fails | Pastikan `ios/ExportOptions.plist` ada (untuk signed builds) |
| Artifact Not Found | Cek path output di build step |
| Cache Issues | Manual re-run dengan clear cache |

---

## 🔐 Security & Credentials

### Android Signing (Optional)
Untuk build release dengan signing:
```yaml
- Decode Android signing key
- Create Android keystore properties
```

**Required Secrets:**
- `ANDROID_KEYSTORE_BASE64` - Base64 encoded keystore
- `ANDROID_KEYSTORE_PASSWORD` - Keystore password
- `ANDROID_KEY_PASSWORD` - Key password
- `ANDROID_KEY_ALIAS` - Key alias

### iOS Signing (Optional)
Untuk build release dengan signing:
```yaml
- Decode provisioning profile
- Decode signing certificate
```

**Required Secrets:**
- `IOS_PROVISIONING_PROFILE_BASE64`
- `IOS_CERTIFICATE_BASE64`
- `KEYCHAIN_PASSWORD`
- `IOS_CERTIFICATE_PASSWORD`

**Setup Guide:** Lihat `GITHUB_SECRETS_SETUP.md`

---

## 📈 Performance Tips

1. **Use GitHub Actions Cache:**
   - Gradle cache (Android)
   - Flutter cache (Both)
   - Pod cache (iOS)

2. **Parallel Builds:**
   - Android & iOS dijalankan bersamaan
   - Hemat ~60% waktu build total

3. **Artifact Compression:**
   - Disabled untuk performa maksimal
   - Set `compression-level: 0`

4. **Cleanup:**
   - Automatic cleanup setelah retention period
   - Default: 30 hari

---

## 🧪 Testing Artifacts Locally

### Test Android APK
```bash
# Download artifact
# Install ke device
adb install app-release.apk

# Atau gunakan Sideloadly
```

### Test iOS IPA
```bash
# Download artifact
# Extract IPA (zip format)
unzip Runner.ipa

# Inspect contents
ls -lah Payload/

# Use Sideloadly untuk install
```

---

## 📝 Customization

### Edit Workflow
File: `.github/workflows/build_apps.yml`

### Change Flutter Version
```yaml
env:
  FLUTTER_VERSION: 3.24.0  # Change here
```

### Change App Name
```yaml
env:
  APP_NAME: tongkrongan_app  # Change here
```

### Change Artifact Retention
```yaml
env:
  ARTIFACT_RETENTION_DAYS: 30  # Change here
```

### Add Build Variants
Edit build steps untuk `--dart-define` atau flavor:
```bash
flutter build apk --release \
  --dart-define=FLAVOR=production
```

---

## 🔗 Related Files

- `.github/workflows/build-android.yml` - Dedicated Android workflow
- `.github/workflows/build-ios.yml` - Dedicated iOS workflow
- `tongkrongan_app/pubspec.yaml` - Flutter dependencies
- `tongkrongan_app/android/` - Android configuration
- `tongkrongan_app/ios/` - iOS configuration

---

## 📞 Support

Untuk bantuan:
1. Check GitHub Actions logs
2. Review error messages
3. Verify secrets & credentials
4. Check Flutter version compatibility
5. Consult workflow documentation

---

## ✨ Features

✅ Parallel builds (Android & iOS)
✅ Automatic artifact generation
✅ Build verification
✅ Metadata tracking (timestamp, commit)
✅ Comprehensive logging
✅ Error handling
✅ Artifact retention management
✅ Status reporting
✅ No-blocking code analysis
✅ Environment variable configuration

---

**Last Updated:** 2024
**Version:** 1.0
