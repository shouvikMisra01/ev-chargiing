# 🔐 Environment Setup - Single Source of Truth

## Overview

All API keys are stored in **ONE FILE**: `.env` at the project root. This file is gitignored and will never be committed to GitHub.

The script `./scripts/generate_config.sh` reads `.env` and generates platform-specific config files automatically.

---

## Quick Setup (3 Steps)

### 1. Create `.env` file

```bash
# Copy the example file
cp .env.example .env

# Edit .env and add your API keys
nano .env  # or use any text editor
```

Add your Google Maps API key:

```bash
GOOGLE_MAPS_API_KEY=AIza...your-actual-key-here
```

### 2. Generate config files

```bash
# Run the generation script
./scripts/generate_config.sh
```

This generates:
- ✅ `web/config.js` (for Flutter Web)
- ✅ `lib/core/config/api_keys.dart` (for Flutter/Dart code)
- ✅ `ios/Runner/Config.swift` (for iOS)
- ✅ Android reads from `.env` automatically via `build.gradle`

### 3. Run your app

```bash
# For web
flutter run -d chrome

# For Android
flutter run

# For iOS
flutter run
```

---

## How It Works

### Single Source of Truth: `.env`

```
.env (gitignored)
  │
  ├─> web/config.js              (Web)
  ├─> lib/core/config/api_keys.dart  (Flutter/Dart)
  ├─> ios/Runner/Config.swift    (iOS)
  └─> android/app/build.gradle   (Android - reads directly)
```

### File Security

✅ **Gitignored (Safe):**
- `.env` - Main config file
- `web/config.js` - Generated
- `lib/core/config/api_keys.dart` - Generated
- `ios/Runner/Config.swift` - Generated

✅ **Committed to Git (Safe - Templates only):**
- `.env.example` - Template
- `web/config.js.example` - Template
- `lib/core/config/api_keys.dart.example` - Template
- `android/app/build.gradle` - Reads from .env at build time
- `ios/Runner/AppDelegate.swift` - Reads from Config.swift

---

## Get Your Google Maps API Key

### Step 1: Create API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a project or select existing
3. Enable these APIs:
   - **Maps JavaScript API** (for Web) ✅
   - **Maps SDK for Android** (for Android) ✅
   - **Maps SDK for iOS** (for iOS) ✅
4. Go to **Credentials** → **Create Credentials** → **API Key**
5. Copy your API key (starts with `AIza...`)

### Step 2: Enable Billing

**Important:** Enable billing on Google Cloud project
- Free tier: $200/month credit
- Most apps stay within free tier
- Without billing, maps won't load

### Step 3: Add to .env

Open `.env` and replace the placeholder:

```bash
GOOGLE_MAPS_API_KEY=AIzaSyB1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p
```

### Step 4: Regenerate Configs

```bash
./scripts/generate_config.sh
```

Done! ✅

---

## Adding New Team Members

1. **Do NOT** share `.env` file via Git (it's gitignored)
2. **Do** share the API key securely (Slack DM, password manager, etc.)
3. New member creates their own `.env` file:

```bash
cp .env.example .env
# Add API key to .env
./scripts/generate_config.sh
```

---

## Adding More API Keys

Edit `.env` and add new keys:

```bash
# Google Maps API Key
GOOGLE_MAPS_API_KEY=AIza...

# Razorpay Payment Gateway
RAZORPAY_KEY_ID=rzp_test_...
RAZORPAY_KEY_SECRET=...

# Firebase
FIREBASE_API_KEY=...
```

Then update `scripts/generate_config.sh` to include the new keys in generated files.

---

## Platform-Specific Details

### Web (Flutter Web)

- Config file: `web/config.js`
- Auto-generated from `.env`
- Loaded by `web/index.html` at runtime
- **No manual editing needed**

### Android

- Reads `.env` directly via `android/app/build.gradle`
- Injects into `AndroidManifest.xml` at build time
- Uses placeholder: `${GOOGLE_MAPS_API_KEY}`
- **No manual editing needed**

### iOS

- Config file: `ios/Runner/Config.swift`
- Auto-generated from `.env`
- Used by `AppDelegate.swift` via `AppConfig.googleMapsApiKey`
- **No manual editing needed**

### Flutter/Dart Code

- Config file: `lib/core/config/api_keys.dart`
- Auto-generated from `.env`
- Use anywhere in Dart: `ApiKeys.googleMapsApiKey`
- **No manual editing needed**

---

## Security Best Practices

### ✅ DO:
- Keep `.env` file gitignored
- Add API key restrictions in Google Cloud Console
- Use different API keys for dev/staging/production
- Share API keys securely (not via email or public Slack)
- Regenerate configs after updating `.env`

### ❌ DON'T:
- Commit `.env` to Git
- Hardcode API keys in committed files
- Share `.env` file publicly
- Use production keys in development

---

## Troubleshooting

### "Config file not found" error

**Solution:**
```bash
./scripts/generate_config.sh
```

### Maps not loading

**Checklist:**
1. ✅ `.env` file exists with your API key
2. ✅ Ran `./scripts/generate_config.sh`
3. ✅ Maps JavaScript API enabled in Google Console
4. ✅ Billing enabled on Google Cloud project
5. ✅ Restarted app (not just hot reload)

### Android build fails

**Solution:**
- Ensure `.env` file exists in project root
- Check `.env` has `GOOGLE_MAPS_API_KEY=...` (no spaces)
- Run `./scripts/generate_config.sh`

### iOS build fails

**Solution:**
- Ensure `ios/Runner/Config.swift` exists
- Run `./scripts/generate_config.sh`
- Add `Config.swift` to Xcode project if needed

---

## Verify Setup

```bash
# 1. Check .env file exists
cat .env

# 2. Generate config files
./scripts/generate_config.sh

# 3. Verify generated files
ls -la web/config.js
ls -la lib/core/config/api_keys.dart
ls -la ios/Runner/Config.swift

# 4. Verify files are gitignored
git check-ignore .env web/config.js lib/core/config/api_keys.dart ios/Runner/Config.swift

# All 4 files should be listed (means they're gitignored ✅)
```

---

## What Gets Committed to Git?

✅ **Safe to commit:**
- `.env.example` - Template
- `scripts/generate_config.sh` - Generation script
- `android/app/build.gradle` - Reads from .env
- `ios/Runner/AppDelegate.swift` - Uses Config.swift
- `web/index.html` - Loads config.js

❌ **Never committed:**
- `.env` - Your actual API keys
- `web/config.js` - Generated file
- `lib/core/config/api_keys.dart` - Generated file
- `ios/Runner/Config.swift` - Generated file

---

## Quick Reference

```bash
# Create .env file
cp .env.example .env

# Edit .env (add your API keys)
nano .env

# Generate all config files
./scripts/generate_config.sh

# Run the app
flutter run -d chrome
```

---

## Need Help?

- See `GOOGLE_MAPS_SETUP.md` for detailed Google Maps setup
- See `API_KEYS_SETUP.md` for alternative setup methods
- Check `.env.example` for template

**Remember:** `.env` is your single source of truth for all API keys!
