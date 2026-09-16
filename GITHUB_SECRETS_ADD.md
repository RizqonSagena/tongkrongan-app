# 🔐 Add GitHub Secrets - Step by Step
**Tanggal:** September 16, 2026  
**Tujuan:** Add 4 Android Secrets ke GitHub untuk APK build

---

## 📋 CREDENTIALS YANG SUDAH READY:

```
Keystore Password:    Tongkrongan@2024
Key Password:         Tongkrongan@2024
Key Alias:            tongkrongan
Base64 String:        [copy dari clipboard]
```

---

## 🌐 STEP 1: Buka GitHub Secrets

1. **Buka GitHub Repository:**
   ```
   https://github.com/RizqonSagena/tongkrongan-app
   ```

2. **Klik Settings Tab:**
   ```
   Atau: https://github.com/RizqonSagena/tongkrongan-app/settings
   ```

3. **Di sidebar kiri, klik "Secrets and variables":**
   ```
   Secrets and variables → Actions
   ```

4. **Full URL:**
   ```
   https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
   ```

---

## ➕ STEP 2: Add Secret #1 - ANDROID_KEYSTORE_BASE64

1. **Klik tombol "New repository secret"** (warna hijau, top-right)

2. **Isi form:**
   ```
   Name: ANDROID_KEYSTORE_BASE64
   
   Value: [Paste base64 string dari clipboard]
          (String panjang ~2800+ characters)
   ```

3. **Klik "Add secret"**

4. **Verify:** Secret muncul di list

---

## ➕ STEP 3: Add Secret #2 - ANDROID_KEYSTORE_PASSWORD

1. **Klik "New repository secret" lagi**

2. **Isi form:**
   ```
   Name: ANDROID_KEYSTORE_PASSWORD
   
   Value: Tongkrongan@2024
   ```

3. **Klik "Add secret"**

---

## ➕ STEP 4: Add Secret #3 - ANDROID_KEY_PASSWORD

1. **Klik "New repository secret" lagi**

2. **Isi form:**
   ```
   Name: ANDROID_KEY_PASSWORD
   
   Value: Tongkrongan@2024
   ```

3. **Klik "Add secret"**

---

## ➕ STEP 5: Add Secret #4 - ANDROID_KEY_ALIAS

1. **Klik "New repository secret" lagi**

2. **Isi form:**
   ```
   Name: ANDROID_KEY_ALIAS
   
   Value: tongkrongan
   ```

3. **Klik "Add secret"**

---

## ✅ VERIFY: Semua 4 Secrets Sudah Ada

**Buka Secrets page lagi:**
```
https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions
```

**Harus terlihat:**
```
✓ ANDROID_KEY_ALIAS
✓ ANDROID_KEY_PASSWORD
✓ ANDROID_KEYSTORE_BASE64
✓ ANDROID_KEYSTORE_PASSWORD

Total: 4 secrets (jika ini pertama kali)
```

---

## 🎉 SELESAI!

4 GitHub Secrets sudah di-add! ✅

**Next:** Test build APK di GitHub Actions

---

## 📸 SCREENSHOT REFERENCE

**Halaman Secrets:**
```
┌─────────────────────────────────────────┐
│ Secrets and variables                   │
├─────────────────────────────────────────┤
│                                         │
│ Actions secrets:                        │
│ ✓ ANDROID_KEY_ALIAS                    │
│ ✓ ANDROID_KEY_PASSWORD                 │
│ ✓ ANDROID_KEYSTORE_BASE64              │
│ ✓ ANDROID_KEYSTORE_PASSWORD            │
│                                         │
│ [New repository secret] button (green)  │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🔒 Security Notes:

✅ Semua values sudah encrypted di GitHub  
✅ Hanya terlihat saat digunakan untuk build  
✅ Tidak bisa di-read kembali setelah di-save  
✅ Safe untuk di-commit!

---

**Report ketika semua 4 secrets sudah di-add!** 👇
