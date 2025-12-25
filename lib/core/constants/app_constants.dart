class AppConstants {
  // App Info
  static const String appName = 'ChargeSpot';
  static const String appVersion = '2.0.0';

  // API Configuration
  // For Android Emulator: Use 10.0.2.2 to connect to host machine's localhost
  // For iOS Simulator: Use localhost or 127.0.0.1
  // For Production: Replace with actual backend URL
  // static const String baseUrl = 'http://10.0.2.2:3000/api'; // Android Emulator
  static const String baseUrl = 'http://localhost:3000/api'; // Web/iOS Simulator
  // static const String baseUrl = 'https://api.chargespot.com/api'; // Production
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;

  // Map Configuration
  static const double defaultZoom = 14.0;
  static const double maxSearchRadius = 50.0; // km
  static const double defaultSearchRadius = 10.0; // km

  // Booking Constants
  static const int minBookingDuration = 30; // minutes
  static const int maxBookingDuration = 480; // 8 hours
  static const int slotInterval = 30; // minutes
  static const int maxAdvanceBookingDays = 30;

  // Payment Constants
  static const double platformCommissionRate = 0.15; // 15%
  static const double minWalletBalance = 50.0; // INR
  static const double maxWalletBalance = 50000.0; // INR

  // KYC Document Types
  static const List<String> acceptedIdTypes = [
    'Aadhaar Card',
    'PAN Card',
    'Driver License',
    'Passport',
  ];

  static const List<String> acceptedPropertyProofs = [
    'Electricity Bill',
    'Property Tax Receipt',
    'Rental Agreement',
    'Ownership Deed',
  ];

  // Charging Port Types
  static const List<String> chargingPortTypes = [
    'Type 1',
    'Type 2',
    'CCS',
    'CHAdeMO',
    'GB/T',
  ];

  // Rating Constants
  static const int minRatingStars = 1;
  static const int maxRatingStars = 5;
  static const double minTrustScore = 0.0;
  static const double maxTrustScore = 5.0;

  // Cache Duration
  static const Duration cacheExpiry = Duration(hours: 1);
  static const Duration tokenRefreshInterval = Duration(minutes: 50);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // OTP Configuration
  static const int otpLength = 6;
  static const Duration otpExpiry = Duration(minutes: 5);
  static const Duration otpResendDelay = Duration(seconds: 30);

  // Location Update Intervals
  static const Duration locationUpdateInterval = Duration(seconds: 10);
  static const double locationUpdateDistance = 50.0; // meters

  // Session Configuration
  static const Duration sessionTimeout = Duration(hours: 24);
  static const Duration inactivityTimeout = Duration(minutes: 30);

  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxDocumentSize = 10 * 1024 * 1024; // 10MB
  static const List<String> acceptedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> acceptedDocumentFormats = ['pdf', 'jpg', 'jpeg', 'png'];
}
