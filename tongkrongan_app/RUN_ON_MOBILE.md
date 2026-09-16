# 📱 Tongkrongan App - Cara Menjalankan di HP

**Updated:** September 16, 2026

---

## 📋 Prasyarat

### Untuk Android
- ✅ Flutter SDK terinstall
- ✅ Android Studio atau minimal Android SDK
- ✅ HP Android dengan USB Debugging aktif
- ✅ Kabel USB atau koneksi WiFi

### Untuk iOS
- ✅ Flutter SDK terinstall
- ✅ Xcode terinstall (Mac only)
- ✅ iPhone/iPad dengan Developer Mode aktif
- ✅ Kabel USB atau koneksi WiFi

---

## 🔧 Setup Awal (Sekali Saja)

### Step 1: Install Flutter
Jika belum install, download dari: https://flutter.dev/docs/get-started/install

```bash
# Verifikasi Flutter sudah terinstall
flutter --version

# Jalankan flutter doctor untuk check setup
flutter doctor
```

### Step 2: Setup Device Debugging

#### **UNTUK ANDROID:**

1. **Aktifkan USB Debugging di HP:**
   - Buka Settings → About Phone
   - Tap "Build Number" 7x sampai keluar "Developer options"
   - Buka Developer Options
   - Aktifkan "USB Debugging"

2. **Hubungkan HP ke PC dengan USB:**
   ```bash
   # Cek device terdeteksi
   flutter devices
   ```

#### **UNTUK iOS (Butuh Mac):**

1. **Aktifkan Developer Mode di iPhone:**
   - Settings → Privacy → Developer Mode → Toggle ON

2. **Hubungkan iPhone ke Mac dengan USB:**
   ```bash
   # Cek device terdeteksi
   flutter devices
   ```

---

## 🚀 Menjalankan di HP

### Opsi 1: Dengan Kabel USB (Recommended)

#### Android
```bash
# 1. Buka terminal di folder project
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app

# 2. Jalankan app
flutter run

# 3. Pilih device yang muncul (biasanya ada opsi untuk HP Anda)
```

#### iOS (Mac only)
```bash
cd tongkrongan_app
flutter run
```

### Opsi 2: Dengan WiFi (Wireless)

#### Android
```bash
# 1. Hubungkan HP dan PC ke WiFi sama
flutter run

# 2. Setelah app pertama kali running dengan USB
# Buka terminal kedua:
adb connect <IP_HP_ANDA>:5555

# Contoh:
adb connect 192.168.1.100:5555

# 3. Jalankan app
flutter run
```

#### iOS (Mac)
```bash
# 1. Hubungkan iPhone dan Mac ke WiFi sama
flutter run

# 2. Di Xcode > Window > Devices and Simulators
# Klik device Anda dan enable wireless connection
```

---

## ⚡ Quick Commands

```bash
# Navigate ke project
cd tongkrongan_app

# Lihat device yang tersedia
flutter devices

# Run di device tertentu
flutter run -d <device_id>

# Run dan maintai hot reload
flutter run

# Run dengan verbose output (untuk debug)
flutter run -v

# Run release build (faster, better performance)
flutter run --release
```

---

## 🎯 Langkah-Langkah Lengkap

### **ANDROID:**

1. **Siapkan HP:**
   - Buka Settings
   - Cari "Developer options"
   - Aktifkan "USB Debugging"
   - Aktifkan "Wireless debugging" (optional)

2. **Hubungkan ke PC:**
   ```bash
   # Buka Windows PowerShell atau Command Prompt
   cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app
   ```

3. **Check Device:**
   ```bash
   flutter devices
   # Output contoh:
   # Pixel 5 (mobile) • emulator-5554 • android-x86 • Android 12
   ```

4. **Run App:**
   ```bash
   flutter run
   
   # Atau dengan device ID spesifik:
   flutter run -d emulator-5554
   ```

5. **Tunggu proses build:**
   - Build pertama kali memakan waktu 2-5 menit
   - Hot reload akan lebih cepat untuk update selanjutnya

---

## 🎨 Hot Reload & Hot Restart

Setelah app running:

```bash
# Tekan 'r' untuk hot reload (save changes)
r

# Tekan 'R' untuk hot restart (full rebuild)
R

# Tekan 'q' untuk quit
q
```

**Hot Reload:** Cepat, hanya refresh UI  
**Hot Restart:** Lebih lama, rebuild semua (gunakan jika hot reload error)

---

## 🐛 Troubleshooting

### "Device tidak terdeteksi"
```bash
# Cek apakah device sudah connect
flutter devices

# Jika tidak muncul, coba:
# 1. Disconnect USB dan reconnect
# 2. Aktifkan USB Debugging di HP
# 3. Izinkan USB access jika diminta HP
```

### "Build error atau gradle error"
```bash
# Clean project
flutter clean

# Get dependencies lagi
flutter pub get

# Jalankan lagi
flutter run
```

### "Port sudah terpakai"
```bash
# Flutter akan auto-pick port lain, tapi jika perlu spesifik:
flutter run --dart-observatory-port=8181
```

### "App crash saat run"
```bash
# Jalankan dengan verbose untuk lihat error
flutter run -v

# Atau check logs HP:
adb logcat
```

### "Izin akses USB tidak diberikan"
```bash
# HP akan muncul popup "Allow USB debugging?"
# Tap "Allow" dan centang "Always allow..."
```

---

## 📊 Performance Tips

### Untuk Better Performance:

1. **Run release build:**
   ```bash
   flutter run --release
   ```
   - Lebih cepat (~50% faster)
   - Ukuran app lebih kecil
   - Debug info berkurang

2. **Monitor performance:**
   ```bash
   # Buka DevTools
   flutter pub global run devtools
   ```

3. **Check FPS:**
   - Double tap ikon DevTools (pojok kiri bawah screen)
   - Bisa lihat frame rate real-time

---

## 🔗 Koneksi PC ke HP

### Cek IP Address HP:
**Android:**
```
Settings → About phone → Status → IP Address
```

### Cek IP Address PC:
```bash
# Windows PowerShell
ipconfig

# Cari "IPv4 Address" di WiFi section
```

---

## 📱 Testing Fitur di HP

### Fitur yang bisa langsung ditest:

✅ Navigation (bottom navigation bar)  
✅ Search & filtering  
✅ Image loading dari Unsplash  
✅ Buttons & interactions  
✅ Styling & design  
✅ Dark/light mode (jika ada)

### Fitur yang butuh backend:

⚙️ Data persistence  
⚙️ Real-time updates  
⚙️ User authentication  
⚙️ File upload  

---

## 💾 Build APK untuk Android (Opsional)

Jika ingin share ke orang lain:

```bash
# Build APK
flutter build apk

# APK akan di: build/app/outputs/flutter-apk/app-release.apk

# Atau build multiple architectures:
flutter build apk --split-per-abi
```

Bisa share APK ke HP lain via:
- Google Drive
- WhatsApp
- Email
- USB transfer

---

## 🍎 Build IPA untuk iOS (Mac only)

```bash
# Build IPA
flutter build ipa

# IPA akan di: build/ios/ipa/

# Bisa di-upload ke TestFlight untuk testing
```

---

## 🔄 Update Code & Test

Workflow saat development:

1. **Edit code di VS Code/Android Studio**
2. **Simpan file (Ctrl+S)**
3. **Di terminal Flutter, tekan 'r'**
4. **Lihat changes langsung di HP**

```bash
# Terminal akan terlihat seperti:
# ═══════════════════════════════════════════════════════════
# ║  Restarted application in 245ms.                         ║
# ═══════════════════════════════════════════════════════════
```

---

## 📝 Checklist Setup

- [ ] Flutter SDK installed & `flutter --version` berfungsi
- [ ] Android SDK/Xcode installed
- [ ] USB Debugging aktif di HP
- [ ] HP terdeteksi dengan `flutter devices`
- [ ] Kabel USB terhubung
- [ ] Folder project di-open di terminal
- [ ] `flutter pub get` sudah dijalankan
- [ ] `flutter run` berfungsi

---

## ✅ Testing Checklist

Saat app running di HP, test:

- [ ] Navigation antar tab bekerja
- [ ] Scroll halaman lancar
- [ ] Images loading dengan baik
- [ ] Buttons responsif saat di-tap
- [ ] Text readable dengan font size yg benar
- [ ] Colors sesuai design
- [ ] Layout tidak ada yang terpotong
- [ ] Loading indicators muncul
- [ ] Error handling berfungsi

---

## 🎯 Troubleshooting Common Issues

| Error | Solusi |
|-------|--------|
| "No devices detected" | Cek USB Debugging aktif, reconnect USB |
| "Gradle error" | Jalankan `flutter clean && flutter pub get` |
| "App crash" | Jalankan `flutter run -v` untuk lihat error |
| "Port taken" | Flutter auto-switch port atau kill process lama |
| "Build too slow" | Gunakan `flutter run --release` |
| "Memory error" | Close background apps di HP |

---

## 📞 Quick Reference

```bash
# Setup awal
flutter doctor
flutter pub get

# Run di device
flutter devices
flutter run

# Development
flutter run                    # Run dengan hot reload
flutter run --release          # Faster, optimized
flutter run -v                 # Verbose output untuk debug

# Keyboard shortcuts (saat app running)
r     → Hot reload
R     → Hot restart
q     → Quit

# Clean & rebuild
flutter clean
flutter pub get
flutter run
```

---

## 🚀 Siap Mulai!

```bash
# 1. Buka terminal
# 2. Navigate ke folder
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app

# 3. Check device
flutter devices

# 4. Run!
flutter run
```

**Selesai!** App akan langsung running di HP Anda 🎉

---

## 📱 Output yang Diharapkan

Saat running, Anda akan lihat:

```
Launching lib/main.dart on Android SDK built for x86 in debug mode...
Running Gradle task 'assembleDebug'...
✓ Built build/app/outputs/apk/debug/app-debug.apk
Installing and launching...
Xcode build done.                                            2.1s
I/Choreographer(  9126): Skipped 1 frame!  The application may be doing too much...
I/flutter (  9126): ════════════════════════════════════════════════════════════
I/flutter (  9126): Flutter run key commands.
I/flutter (  9126): r Hot reload. 🔥🔥🔥
I/flutter (  9126): R Hot restart.
I/flutter (  9126): h Show this help message again.
I/flutter (  9126): d Detach (terminate "flutter run").
I/flutter (  9126): c Clear the screen
I/flutter (  9126): q Quit (terminate the app on the device).
I/flutter (  9126): ════════════════════════════════════════════════════════════
Application finished.
```

Tergantung device, waktu build bisa 2-5 menit untuk first run.

---

**Status:** ✅ Siap untuk Mobile Testing  
**Last Updated:** September 16, 2026
