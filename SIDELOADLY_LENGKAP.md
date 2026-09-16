# 🔧 Panduan Lengkap Sideloadly untuk APK & IPA Testing
**Versi:** 1.0  
**Tanggal:** September 16, 2026  
**Status:** Siap untuk Testing

---

## 📱 Apa itu Sideloadly?

**Sideloadly** adalah aplikasi desktop gratis yang memungkinkan Anda:
- ✅ Install APK ke Android tanpa Google Play Store
- ✅ Install IPA ke iOS tanpa TestFlight (requires Apple ID)
- ✅ Install siap dari file lokal (build APK/IPA)
- ✅ Install otomatis dari GitHub Actions

**Keuntungan:**
- ✓ Gratis
- ✓ Mudah digunakan
- ✓ Support Mac & Windows
- ✓ Testing pre-release app

---

## 🖥️ STEP 1: Download dan Install Sideloadly

### Windows

1. **Download dari website:**
   ```
   URL: https://sideloadly.io
   Klik: "Download for Windows"
   File: SideloadlySetup.exe (~30 MB)
   ```

2. **Install:**
   ```
   - Double-click SideloadlySetup.exe
   - Windows SmartScreen popup muncul
   - Klik "More info" → "Run anyway"
   - Wizard muncul, klik Next
   - Accept Terms
   - Klik Install
   - Selesai, aplikasi auto-launch
   ```

3. **Verifikasi:**
   ```
   - Aplikasi Sideloadly membuka di PC
   - Anda akan melihat interface dengan tombol "Install"
   - Menu "Settings" di atas
   ```

### macOS

1. **Download:**
   ```
   URL: https://sideloadly.io
   Klik: "Download for macOS"
   File: Sideloadly.dmg (~40 MB)
   ```

2. **Install:**
   ```
   - Double-click Sideloadly.dmg
   - Drag aplikasi Sideloadly ke "Applications" folder
   - Buka Applications → Sideloadly
   ```

3. **Permissions (jika diminta):**
   ```
   - System minta permission untuk app
   - Klik "Open"
   - Enter Mac password jika diminta
   ```

---

## 🤖 STEP 2: Setup Android untuk Sideloadly

### A. Enable USB Debugging di Android Phone

**Untuk Android 12+:**

1. **Buka Settings:**
   ```
   Phone Settings → About Phone
   ```

2. **Tap Build Number 7x:**
   ```
   Scroll ke bawah cari "Build Number"
   Contoh: "Build number 14.0.1.5.TMAMIX"
   Tap 7x dengan cepat
   Toast muncul: "You are now a developer!"
   ```

3. **Buka Developer Options:**
   ```
   Back ke Settings
   Cari "Developer options" atau "Developer Options"
   Tap untuk buka
   ```

4. **Enable USB Debugging:**
   ```
   Cari: "USB Debugging" atau "USB debugging"
   Toggle ke ON ✓
   ```

5. **Optional: Disable Password Protection:**
   ```
   Settings → Security → Screen lock
   Ganti ke "None" atau "Swipe"
   (Agar saat connect tidak keluar lock screen)
   ```

**Catatan untuk berbagai brand:**

- **Samsung:** Settings → About Phone → Build Number (7x) → Developer Options
- **Xiaomi/POCO:** Settings → About Phone → MIUI Version (7x) → Developer Options
- **Realme:** Settings → About Phone → Build Version (7x) → Developer Options
- **Oppo/Vivo:** Settings → About Phone → Version (7x) → Developer Options

---

### B. Connect Android ke PC

1. **Siapkan USB Cable:**
   ```
   Gunakan original cable atau quality cable
   Jangan gunakan cable yang rusak
   ```

2. **Connect ke PC:**
   ```
   - Plug cable ke phone
   - Plug cable ke PC/Mac
   - Tunggu 2-3 detik
   ```

3. **di Android Phone (muncul popup):**
   ```
   "Allow USB Debugging?"
   Tap: "Allow"
   
   OR
   
   "Allow access to device data?"
   Tap: "Allow"
   ```

4. **Verifikasi di PC:**
   ```
   - Settings → Device Management (Windows)
     Atau cek di File Explorer → This PC
   - Phone harus muncul sebagai device
   ```

---

### C. Cek Connection di Sideloadly

1. **Buka Sideloadly:**
   ```
   Windows: Start → Sideloadly
   Mac: Applications → Sideloadly
   ```

2. **Cek Device Dropdown:**
   ```
   Top area ada dropdown: "Select Device"
   Dropdown harus menunjukkan Android phone Anda
   Contoh: "Samsung Galaxy S21"
   ```

3. **Jika device tidak muncul:**
   ```
   Troubleshoot:
   - Check USB Debugging is ON
   - Disconnect USB → reconnect
   - Restart Sideloadly
   - Restart Android phone
   - Try different USB cable
   - Try different USB port
   ```

---

## 🍎 STEP 3: Setup iOS untuk Sideloadly

### A. Enable Developer Mode di iOS Device

**iOS 15+:**

1. **Settings → Privacy & Security:**
   ```
   Settings app
   Scroll down → Privacy & Security
   ```

2. **Cari Developer Mode:**
   ```
   Scroll ke bawah di Privacy & Security
   Tap "Developer Mode"
   Toggle ke ON
   ```

3. **Confirm jika muncul popup:**
   ```
   "Enable Developer Mode?"
   Tap "Enable"
   iPhone akan restart
   Tunggu ~30 detik
   ```

**iOS 14 dan lebih lama:**
```
Developer Mode tidak diperlukan
Langsung ke step B
```

---

### B. Trust Computer Certificate

1. **Connect iPhone ke Mac/PC:**
   ```
   - Plug Lightning/USB-C cable ke iPhone
   - Plug cable ke PC/Mac
   ```

2. **Di iPhone (muncul popup):**
   ```
   "Trust This Computer?"
   Tap: "Trust"
   ```

3. **Enter Passcode:**
   ```
   Jika iPhone minta, masukkan passcode
   ```

4. **Di Mac/PC:**
   ```
   Windows: Notification muncul di taskbar
   Mac: Jika ada prompt, klik "Allow"
   ```

---

### C. Verify Connection di Sideloadly

1. **Buka Sideloadly:**
   ```
   Mac: Applications → Sideloadly
   Windows: Start → Sideloadly
   ```

2. **Cek Device Dropdown:**
   ```
   Top area: "Select Device"
   Dropdown harus menunjukkan iPhone Anda
   Contoh: "iPhone 14 Pro"
   ```

3. **Jika device tidak muncul:**
   ```
   Troubleshoot:
   - Reconnect USB cable
   - Trust again jika prompted
   - Restart Sideloadly
   - Restart iPhone
   - Update Xcode (Mac only): xcode-select --install
   ```

---

## 📦 STEP 4: Install APK (Android)

### Setup Selesai? Mari Install!

1. **Buka Sideloadly:**
   ```
   Pastikan Sideloadly sudah running
   ```

2. **Select Device:**
   ```
   Dropdown "Select Device" → Pilih Android phone Anda
   ```

3. **Click "Select App" Button:**
   ```
   Large button di tengah: "Select App" atau "..."
   Atau drag-drop file APK ke window
   ```

4. **Browse ke APK File:**
   ```
   File browser terbuka
   Cari file: app-release.apk
   Biasanya di: Downloads folder
   Click "Open" atau "Select"
   ```

5. **Verify APK Info:**
   ```
   Sideloadly menampilkan:
   - App name: "Tongkrongan"
   - App icon: Tongkrongan logo
   - Version: (contoh v1.0.0)
   - Size: ~60 MB
   ```

6. **Click "Install" Button:**
   ```
   Large blue/colored button: "Install"
   Proses dimulai
   ```

7. **Monitor Progress:**
   ```
   Progress bar menunjukkan:
   - Uploading: 0% → 100%
   - Installing: 0% → 100%
   - Verifying: ✓
   
   Estimated time: 2-5 menit
   ```

8. **Installation Complete!:**
   ```
   Status muncul: "✓ Installation Completed"
   atau "Installation Successful"
   ```

9. **Open App:**
   ```
   Di Android phone:
   Home screen → Tap "Tongkrongan" icon
   Atau Settings → Apps → Tongkrongan → Open
   ```

---

## 🍎 STEP 5: Install IPA (iOS)

### Setup Selesai? Mari Install!

1. **Buka Sideloadly:**
   ```
   Pastikan running dan iPhone terhubung
   ```

2. **Select Device:**
   ```
   Dropdown "Select Device" → Pilih iPhone Anda
   ```

3. **Click "Select App" Button:**
   ```
   Button di tengah: "Select App" atau drag-drop IPA file
   ```

4. **Browse ke IPA File:**
   ```
   File browser terbuka
   Cari: app-release.ipa
   Biasanya di: Downloads folder
   Click "Open"
   ```

5. **Enter Apple ID:**
   ```
   Popup muncul: "Apple ID Login"
   Email: Masukkan Apple ID email
   Password: Masukkan password
   
   Klik "Next"
   ```

6. **Verify Apple ID:**
   ```
   Jika ada 2FA (Two-Factor Authentication):
   - Check email atau notification di trusted device
   - Masukkan 6-digit code yang diterima
   - Klik "Verify"
   ```

7. **Monitor Installation:**
   ```
   Progress bar:
   - Extracting: 0% → 100%
   - Resigning: 0% → 100%
   - Installing: 0% → 100%
   
   Waktu: 3-8 menit
   ```

8. **Installation Complete!:**
   ```
   Status: "✓ Installation Completed"
   Atau "Installation Successful"
   ```

9. **Trust Developer Certificate (di iPhone):**
   ```
   Jika muncul di iPhone:
   "Untrusted Enterprise Developer"
   
   Lakukan:
   iPhone Settings → General → Device Management
   Tap "RizqonSagena" (atau nama developer)
   Tap "Trust [Developer Name]"
   
   Aplikasi sekarang bisa dibuka
   ```

10. **Open App:**
    ```
    Di iPhone:
    Home screen → Swipe untuk cari "Tongkrongan" app
    Tap untuk buka
    Atau: Settings → General → iPhone Storage → Tongkrongan → Open
    ```

---

## 🔄 Reinstall / Update (Cara Cepat)

Jika sudah install dan ada update APK/IPA baru:

### Android:
```
1. Buka Sideloadly
2. Device tetap pilihan yang sama
3. Klik "Select App" → pilih APK baru
4. Klik "Install"
5. Sideloadly akan uninstall versi lama, install yang baru
6. Done! Tidak perlu manual uninstall
```

### iOS:
```
1. Buka Sideloadly
2. Device tetap pilihan yang sama
3. Klik "Select App" → pilih IPA baru
4. Klik "Install"
5. Sideloadly handle uninstall + install baru
6. Trust certificate kalau prompted
7. Done!
```

---

## 🛠️ Troubleshooting Sideloadly

### Issue 1: Device Tidak Muncul di Dropdown

**Android:**
```
Solusi:
1. Buka Settings → Developer Options → USB Debugging → Toggle ON
2. Disconnect USB → wait 3 detik → reconnect
3. Di phone: Tap "Allow" jika prompted
4. Close Sideloadly → Reopen
5. Jika masih tidak muncul:
   - Try different USB port
   - Try different cable
   - Restart computer
```

**iOS:**
```
Solusi:
1. Disconnect USB → reconnect
2. Di iPhone: Tap "Trust" jika prompted
3. Settings → Privacy & Security → Developer Mode → ON
4. Close Sideloadly → Reopen
5. Restart iPhone
6. Restart Mac/PC jika masih tidak muncul
```

---

### Issue 2: "Invalid App" atau File Corrupt

```
Penyebab: APK/IPA download tidak sempurna

Solusi:
1. Delete file APK/IPA yang sudah ada
2. Download lagi dari GitHub Artifacts
3. Verify file size cocok dengan yg di screenshot
4. Try install lagi di Sideloadly
```

---

### Issue 3: Installation Failed

**Android:**
```
Error Message: "Installation Failed" atau "Error 110"

Solusi:
1. Uninstall app manual:
   Settings → Apps → Tongkrongan → Uninstall
2. Close Sideloadly
3. Restart Android phone
4. Reopen Sideloadly
5. Try install lagi
```

**iOS:**
```
Error: "Installation Failed" atau "Provisioning Failed"

Solusi:
1. Uninstall app dari iPhone:
   Settings → General → iPhone Storage → Tongkrongan → Delete
2. Close Sideloadly
3. Restart iPhone
4. Disconnect USB → reconnect
5. Trust certificate lagi jika prompted
6. Reopen Sideloadly
7. Try install lagi
```

---

### Issue 4: "Untrusted Enterprise Developer" (iOS)

```
Jika muncul error ini saat buka app:

Solusi:
1. Di iPhone: Settings → General → Device Management
2. Cari nama "RizqonSagena" atau "Profile"
3. Tap → Tap "Trust" button
4. Buka app lagi
```

---

### Issue 5: App Crashes on Launch

```
Jika app langsung crash:

Solusi Android:
1. Tap "Allow" atau "Grant" jika ada permission popup
2. Force close: Settings → Apps → Tongkrongan → Force Stop
3. Clear cache: App Info → Storage → Clear Cache
4. Reopen app

Solusi iOS:
1. Force close app: Swipe up dari bottom
2. Tap app di home screen lagi
3. Jika masih crash: Uninstall → reinstall dari Sideloadly
```

---

### Issue 6: Sideloadly Crash atau Hang

```
Jika Sideloadly tidak response:

Solusi:
1. Force close Sideloadly (Task Manager / Activity Monitor)
2. Disconnect USB cable
3. Restart computer
4. Reopen Sideloadly
5. Reconnect device
```

---

## 📋 Sideloadly Settings (Optional)

Buka Settings di Sideloadly untuk customize (opsional):

```
Sideloadly → Menu "Settings" atau gear icon

Opsi yang bisa di-adjust:
- Notification sounds: ON/OFF
- Device Management: Backup settings
- App Cache: Clear cache if needed
- Language: English / Bahasa lainnya
```

**Biasanya tidak perlu dirubah.**

---

## 🎯 Comparison: APK vs IPA

| Aspek | APK (Android) | IPA (iOS) |
|-------|---------------|----------|
| Install time | 2-5 min | 3-8 min |
| Requires | USB debugging | Apple ID |
| File size | ~60 MB | ~100 MB |
| Difficulty | Easy | Medium |
| Uninstall | Easy | Easy |
| Update | Simple | Simple |
| Error prone | Low | Medium |

---

## 🔐 Security Notes

Sideloadly adalah tools resmi dan aman, **TAPI:**

1. **Never install APK/IPA dari sumber tidak trusted**
   - Hanya dari GitHub official atau developer
   - Tidak dari random link

2. **APK/IPA ini build dari code kita**
   - Sudah di-review
   - Safe untuk testing

3. **Apple ID Security (iOS):**
   - Sideloadly tidak menyimpan password
   - Password hanya digunakan saat install
   - Recommended: enable 2FA di Apple ID

---

## ✅ Checklist: Siap Testing

Sebelum start testing:

**Android:**
- [ ] USB Debugging enabled
- [ ] USB cable connected
- [ ] Device muncul di Sideloadly
- [ ] APK file sudah download
- [ ] Installation berhasil
- [ ] App bisa dibuka

**iOS:**
- [ ] Developer Mode enabled (iOS 15+)
- [ ] Trust Computer sudah done
- [ ] Device muncul di Sideloadly
- [ ] IPA file sudah download
- [ ] Apple ID sudah login ke Sideloadly
- [ ] Installation berhasil
- [ ] Certificate sudah di-trust
- [ ] App bisa dibuka

---

## 📞 Quick Help

| Problem | Solution |
|---------|----------|
| Device not showing | Reconnect USB, enable USB debug (Android) |
| Install fails | Clear app data, uninstall, try again |
| App crashes | Tap "Allow" permissions, force close + reopen |
| IPA won't install | Enter correct Apple ID, enable Developer Mode |
| Cannot find file | Check Downloads folder, verify filename |
| Sideloadly stuck | Force close, restart computer |

---

## 🎉 Ready to Test!

Setup selesai. Sekarang Anda bisa:
1. ✅ Download APK/IPA dari GitHub
2. ✅ Install dengan Sideloadly
3. ✅ Test aplikasi di device
4. ✅ Update setiap ada build baru

**Happy Testing!** 🚀

---

*Panduan ini di-update untuk Sideloadly latest version*  
*Last Updated: September 16, 2026*
