# 🔐 API Keys Setup Guide

## Important Security Notice

**Never commit your API keys to Git!** This project uses gitignored config files to keep your keys safe.

---

## Quick Setup

### 1. Google Maps API Key (Required for Maps)

#### Get Your API Key:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable these APIs:
   - **Maps JavaScript API** (for Web) ✅
   - **Maps SDK for Android** (for Android app)
   - **Maps SDK for iOS** (for iOS app)
4. Go to **Credentials** → **Create Credentials** → **API Key**
5. Copy your API key
6. **Enable billing** (Free tier includes $200/month credit)

#### Add Your Key:

**For Web (Flutter Web):**

Open `web/config.js` and replace the placeholder:

```javascript
window.GOOGLE_MAPS_API_KEY = 'AIza...your-actual-key-here';
```

**For Mobile (Android/iOS):**

Open `lib/core/config/api_keys.dart` and replace:

```dart
static const String googleMapsApiKey = 'AIza...your-actual-key-here';
```

**For Android (AndroidManifest.xml):**

Open `android/app/src/main/AndroidManifest.xml` and update line ~16:

```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="AIza...your-actual-key-here"/>
```

**For iOS (AppDelegate.swift):**

Open `ios/Runner/AppDelegate.swift` and update line ~12:

```swift
GMSServices.provideAPIKey("AIza...your-actual-key-here")
```

---

## File Structure

```
ev-chargiing/
├── web/
│   ├── config.js              # ← Add your key here (gitignored)
│   └── config.js.example      # Template (committed to git)
├── lib/core/config/
│   ├── api_keys.dart          # ← Add your key here (gitignored)
│   └── api_keys.dart.example  # Template (committed to git)
├── android/app/src/main/
│   └── AndroidManifest.xml    # Add key here too
└── ios/Runner/
    └── AppDelegate.swift      # Add key here too
```

---

## Security Best Practices

### ✅ DO:
- Add API keys to gitignored files (`config.js`, `api_keys.dart`)
- Use API key restrictions in Google Cloud Console
- Enable billing (prevents abuse with $200/month free tier)
- Restrict keys by platform (Android SHA-1, iOS bundle ID)
- Rotate keys if accidentally exposed

### ❌ DON'T:
- Commit `config.js` or `api_keys.dart` to Git
- Share your API keys publicly
- Use same key for dev/staging/production
- Hardcode keys in committed files

---

## Verify Setup

After adding your API key, restart the app:

```bash
# Kill running app
# Restart for web
flutter run -d chrome

# Or for mobile
flutter run
```

You should see:
- ✅ Map loads without errors
- ✅ No "Google Maps API key not configured" warning in console
- ✅ Charging station markers appear on map

---

## Troubleshooting

### Map doesn't load (blank/gray screen)

**Solution:**
1. Check API key is correct (no extra spaces)
2. Verify "Maps JavaScript API" is enabled in Google Console
3. Enable billing on Google Cloud project
4. Wait 5 minutes after enabling APIs (propagation delay)
5. Hard refresh browser (Cmd/Ctrl + Shift + R)

### Console shows "API key not configured"

**Solution:**
- Check `web/config.js` exists and has your key
- Make sure key is not `YOUR_GOOGLE_MAPS_API_KEY_HERE`
- Restart the app (not just hot reload)

### "This API project is not authorized"

**Solution:**
- Enable "Maps JavaScript API" in Google Console
- Enable "Maps SDK for Android" for mobile

### Map shows "For development purposes only"

**Solution:**
- Enable billing on Google Cloud project
- Or ignore it (free tier still works, just has watermark)

---

## Cost Information

**Free Tier:**
- $200 credit per month
- ~28,000 map loads free per month
- For development: **FREE**

**After Free Tier:**
- Map loads: $7 per 1,000 loads
- Most small apps stay within free tier

---

## Need Help?

- Google Maps Setup: See `GOOGLE_MAPS_SETUP.md`
- Google Cloud Console: https://console.cloud.google.com/
- Maps Flutter Plugin: https://pub.dev/packages/google_maps_flutter

---

## Gitignored Files (Safe for Your Keys)

These files are automatically ignored by Git:

- ✅ `web/config.js`
- ✅ `lib/core/config/api_keys.dart`
- ✅ `.env` files

You can safely add your API keys to these files!
