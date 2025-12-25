# 🔐 API Keys - Quick Start

## TL;DR

**One file to rule them all:** `.env`

```bash
# 1. Setup
cp .env.example .env
nano .env  # Add your Google Maps API key

# 2. Generate configs for all platforms
./scripts/generate_config.sh

# 3. Run
flutter run -d chrome
```

That's it! ✅

---

## File Structure

```
.env (gitignored) ← SINGLE SOURCE OF TRUTH
  │
  ├─> web/config.js               (Web - gitignored)
  ├─> lib/core/config/api_keys.dart   (Flutter - gitignored)
  ├─> ios/Runner/Config.swift     (iOS - gitignored)
  └─> Android build.gradle reads .env directly
```

---

## Security Status

### ✅ Gitignored (Your actual API keys - SAFE):
- `.env`
- `web/config.js`
- `lib/core/config/api_keys.dart`
- `ios/Runner/Config.swift`

### ✅ Committed to Git (Templates & scripts - SAFE):
- `.env.example`
- `scripts/generate_config.sh`
- `ENV_SETUP.md` (detailed docs)

**Result:** Your API keys are NEVER pushed to GitHub! 🎉

---

## How Each Platform Gets API Keys

| Platform | How It Works |
|----------|-------------|
| **Web** | `index.html` loads `config.js` (auto-generated from .env) |
| **Android** | `build.gradle` reads .env → injects into AndroidManifest.xml |
| **iOS** | AppDelegate.swift uses `Config.swift` (auto-generated from .env) |
| **Flutter Code** | Import `ApiKeys.googleMapsApiKey` (auto-generated from .env) |

All generated from ONE file: `.env`

---

## Get Google Maps API Key

1. [Google Cloud Console](https://console.cloud.google.com/) → Create project
2. Enable: Maps JavaScript API, Maps SDK for Android/iOS
3. Credentials → Create API Key
4. **Enable billing** (Free $200/month credit)
5. Copy key to `.env`
6. Run `./scripts/generate_config.sh`

---

## For Team Members

**DON'T** commit `.env` to Git!

**DO** share API key securely:
1. Get API key from team lead (via Slack DM, password manager, etc.)
2. Create your `.env` file:
   ```bash
   cp .env.example .env
   # Paste API key into .env
   ./scripts/generate_config.sh
   ```

---

## Detailed Docs

- 📖 `ENV_SETUP.md` - Full setup guide
- 📖 `GOOGLE_MAPS_SETUP.md` - Google Maps specific
- 📖 `API_KEYS_SETUP.md` - Alternative methods

---

## Verify Setup

```bash
# All 4 files should be listed (means gitignored ✅)
git check-ignore .env web/config.js lib/core/config/api_keys.dart ios/Runner/Config.swift
```

---

**Remember:** Always run `./scripts/generate_config.sh` after updating `.env`!
