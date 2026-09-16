# 🚀 Getting Started - Tongkrongan App Testing Setup
**Quick Start Guide untuk Setup Cepat**  
**Versi:** 1.0  
**Tanggal:** September 16, 2026

---

## ⚡ TL;DR (30 Detik Summary)

Aplikasi Tongkrongan sudah siap untuk **automated testing** via:
- ✅ **GitHub Actions** - Automatic build APK & IPA
- ✅ **Sideloadly** - Easy install ke Android & iOS
- ✅ **No coding needed** - Klien bisa test langsung

**Workflow:** Push code → GitHub build → Download APK/IPA → Install Sideloadly → Test

---

## 📚 Dokumentasi Tersedia

Pilih dokumentasi sesuai role Anda:

### 👥 Untuk Klien (Pengguna Testing):
→ **Baca: `SETUP_UNTUK_KLIEN.md`** (15-20 min)
- Setup Sideloadly
- Download APK/IPA dari GitHub Actions
- Install ke phone
- Testing checklist

### 🔧 Untuk Developer/Admin (Setup Initial):
→ **Baca dalam urutan ini:**

1. **`GITHUB_SECRETS_SETUP_LENGKAP.md`** (45-60 min)
   - Prepare credential files (Android keystore, iOS certificate)
   - Add GitHub Secrets
   - Encode ke base64

2. **`WORKFLOW_VERIFICATION.md`** (30-45 min)
   - Test build workflow
   - Download APK/IPA
   - Verify hasil build

3. **`IMPLEMENTATION_CHECKLIST.md`** (Reference)
   - Final checklist sebelum go-live
   - Testing sign-off
   - Client handover

### 🎯 Untuk Project Manager:
→ **Baca: `IMPLEMENTATION_CHECKLIST.md`** (20 min)
- Project timeline
- Testing process
- Client communication

---

## ⏱️ Timeline

| Phase | Durasi | Task |
|-------|--------|------|
| **Phase 1** | 1-2 jam | Prepare credentials (Android keystore, iOS cert) |
| **Phase 2** | 2-3 jam | Add GitHub Secrets (8-10 secrets) |
| **Phase 3** | 1-2 jam | Test builds (Android APK + iOS IPA) |
| **Phase 4** | 2-3 jam | Test Sideloadly installation & verify app |
| **Phase 5** | 1-2 jam | Functional testing (all 5 screens) |
| **Phase 6** | 1 jam | Client preparation & handover |
| **TOTAL** | ~10 jam | End-to-end setup (spread over 2-3 days) |

---

## 🎯 Quick Start Path

### Path A: Klien Only (30 menit setup)

```
1. Download Sideloadly: https://sideloadly.io
2. Connect Android/iOS via USB
3. Follow: SETUP_UNTUK_KLIEN.md
4. Download APK/IPA dari GitHub Actions
5. Install dengan Sideloadly
6. Test aplikasi
```

**Prerequisites:**
- ✅ GitHub account (dapat akses repository)
- ✅ USB cable
- ✅ Android phone / iPhone
- ✅ Sideloadly installed

---

### Path B: Developer (First-Time Setup - 8-10 jam)

```
1. Prepare credentials:
   - Android: upload-keystore.jks (atau generate baru)
   - iOS: certificate.p12 + profile.mobileprovision
   
2. Encode ke base64 (GITHUB_SECRETS_SETUP_LENGKAP.md)

3. Add GitHub Secrets (8-10 secrets)

4. Test builds:
   - Trigger Android APK build
   - Wait 15-20 min
   - Trigger iOS IPA build
   - Wait 25-30 min

5. Download APK/IPA

6. Test dengan Sideloadly (Android + iOS)

7. Functional testing (all 5 screens)

8. Client handover & documentation
```

**Prerequisites:**
- ✅ GitHub owner/admin access
- ✅ Android signing credentials
- ✅ iOS signing credentials (or Apple Developer account)
- ✅ USB cables + devices
- ✅ Sideloadly installed

---

## 📋 5-Minute Checklist

Jika ingin quick overview, check ini:

```
✅ GitHub Actions workflows exist:
   - .github/workflows/build-android.yml
   - .github/workflows/build-ios.yml

✅ GitHub repository accessible:
   - https://github.com/RizqonSagena/tongkrongan-app
   - Settings tab visible (admin access)

✅ Documentation ready:
   - SETUP_UNTUK_KLIEN.md
   - GITHUB_SECRETS_SETUP_LENGKAP.md
   - SIDELOADLY_LENGKAP.md
   - WORKFLOW_VERIFICATION.md

✅ Sideloadly download link:
   - https://sideloadly.io

Status: 🟢 Ready to start
```

---

## 🔑 Key Files & Locations

```
📁 Repository Root
├── .github/workflows/
│   ├── build-android.yml         ← APK build workflow
│   ├── build-ios.yml             ← IPA build workflow
│   └── deploy-sideloadly.yml     ← Optional auto-deploy
│
├── SETUP_UNTUK_KLIEN.md          ← 👈 START HERE (klien)
├── GITHUB_SECRETS_SETUP_LENGKAP.md ← GitHub Secrets guide
├── SIDELOADLY_LENGKAP.md         ← Sideloadly installation
├── WORKFLOW_VERIFICATION.md      ← Build verification
├── IMPLEMENTATION_CHECKLIST.md   ← Final checklist
└── GETTING_STARTED.md            ← You are here

📁 tonkrongan_app/
├── android/app/
│   └── upload-keystore.jks       ← Android signing key (SENSITIVE)
├── ios/
│   └── certificate.p12           ← iOS signing cert (SENSITIVE)
│   └── profile.mobileprovision   ← iOS provisioning (SENSITIVE)
└── ...
```

---

## 🔐 Security Notes

⚠️ **CRITICAL - READ FIRST:**

```
1. Credentials files are SENSITIVE
   - Never commit to repository
   - Never share in chat/email
   - Store safely offline

2. GitHub Secrets are ENCRYPTED
   - Values visible as dots (not readable)
   - Only used during build
   - Cannot be accessed by others

3. Base64 encoding is NOT encryption
   - Anyone with base64 string dapat decode
   - JANGAN share di public!

4. API Keys
   - Rotate regularly
   - Monitor usage
   - Revoke if compromised
```

---

## 💾 Download & Setup

### Step 1: Clone/Download Repository

```bash
# Via Git:
git clone https://github.com/RizqonSagena/tongkrongan-app.git

# Or download ZIP from GitHub website
```

### Step 2: Download Sideloadly

```
URL: https://sideloadly.io
Platform: Windows / macOS
Size: ~30-40 MB
```

### Step 3: Connect Devices

```
Android: USB cable + Enable USB Debugging
iOS: USB cable + Trust Computer + Enable Developer Mode
```

### Step 4: Read Documentation

```
Klien: SETUP_UNTUK_KLIEN.md (20 min)
Developer: GITHUB_SECRETS_SETUP_LENGKAP.md (60 min)
```

---

## 🚀 First Build

### Trigger Manual Build:

```
1. GitHub → Actions tab
2. Select workflow: "Build Android APK"
3. Click "Run workflow"
4. Branch: main
5. Click green "Run workflow" button
6. Wait 15-20 minutes
7. Download APK from Artifacts
8. Repeat for iOS (takes 25-30 min)
```

### Install & Test:

```
1. Open Sideloadly
2. Connect device
3. Select APK/IPA file
4. Click "Install"
5. Wait 2-5 minutes
6. App appears on device
7. Tap to open & test
```

---

## ✅ Success Indicators

Jika melihat ini, setup sudah sukses:

```
✅ APK file: ~60 MB dalam Artifacts
✅ IPA file: ~100 MB dalam Artifacts
✅ Installation via Sideloadly: Successful
✅ App opens on device: No crash
✅ UI visible: All 5 tabs accessible
✅ Navigation works: Can tap between screens
✅ Performance: Smooth scrolling, 60 FPS
```

---

## 🐛 Common Issues

| Problem | Solution |
|---------|----------|
| Build failed in GitHub | Check error log, verify secrets |
| APK/IPA not in Artifacts | Build failed, check logs |
| Sideloadly: Device not found | Reconnect USB, enable debugging |
| App crashes on launch | Check device logs, report to dev |
| Installation stuck | Wait 5-10 min, try restart |
| "Untrusted Developer" (iOS) | Trust certificate in Settings |

**For detailed troubleshooting:** See WORKFLOW_VERIFICATION.md

---

## 📞 Support Resources

| Resource | Link |
|----------|------|
| GitHub Actions Docs | https://docs.github.com/en/actions |
| Flutter Deployment | https://flutter.dev/docs/deployment |
| Sideloadly Support | https://sideloadly.io/support |
| Repository Issues | https://github.com/RizqonSagena/tongkrongan-app/issues |

---

## 📊 Project Structure

```
Tongkrongan App = Flutter Mobile Application

Platform Support:
✅ Android: 5.0+ (APK via GitHub Actions)
✅ iOS: 12.0+ (IPA via GitHub Actions)

Distribution Method:
✅ GitHub Actions (automated build)
✅ Sideloadly (install to device)
✅ No App Store needed (for testing)

Features (5 Screens):
1. Explore - Discover hangout spots
2. Favorites - Save favorite places
3. Booking - Schedule hangout plans
4. Chat - Message with places
5. Profile - User profile & settings
```

---

## 🎯 Next Steps

### I'm a Client → 
**Go to: `SETUP_UNTUK_KLIEN.md`**

### I'm Setting Up GitHub Secrets →
**Go to: `GITHUB_SECRETS_SETUP_LENGKAP.md`**

### I'm Verifying the Workflow →
**Go to: `WORKFLOW_VERIFICATION.md`**

### I'm Doing Final Checklist →
**Go to: `IMPLEMENTATION_CHECKLIST.md`**

---

## 🎉 Ready?

```
✅ Documentation: Complete
✅ Workflow: Tested
✅ Setup: Documented
✅ Support: Available

Status: 🟢 READY TO GO!

Let's test! 🚀
```

---

## 📝 Quick Notes

1. **This is a testing setup** - NOT production deployment
2. **Credentials are temporary** - Rotate before production
3. **Documentation is comprehensive** - Refer when stuck
4. **Support is available** - Ask questions via GitHub Issues
5. **Continuous improvement** - Feedback welcome!

---

**Questions?** Check the detailed documentation files.  
**Ready to start?** Pick your path above and begin! ⚡

---

**Created:** September 16, 2026  
**Version:** 1.0  
**Status:** ✅ Ready for Implementation

Good luck! 🚀
