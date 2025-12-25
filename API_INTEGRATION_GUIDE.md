# 🔌 API Integration Guide - Flutter to Backend

## ✅ What Has Been Completed

### 1. Backend URL Configuration

**File:** `lib/core/constants/app_constants.dart`

```dart
// Android Emulator (connects to host machine's localhost)
static const String baseUrl = 'http://10.0.2.2:3000/api';

// iOS Simulator (use localhost)
// static const String baseUrl = 'http://localhost:3000/api';

// Production
// static const String baseUrl = 'https://api.chargespot.com/api';
```

**Instructions:**
- For Android Emulator: Keep `10.0.2.2:3000/api` (already set)
- For iOS Simulator: Uncomment the localhost line
- For Production: Replace with your actual backend URL

---

### 2. API Endpoints Updated

**File:** `lib/core/constants/api_endpoints.dart`

All endpoints now match the backend routes:
- ✅ Auth: `/auth/send-otp`, `/auth/verify-otp`
- ✅ User: `/user/profile`
- ✅ Stations: `/stations/search`, `/stations/:id`, `/stations/:id/availability`
- ✅ Bookings: `/bookings`, `/bookings/:id`, `/bookings/:id/cancel`
- ⚠️ Owner/Payment/KYC endpoints are placeholders (backend needs implementation)

---

### 3. Authentication - Real API Connected

**File:** `lib/features/auth/data/datasources/auth_remote_datasource.dart`

**✅ Implemented:**
- `sendOtp()` - Calls `POST /auth/send-otp`
- `verifyOtp()` - Calls `POST /auth/verify-otp`, saves JWT tokens
- `getCurrentUser()` - Calls `GET /user/profile`
- `updateProfile()` - Calls `PUT /user/profile`
- `logout()` - Calls `POST /auth/logout`, clears local tokens

**Request/Response Format:**

```dart
// Send OTP
POST /auth/send-otp
Body: { "phone": "+919876543210" }
Response: { "message": "OTP sent successfully" }

// Verify OTP
POST /auth/verify-otp
Body: { "phone": "+919876543210", "otp": "123456" }
Response: {
  "accessToken": "eyJhbGc...",
  "refreshToken": "eyJhbGc...",
  "user": {
    "id": "uuid",
    "phone": "+919876543210",
    "role": "USER",
    "name": "John Doe",
    // ...
  }
}
```

---

### 4. Station/Map Search - Real API Connected

**New File:** `lib/features/map/data/datasources/station_remote_datasource.dart`

**✅ Implemented:**
- `searchStations()` - Calls `POST /stations/search` with time-based geo search
- `getStationDetails()` - Calls `GET /stations/:id`
- `getStationAvailability()` - Calls `GET /stations/:id/availability`

**Updated File:** `lib/features/map/presentation/providers/map_providers.dart`

Now uses real API with automatic fallback to mock data if:
- Backend is not running
- API call fails
- Location permission denied

**Request Format:**

```dart
POST /stations/search
Body: {
  "latitude": 28.6139,
  "longitude": 77.2090,
  "arrivalTime": "2025-12-23T18:00:00Z",  // Optional
  "chargingDuration": 2,                   // hours
  "radius": 10.0,                          // km
  "chargerType": "Type2"                   // Optional
}

Response: {
  "stations": [
    {
      "id": "uuid",
      "owner_id": "uuid",
      "owner_name": "Rajesh Kumar",
      "latitude": 28.6139,
      "longitude": 77.2090,
      "address": "Connaught Place",
      "city": "New Delhi",
      "state": "Delhi",
      "pincode": "110001",
      "charger_type": "Type2",
      "price_per_hour": 50.0,
      "is_online": true,
      "is_verified": true,
      "rating": 4.5,
      "total_ratings": 120,
      "distance_km": 2.3,
      "available_slots": [
        {
          "id": "uuid",
          "start_time": "2025-12-23T18:00:00Z",
          "end_time": "2025-12-23T20:00:00Z",
          "is_booked": false
        }
      ]
    }
  ]
}
```

---

### 5. Booking - Real API Connected

**New File:** `lib/features/booking/data/datasources/booking_remote_datasource.dart`

**✅ Implemented:**
- `createBooking()` - Calls `POST /bookings`
- `getUserBookings()` - Calls `GET /bookings`
- `getBookingById()` - Calls `GET /bookings/:id`
- `cancelBooking()` - Calls `PUT /bookings/:id/cancel`

**Updated File:** `lib/features/booking/presentation/providers/booking_providers.dart`

Now uses real API with automatic fallback to mock data.

**Request/Response Format:**

```dart
// Create Booking
POST /bookings
Headers: { "Authorization": "Bearer <token>" }
Body: {
  "stationId": "uuid",
  "startTime": "2025-12-23T18:00:00Z",
  "endTime": "2025-12-23T20:00:00Z"
}

Response: {
  "booking": {
    "id": "uuid",
    "user_id": "uuid",
    "station_id": "uuid",
    "start_time": "2025-12-23T18:00:00Z",
    "end_time": "2025-12-23T20:00:00Z",
    "status": "CONFIRMED",
    "total_amount": 100.0,
    "price_per_hour": 50.0,
    "created_at": "2025-12-23T10:30:00Z"
  }
}

// Cancel Booking
PUT /bookings/:id/cancel
Body: { "reason": "Plans changed" }
Response: { "booking": { ...updated booking... } }
```

---

## 🔧 How It Works

### Graceful Degradation

All API-connected features have automatic fallback:

```dart
try {
  // Try to fetch from backend
  final dataSource = ref.watch(stationRemoteDataSourceProvider);
  final stations = await dataSource.searchStations(...);
  return stations;
} catch (e) {
  // If backend fails, show mock data for development
  return _getMockProviders();
}
```

**Benefits:**
- App works even if backend is down (development mode)
- Smooth transition from mock to real data
- Easy to test UI without backend

---

### Authentication Flow

1. User enters phone number → `sendOtp()` → Backend sends OTP via SMS
2. User enters OTP → `verifyOtp()` → Backend validates & returns JWT tokens
3. Tokens saved to FlutterSecureStorage
4. AuthInterceptor automatically adds token to all API requests:
   ```dart
   headers: { "Authorization": "Bearer <access_token>" }
   ```
5. If token expires, user is redirected to login

---

### Error Handling

**DioClient** (`lib/core/network/dio_client.dart`) handles all errors:

```dart
try {
  final response = await dioClient.post('/bookings', data: {...});
} on NetworkException {
  // No internet connection
} on AuthException {
  // 401/403 - Redirect to login
} on ValidationException {
  // 422 - Show field errors
} on ServerException {
  // 500+ - Show "Server error"
}
```

---

## 📝 Next Steps to Complete Integration

### Step 1: Run Code Generation (CRITICAL!)

```bash
cd /Users/shouvik_misra/Project/ev-chargiing
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**This generates:**
- `*.freezed.dart` - Immutable model classes
- `*.g.dart` - JSON serialization & Riverpod providers
- **Without this, the app won't compile!**

---

### Step 2: Start Backend

```bash
cd /Users/shouvik_misra/Project/ev-charging-backend

# 1. Install dependencies
npm install

# 2. Configure .env
cp .env.example .env
# Edit .env with your DB credentials

# 3. Start PostgreSQL (Docker)
docker ps  # Check if postgres is running

# 4. Create database
docker exec -it <postgres-container> psql -U postgres
CREATE DATABASE ev_charging;
\c ev_charging;
CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION postgis;
\q

# 5. Run migration
npm run migrate

# 6. Start Redis
docker run -d -p 6379:6379 redis:alpine

# 7. Start backend
npm run dev
# Should show: Server running on port 3000
```

---

### Step 3: Test API Connectivity

```bash
# Terminal 1: Backend should be running
npm run dev

# Terminal 2: Test health check
curl http://localhost:3000/health
# Should return: {"status":"ok"}

# Test OTP send
curl -X POST http://localhost:3000/api/auth/send-otp \
  -H "Content-Type: application/json" \
  -d '{"phone": "+919876543210"}'

# Check backend console for OTP code
```

---

### Step 4: Run Flutter App

```bash
cd /Users/shouvik_misra/Project/ev-chargiing

# For Android Emulator (uses 10.0.2.2)
flutter run

# For iOS Simulator (need to change baseUrl to localhost)
# 1. Edit lib/core/constants/app_constants.dart
# 2. Uncomment: baseUrl = 'http://localhost:3000/api'
flutter run
```

---

### Step 5: Test Complete Flow

1. **Launch app** → Should show splash screen → Onboarding
2. **Enter phone number** → Tap "Send OTP"
   - Check backend console for OTP code
   - App should show success message
3. **Enter OTP** (from backend console) → Tap "Verify"
   - Should navigate to role selection
4. **Select "EV User"** → Should navigate to map screen
5. **Map should load with providers**
   - If backend has data: Shows real stations
   - If no data: Shows 5 mock providers (fallback)
6. **Select a provider** → Tap "Book Now"
7. **Select time slot** → Confirm booking
   - Should create booking in backend
   - Navigate to booking history

---

## 🐛 Troubleshooting

### Issue 1: App can't connect to backend

**Symptoms:**
- Map shows mock data only
- Auth fails silently

**Solutions:**
```bash
# 1. Check backend is running
curl http://localhost:3000/health

# 2. Check Flutter logs
flutter logs
# Look for "DioException" or "Connection refused"

# 3. For Android Emulator, verify URL
# Should be: http://10.0.2.2:3000/api
# NOT: http://localhost:3000/api

# 4. Check firewall
# Ensure port 3000 is not blocked
```

---

### Issue 2: "Invalid OTP" Error

**Problem:** Backend generated OTP doesn't match what you entered

**Solution:**
```bash
# Check backend console output
# You should see: "Generated OTP for +919876543210: 123456"
# Enter EXACTLY that OTP in the app
```

---

### Issue 3: Code Generation Fails

**Symptoms:**
- `*.g.dart` files missing
- Compile errors about missing classes

**Solutions:**
```bash
# 1. Clean everything
flutter clean
rm -rf .dart_tool/
rm -rf pubspec.lock

# 2. Re-install dependencies
flutter pub get

# 3. Delete conflicting files
find lib -name "*.g.dart" -delete
find lib -name "*.freezed.dart" -delete

# 4. Run generation
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### Issue 4: Map doesn't show stations

**Symptoms:**
- Map loads but no markers
- Or shows mock data when backend has real data

**Debugging:**
```dart
// In lib/features/map/presentation/providers/map_providers.dart
// Add debug prints in build() method:

try {
  final dataSource = ref.watch(stationRemoteDataSourceProvider);
  final stations = await dataSource.searchStations(...);
  print('✅ Fetched ${stations.length} stations from API');
  return stations;
} catch (e) {
  print('❌ API failed: $e');
  print('Falling back to mock data');
  return _getMockProviders();
}
```

Check Flutter logs:
```bash
flutter logs | grep stations
```

---

## 🔍 Key Files Modified

### Configuration
- ✅ `lib/core/constants/app_constants.dart` - Backend URL
- ✅ `lib/core/constants/api_endpoints.dart` - API routes

### Auth
- ✅ `lib/features/auth/data/datasources/auth_remote_datasource.dart` - Real API calls

### Map/Stations
- ✅ `lib/features/map/data/datasources/station_remote_datasource.dart` - NEW FILE
- ✅ `lib/features/map/presentation/providers/map_providers.dart` - Real API integration

### Bookings
- ✅ `lib/features/booking/data/datasources/booking_remote_datasource.dart` - NEW FILE
- ✅ `lib/features/booking/presentation/providers/booking_providers.dart` - Real API integration

---

## 📊 Current Status

| Feature | API Status | Fallback |
|---------|-----------|----------|
| Auth (OTP) | ✅ Connected | None (critical path) |
| User Profile | ✅ Connected | None |
| Station Search | ✅ Connected | Mock data (5 stations) |
| Station Details | ✅ Connected | Mock data |
| Booking Create | ✅ Connected | Mock data |
| Booking List | ✅ Connected | Mock data (3 bookings) |
| Booking Cancel | ✅ Connected | Mock data |
| **Owner Endpoints** | ⚠️ Placeholders | Not implemented |
| **Payment/Wallet** | ⚠️ Placeholders | Not implemented |
| **KYC Upload** | ⚠️ Placeholders | Not implemented |
| **Charging Session** | ⚠️ Placeholders | Not implemented |

---

## 🚀 What You Can Test Right Now

### With Backend Running:
1. ✅ Phone OTP login flow
2. ✅ User profile fetch
3. ✅ Station search (if you have stations in DB)
4. ✅ Booking creation (with Redis locking)
5. ✅ Booking cancellation

### Without Backend (Fallback Mode):
1. ✅ Map with 5 mock stations
2. ✅ Station details
3. ✅ Booking flow with mock data
4. ✅ Booking history (3 mock bookings)

---

## 📚 Additional Resources

- **Backend API Docs:** `/ev-charging-backend/README.md`
- **Database Schema:** `/ev-charging-backend/src/db/schema.sql`
- **Flutter Architecture:** `/ev-chargiing/ARCHITECTURE.md`
- **Production Checklist:** `/PRODUCTION_CHECKLIST.md`
- **Google Maps Setup:** `/GOOGLE_MAPS_SETUP.md`

---

## ✅ Checklist Before First Run

- [ ] Backend running on port 3000
- [ ] Redis running on port 6379
- [ ] PostgreSQL with `ev_charging` database
- [ ] Database migration completed
- [ ] Flutter code generation completed
- [ ] Google Maps API keys added (Android & iOS)
- [ ] Correct baseUrl in app_constants.dart

Once all checked, run:
```bash
flutter run
```

And test the complete user flow! 🎉
