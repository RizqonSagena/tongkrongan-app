# 🚀 Quick Start - Mobile Testing Guide

**For:** Testing all 5 customer screens on your mobile device  
**Duration:** 5-10 minutes setup + testing time  
**Status:** ✅ All screens ready

---

## ⚡ Quick Setup (5 minutes)

### Step 1: Connect Your Device
```bash
# Enable USB Debugging on Android (Settings > Developer Options)
# OR use iOS simulator/device with Xcode

# Verify device is connected
flutter devices
```

### Step 2: Run the App
```bash
# Navigate to project
cd c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app

# Get dependencies
flutter pub get

# Run on device (debug mode - fastest)
flutter run

# Or for performance testing
flutter run --profile
```

### Step 3: Test Each Screen
The app has 5 screens accessible via bottom navigation:
1. 🔍 **Explore** - Browse locations
2. ❤️ **Favorites** - Your saved places
3. 📅 **Booking** - Schedule hangouts
4. 💬 **Chat** - Messages
5. 👤 **Profile** - Your profile

---

## 🎯 What to Test (Quick Version)

### ⏱️ ~2 Minutes Per Screen

#### EXPLORE SCREEN
- [ ] Scroll smoothly
- [ ] Tap filters (distance, category, status)
- [ ] Watch pulsing dot animation on status pills ✨
- [ ] Tap favorite button - card scales ✨
- [ ] Scroll horizontally on chips

#### FAVORITES SCREEN
- [ ] See favorite cards
- [ ] Tap filter tabs (smooth animation)
- [ ] Watch pulsing dot on status ✨
- [ ] Verify all images load

#### BOOKING SCREEN
- [ ] Watch tab underline animate smoothly ✨
- [ ] Tap "Buat Janji" button
- [ ] Fill booking form:
  - Enter title
  - Pick date (calendar)
  - Pick times
  - Select purpose
  - Adjust person count
  - Submit
- [ ] See success toast notification

#### CHAT SCREEN
- [ ] Tap a conversation
- [ ] See message bubbles
- [ ] Notice bot badge
- [ ] Check fixed input area with blur
- [ ] Tap back button

#### PROFILE SCREEN
- [ ] Scroll to see hero card
- [ ] Check stats grid
- [ ] See menu sections
- [ ] Toggle notifications switch
- [ ] Tap logout button
- [ ] Confirm logout

---

## ✨ Key Animations to Check

Look for these smooth animations:
1. **Pulsing Dots** - Green dots pulsing on "Buka" indicators (Explore & Favorites)
2. **Favorite Scale** - Card scales down when tapping heart (Explore)
3. **Filter Transitions** - Chips smoothly change color on tap
4. **Tab Animation** - Tab underline smoothly slides (Booking)

All should be **smooth 60 FPS** with **no stuttering**.

---

## 📱 Device Requirements

### Android
- API Level 21+ (Android 5.0+)
- 2GB+ RAM
- USB Debugging enabled

### iOS
- iOS 11.0+
- 2GB+ RAM
- Xcode installed

---

## 🎬 Screenshot Checklist

Good photos to capture:
- [ ] Explore screen with all filters visible
- [ ] Place card with pulsing animation (capture video if possible)
- [ ] Booking form modal
- [ ] Chat screen with message bubbles
- [ ] Profile hero card with gradient
- [ ] Any animations in action (video is best)

---

## 🚨 If You Encounter Issues

### App won't build
```bash
flutter clean
flutter pub get
flutter run
```

### Images not loading
- Check internet connection
- Unsplash CDN should be accessible
- App shows loading spinner then error icon

### Animations not smooth
- Use `--profile` build mode for less overhead
- Close other apps
- Try on different device if possible
- Check if 60+ FPS in DevTools

### Keyboard covers input
- This is normal mobile behavior
- App handles scrolling
- Submit button should be visible

---

## 📊 Testing Checklist (Detailed)

If you want to be thorough, use:

**File:** `MOBILE_TESTING_CHECKLIST.md`
- 50+ detailed test steps
- Screen-by-screen verification
- Performance metrics
- Issue reporting template

**File:** `PROJECT_COMPLETION_SUMMARY.md`
- Overview of all features
- What was built
- Key achievements

---

## 🎯 Success Criteria

All 5 screens should have:
- ✅ Proper layout & spacing
- ✅ Images loaded correctly
- ✅ All text readable
- ✅ Buttons responsive to tap
- ✅ Animations smooth 60 FPS
- ✅ Colors match design
- ✅ No crashes or errors

---

## 💬 Feedback

### What to Note
- Any visual inconsistencies
- Animation stuttering
- Image loading issues
- Layout/spacing problems
- Keyboard issues
- Performance problems
- Missing features

### How to Report
Use template in `MOBILE_TESTING_CHECKLIST.md`:
1. Screenshot/video of issue
2. Steps to reproduce
3. Expected vs actual
4. Device info

---

## 🔗 Useful Commands

```bash
# Hot reload (while running)
Press 'r' in terminal

# Full rebuild
Press 'R' in terminal

# Stop app
Press 'q' in terminal

# Clear and rebuild
flutter clean && flutter pub get && flutter run

# Check FPS with DevTools
flutter pub global run devtools
# Then open http://localhost:9100 in browser
```

---

## 📞 Need Help?

### Check These Files
1. `PROJECT_COMPLETION_SUMMARY.md` - Overall project info
2. `MOBILE_TESTING_CHECKLIST.md` - Detailed test cases
3. `CUSTOMER_SCREENS_COMPLETION_REPORT.md` - Implementation details
4. `STITCH_DESIGN_MIGRATION_GUIDE.md` - Design specs

### Flutter Documentation
- [Flutter Docs](https://flutter.dev/docs)
- [Material Design 3](https://flutter.dev/material)
- [Debugging Guide](https://flutter.dev/docs/testing/debugging)

---

## ⏱️ Time Estimates

- **Setup:** 3-5 minutes
- **Quick Test:** 10-15 minutes (all 5 screens)
- **Detailed Test:** 30-45 minutes (using full checklist)
- **Issue Reporting:** 10+ minutes (depends on findings)

---

## 🎉 You're All Set!

Everything is production-ready and waiting for your testing!

```bash
# Run this and start testing!
flutter run
```

**Happy testing!** 🚀

---

**Last Updated:** September 16, 2026  
**Status:** ✅ Ready to Test
