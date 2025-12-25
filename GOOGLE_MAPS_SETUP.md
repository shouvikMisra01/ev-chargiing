# 🗺️ Google Maps API Setup Guide

## Step 1: Get Your API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing one)
3. Click **"APIs & Services"** → **"Library"**
4. Search and enable these APIs:
   - ✅ **Maps SDK for Android**
   - ✅ **Maps SDK for iOS**
   - ✅ **Places API** (optional, for address autocomplete)
   - ✅ **Geocoding API** (optional, for address to coordinates)

5. Go to **"Credentials"** → **"Create Credentials"** → **"API Key"**
6. Copy your API key (looks like: `AIzaSyB1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p`)

7. **IMPORTANT:** Enable billing on your Google Cloud project
   - Without billing, maps won't load
   - Free tier includes $200/month credit

8. (Optional) Restrict your API key:
   - Click on the API key → "Edit API key"
   - **Application restrictions:**
     - Android: Add package name + SHA-1 fingerprint
     - iOS: Add bundle identifier
   - **API restrictions:** Select only Maps SDK for Android/iOS

---

## Step 2: Add API Key to Android

### File Location:
```
ev-chargiing/android/app/src/main/AndroidManifest.xml
```

### Line 15-16:

**BEFORE:**
```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_Maps_API_KEY"/>
```

**AFTER (replace with your key):**
```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="AIzaSyB1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p"/>
```

### Complete Context:
```xml
<application
    android:label="EV Charging App"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">

    <!-- ADD YOUR API KEY HERE -->
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR_ACTUAL_API_KEY_HERE"/>

    <activity android:name=".MainActivity" ...>
```

---

## Step 3: Add API Key to iOS

### File Location:
```
ev-chargiing/ios/Runner/AppDelegate.swift
```

### Line 12:

**BEFORE:**
```swift
GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
```

**AFTER (replace with your key):**
```swift
GMSServices.provideAPIKey("AIzaSyB1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p")
```

### Complete Context:
```swift
import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // ADD YOUR API KEY HERE
    GMSServices.provideAPIKey("YOUR_ACTUAL_API_KEY_HERE")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## Step 4: Test Google Maps

### Android:
```bash
flutter run
# Make sure you're running on Android emulator or device
```

### iOS:
```bash
flutter run
# Make sure you're running on iOS simulator or device
```

### If map doesn't show:
1. ✅ Check API key is correct (no extra spaces)
2. ✅ Verify "Maps SDK for Android/iOS" is enabled in Google Console
3. ✅ Ensure billing is enabled on Google Cloud project
4. ✅ Restart the app completely (hot reload won't work)
5. ✅ Check logs for errors: `flutter logs`

---

## Common Errors & Solutions

### Error: "Google Maps SDK needs to be initialized"
**Solution:** Billing not enabled on Google Cloud project

### Error: "This API project is not authorized to use this API"
**Solution:** Enable "Maps SDK for Android" or "Maps SDK for iOS" in Google Console

### Error: Map shows "For development purposes only"
**Solution:**
- This is normal without billing
- Enable billing to remove watermark
- Or add payment method (free tier = $200/month credit)

### Error: Blank/gray map screen
**Solutions:**
1. Check API key is correct
2. Enable billing
3. Wait 5 minutes after enabling APIs (propagation time)
4. Restart app (not hot reload)
5. Check console logs: `flutter logs`

---

## Security Best Practices

### Don't commit API keys to Git
Add to `.gitignore`:
```
# API Keys (add this line)
**/google_maps_api_key.txt
```

### Use restricted API keys in production:
1. Go to Google Cloud Console → Credentials
2. Click on your API key → "Edit"
3. **Application restrictions:**
   - Android apps: Add SHA-1 fingerprint
   - iOS apps: Add bundle identifier
4. **API restrictions:**
   - Select "Restrict key"
   - Choose only "Maps SDK for Android" and "Maps SDK for iOS"

### Environment-specific keys (Advanced):
- Use different API keys for dev/staging/production
- Store in environment variables or secure vaults
- Use build flavors in Flutter

---

## Test Checklist

- [ ] API key copied from Google Cloud Console
- [ ] Maps SDK for Android enabled
- [ ] Maps SDK for iOS enabled
- [ ] Billing enabled on Google Cloud project
- [ ] API key added to `AndroidManifest.xml` (line 16)
- [ ] API key added to `AppDelegate.swift` (line 12)
- [ ] App restarted (not just hot reload)
- [ ] Map shows with providers/markers
- [ ] No "For development purposes only" watermark (if billing enabled)

---

## Verify Setup

### Android Emulator:
```bash
flutter run -d emulator-5554
# Tap on map screen
# Should see map with charging station markers
```

### iOS Simulator:
```bash
flutter run -d iPhone
# Tap on map screen
# Should see map with charging station markers
```

---

## Cost Estimate (Google Maps)

**Free Tier:**
- $200 credit per month
- Map loads: 28,000 free per month
- For small apps: **FREE**

**After Free Tier:**
- Map loads: $7 per 1,000 loads
- For 10K users: ~$50-100/month

**Tips to reduce costs:**
- Cache map tiles
- Use static maps for thumbnails
- Implement rate limiting
- Monitor usage in Google Console

---

## Getting Your Android SHA-1 Fingerprint (for API key restriction)

```bash
cd android

# Debug key (for development)
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Release key (for production)
keytool -list -v -keystore your-release-key.jks -alias your-alias
```

Copy the SHA-1 fingerprint and add it to your API key restrictions in Google Console.

---

## Need Help?

Check Google Maps Flutter plugin docs:
https://pub.dev/packages/google_maps_flutter

Google Cloud Console:
https://console.cloud.google.com/

---

**Your API key locations:**
1. ✅ `android/app/src/main/AndroidManifest.xml` (line 16)
2. ✅ `ios/Runner/AppDelegate.swift` (line 12)

**Replace `YOUR_GOOGLE_MAPS_API_KEY` / `YOUR_Maps_API_KEY` with your actual key!**
