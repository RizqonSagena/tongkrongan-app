# 🚀 Panduan Setup Aplikasi Tongkrongan untuk Testing
**Status:** Siap untuk Klien Testing  
**Versi:** 1.0  
**Tanggal:** September 16, 2026  
**Bahasa:** Bahasa Indonesia

---

## 📱 Ringkasan Singkat

Aplikasi **Tongkrongan** adalah aplikasi mobile untuk discovery tempat nongkrong (café, bar, hangout spot) dengan fitur:
- ✅ Jelajahi tempat nongkrong terdekat
- ✅ Simpan favorit Anda
- ✅ Jadwalkan janji nongkrong dengan teman
- ✅ Chat dengan admin tempat
- ✅ Rating dan review tempat

**Untuk testing, Anda punya 2 cara:**

### ✨ Cara 1: Testing Otomatis (REKOMENDASI - Mudah!)
- Download APK/IPA dari GitHub Actions (built otomatis)
- Install di Android atau iOS menggunakan Sideloadly
- Tidak perlu clone repository atau install dependencies

### 🛠️ Cara 2: Manual Development Build
- Clone repository
- Install Flutter SDK
- Build sendiri (APK/IPA)
- Testing langsung di emulator atau device

**Panduan ini fokus ke Cara 1 (Recommended untuk klien).**

---

## 🎯 CARA 1: Testing dengan GitHub Actions + Sideloadly (REKOMENDASI)

### Prasyarat
- ✅ Akun GitHub (gratis)
- ✅ USB Cable untuk connect device
- ✅ Sideloadly (gratis) - aplikasi desktop untuk install APK/IPA
- ✅ Internet yang stabil

**Durasi:** 30 menit setup + 40 menit build = ~70 menit pertama kali

---

### Step 1️⃣: GitHub Actions Build (Automatic)

#### A. Trigger Build APK (Android)

1. **Buka GitHub Repository:**
   - URL: https://github.com/RizqonSagena/tongkrongan-app
   - Atau klik link yang dikirim developer

2. **Navigasi ke Actions:**
   ```
   GitHub Repo → [Actions tab] → [Build Android APK workflow]
   ```

3. **Jalankan Build Manual:**
   ```
   - Klik "Build Android APK" workflow
   - Klik tombol "Run workflow"
   - Pilih branch: main
   - Klik "Run workflow" button
   ```

4. **Tunggu Build Selesai:**
   ```
   Status akan berubah:
   🟡 Queued → 🟡 In Progress → ✅ Completed
   
   Waktu: ~15-20 menit
   ```

5. **Download APK:**
   ```
   Ketika selesai:
   - Klik workflow run yang selesai
   - Scroll ke bawah "Artifacts"
   - Download "app-release.apk"
   - File size: ~50-80 MB
   ```

**Catatan:** Jika APK tidak ada di Artifacts, berarti build gagal. Scroll ke atas untuk lihat error message.

---

#### B. Trigger Build IPA (iOS)

1. **Buka GitHub Actions:**
   ```
   GitHub Repo → [Actions tab] → [Build iOS IPA workflow]
   ```

2. **Jalankan Build:**
   ```
   - Klik "Build iOS IPA" workflow
   - Klik "Run workflow"
   - Pilih branch: main
   - Klik "Run workflow"
   ```

3. **Tunggu Build Selesai:**
   ```
   Waktu: ~20-30 menit (lebih lama dari Android)
   Status: 🟡 → ✅
   ```

4. **Download IPA:**
   ```
   Artifacts → Download "app-release.ipa"
   File size: ~80-120 MB
   ```

---

### Step 2️⃣: Install Sideloadly (Aplikasi Desktop)

#### Untuk Windows / Mac

1. **Download Sideloadly:**
   - URL: https://sideloadly.io
   - Klik "Download" (pilih Windows/Mac sesuai OS Anda)

2. **Install Aplikasi:**
   - Jalankan installer (.exe atau .dmg)
   - Ikuti wizard installer
   - Finish

3. **Verifikasi Instalasi:**
   - Buka Sideloadly
   - Anda harus melihat interface dengan tombol "Install"

---

### Step 3️⃣: Install APK ke Android (Sideloadly)

**Prasyarat:**
- ✅ Android phone / tablet (Android 5.0+)
- ✅ USB cable
- ✅ USB debugging enabled di phone

#### A. Enable USB Debugging di Android

1. **Buka Settings di Phone:**
   ```
   Settings → About Phone
   ```

2. **Tap Build Number 7x:**
   ```
   Cari "Build Number" (biasanya di bawah)
   Tap 7x sampai muncul "You are now a developer"
   ```

3. **Back ke Settings, buka Developer Options:**
   ```
   Settings → System → Developer Options
   ```

4. **Enable USB Debugging:**
   ```
   Cari "USB Debugging"
   Tap toggle untuk ON ✓
   ```

5. **Connect ke PC:**
   ```
   - Plug USB cable ke phone
   - Di phone: tap "Allow" untuk debugging
   - Tunggu sampai device recognized di PC
   ```

#### B. Install APK dengan Sideloadly

1. **Buka Sideloadly di PC:**
   ```
   Jalankan aplikasi Sideloadly
   ```

2. **Select Device:**
   ```
   Anda harus melihat Android phone muncul di dropdown
   Pilih device Anda
   ```

3. **Select APK File:**
   ```
   - Klik tombol "..." atau "Select App"
   - Pilih file "app-release.apk" yang sudah di-download
   ```

4. **Install:**
   ```
   - Klik tombol "Install"
   - Tunggu progress bar finish
   - Status: ✅ "Installation completed"
   ```

5. **Aplikasi Siap:**
   ```
   - APK sudah terinstall di phone
   - Aplikasi muncul di home screen atau app drawer
   - Tap untuk membuka
   ```

---

### Step 4️⃣: Install IPA ke iOS (Sideloadly)

**Prasyarat:**
- ✅ iPhone / iPad (iOS 12.0+)
- ✅ USB cable (Lightning atau USB-C)
- ✅ Apple ID (boleh akun gratis)

#### A. Setup iOS Device

1. **Connect iPhone ke PC:**
   ```
   Plug USB cable ke iPhone
   Di iPhone: tap "Trust" ketika muncul popup
   ```

2. **Buka Sideloadly:**
   ```
   Jalankan aplikasi Sideloadly
   iPhone akan muncul di dropdown
   ```

#### B. Install IPA dengan Sideloadly

1. **Select Device:**
   ```
   Dropdown → Pilih iPhone Anda
   ```

2. **Select IPA File:**
   ```
   Klik "..." → Pilih file "app-release.ipa"
   ```

3. **Enter Apple ID:**
   ```
   Sideloadly akan minta:
   - Apple ID email
   - Apple ID password
   
   Ketik dan klik "Next"
   ```

4. **Install:**
   ```
   - Klik "Install"
   - Tunggu proses (biasanya 3-5 menit)
   - Status: ✅ "Installation completed"
   ```

5. **Trust Developer Certificate di iPhone:**
   ```
   Jika muncul "Untrusted Enterprise Developer":
   
   Di iPhone:
   Settings → General → Device Management
   Pilih "RizqonSagena" atau developer name
   Tap "Trust [name]"
   ```

6. **Aplikasi Siap:**
   ```
   Aplikasi "Tongkrongan" muncul di iPhone home screen
   Tap untuk membuka
   ```

---

## 🔄 Testing Workflow (Setiap Update)

Setiap kali developer push code baru:

### Untuk Android:

```
1. Developer push ke GitHub
   ↓
2. GitHub Actions build otomatis (15 menit)
   ↓
3. Kamu download APK dari Artifacts
   ↓
4. Sideloadly install ke phone
   ↓
5. Testing di phone
```

### Untuk iOS:

```
1. Developer push ke GitHub
   ↓
2. GitHub Actions build otomatis (25 menit)
   ↓
3. Kamu download IPA dari Artifacts
   ↓
4. Sideloadly install ke iPhone
   ↓
5. Testing di iPhone
```

---

## 🎯 Testing Checklist

### Explore Screen (Jelajah Tempat)
- [ ] Halaman load dengan smooth
- [ ] Lokasi menunjukkan tempat di sekitar
- [ ] Bisa scroll daftar tempat
- [ ] Bisa filter berdasarkan jarak
- [ ] Bisa search tempat
- [ ] Status "Buka Sekarang" menunjukkan dot berkedip (animasi)
- [ ] Bisa tap favorite (heart icon)
- [ ] Image tempat load dengan baik

### Favorites Screen (Favorit Saya)
- [ ] Tab "Favorit Saya" buka
- [ ] Menampilkan semua tempat yang di-favorite
- [ ] Bisa filter: "Semua", "Buka Sekarang", "Tutup"
- [ ] Bisa remove dari favorit (unfavorite)
- [ ] Empty state muncul jika belum ada favorit

### Booking Screen (Jadwal Nongkrongan)
- [ ] Tab "Jadwal Nongkrongan" buka
- [ ] Bisa membuat janji nongkrong baru (tombol "Buat Janji")
- [ ] Form punya field: Judul, Tempat, Tanggal, Jam, Tujuan, Peserta
- [ ] Date picker dan time picker bekerja
- [ ] Bisa submit booking
- [ ] Booking muncul di daftar

### Chat Screen (Pesan)
- [ ] Tab "Chat" buka
- [ ] Daftar conversations muncul
- [ ] Bisa buka conversation
- [ ] Bisa kirim pesan
- [ ] Pesan muncul di screen
- [ ] Bot messages terlihat dengan badge "Bot Support"

### Profile Screen (Profil Saya)
- [ ] Tab "Profil" buka
- [ ] Nama dan avatar terlihat
- [ ] Menu-menu ada: Edit, Keamanan, Notifikasi, etc.
- [ ] Bisa toggle Dark Mode (jika ada)
- [ ] Bisa logout

### Performance
- [ ] Scroll smooth (tidak lag)
- [ ] Tidak ada crash
- [ ] Loading time reasonable (< 3 detik untuk tiap screen)
- [ ] Image loading tidak berat

---

## 📋 Reporting Issues

Jika ada bug atau issue, **screenshot atau video** dan kirim:

### Format Report:
```
Screen: [Explore / Favorites / Booking / Chat / Profile]
Issue: [Deskripsi masalah]
Steps: 
  1. Buka screen X
  2. Tap tombol Y
  3. Error terjadi...
Expected: [Apa yang seharusnya terjadi]
Actual: [Apa yang benar-benar terjadi]
Device: [Android / iOS, versi OS]
Screenshot/Video: [Lampirkan file]
```

---

## 🆘 Troubleshooting

### APK Download dari GitHub Artifacts Tidak Muncul

**Penyebab:** Build gagal

**Solusi:**
1. Buka workflow run
2. Scroll ke atas → lihat error di build logs
3. Screenshot error dan kirim ke developer

---

### Sideloadly: Device Tidak Muncul

**Penyebab:** USB Debugging tidak enabled atau connection bermasalah

**Solusi Android:**
1. Buka Settings → Developer Options → USB Debugging → ON
2. Disconnect USB → reconnect
3. Tap "Allow" di device
4. Restart Sideloadly

**Solusi iOS:**
1. Disconnect USB → reconnect
2. Di iPhone: tap "Trust"
3. Restart Sideloadly
4. Restart iPhone jika masih tidak muncul

---

### Installation Failed / App Tidak Install

**Penyebab:** File corrupted atau download tidak sempurna

**Solusi:**
1. Delete file APK/IPA yang sudah download
2. Download ulang dari GitHub Artifacts
3. Coba install lagi dengan Sideloadly

---

### "Untrusted Enterprise Developer" (iOS)

**Solusi:**
1. Di iPhone: Settings → General → Device Management
2. Tap "RizqonSagena" atau developer name
3. Tap "Trust [name]"
4. Buka aplikasi lagi

---

### App Crash Saat Dibuka

**Penyebab:** Bug di aplikasi atau permission tidak granted

**Solusi:**
1. Tap "Allow" jika muncul permission popup
2. Force close app dan buka lagi
3. Uninstall dan reinstall
4. Jika masih crash, screenshot error dan kirim ke developer

---

## 📞 Quick Reference

| Action | Waktu | File |
|--------|-------|------|
| Build APK | 15 min | app-release.apk (~60MB) |
| Build IPA | 25 min | app-release.ipa (~100MB) |
| Download | 5 min | Depends on internet |
| Install APK | 2 min | Via Sideloadly |
| Install IPA | 5 min | Via Sideloadly |
| **Total** | **~70 min** | Pertama kali |

---

## 🎬 Video Tutorial (Optional)

Jika ada video tutorial setup Sideloadly:
- YouTube: Search "Sideloadly iOS IPA install"
- Atau developer bisa share video tutorial

---

## ✅ Setup Completion Checklist

Sebelum mulai testing, pastikan semua sudah done:

- [ ] GitHub account sudah access ke repository
- [ ] Sideloadly sudah installed di PC/Mac
- [ ] USB cable tersedia
- [ ] Android/iOS device tersedia dan connected
- [ ] USB Debugging enabled (Android)
- [ ] Developer Options enabled (Android)
- [ ] APK/IPA sudah downloaded
- [ ] First install berhasil
- [ ] App buka tanpa error

---

## 🎉 Ready for Testing!

Setelah setup selesai, aplikasi siap untuk testing penuh. Setiap ada update:
1. Developer push → GitHub Actions build → Download APK/IPA → Install dengan Sideloadly → Test

**Estimated time per update: ~30-40 menit (build time)**

---

## 📞 Support

Jika ada masalah atau pertanyaan:
1. **GitHub Issues:** https://github.com/RizqonSagena/tongkrongan-app/issues
2. **Direct Message:** Hubungi developer
3. **Check troubleshooting section** di atas

---

**Happy Testing! 🚀**

---

*Dokumen ini akan di-update seiring dengan progress development.*  
*Last Updated: September 16, 2026*
