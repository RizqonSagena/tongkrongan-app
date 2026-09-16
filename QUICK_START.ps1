# Tongkrongan App - Quick Start PowerShell Script

Write-Host ""
Write-Host "========================================"
Write-Host "  Tongkrongan App - Quick Start"
Write-Host "========================================"
Write-Host ""

$projectPath = "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app"
Set-Location $projectPath

Write-Host "📍 Current directory: $projectPath"
Write-Host ""

# Check Flutter
Write-Host "🔍 Checking Flutter installation..."
flutter doctor

Write-Host ""
Write-Host "⬇️ Getting dependencies..."
flutter pub get

Write-Host ""
Write-Host "========================================"
Write-Host "  Available Commands:"
Write-Host "========================================"
Write-Host ""
Write-Host "1. Run on Android Device"
Write-Host "2. Run on Chrome (Web)"
Write-Host "3. Run on Edge (Web)"
Write-Host "4. List available devices"
Write-Host "5. Exit"
Write-Host ""

$choice = Read-Host "Select an option (1-5)"

switch($choice) {
    "1" {
        Write-Host "🚀 Running on Android Device..."
        flutter run -d 23053RN02A
    }
    "2" {
        Write-Host "🚀 Running on Chrome..."
        flutter run -d chrome
    }
    "3" {
        Write-Host "🚀 Running on Edge..."
        flutter run -d edge
    }
    "4" {
        Write-Host "📱 Available devices:"
        flutter devices
    }
    "5" {
        Write-Host "👋 Goodbye!"
        exit
    }
    default {
        Write-Host "❌ Invalid choice"
        exit 1
    }
}

Write-Host ""
Write-Host "Done!"
