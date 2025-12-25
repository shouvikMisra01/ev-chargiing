class ApiEndpoints {
  // Auth (Implemented in backend)
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';

  // User Profile (Implemented in backend)
  static const String getUserProfile = '/user/profile';
  static const String updateUserProfile = '/user/profile';
  static const String uploadProfilePicture = '/user/profile/picture';

  // Stations (Implemented in backend)
  static const String searchStations = '/stations/search'; // POST - time-based geo search
  static const String getStation = '/stations'; // GET /:id
  static const String getStationAvailability = '/stations'; // GET /:id/availability

  // Owner/Provider (Placeholders in backend - needs implementation)
  static const String registerOwner = '/owner/register';
  static const String updateOwner = '/owner/profile';
  static const String getOwnerDetails = '/owner/profile';
  static const String createStation = '/owner/stations';
  static const String updateStation = '/owner/stations'; // PUT /:id
  static const String deleteStation = '/owner/stations'; // DELETE /:id
  static const String updateAvailability = '/owner/availability';
  static const String toggleOnlineStatus = '/owner/online-status';
  static const String uploadStationImages = '/owner/stations/images';

  // KYC (Placeholders in backend - needs implementation)
  static const String uploadKycDocuments = '/owner/kyc/upload';
  static const String getKycStatus = '/owner/kyc/status';
  static const String submitKyc = '/owner/kyc/submit';

  // Booking (Implemented in backend)
  static const String createBooking = '/bookings'; // POST
  static const String getBooking = '/bookings'; // GET /:id
  static const String getUserBookings = '/bookings'; // GET /
  static const String cancelBooking = '/bookings'; // PUT /:id/cancel

  // Charging Session (Placeholders in backend - needs implementation)
  static const String startCharging = '/sessions/start';
  static const String endCharging = '/sessions/end';
  static const String getActiveSession = '/sessions/active';
  static const String getSessionHistory = '/sessions/history';

  // Payment & Wallet (Placeholders in backend - needs implementation)
  static const String getWalletBalance = '/wallet/balance';
  static const String addMoney = '/wallet/add';
  static const String withdraw = '/wallet/withdraw';
  static const String getTransactions = '/wallet/transactions';
  static const String initiatePayment = '/payments/initiate';
  static const String verifyPayment = '/payments/verify';
  static const String getPaymentMethods = '/payments/methods';

  // Ratings & Reviews (Placeholders in backend - needs implementation)
  static const String rateUser = '/ratings/user';
  static const String rateProvider = '/ratings/provider';
  static const String getUserRatings = '/ratings/user'; // GET /:id
  static const String getProviderRatings = '/ratings/provider'; // GET /:id

  // Notifications (Placeholders in backend - needs implementation)
  static const String getNotifications = '/notifications';
  static const String markAsRead = '/notifications'; // PUT /:id/read
  static const String updateFcmToken = '/notifications/fcm-token';

  // Analytics (Placeholders in backend - needs implementation)
  static const String getOwnerAnalytics = '/analytics/owner';
  static const String getUserAnalytics = '/analytics/user';
}
