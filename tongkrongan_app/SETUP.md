# Setup dan Menjalankan Aplikasi Tongkrongan

## Persyaratan Sistem

- Flutter 3.47.2 atau lebih baru
- Dart 3.13.2 atau lebih baru
- Android SDK untuk Android devices (Android 15 API 35)
- Chrome untuk testing di web
- Android Device atau Emulator

## Instalasi Dependencies

Jalankan command ini di root project:

```bash
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app
flutter pub get
```

## Menjalankan Aplikasi

### 1. Cek Device yang Tersedia

```bash
flutter devices
```

Output akan menampilkan device yang terhubung, misalnya:
- Android device
- Windows desktop
- Chrome web browser

### 2. Jalankan di Device/Browser Pilihan

**Option A: Jalankan di Android Device (Physical/Emulator)**
```bash
flutter run -d 23053RN02A
# atau gunakan device name lain yang muncul di flutter devices
```

**Option B: Jalankan di Web (Chrome)**
```bash
flutter run -d chrome
```

**Option C: Jalankan di Web (Edge)**
```bash
flutter run -d edge
```

### 3. Aplikasi Sudah Berjalan!

Saat aplikasi running:
- Tunggu splash screen (3 detik)
- Akan diarahkan ke login screen
- Pilih user type: **Customer**, **Owner**, atau **Admin**
- Masukkan email dan password (minimal 6 karakter untuk password)
- Tekan tombol "Masuk"

## Navigasi dalam Aplikasi

### Customer Features
1. **Explore** - Jelajahi tempat tongkrongan dengan filter dan search
2. **Favorit** - Simpan tempat favorit Anda
3. **Booking** - Buat jadwal nongkrong
4. **Chat** - Komunikasi dengan pengguna lain
5. **Profil** - Kelola profil personal

### Owner Features
1. **Dashboard** - Pantau performa bisnis Anda
2. **Analytics** - Analitik bisnis yang detail
3. **Orders** - Kelola pesanan dan reservasi
4. **Chat Management** - Komunikasi dengan pelanggan
5. **Profil** - Kelola profil bisnis

### Admin Features
1. **Dashboard** - Overview sistem keseluruhan
2. **Store Management** - Kelola dan verifikasi kedai
3. **Content Management** - Moderasi konten
4. **Support Chat** - Customer support
5. **Profil** - Pengaturan admin

## Hot Reload & Hot Restart

Saat aplikasi running, Anda bisa menggunakan:

- **r** - Hot reload (reload perubahan code tanpa restart app)
- **R** - Hot restart (restart app)
- **q** - Quit (keluar aplikasi)

## Troubleshooting

### Error: "ADB exited with exit code 1"
- Reconnect Android device via USB
- Pastikan USB debugging sudah enable di device
- Coba jalankan: `flutter run -d chrome` (gunakan web browser)

### Error: "Unable to find suitable Visual Studio toolchain"
- Windows desktop development tidak tersedia
- Gunakan Android device atau Chrome web browser sebagai gantinya

### Error: "NetworkImageLoadException"
- Image dari internet tidak bisa diload
- Coba jalankan dengan koneksi internet yang stabil
- Atau restart aplikasi

### Aplikasi Lambat
- Gunakan `flutter run --profile` untuk performance yang lebih baik
- Atau gunakan physical device daripada emulator

## Development Commands

```bash
# Check Flutter installation
flutter doctor

# Get dependencies
flutter pub get

# Analyze code
dart analyze lib/

# Format code
dart format lib/

# Build APK (untuk Android)
flutter build apk --release

# Build for Web
flutter build web
```

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── core/
│   ├── themes/              # App theming
│   ├── router/              # Navigation routing
│   └── widgets/             # Shared widgets
└── features/
    ├── shared/              # Auth, onboarding
    ├── customer/            # Customer features
    ├── owner/               # Owner features
    └── admin/               # Admin features
```

## Notes

- Semua fitur di halaman selain Explore masih berupa placeholder
- Implementasi backend API belum dilakukan
- State management belum diintegrasikan
- Real-time features seperti chat belum diimplementasikan

## Bantuan Lebih Lanjut

- Flutter Documentation: https://flutter.dev/docs
- Flutter Community: https://flutter.dev/community
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter
