# Convert Android Keystore to Base64 for GitHub Secrets

Write-Host "
╔════════════════════════════════════════════════════════════════════╗
║     Convert Android Keystore to Base64 for GitHub Secrets         ║
╚════════════════════════════════════════════════════════════════════╝
" -ForegroundColor Cyan

# Path to keystore
$keystorePath = "c:\Users\ASUS\Downloads\stitch_tongkrongan_hangout_discovery_app\tongkrongan_app\android\app\upload-keystore.jks"

Write-Host "Checking keystore file..." -ForegroundColor Yellow

if (-Not (Test-Path $keystorePath)) {
    Write-Host "❌ Keystore not found at: $keystorePath" -ForegroundColor Red
    Write-Host "Exiting..." -ForegroundColor Red
    exit
}

Write-Host "✅ Keystore found!" -ForegroundColor Green
Write-Host "Location: $keystorePath" -ForegroundColor Cyan

Write-Host "`nConverting to base64..." -ForegroundColor Yellow

# Read file as bytes
$fileBytes = [System.IO.File]::ReadAllBytes($keystorePath)

# Convert to base64
$base64String = [Convert]::ToBase64String($fileBytes)

# Save to temporary file
$outputPath = "keystore-base64.txt"
$base64String | Out-File -FilePath $outputPath -Encoding UTF8

Write-Host "✅ Base64 conversion complete!" -ForegroundColor Green
Write-Host "`nSaved to: $outputPath" -ForegroundColor Cyan

Write-Host "`n📋 Copy the base64 value to GitHub secret:" -ForegroundColor Yellow
Write-Host "────────────────────────────────────────────────────────────" -ForegroundColor Yellow

# Copy to clipboard
$base64String | Set-Clipboard
Write-Host "✅ Base64 copied to clipboard!" -ForegroundColor Green

Write-Host "`nSteps to add to GitHub:" -ForegroundColor Cyan
Write-Host "1. Go to: https://github.com/RizqonSagena/tongkrongan-app/settings/secrets/actions" -ForegroundColor White
Write-Host "2. Click [New repository secret]" -ForegroundColor White
Write-Host "3. Name: ANDROID_KEYSTORE_BASE64" -ForegroundColor White
Write-Host "4. Value: [paste from clipboard]" -ForegroundColor White
Write-Host "5. Click [Add secret]" -ForegroundColor White

Write-Host "`n📊 Base64 Info:" -ForegroundColor Yellow
Write-Host "Original size: $($fileBytes.Length) bytes" -ForegroundColor Cyan
Write-Host "Base64 size: $($base64String.Length) characters" -ForegroundColor Cyan

Write-Host "`n✨ You're ready to add secrets to GitHub!" -ForegroundColor Green
