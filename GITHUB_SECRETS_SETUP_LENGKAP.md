# 🔐 Panduan Setup GitHub Secrets - Lengkap & Praktis
**Versi:** 2.0  
**Tanggal:** September 16, 2026  
**Status:** Siap untuk Setup

---

## 📋 Overview: Apa itu GitHub Secrets?

GitHub Secrets adalah tempat menyimpan data sensitif (passwords, API keys, certificates) di GitHub secara aman. Data disimpan **encrypted** dan tidak bisa dilihat di repository.

**Contoh secrets yang diperlukan:**
- Android keystore file (signing key untuk APK)
- iOS certificate & provisioning profile (untuk sign IPA)
- Passwords untuk signing
- Sideloadly API keys (opsional)

**Total yang diperlukan: 10 secrets (bisa lebih)**

---

## 🎯 QUICK START (5 Menit)

Jika Anda sudah punya semua file, ikuti ini:

### Secrets yang WAJIB ditambahkan:

| # | Name | Required | Deskripsi |
|---|------|----------|-----------|
| 1 | `ANDROID_KEYSTORE_BASE64` | ✅ WAJIB | Android signing key (base64) |
| 2 | `ANDROID_KEYSTORE_PASSWORD` | ✅ WAJIB | Password untuk keystore |
| 3 | `ANDROID_KEY_PASSWORD` | ✅ WAJIB | Password untuk key |
| 4 | `ANDROID_KEY_ALIAS` | ✅ WAJIB | Alias nama key (biasanya: tongkrongan) |
| 5 | `IOS_CERTIFICATE_BASE64` | ✅ WAJIB | iOS certificate (.p12) base64 |
| 6 | `IOS_CERTIFICATE_PASSWORD` | ✅ WAJIB | Password untuk certificate |
| 7 | `IOS_PROVISIONING_PROFILE_BASE64` | ✅ WAJIB | iOS provisioning profile base64 |
| 8 | `KEYCHAIN_PASSWORD` | ✅ WAJIB | Keychain password (any secure password) |

### Secrets OPSIONAL (untuk auto-install):

| # | Name | Required | Deskripsi |
|---|------|----------|-----------|
| 9 | `SIDELOADLY_API_KEY` | ⭕ OPSIONAL | Untuk auto-install ke device |
| 10 | `SIDELOADLY_DEVICE_ID` | ⭕ OPSIONAL | Device ID untuk auto-install |

---

## 📌 PENTING: Sebelum Mulai

### ✅ Checklist Persiapan:

Pastikan Anda SUDAH PUNYA:

**UNTUK ANDROID:**
- ☐ File: `upload-keystore.jks` (Android signing key)
- ☐ Keystore password
- ☐ Key password
- ☐ Key alias (atau catat: "tongkrongan")

**UNTUK iOS:**
- ☐ File: `certificate.p12` (iOS signing certificate)
- ☐ Certificate password
- ☐ File: `profile.mobileprovision` (iOS provisioning profile)

**CATATAN:** Jika tidak punya file-file di atas, **SKIP ke section "Jika Tidak Punya File Credentials"** di bawah.

---

## 🚀 STEP 1: Akses GitHub Repository

1. **Buka GitHub:**
   ```
   https://github.com/RizqonSagena/tongkrongan-app
   ```

2. **Login dengan akun GitHub Anda:**
   ```
   Username / Email: [your github email]
   Password: [your github password]
   ```

3. **Verifikasi Anda adalah Owner/Admin:**
   ```
   - Harus punya akses ke Settings tab
   - Jika tidak ada Settings, minta owner untuk add Anda sebagai Collaborator
   ```

---

## 🔑 STEP 2: Persiapkan Android Secrets

### 2A: Encode upload-keystore.jks ke Base64

Anda perlu convert file `.jks` menjadi base64 string.

#### CARA 1: Windows PowerShell (RECOMMENDED)

```powershell
# Buka PowerShell di folder yang ada file upload-keystore.jks

# Contoh path:
# C:\Users\[YourName]\Documents\tongkrongan_app\android\app\upload-keystore.jks

# Jalankan command ini:
$data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
[Convert]::ToBase64String($data) | Set-Clipboard

# Output: Base64 string sudah di clipboard
# Paste ke notepad atau text editor untuk temporary save
```

**Verifikasi output:**
```
String mulai dengan: MIIJrAIBAzCC... (random characters)
String sangat panjang: ~5000+ characters
```

#### CARA 2: Online Tool (Jika PowerShell tidak bisa)

1. **Buka website:** https://www.base64encode.org/
2. **Upload file:** `upload-keystore.jks`
3. **Click "Encode"**
4. **Copy hasil encoding**

#### CARA 3: Mac / Linux

```bash
# Buka Terminal di folder dengan upload-keystore.jks

# Convert ke base64:
base64 -i upload-keystore.jks | pbcopy

# Di Linux:
base64 -w 0 upload-keystore.jks | xclip -selection clipboard
```

---

### 2B: Siapkan Android Credentials

Siapkan informasi ini (catat di notepad sementara):

```
1. ANDROID_KEYSTORE_BASE64
   Value: [base64 string hasil encode upload-keystore.jks]
   
   Contoh format (jangan copy ini!):
   MIIJrAIBAzCCCXgGCSqGSIb3DQEBBQUAMIIJcjCCC...

2. ANDROID_KEYSTORE_PASSWORD
   Value: [password untuk keystore]
   
   Contoh:
   MyKeystorePass123!

3. ANDROID_KEY_PASSWORD
   Value: [password untuk key]
   
   Contoh:
   MyKeyPass456!

4. ANDROID_KEY_ALIAS
   Value: tongkrongan
   
   (Hampir pasti "tongkrongan", verify di keytool)
```

---

## 🍎 STEP 3: Persiapkan iOS Secrets

### 3A: Encode certificate.p12 ke Base64

#### CARA 1: Windows PowerShell

```powershell
# Buka PowerShell di folder yang ada file certificate.p12

$data = [System.IO.File]::ReadAllBytes("certificate.p12")
[Convert]::ToBase64String($data) | Set-Clipboard

# Paste ke notepad temporary save
```

#### CARA 2: Mac Terminal

```bash
base64 -i certificate.p12 | pbcopy
```

#### CARA 3: Online Tool

1. Buka: https://www.base64encode.org/
2. Upload: `certificate.p12`
3. Click Encode
4. Copy hasil

---

### 3B: Encode profile.mobileprovision ke Base64

Sama dengan certificate.p12:

#### CARA 1: Windows PowerShell

```powershell
$data = [System.IO.File]::ReadAllBytes("profile.mobileprovision")
[Convert]::ToBase64String($data) | Set-Clipboard
```

#### CARA 2: Mac Terminal

```bash
base64 -i profile.mobileprovision | pbcopy
```

---

### 3C: Siapkan iOS Credentials

Catat informasi ini:

```
1. IOS_CERTIFICATE_BASE64
   Value: [base64 string dari certificate.p12]
   
   Format: MIIIhgIBAzCCCGo...

2. IOS_CERTIFICATE_PASSWORD
   Value: [password untuk certificate]
   
   Contoh:
   CertificatePass789!

3. IOS_PROVISIONING_PROFILE_BASE64
   Value: [base64 string dari profile.mobileprovision]
   
   Format: H4sICNxxx...

4. KEYCHAIN_PASSWORD
   Value: [any secure password untuk keychain saat build]
   
   Contoh:
   SecureKeychain123!@
   
   (Bisa dibuat sembarangan, hanya dipakai internal GitHub Actions)
```

---

## 🔐 STEP 4: Add Secrets ke GitHub

### 4A: Buka GitHub Secrets Page

1. **Pergi ke GitHub Settings:**
   ```
   Repository → Settings → Secrets and variables → Actions
   ```
   
   Atau langsung: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions

2. **Verifikasi halaman:**
   ```
   Anda akan melihat:
   - Tombol besar "New repository secret" (warna hijau)
   - List kosong atau existing secrets
   ```

---

### 4B: Add Secret #1: ANDROID_KEYSTORE_BASE64

1. **Klik tombol "New repository secret"**

2. **Isi form:**
   ```
   Name: ANDROID_KEYSTORE_BASE64
   Value: [paste base64 string yang sudah di-encode]
   ```

3. **Klik "Add secret"**

4. **Verifikasi:**
   ```
   Secret muncul di list dengan name "ANDROID_KEYSTORE_BASE64"
   ```

---

### 4C: Add Secret #2: ANDROID_KEYSTORE_PASSWORD

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: ANDROID_KEYSTORE_PASSWORD
   Value: [password untuk keystore]
   ```

3. **Klik "Add secret"**

---

### 4D: Add Secret #3: ANDROID_KEY_PASSWORD

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: ANDROID_KEY_PASSWORD
   Value: [password untuk key]
   ```

3. **Klik "Add secret"**

---

### 4E: Add Secret #4: ANDROID_KEY_ALIAS

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: ANDROID_KEY_ALIAS
   Value: tongkrongan
   ```

3. **Klik "Add secret"**

---

### 4F: Add Secret #5: IOS_CERTIFICATE_BASE64

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: IOS_CERTIFICATE_BASE64
   Value: [paste base64 string dari certificate.p12]
   ```

3. **Klik "Add secret"**

---

### 4G: Add Secret #6: IOS_CERTIFICATE_PASSWORD

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: IOS_CERTIFICATE_PASSWORD
   Value: [password untuk certificate]
   ```

3. **Klik "Add secret"**

---

### 4H: Add Secret #7: IOS_PROVISIONING_PROFILE_BASE64

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: IOS_PROVISIONING_PROFILE_BASE64
   Value: [paste base64 string dari profile.mobileprovision]
   ```

3. **Klik "Add secret"**

---

### 4I: Add Secret #8: KEYCHAIN_PASSWORD

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: KEYCHAIN_PASSWORD
   Value: SecureKeychain123!@
   
   (Bisa apa saja, gunakan password yang aman)
   ```

3. **Klik "Add secret"**

---

### 4J (OPSIONAL): Add Secret #9: SIDELOADLY_API_KEY

**SKIP jika tidak ada akun Sideloadly Pro.**

Jika punya:

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: SIDELOADLY_API_KEY
   Value: [API key dari Sideloadly account]
   ```

3. **Klik "Add secret"**

---

### 4K (OPSIONAL): Add Secret #10: SIDELOADLY_DEVICE_ID

**SKIP jika tidak ada akun Sideloadly Pro.**

Jika punya:

1. **Klik "New repository secret"**

2. **Isi:**
   ```
   Name: SIDELOADLY_DEVICE_ID
   Value: [device ID dari Sideloadly]
   ```

3. **Klik "Add secret"**

---

## ✅ STEP 5: Verifikasi Semua Secrets Sudah Ditambah

1. **Buka GitHub Secrets page lagi:**
   ```
   https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
   ```

2. **Verifikasi checklist:**
   ```
   ✓ ANDROID_KEY_ALIAS
   ✓ ANDROID_KEY_PASSWORD
   ✓ ANDROID_KEYSTORE_BASE64
   ✓ ANDROID_KEYSTORE_PASSWORD
   ✓ IOS_CERTIFICATE_BASE64
   ✓ IOS_CERTIFICATE_PASSWORD
   ✓ IOS_PROVISIONING_PROFILE_BASE64
   ✓ KEYCHAIN_PASSWORD
   
   (Optional)
   ✓ SIDELOADLY_API_KEY
   ✓ SIDELOADLY_DEVICE_ID
   ```

3. **Pastikan tidak ada typo di nama:**
   ```
   Case-sensitive! Harus EXACT match dengan workflow files.
   
   Contoh yang SALAH:
   - android_keystore_base64 (lowercase)
   - ANDROID_KEYSTORE (kurang "_BASE64")
   
   Harus:
   - ANDROID_KEYSTORE_BASE64 (uppercase, exact)
   ```

---

## 🚨 TROUBLESHOOTING: Jika Tidak Punya File Credentials

### Scenario 1: Tidak Ada upload-keystore.jks (Android)

**Generate keystore baru:**

```powershell
# Buka PowerShell/Command Prompt di folder:
# tongkrongan_app\android\app\

cd tongkrongan_app\android\app\

# Generate keystore dengan keytool:
keytool -genkey -v -keystore upload-keystore.jks `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias tongkrongan `
  -storepass MyKeystorePassword123 `
  -keypass MyKeyPassword456 `
  -dname "CN=Tongkrongan,O=Tongkrongan,C=ID"

# Result:
# File upload-keystore.jks tercipta
```

**Catat passwords yang digunakan:**
```
Keystore password: MyKeystorePassword123
Key password: MyKeyPassword456
Key alias: tongkrongan
```

---

### Scenario 2: Tidak Ada certificate.p12 & profile.mobileprovision (iOS)

**Anda memerlukan Apple Developer Account:**

Ini kompleks dan memerlukan akses ke Apple Developer portal. Ada 2 options:

#### Option A: Gunakan TestFlight (Recommended untuk testing)

TestFlight tidak butuh custom certificate, lebih mudah:

1. Buka: https://developer.apple.com
2. Login dengan Apple ID
3. Certificates, Identifiers & Profiles → App IDs
4. Create App ID: `com.stitch.tongkrongan`
5. Create provisioning profile otomatis
6. Download certificate + profile

**Referensi:**
- Apple Developer: https://developer.apple.com
- Flutter iOS Signing: https://flutter.dev/docs/deployment/ios

#### Option B: Hire Developer dengan Mac

Karena build iOS hanya bisa di Mac, recommend untuk hire developer dengan Mac untuk:
1. Generate certificates
2. Setup provisioning profiles
3. Build IPA di Mac
4. Export dan berikan IPA ke Anda

---

### Scenario 3: Sudah Punya Tapi File Hilang

**Recover dari existing app:**

Jika app sudah published di:
- Android: Google Play Store
- iOS: App Store

Anda bisa export/recover signing keys dari platform tersebut.

**Untuk Android Play Store:**

```
1. Buka: https://play.google.com/console
2. Pilih app: Tongkrongan
3. Release → Setup → App signing
4. Download signing key (jika available)
```

**Untuk iOS App Store:**

```
1. Buka: https://appstoreconnect.apple.com
2. Pilih app: Tongkrongan
3. Buka Xcode pada Mac
4. Xcode → Preferences → Accounts
5. Download signing certificates
```

---

## 🧪 STEP 6: Test GitHub Actions Build

Setelah semua secrets ditambah, test build:

### 6A: Trigger Manual Build

1. **Buka GitHub Actions:**
   ```
   Repository → Actions tab
   ```

2. **Pilih workflow "Build Android APK":**
   ```
   Klik nama workflow di list
   ```

3. **Klik "Run workflow":**
   ```
   Tombol "Run workflow" (top-right)
   Pilih branch: main
   Klik "Run workflow" button
   ```

4. **Monitor build:**
   ```
   Status akan update:
   🟡 Queued
   🟡 In Progress (ubuntu-latest runner)
   ✅ Completed atau ❌ Failed
   
   Waktu: ~15 menit
   ```

5. **Check hasil:**
   ```
   Jika ✅ Completed:
   - Klik workflow run
   - Scroll ke bawah "Artifacts"
   - Download "app-release-*.apk"
   - File size: ~60 MB
   
   Jika ❌ Failed:
   - Scroll ke atas lihat error messages
   - Common errors:
     * Missing secrets (check nama)
     * Invalid base64 encoding
     * Keystore password salah
   ```

---

### 6B: Trigger iOS Build

Sama seperti Android:

1. **Actions tab → "Build iOS IPA" workflow**
2. **Klik "Run workflow"**
3. **Monitor progress (~25 menit)**
4. **Download IPA dari Artifacts**

---

## 📊 Checklist Selesai

- [ ] Sudah prepare semua credential files
- [ ] Encode ke base64 semua secrets
- [ ] Add semua 8 required secrets ke GitHub
- [ ] Verifikasi semua secrets sudah ada (dan nama tidak typo)
- [ ] Test build Android → APK downloaded
- [ ] Test build iOS → IPA downloaded
- [ ] APK install sukses dengan Sideloadly
- [ ] IPA install sukses dengan Sideloadly
- [ ] App bisa dibuka di device

---

## 📞 Referensi & Links

| Topik | Link |
|-------|------|
| GitHub Secrets Docs | https://docs.github.com/en/actions/security-guides/encrypted-secrets |
| Flutter Build APK | https://flutter.dev/docs/deployment/android |
| Flutter Build IPA | https://flutter.dev/docs/deployment/ios |
| Base64 Encode Tool | https://www.base64encode.org/ |
| Sideloadly Download | https://sideloadly.io |
| GitHub Actions Setup | https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions |

---

## 🎉 Setup Complete!

Jika semua sudah selesai:

1. ✅ Secrets sudah di GitHub
2. ✅ Build Android APK berhasil
3. ✅ Build iOS IPA berhasil
4. ✅ App install dengan Sideloadly
5. ✅ Testing bisa mulai

Setiap push ke `main` branch, GitHub Actions akan:
- Automatically build APK
- Automatically build IPA
- Automatically upload ke Artifacts
- Ready untuk download dan test!

---

## ⚠️ Security Notes

1. **Jangan share secrets di public:**
   - Base64 strings adalah encoded, bukan encrypted
   - Siapa pun yang punya string bisa decode ke file asli
   - JANGAN commit ke repository
   - JANGAN share di chat / email

2. **Keychain Password:**
   - Password ini hanya dipakai di GitHub Actions
   - Tidak disimpan di device Anda
   - Bisa di-change kapan saja

3. **Backup Credentials:**
   - Simpan credential files di safe place (external HDD / cloud encrypted)
   - Jangan hanya di satu tempat

---

**Status:** Ready for Testing  
**Last Updated:** September 16, 2026  
**Version:** 2.0

**Butuh help?** Check SETUP_UNTUK_KLIEN.md untuk panduan testing lengkap.
