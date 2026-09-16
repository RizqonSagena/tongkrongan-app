# 🚀 Build & Test APK - GitHub Actions
**Tanggal:** September 16, 2026  
**Tujuan:** Trigger build APK dan download

---

## 📋 Prerequisites:

Sebelum mulai, pastikan:

```
✅ 4 GitHub Secrets sudah di-add
✅ upload-keystore.jks sudah tercipta
✅ Anda punya akses ke GitHub repository
```

---

## 🔄 STEP 1: Trigger APK Build Manual

### 1A. Buka GitHub Actions

```
Buka: https://github.com/RizqonSagena/tongkrongan-app/actions
```

### 1B. Pilih Workflow "Build Android APK"

```
Di sebelah kiri ada list workflows:
- Pilih: "Build Android APK"
- Klik nama workflow
```

### 1C. Klik "Run workflow"

```
Button "Run workflow" muncul (top-right)
Klik tombol tersebut
```

### 1D. Select Branch & Run

```
Branch dropdown: Pilih "main"
Klik green button: "Run workflow"

Status berubah: Queued → In Progress → Completed
```

---

## ⏱️ STEP 2: Monitor Build Progress

### Build akan jalankan steps ini:

```
Step 1:  ✓ Checkout code
Step 2:  ✓ Set up Java
Step 3:  ✓ Set up Flutter
Step 4:  ✓ Get dependencies
Step 5:  ✓ Run analysis
Step 6:  ✓ Decode Android signing key
Step 7:  ✓ Create Android keystore properties
Step 8:  🔄 Build APK (Release) ← LONGEST STEP (5-10 min)
Step 9:  ✓ Generate version tag
Step 10: ✓ Upload APK to Artifacts
Step 11: ✓ Post Build Status

Expected time: 15-20 minutes total
```

### Monitor dari halaman workflow:

```
1. Klik workflow run yang sedang berjalan
2. Scroll ke bawah untuk lihat step-by-step progress
3. Cari green checkmarks (✓) = success
4. Cari red X marks (❌) = failed step
5. Jika ada error, klik step untuk expand & lihat detail
```

---

## 📊 POSSIBLE OUTCOMES:

### ✅ SUCCESS (Build Completed)

```
Status: ✓ Completed (green checkmark)

Next:
1. Scroll ke bawah → "Artifacts" section
2. File "app-release.apk" harus ada
3. Click download
4. File size: 50-80 MB
```

### ❌ FAILED (Build Error)

```
Status: ✗ Failed (red X)

Troubleshoot:
1. Scroll ke atas cari step yang red
2. Click step untuk expand & lihat error message
3. Common errors:
   - Missing secret (check GitHub Secrets)
   - Invalid base64 (re-encode keystore)
   - Wrong password (verify passwords match)
4. Fix issue & retry workflow
```

---

## 📥 STEP 3: Download APK

### Jika Build SUCCESS:

1. **Buka workflow run yang completed**

2. **Scroll ke bawah - cari "Artifacts" section:**
   ```
   Artifacts
   ├── app-release-20260916_120000.apk (60 MB)
   ```

3. **Click nama artifact untuk download:**
   ```
   Nama: app-release-[timestamp].apk
   Size: ~60 MB (normal)
   ```

4. **File akan di-download ke Downloads folder**

5. **Verify file:**
   ```
   File size: 50-80 MB ✓
   Filename: app-release-*.apk ✓
   Bukan 0 bytes ✓
   ```

---

## 🧪 STEP 4: Test APK Manually (Optional)

Sebelum lanjut ke Sideloadly, verify APK bukan corrupt:

```powershell
# Di PowerShell:
# Check file size
Get-Item "Downloads\app-release-*.apk" | Select-Object Length

# Output contoh:
# Length: 68435456 (65 MB - good size)
```

---

## ✅ CHECKLIST:

Sebelum declare "BUILD SUCCESS":

```
✅ GitHub Actions workflow completed (green checkmark)
✅ APK file ada di Artifacts
✅ File size reasonable (50-80 MB)
✅ File bukan corrupt (bisa di-open dengan 7-zip)
✅ File downloaded ke local machine
✅ Filename: app-release-*.apk
```

---

## 🎯 NEXT STEPS:

Setelah APK ready:

1. ✅ **Download APK ke local**
2. ✅ **Download Sideloadly** (https://sideloadly.io)
3. ✅ **Connect Android device via USB**
4. ✅ **Install APK dengan Sideloadly** (2-5 menit)
5. ✅ **Test di device**

---

## 🐛 TROUBLESHOOTING:

| Problem | Solution |
|---------|----------|
| Build failed | Check GitHub Secrets (names & values) |
| APK not in Artifacts | Build failed - check logs above |
| "Decode failed" error | Base64 encoding error - re-encode keystore |
| "Bad decrypt" error | Wrong keystore password - verify password |
| Workflow timeout | Build took too long - check Flutter version |

---

## 📞 HELP:

Jika ada masalah:

1. **Check error message di build logs**
2. **Take screenshot of error**
3. **Verify GitHub Secrets** (correct names, correct values)
4. **Verify keystore file** (upload-keystore.jks exists)
5. **Retry workflow**

---

**Report hasil build! Success? atau ada error?** 👇
