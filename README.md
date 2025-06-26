# EV Charging Mobile App

A comprehensive Flutter mobile application for EV charging station management with two main user roles: Residential Owners and EV Users.

## Features

### Authentication
- Email and mobile number registration/login
- Role-based user accounts (EV User vs Provider)
- Firebase Authentication integration

### EV Users
- **Map Integration**: Find nearby charging stations using Google Maps
- **Real-time Search**: View available charging stations in real-time
- **Booking System**: Book time slots based on provider availability
- **Booking Management**: View and manage current and past bookings
- **Provider Details**: View charging port types, pricing, and availability

### Residential Owners (Providers)
- **Provider Setup**: Register as a charging provider with verification
- **Document Upload**: Submit proof of parking and charging equipment
- **Availability Management**: Set specific time slots for availability
- **Online/Offline Status**: Toggle availability in real-time
- **Booking Management**: Accept/decline booking requests
- **Dashboard**: View earnings, today's bookings, and analytics

### Additional Features
- **Real-time Updates**: Live status updates for availability and bookings
- **Location Services**: GPS integration for accurate location tracking
- **Image Upload**: Camera integration for document verification
- **Responsive Design**: Optimized for various screen sizes
- **Material Design**: Modern UI following Material Design principles

## Technical Stack

- **Framework**: Flutter 3.0+
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Maps**: Google Maps Flutter
- **State Management**: Provider pattern
- **Location**: Geolocator & Geocoding
- **Image Handling**: Image Picker
- **Date/Time**: DateTime Picker Plus

## Setup Instructions

### Prerequisites
1. Flutter SDK (3.0 or higher)
2. Firebase project setup
3. Google Maps API key
4. Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ev_charging_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Authentication (Email/Password)
   - Create Firestore database
   - Enable Storage
   - Download `google-services.json` and place in `android/app/`

4. **Google Maps Setup**
   - Get Google Maps API key from Google Cloud Console
   - Enable Maps SDK for Android
   - Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml`

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_model.dart
│   └── booking_model.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── user_provider.dart
│   └── booking_provider.dart
├── screens/                  # UI screens
│   ├── auth/                # Authentication screens
│   ├── user/                # EV user screens
│   ├── owner/               # Provider screens
│   └── profile_screen.dart
└── utils/                   # Utilities
    └── app_theme.dart
```

## Database Schema

### Users Collection
```json
{
  "id": "string",
  "email": "string",
  "phoneNumber": "string",
  "name": "string",
  "role": "user|owner",
  "isVerified": "boolean",
  "createdAt": "timestamp",
  "providerDetails": {
    "address": "string",
    "latitude": "number",
    "longitude": "number",
    "equipmentImages": ["string"],
    "parkingImages": ["string"],
    "chargingPortType": "string",
    "pricePerHour": "number",
    "isOnline": "boolean",
    "availableSlots": [
      {
        "startTime": "timestamp",
        "endTime": "timestamp",
        "isBooked": "boolean",
        "bookedBy": "string"
      }
    ]
  }
}
```

### Bookings Collection
```json
{
  "id": "string",
  "userId": "string",
  "providerId": "string",
  "startTime": "timestamp",
  "endTime": "timestamp",
  "totalAmount": "number",
  "status": "pending|confirmed|active|completed|cancelled",
  "createdAt": "timestamp",
  "providerAddress": "string",
  "providerLatitude": "number",
  "providerLongitude": "number"
}
```

## Key Features Implementation

### Real-time Location Tracking
- Uses Geolocator for GPS positioning
- Geocoding for address resolution
- Distance calculation for nearby providers

### Map Integration
- Google Maps with custom markers
- Real-time provider locations
- Interactive map with provider details

### Booking System
- Time slot management
- Conflict detection
- Real-time availability updates

### Image Upload
- Camera and gallery integration
- Firebase Storage for image hosting
- Verification document management

## Security Features

- Firebase Authentication
- Role-based access control
- Data validation
- Secure API endpoints

## Future Enhancements

- Payment gateway integration
- Push notifications
- Rating and review system
- Advanced analytics
- Multi-language support
- Dark mode theme

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please contact [your-email@example.com]