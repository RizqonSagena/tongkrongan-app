# 🔧 Troubleshooting & Quick Reference Guide

**Purpose:** Solusi cepat untuk masalah umum Android & iOS  
**Last Updated:** September 16, 2026  
**Coverage:** Setup, Build, Runtime Issues

---

## 🆘 Quick Troubleshooting Flowchart

```
❓ Masalah?
    │
    ├─→ App won't build? ...................... [BUILD ISSUES]
    ├─→ App crashes on startup? .............. [RUNTIME ERRORS]
    ├─→ Emulator/Simulator issues? ........... [DEVICE ISSUES]
    ├─→ Specific feature not working? ....... [FEATURE ISSUES]
    ├─→ Performance problems? ................ [PERFORMANCE ISSUES]
    └─→ Can't run on physical device? ....... [DEVICE CONNECTION]
```

---

# 🏗️ BUILD ISSUES

## Issue 1: Gradle Build Fails (Android)

### ❌ Error Message Examples
```
FAILURE: Build failed with an exception.
Could not resolve all files for configuration ':app:debugRuntimeClasspath'
```

### ✅ Solutions

**Solution 1: Clean Build**
```powershell
# Windows PowerShell
flutter clean
Remove-Item -Recurse -Force android\.gradle
Remove-Item -Recurse -Force android\app\build
flutter pub get
flutter build apk --release -v
```

**Solution 2: Update Gradle**
```
File: android/build.gradle
Change:
    dependencies {
        classpath 'com.android.tools.build:gradle:7.0.0'
    }

To:
    dependencies {
        classpath 'com.android.tools.build:gradle:7.4.0'
    }
```

**Solution 3: Check Java Version**
```powershell
java -version

# Need JDK 11+
# If not installed:
choco install openjdk11

# Then set JAVA_HOME:
$env:JAVA_HOME = "C:\Program Files\Java\jdk-11.x"
```

**Solution 4: Invalidate Gradle Cache**
```powershell
cd android
# On Windows, delete:
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\.gradle"
cd ..
flutter pub get
flutter build apk -v
```

---

## Issue 2: Pod Installation Fails (iOS on Mac)

### ❌ Error Message Examples
```
[!] Error installing pods:
[!] The dependency `firebase_core` requires minimum deployment target
```

### ✅ Solutions

**Solution 1: Update CocoaPods Repo**
```bash
pod repo update
cd ios
pod install --repo-update --verbose
cd ..
```

**Solution 2: Deep Clean Pods**
```bash
cd ios
rm -rf Pods/
rm Podfile.lock
pod deintegrate
pod install --repo-update --verbose
cd ..
flutter pub get
flutter clean
```

**Solution 3: Update Minimum iOS Version**
```
File: ios/Podfile (end of file, inside post_install block)

Change:
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'

To:
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
```

**Solution 4: Force Pod Version Update**
```bash
cd ios
pod update
pod install --repo-update
cd ..
```

---

## Issue 3: Dependency Version Conflicts

### ❌ Error Message Examples
```
Because tongkrongan_app depends on provider ^6.0.0 which requires Dart >=3.0.0,
and tongkrongan_app depends on some_package ^1.0.0 which requires Dart <2.19.0,
some_package ^1.0.0 is forbidden.
```

### ✅ Solutions

**Solution 1: View Dependency Tree**
```powershell
flutter pub outdated
# Shows which packages are outdated
```

**Solution 2: Update All Packages**
```powershell
flutter pub upgrade
flutter pub get
flutter clean
flutter build apk --release -v  # Android
# Or: flutter build ios --release -v  # iOS on Mac
```

**Solution 3: Lock Specific Version**
```yaml
# File: pubspec.yaml
dependencies:
  provider: ^6.0.0        # Locked to major version 6
  firebase_core: ^2.24.0  # Locked to specific version
```

**Solution 4: Check Pubspec.yaml Syntax**
```bash
flutter pub get --dry-run
# Shows if there are parsing errors
```

---

## Issue 4: AndroidX Migration Issues (Android)

### ❌ Error Message Examples
```
androidx.* imports cannot be resolved
Cannot find symbol: class AppCompatActivity
```

### ✅ Solutions

**Solution 1: Update android/build.gradle**
```gradle
// android/build.gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 33
    }
}
```

**Solution 2: Update gradle.properties**
```
File: android/gradle.properties

org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
android.useLegacyToolchain=false
```

**Solution 3: Force AndroidX**
```powershell
flutter pub get
flutter packages pub get
flutter build apk --release -v
```

---

# 💥 RUNTIME ERRORS

## Issue 5: App Crashes on Startup (Both Platforms)

### ❌ Common Symptoms
- Black screen then crash
- No error message
- Immediate exit

### ✅ Solutions

**Solution 1: Check Console Logs**
```powershell
# Android
flutter logs

# iOS (on Mac)
flutter logs
# Or: Cmd + Shift + C in Xcode
```

**Look for errors like:**
- `E/flutter: [ERROR:flutter/runtime/dart_vm.cc:...]`
- `NoSuchMethodError`
- `NullPointerException`

**Solution 2: Check Main Entry Point**
```dart
// File: lib/main.dart
void main() {
  runApp(const MyApp());  // ← Should not have issues here
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tongkrongan',
      home: const MainScreen(),
    );
  }
}
```

**Solution 3: Check for Null Pointer Errors**
```dart
// ❌ BAD - Can crash
String name = user.name;  // If user is null → crash

// ✅ GOOD - Safe
String name = user?.name ?? 'Unknown';
```

**Solution 4: Verify Firebase Configuration**
```
Android: Check google-services.json exists in android/app/
iOS: Check GoogleService-Info.plist exists in ios/Runner/
```

**Solution 5: Run with Verbose Logging**
```powershell
# Android
flutter run -v

# iOS (on Mac)
flutter run -v
```

---

## Issue 6: Platform-Specific Crashes

### Android: MissingPluginException

**❌ Error:**
```
MissingPluginException: No implementation found for method 
getCameraDevice on channel ...
```

**✅ Solution:**
```powershell
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
flutter run -v
```

### iOS: Thread Sanitizer Error

**❌ Error:**
```
WARNING: ThreadSanitizer: data race on vptr for object of type
```

**✅ Solution:**
```bash
# On Mac, disable thread sanitizer:
open ios/Runner.xcworkspace

# In Xcode:
# Product → Scheme → Edit Scheme
# Diagnostics → Uncheck Thread Sanitizer
```

---

# 📱 DEVICE ISSUES

## Issue 7: Emulator/Simulator Won't Start

### Android Emulator

**❌ Symptoms:**
- Emulator window won't open
- "qemu-system-x86_64 not found"
- Emulator gets stuck loading

**✅ Solutions:**

**Solution 1: Restart Emulator**
```powershell
# Kill all emulator instances
Get-Process "emulator" -ErrorAction SilentlyContinue | Stop-Process -Force

# Wait 2 seconds
Start-Sleep -Seconds 2

# List available emulators
flutter devices

# Start specific emulator
flutter run -d emulator-5554
```

**Solution 2: Recreate Emulator**
```
1. Open Android Studio
2. Virtual Device Manager
3. Delete existing emulator
4. Create new:
   - Device: Pixel 6
   - API: 33 (Android 13)
   - RAM: 4GB
   - Storage: 4GB
5. Start emulator
```

**Solution 3: Enable Hardware Acceleration**
```
On Windows with Hyper-V:
1. Android Studio → Settings → System Settings → Android SDK
2. Emulator → Advanced → Check "Use Android Emulator Hypervisor Driver"
3. Restart emulator
```

### iOS Simulator (On Mac)

**❌ Symptoms:**
- Simulator won't boot
- "Booting the iOS Simulator is taking longer than expected"
- Simulator hangs

**✅ Solutions:**

**Solution 1: Erase & Restart**
```bash
# Shutdown all simulators
xcrun simctl shutdown all

# Erase all simulators
xcrun simctl erase all

# Restart Simulator app
open -a Simulator

# Boot specific device
xcrun simctl boot "iPhone 15 Pro"
```

**Solution 2: Delete & Recreate Simulator**
```bash
# Delete all
xcrun simctl delete all

# Create new
xcrun simctl create "iPhone 15 Test" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-15 \
  com.apple.CoreSimulator.SimRuntime.iOS-17-0

# Boot
xcrun simctl boot "iPhone 15 Test"
```

**Solution 3: Restart Mac**
```bash
# Sometimes just needed:
sudo killall "Simulator"
open -a Simulator
```

---

## Issue 8: Device Not Detected via ADB/USB

### Android Device Not Showing

**❌ Symptoms:**
```powershell
flutter devices
# Output: (no devices shown)
```

**✅ Solutions:**

**Solution 1: Check USB Connection**
1. Try different USB port
2. Try different USB cable
3. Restart Android device
4. Re-check Settings → Developer Options → USB Debugging (toggle OFF/ON)

**Solution 2: Restart ADB**
```powershell
# Kill ADB server
adb kill-server

# Wait 2 seconds
Start-Sleep -Seconds 2

# Restart ADB
adb start-server

# Check devices
adb devices

# Then in Flutter:
flutter devices
```

**Solution 3: Check USB Driver (Windows)**
```
1. Windows Device Manager
2. Locate your phone (might show unknown device)
3. Right-click → Update driver
4. Browser computer for driver software
5. Let me pick from list
6. Android Device → Android USB Device
7. Finish

Then:
adb devices  # Should show your phone now
```

**Solution 4: Trust USB Debugging on Phone**
```
On your Android device:
1. Plug into Windows PC
2. A prompt appears: "Allow USB debugging?"
3. Check "Always allow from this computer"
4. Tap "Allow"
5. Run: adb devices (should show your phone)
```

### iPhone Not Showing (On Mac)

**❌ Symptoms:**
```bash
flutter devices
# Output: (no iOS devices shown)
```

**✅ Solutions:**

**Solution 1: Disconnect & Reconnect**
1. Unplug iPhone from Mac
2. Unlock iPhone
3. Plug back in (use USB-C or Lightning cable)
4. On iPhone: Trust the computer (if prompted)
5. Run: `flutter devices`

**Solution 2: Restart Xcode Processes**
```bash
# Kill Xcode processes
killall -9 "Xcode"
killall -9 "usbmuxd"

# Wait 2 seconds
sleep 2

# Reconnect iPhone
# Then: flutter devices
```

**Solution 3: Fix Developer Certificate**
```bash
# Open Xcode
open ios/Runner.xcworkspace

# Xcode → Preferences → Accounts
# Select your Apple ID
# Verify "Manage Certificates" works
# Download all manual identities if needed
```

---

## Issue 9: Can't Install App on Physical Device

### Android Device

**❌ Error:**
```
Failure: Device offline
Installation failed due to: No such device or wrong parameter
```

**✅ Solutions:**

**Solution 1: Check Device is Ready**
```powershell
# Verify device connection
adb devices

# Expected:
# XXXXX device

# NOT:
# XXXXX offline
# XXXXX recovery
```

**Solution 2: Manually Install APK**
```powershell
# Build APK
flutter build apk --release

# Get APK path
$apkPath = "build\app\outputs\flutter-app\release\app-release.apk"

# Install
adb install $apkPath

# If error about old version:
adb uninstall com.stitch.tongkrongan
adb install $apkPath
```

**Solution 3: Clear Device Cache**
```powershell
# Uninstall old app version
adb uninstall com.stitch.tongkrongan

# Clear app data
adb shell pm clear com.stitch.tongkrongan

# Then reinstall:
flutter run -v
```

### iPhone Device

**❌ Error:**
```
Could not launch com.stitch.tongkrongan. Try to manually launch the app on the device.
```

**✅ Solutions:**

**Solution 1: Check Code Signing (On Mac)**
```bash
# Open Xcode
open ios/Runner.xcworkspace

# Select Runner project
# Go to: Signing & Capabilities
# Verify Team is set
# Check provisioning profile shows "Managed by Xcode"
# All should be green ✓
```

**Solution 2: Trust Developer Certificate on iPhone**
```
On your iPhone:
1. Settings → General → VPN & Device Management
2. Look for your certificate/profile
3. Tap and select "Trust"
4. Confirm
```

**Solution 3: Rebuild & Deploy**
```bash
flutter clean
flutter pub get
cd ios && pod install --repo-update && cd ..
flutter build ios -v
flutter run -d "iPhone of User" -v
```

---

# ⚡ FEATURE ISSUES

## Issue 10: Images Not Loading

### ❌ Symptoms
- Blank image placeholders
- Loading spinner stuck
- Error icons showing

### ✅ Solutions

**Solution 1: Check Network Connection**
```dart
// Verify internet permission in AndroidManifest.xml
<uses-permission android:name="android.permission.INTERNET" />

// iOS Info.plist
<key>NSLocalNetworkUsageDescription</key>
<string>App needs network access to load images</string>
```

**Solution 2: Check Image URL**
```dart
// ❌ Wrong - relative URL
Image.network('images/place.jpg')

// ✅ Correct - full URL
Image.network('https://unsplash.com/photos/xxxxx/download?w=400')
```

**Solution 3: Add Error Handling**
```dart
Image.network(
  'https://example.com/image.jpg',
  errorBuilder: (context, error, stackTrace) {
    return Container(
      color: Colors.grey[300],
      child: const Icon(Icons.broken_image),
    );
  },
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return const CircularProgressIndicator();
  },
)
```

**Solution 4: Check CDN Credentials (if using CloudFront/CDN)**
```dart
// If using signed URLs:
String imageUrl = await generateSignedUrl('image.jpg');
Image.network(imageUrl)
```

---

## Issue 11: Buttons/Forms Not Working

### ❌ Symptoms
- Button doesn't respond to tap
- Form fields can't be edited
- No visual feedback on tap

### ✅ Solutions

**Solution 1: Check Button is Enabled**
```dart
// ❌ Wrong - button might be disabled
ElevatedButton(
  onPressed: () => print('Tapped'),
  child: const Text('Tap Me'),
)

// ✅ Correct - verify button state
ElevatedButton(
  onPressed: isFormValid ? () => submit() : null,
  child: const Text('Tap Me'),
)
```

**Solution 2: Check Touch Target Size**
```dart
// Material Design requires minimum 48x48 dp
// Check widgets have adequate size:
GestureDetector(
  onTap: () => print('Tapped'),
  child: Container(
    width: 48,  // ✓ Minimum
    height: 48, // ✓ Minimum
    color: Colors.blue,
  ),
)
```

**Solution 3: Check for Widget Rebuild Issues**
```dart
// If button stops working after navigation:
// Use Navigator.pushReplacement instead of push
// Or check if parent widget is rebuilding unnecessarily
```

---

## Issue 12: Animations Not Smooth

### ❌ Symptoms
- Janky animations
- Frame drops visible
- Stuttering transitions

### ✅ Solutions

**Solution 1: Check Animation Duration**
```dart
// Animation too fast can feel jerky
AnimationController(
  duration: const Duration(milliseconds: 300),  // ✓ Good
  vsync: this,
)

// Too fast (< 150ms) can feel abrupt
// Too slow (> 500ms) can feel sluggish
```

**Solution 2: Check Curve**
```dart
// Use appropriate easing curve
Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,  // ✓ Smooth
  ),
);

// Avoid Curves.linear for most animations
// Use: easeInOut, easeOut, easeIn
```

**Solution 3: Monitor Frame Rate**
```powershell
# Android - Check logcat
flutter logs | findstr "FrameTime"

# iOS (on Mac)
flutter logs | grep "FrameTime"

# Should consistently show 16.67ms (60 FPS)
# If higher: 33ms+ (30 FPS) → animation is dropping frames
```

**Solution 4: Optimize Build Performance**
```dart
// Split large builds into smaller widgets
// Use const constructors where possible
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);  // ✓ Const
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();  // ✓ Const
  }
}
```

---

# 🚀 PERFORMANCE ISSUES

## Issue 13: App is Slow / Memory Leak

### ❌ Symptoms
- App gets slower over time
- Memory usage increases
- App crashes after long use

### ✅ Solutions

**Solution 1: Profile App Performance**
```powershell
# Run in profile mode
flutter run --profile

# Monitor in DevTools:
flutter pub global run devtools
# Open: http://localhost:9100
# Go to: Memory tab
```

**Solution 2: Check for Common Memory Leaks**

```dart
// ❌ Bad - AnimationController never disposed
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late AnimationController controller;
  
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    // Never disposed! ❌
  }
}

// ✅ Good - Properly disposed
class _MyWidgetState extends State<MyWidget> {
  late AnimationController controller;
  
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }
  
  @override
  void dispose() {
    controller.dispose();  // ✓ Always dispose
    super.dispose();
  }
}
```

**Solution 3: Optimize Image Loading**
```dart
// Cache images
ImageCache cache = ImageCache();
cache.maximumSize = 100;  // Limit cached images

// Use size-appropriate images
Image.network(
  'https://example.com/image.jpg?w=400&h=400',  // ✓ Resized on server
  cacheHeight: 400,
  cacheWidth: 400,
)
```

**Solution 4: Check ListView/GridView Performance**
```dart
// ❌ Bad - builds all items (even off-screen)
ListView(
  children: List.generate(1000, (i) => TextItem(i)),
)

// ✅ Good - builds only visible items
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) => TextItem(index),
)
```

---

## Issue 14: App Crashes After Running for Hours

### ❌ Symptoms
- App works fine initially
- Crashes after extended use
- Memory usage grows

### ✅ Solutions

**Solution 1: Check Stream/Future Cleanup**
```dart
// ❌ Bad - Stream never cancelled
StreamSubscription subscription = myStream.listen((data) {
  print(data);
});
// Never unsubscribed!

// ✅ Good - Stream properly managed
late StreamSubscription subscription;

@override
void initState() {
  subscription = myStream.listen((data) {
    print(data);
  });
}

@override
void dispose() {
  subscription.cancel();  // ✓ Cancel subscription
  super.dispose();
}
```

**Solution 2: Check Timer Cleanup**
```dart
// ❌ Bad - Timer never cancelled
Timer timer = Timer.periodic(Duration(seconds: 1), (_) {
  // This repeats forever! ❌
});

// ✅ Good - Timer properly cancelled
late Timer timer;

@override
void initState() {
  timer = Timer.periodic(Duration(seconds: 1), (_) {
    // Work here
  });
}

@override
void dispose() {
  timer.cancel();  // ✓ Cancel timer
  super.dispose();
}
```

---

# 📞 SUPPORT & ESCALATION

## When to Check Documentation

| Issue | Resource |
|-------|----------|
| Flutter basics | [flutter.dev/docs](https://flutter.dev/docs) |
| Package issues | Check package README on pub.dev |
| Firebase issues | [firebase.flutter.dev](https://firebase.flutter.dev) |
| Android specific | [developer.android.com](https://developer.android.com) |
| iOS specific | [developer.apple.com](https://developer.apple.com) |

## When to Search Stack Overflow

Search using format:
```
[flutter] [package_name] [specific_error]

Example:
[flutter] [firebase_core] "MissingPluginException"
```

---

# ✅ QUICK FIX CHECKLIST

Before escalating issues, try:

- [ ] `flutter clean`
- [ ] `flutter pub get`
- [ ] Delete build directory (platform-specific)
- [ ] Restart emulator/simulator
- [ ] Restart IDE
- [ ] Clear app cache (on device)
- [ ] Reinstall app from scratch
- [ ] Check Flutter/Dart versions match
- [ ] Review error logs carefully
- [ ] Search Stack Overflow
- [ ] Check GitHub issues for known problems
- [ ] Try on different device/emulator

---

# 🔗 QUICK COMMAND REFERENCE

## Android (Windows)
```powershell
# Clean & Fresh Start
flutter clean
Remove-Item -Recurse -Force android\.gradle
Remove-Item -Recurse -Force android\app\build
flutter pub get

# Build
flutter build apk --release -v

# Run
flutter devices
flutter run -v -d emulator-5554

# Logs
flutter logs
```

## iOS (Mac)
```bash
# Clean & Fresh Start
flutter clean
rm -rf ios/Pods ios/Podfile.lock
flutter pub get
cd ios && pod install --repo-update && cd ..

# Build
flutter build ios --release -v

# Run
flutter devices
flutter run -v -d "iPhone 15 Pro"

# Logs
flutter logs
```

---

**Troubleshooting Guide Status:** ✅ READY  
**Last Updated:** September 16, 2026  
**Version:** 1.0

