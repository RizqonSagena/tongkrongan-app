# SETUP LOGO TONGKRONGAN APP

## Instruksi Memasang Logo

### Status: Logo SVG sudah dibuat ✓
File: `tongkrongan_logo.svg` (512x512)

### Langkah 1: Convert SVG ke PNG

**Opsi A: Menggunakan Online Tool (Paling Mudah)**
1. Buka: https://cloudconvert.com/svg-to-png
2. Upload file `tongkrongan_logo.svg` dari folder Downloads
3. Atur ukuran ke 512x512 pixel
4. Download hasil PNG dengan nama `ic_launcher_foreground.png`
5. Ulangi untuk ukuran:
   - 192x192 (untuk HDPI)
   - 144x144 (untuk MDPI)  
   - 96x96 (untuk XHDPI)
   - 72x72 (untuk XXHDPI)
   - 48x48 (untuk XXXHDPI)

**Opsi B: Menggunakan Figma (Gratis)**
1. Buka: https://figma.com
2. Buat project baru
3. Upload SVG file
4. Export sebagai PNG dengan skala yang berbeda
5. Download semua ukuran

### Langkah 2: Letakkan Logo di Android Folders

Setelah mendapat PNG files, letakkan di:

```
tongkrongan_app/android/app/src/main/res/
├── mipmap-mdpi/
│   └── ic_launcher_foreground.png (72x72)
├── mipmap-hdpi/
│   └── ic_launcher_foreground.png (108x108)
├── mipmap-xhdpi/
│   └── ic_launcher_foreground.png (144x144)
├── mipmap-xxhdpi/
│   └── ic_launcher_foreground.png (192x192)
└── mipmap-xxxhdpi/
    └── ic_launcher_foreground.png (256x256)
```

### Langkah 3: Setup iOS Logo

1. Buka: `tongkrongan_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/`
2. Ganti semua file PNG dengan logo baru sesuai ukuran:
   - 20x20, 40x40, 60x60 (iPhone Notification)
   - 58x58, 87x87, 174x174 (iPhone Spotlight)
   - 80x80, 120x120, 180x180 (iPhone App)
   - 1024x1024 (App Store)

### Langkah 4: Update Build Names

Edit `pubspec.yaml` untuk memastikan logo terbaca:

```yaml
flutter:
  assets:
    - assets/logo/
  uses-material-design: true
```

### Langkah 5: Build Ulang

```bash
cd tongkrongan_app
flutter clean
flutter pub get
flutter build apk --release
flutter build ios --release --no-codesign
```

### Hasil Akhir

✓ Logo akan muncul di home screen dengan nama "Tongkrongan"
✓ Deskripsi: "Discover Your Perfect Hangout"

---

Catatan: Untuk hasil terbaik, gunakan ukuran PNG yang sesuai untuk setiap folder mipmap.
