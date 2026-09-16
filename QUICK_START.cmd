@echo off
REM Tongkrongan App - Quick Start Script
REM This script will help you get started quickly

echo.
echo ========================================
echo  Tongkrongan App - Quick Start
echo ========================================
echo.

cd /d "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app"

echo Checking Flutter installation...
flutter doctor --verbose

echo.
echo Getting dependencies...
flutter pub get

echo.
echo ========================================
echo  Available Commands:
echo ========================================
echo.
echo 1. Run on Android Device:
echo    flutter run -d 23053RN02A
echo.
echo 2. Run on Chrome (Web):
echo    flutter run -d chrome
echo.
echo 3. Run on Edge (Web):
echo    flutter run -d edge
echo.
echo 4. Check available devices:
echo    flutter devices
echo.
echo ========================================
echo.
echo Select an option (1-4) or press Ctrl+C to exit:
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo Running on Android Device...
    flutter run -d 23053RN02A
) else if "%choice%"=="2" (
    echo Running on Chrome...
    flutter run -d chrome
) else if "%choice%"=="3" (
    echo Running on Edge...
    flutter run -d edge
) else if "%choice%"=="4" (
    echo Available devices:
    flutter devices
) else (
    echo Invalid choice
    exit /b 1
)
