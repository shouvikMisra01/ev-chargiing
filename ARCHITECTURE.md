# EV Charging App - Clean Architecture Documentation

## 📋 Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Tech Stack](#tech-stack)
3. [Project Structure](#project-structure)
4. [Data Flow](#data-flow)
5. [Features](#features)
6. [Code Generation](#code-generation)
7. [Running the App](#running-the-app)

## 🏗️ Architecture Overview

This app follows **Clean Architecture** with three distinct layers:

```
┌──────────────────────────────────────────────┐
│         PRESENTATION LAYER                    │
│  • Screens (UI)                               │
│  • Widgets                                    │
│  • Riverpod Providers (State Management)     │
└──────────────────────────────────────────────┘
                    ↓
┌──────────────────────────────────────────────┐
│           DOMAIN LAYER                        │
│  • Entities (Business Models)                 │
│  • Use Cases (Business Logic)                 │
│  • Repository Interfaces                      │
└──────────────────────────────────────────────┘
                    ↓
┌──────────────────────────────────────────────┐
│            DATA LAYER                         │
│  • Models (Data Transfer Objects)             │
│  • Repository Implementations                 │
│  • Data Sources (API, Local DB)               │
└──────────────────────────────────────────────┘
```

### Key Principles

1. **Dependency Rule**: Dependencies only point inward (Data → Domain ← Presentation)
2. **Separation of Concerns**: Each layer has a single responsibility
3. **Testability**: Business logic is isolated and easily testable
4. **Scalability**: Easy to add new features without affecting existing code

## 🛠️ Tech Stack

### State Management
- **Riverpod 2.x** with code generation
- Why: Compile-time safety, less boilerplate, better performance than Bloc

### Navigation
- **GoRouter** for declarative, type-safe routing
- Role-based route guards (User vs Owner)

### Code Generation
- **Freezed**: Immutable data classes, unions, pattern matching
- **JSON Serializable**: Automatic JSON serialization
- **Riverpod Generator**: Generate providers

### Backend (Mock)
- **Dio**: HTTP client with interceptors
- **Firebase**: Auth, Firestore, Storage (future integration)
- Mock data sources for development

## 📁 Project Structure

```
lib/
├── core/                           # Core app functionality
│   ├── constants/
│   │   ├── app_constants.dart      # App-wide constants
│   │   └── api_endpoints.dart      # API endpoints
│   ├── theme/
│   │   ├── app_theme.dart          # Material & Cupertino themes
│   │   ├── app_colors.dart         # Color palette
│   │   └── app_text_styles.dart    # Typography
│   ├── errors/
│   │   ├── failures.dart           # Failure classes
│   │   └── exceptions.dart         # Exception classes
│   ├── network/
│   │   ├── dio_client.dart         # HTTP client configuration
│   │   └── auth_interceptor.dart   # JWT token handling
│   ├── services/
│   │   └── token_service.dart      # Secure token storage
│   └── utils/
│       ├── validators.dart         # Form validators
│       └── helpers.dart            # Utility functions
│
├── shared/                         # Shared across features
│   ├── models/
│   │   ├── enums.dart              # Shared enums
│   │   ├── location.dart           # Location model
│   │   └── time_slot.dart          # Time slot model
│   └── widgets/                    # Reusable widgets
│
├── features/                       # Feature modules
│   ├── auth/                       # Authentication
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── send_otp_usecase.dart
│   │   │       ├── verify_otp_usecase.dart
│   │   │       └── get_current_user_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       ├── screens/
│   │       │   ├── phone_input_screen.dart
│   │       │   ├── otp_verification_screen.dart
│   │       │   └── role_selection_screen.dart
│   │       └── widgets/
│   │           └── phone_input_field.dart
│   │
│   ├── map/                        # Map & Provider Discovery
│   │   ├── data/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── usecases/
│   │   │       ├── get_nearby_providers_usecase.dart
│   │   │       └── filter_by_time_usecase.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── map_screen.dart
│   │       │   └── provider_details_screen.dart
│   │       └── widgets/
│   │           ├── map_view.dart
│   │           └── time_filter_sheet.dart
│   │
│   ├── booking/                    # Booking Management
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   │   └── booking_model.dart
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── booking_entity.dart
│   │   │   └── usecases/
│   │   │       ├── create_booking_usecase.dart
│   │   │       ├── cancel_booking_usecase.dart
│   │   │       └── get_user_bookings_usecase.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── booking_screen.dart
│   │       │   └── booking_history_screen.dart
│   │       └── widgets/
│   │           └── time_slot_picker.dart
│   │
│   ├── charging/                   # Charging Session
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── charging_session_entity.dart
│   │   │   └── usecases/
│   │   │       ├── start_charging_usecase.dart
│   │   │       └── end_charging_usecase.dart
│   │   └── presentation/
│   │       └── screens/
│   │           └── charging_session_screen.dart
│   │
│   ├── payment/                    # Payments & Wallet
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── payment_entity.dart
│   │   │   └── usecases/
│   │   │       └── process_payment_usecase.dart
│   │   └── presentation/
│   │       └── screens/
│   │           ├── wallet_screen.dart
│   │           └── payment_screen.dart
│   │
│   ├── owner/                      # Owner Features
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── provider_entity.dart
│   │   │   │   └── kyc_entity.dart
│   │   │   └── usecases/
│   │   │       ├── register_provider_usecase.dart
│   │   │       └── submit_kyc_usecase.dart
│   │   └── presentation/
│   │       └── screens/
│   │           ├── owner_dashboard_screen.dart
│   │           ├── provider_setup_screen.dart
│   │           ├── kyc_upload_screen.dart
│   │           └── availability_management_screen.dart
│   │
│   ├── rating/                     # Ratings & Reviews
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       └── rating_entity.dart
│   │   └── presentation/
│   │       └── screens/
│   │           └── rating_screen.dart
│   │
│   └── profile/                    # User Profile
│       └── presentation/
│           └── screens/
│               └── profile_screen.dart
│
└── main.dart                       # App entry point
```

## 🔄 Data Flow

### Example: Creating a Booking

```
1. User taps "Book" button on UI
   ↓
2. BookingScreen calls provider method
   ↓
3. BookingProvider.createBooking()
   ↓
4. CreateBookingUseCase.call(params)
   ↓
5. BookingRepository.createBooking()
   ↓
6. BookingRemoteDataSource.createBooking()
   ↓
7. Dio makes API call
   ↓
8. JSON response → BookingModel
   ↓
9. BookingModel → BookingEntity (domain)
   ↓
10. Success/Failure result returns up the chain
   ↓
11. UI updates via Riverpod state change
```

## ✨ Features

### 1. Authentication (Phone OTP)
- **Flow**: Phone Input → Send OTP → Verify OTP → Role Selection
- **Tech**: Firebase Auth (future) / Mock API (current)
- **Screens**: `phone_input_screen.dart`, `otp_verification_screen.dart`, `role_selection_screen.dart`

### 2. Map & Time-Based Search (CRITICAL FEATURE)
- **Functionality**:
  - Show nearby providers on Google Maps
  - Filter by future time window ("I'll arrive in 4 hours")
  - Only show providers available during that time
- **Tech**: Google Maps Flutter, Geolocator, custom time filtering algorithm
- **Screens**: `map_screen.dart`, `time_filter_sheet.dart`

### 3. Booking System
- **Features**:
  - Time slot selection
  - Double-booking prevention
  - Booking confirmation
  - Cancellation with refund
- **States**: Pending → Confirmed → Active → Completed / Cancelled
- **Screens**: `booking_screen.dart`, `booking_history_screen.dart`

### 4. Charging Session
- **Flow**: Start → Active (with timer) → End → Payment
- **Features**: Real-time timer, energy tracking (future), auto-cost calculation
- **Screens**: `charging_session_screen.dart`

### 5. Payment & Wallet
- **Methods**: Wallet, UPI, Card, Net Banking
- **Features**: Add money, auto-debit, transaction history, owner payouts
- **Commission**: Platform takes 15% (configurable)
- **Screens**: `wallet_screen.dart`, `payment_screen.dart`

### 6. Owner KYC Verification
- **Documents Required**:
  - Government ID (Aadhaar/PAN/License/Passport)
  - Property Proof (Bill/Tax/Agreement/Deed)
  - Charging facility proof
- **Screens**: `kyc_upload_screen.dart`

### 7. Ratings & Trust Score
- **Features**: 5-star ratings, reviews, trust score calculation
- **Screens**: `rating_screen.dart`

## 🔧 Code Generation

This project uses code generation extensively. Run these commands:

### Generate all code (Freezed, JSON, Riverpod)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Watch mode (auto-regenerate on file changes)
```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 🚀 Running the App

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Generate Code
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run the App
```bash
flutter run
```

## 📝 Implementation Guide

### Adding a New Feature

1. **Create Domain Layer** (business logic)
   - Define entities in `domain/entities/`
   - Create repository interface in `domain/repositories/`
   - Implement use cases in `domain/usecases/`

2. **Create Data Layer** (data handling)
   - Create models in `data/models/` with Freezed
   - Implement repository in `data/repositories/`
   - Create data source in `data/datasources/`

3. **Create Presentation Layer** (UI)
   - Create Riverpod providers in `presentation/providers/`
   - Build screens in `presentation/screens/`
   - Create reusable widgets in `presentation/widgets/`

4. **Register Routes** in `GoRouter` configuration

### Example: Auth Flow Implementation

See `/lib/features/auth/` for complete implementation pattern.

## 🎯 Critical Implementation Details

### Time-Based Filtering Algorithm

```dart
// Pseudo-code for time-based provider search
List<Provider> filterByTime(
  List<Provider> allProviders,
  DateTime arrivalTime,
  Duration chargingDuration,
) {
  return allProviders.where((provider) {
    // Check if provider will be online
    if (!provider.isOnline) return false;

    // Check if provider has available slots
    final slots = provider.getAvailableSlots(arrivalTime.date);

    // Find slots that fit the requested time window
    return slots.any((slot) =>
      slot.startTime <= arrivalTime &&
      slot.endTime >= arrivalTime.add(chargingDuration) &&
      !slot.isBooked
    );
  }).toList();
}
```

### Double Booking Prevention

```dart
// Repository level check
Future<bool> isSlotAvailable(String providerId, TimeSlot slot) async {
  final existingBookings = await getProviderBookings(providerId);

  return !existingBookings.any((booking) =>
    booking.status != BookingStatus.cancelled &&
    Helpers.doTimeSlotsOverlap(
      booking.startTime,
      booking.endTime,
      slot.startTime,
      slot.endTime,
    )
  );
}
```

## 🧪 Testing Strategy

- **Unit Tests**: Use cases, repositories, utils
- **Widget Tests**: Individual screens and widgets
- **Integration Tests**: Complete user flows
- **Mock Data**: All API calls use mock data sources

## 🔐 Security Considerations

- JWT tokens stored in `FlutterSecureStorage`
- Auto token refresh via interceptor
- API calls authenticated via Bearer token
- Input validation on all forms
- Sensitive data (KYC) encrypted at rest

## 📱 Platform Support

- iOS: Yes (Cupertino adaptive UI)
- Android: Yes (Material 3)
- Web: Partial (no camera/location)
- Desktop: No (not prioritized)

## 🎨 UI/UX Notes

- **Adaptive UI**: Automatically switches between Material (Android) and Cupertino (iOS)
- **Theme**: Green primary color (#00C853) for EV branding
- **Accessibility**: Semantic labels, font scaling support
- **Offline**: Basic caching, offline-first for bookings

---

**Next Steps**: Implement remaining screens, connect to real backend, add Firebase integration, implement analytics.
