# 🔑 Generate Android Keystore BARU - Setup Dari Nol
**Status:** Fresh Start  
**Tanggal:** September 16, 2026

---

## ✨ Credentials Baru Untuk Testing

Saya akan generate **Android Keystore BARU** dengan password yang jelas untuk testing.

---

## 🔧 STEP 1: Generate Keystore Baru

**Buka PowerShell di folder project:**

```powershell
# Navigate ke android/app folder
cd "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app"

# Generate keystore BARU dengan password yang jelas:
keytool -genkey -v -keystore upload-keystore.jks `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias tongkrongan `
  -storepass "Tongkrongan@2024" `
  -keypass "Tongkrongan@2024" `
  -dname "CN=Tongkrongan,O=Tongkrongan,C=ID"

# Hasil: File upload-keystore.jks tercipta di folder tersebut
```

**Ketika di-run, output akan seperti:**
```
Generating 2,048 bit RSA key pair and self-signed certificate...
Done!
upload-keystore.jks tercipta
```

---

## ✅ CREDENTIALS UNTUK TESTING:

Simpan informasi ini - PENTING untuk GitHub Secrets:

```
📌 ANDROID KEYSTORE CREDENTIALS (untuk testing)
═══════════════════════════════════════════════

Keystore File: upload-keystore.jks
Location: tongkrongan_app/android/app/upload-keystore.jks

🔐 PASSWORDS (Catat ini!):
─────────────────────────
Keystore Password: Tongkrongan@2024
Key Password:      Tongkrongan@2024
Key Alias:         tongkrongan

Status: ✅ READY
```

---

## 📋 NEXT STEPS:

1. ✅ **Run command di atas di PowerShell**
2. ✅ **Confirm file tercipta:** `upload-keystore.jks`
3. ✅ **Catat passwords** (sudah di atas)
4. ✅ **Encode ke base64** (STEP 2 di bawah)
5. ✅ **Add GitHub Secrets** (STEP 3)
6. ✅ **Test build APK** (STEP 4)

---

## 🔐 STEP 2: Encode Keystore ke Base64

**Di PowerShell yang sama:**

```powershell
# Masih di folder: tongkrongan_app/android/app

# Encode keystore ke base64:
$data = [System.IO.File]::ReadAllBytes("upload-keystore.jks")
$base64 = [Convert]::ToBase64String($data)
$base64 | Set-Clipboard

# Copy output:
Write-Host "Base64 string sudah di clipboard (siap di-paste)"
Write-Host "String length: $($base64.Length) characters"
```

**Output contoh:**
```
Base64 string sudah di clipboard (siap di-paste)
String length: 2847 characters
```

✅ Base64 string sudah siap di clipboard!

---

## 📌 GITHUB SECRETS - Siap untuk di-add:

Setelah base64 di-copy, siapkan ini untuk GitHub:

```
Secret #1: ANDROID_KEYSTORE_BASE64
Value: [base64 string dari atas - paste dari clipboard]

Secret #2: ANDROID_KEYSTORE_PASSWORD
Value: Tongkrongan@2024

Secret #3: ANDROID_KEY_PASSWORD
Value: Tongkrongan@2024

Secret #4: ANDROID_KEY_ALIAS
Value: tongkrongan
```

---

## ✅ VERIFICATION:

**Check file tercipta:**

```powershell
# Di PowerShell:
ls -lah upload-keystore.jks

# Output contoh:
# -rw-r--r-- 1 user staff 2567 Sep 16 12:00 upload-keystore.jks
```

File size harus: **2-3 KB** ✅

---

## 🚀 READY?

Setelah semua done:

1. ✅ `upload-keystore.jks` tercipta
2. ✅ Base64 string di clipboard
3. ✅ Passwords tercatat

**Next:** Add 4 GitHub Secrets!

---

**Ketik di PowerShell command di atas, lalu report hasilnya!** 👇
