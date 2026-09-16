# Tongkrongan - Hangout Discovery App

Aplikasi Flutter untuk menemukan tempat tongkrongan terbaik dengan fitur yang terpisah untuk Customer, Owner, dan Admin.

## Struktur Project

```
lib/
├── main.dart
├── core/
│   ├── themes/
│   │   └── app_theme.dart
│   ├── router/
│   │   └── app_router.dart
│   └── widgets/
│       └── main_layout.dart
├── features/
│   ├── shared/
│   │   └── auth/
│   │       └── views/
│   │           ├── splash_screen.dart
│   │           └── login_screen.dart
│   ├── customer/
│   │   ├── explore/
│   │   │   ├── views/
│   │   │   │   └── explore_screen.dart
│   │   │   └── widgets/
│   │   │       ├── location_header.dart
│   │   │       ├── search_bar_widget.dart
│   │   │       ├── filter_chips.dart
│   │   │       └── place_card.dart
│   │   ├── favorites/
│   │   ├── booking/
│   │   ├── chat/
│   │   ├── profile/
│   │   └── detail_place/
│   ├── owner/
│   │   ├── dashboard/
│   │   ├── analytics/
│   │   ├── orders/
│   │   ├── chat_management/
│   │   └── profile/
│   └── admin/
│       ├── dashboard/
│       ├── store_management/
│       ├── content_management/
│       ├── chat_management/
│       └── profile/
```

## Fitur Utama

### Customer
- **Explore**: Jelajahi tempat tongkrongan dengan filter lokasi, kategori, dan preferensi
- **Favorites**: Simpan tempat favorit
- **Booking**: Buat jadwal tongkrongan
- **Chat**: Komunikasi dengan sesama pengguna
- **Profile**: Kelola profil personal

### Owner
- **Dashboard**: Pantau performa bisnis
- **Analytics**: Analitik bisnis mendalam
- **Orders**: Kelola pesanan dan reservasi
- **Chat Management**: Komunikasi dengan pelanggan
- **Profile**: Kelola profil bisnis

### Admin
- **Dashboard**: Overview sistem keseluruhan
- **Store Management**: Verifikasi dan kelola kedai
- **Content Management**: Moderasi konten
- **Support Chat**: Customer support
- **Profile**: Pengaturan admin

## Design System

Aplikasi menggunakan design system yang konsisten dengan:
- **Color Palette**: Primary (orange), Secondary (brown), Tertiary (green)
- **Typography**: Plus Jakarta Sans font family
- **Spacing**: Sistem spacing yang konsisten (xs, sm, md, lg, xl)
- **Components**: Material Design 3 components

## Cara Menjalankan

1. Install Flutter SDK
2. Clone repository ini
3. Jalankan `flutter pub get` untuk install dependencies
4. Jalankan `flutter run` untuk menjalankan aplikasi

## Login Credentials

Untuk testing, gunakan email dan password apa saja (minimal 6 karakter untuk password).
Pilih user type yang diinginkan:
- Customer: Akses fitur customer
- Owner: Akses fitur owner
- Admin: Akses fitur admin

## Teknologi yang Digunakan

- **Flutter**: Framework UI
- **Dart**: Bahasa pemrograman
- **Material Design 3**: Design system
- **Provider/Bloc**: State management (akan ditambahkan)
- **HTTP**: API calls (akan ditambahkan)

## Roadmap

- [ ] Implementasi state management
- [ ] Integrasi dengan backend API
- [ ] Push notifications
- [ ] Maps integration
- [ ] Payment gateway
- [ ] Real-time chat
- [ ] Review dan rating system

## Kontribusi

Silakan buat pull request atau issue untuk kontribusi dan feedback.