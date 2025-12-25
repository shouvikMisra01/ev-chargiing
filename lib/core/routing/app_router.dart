import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/phone_input_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/auth/presentation/screens/role_selection_screen.dart';
import '../../features/auth/presentation/screens/owner_profile_setup_screen.dart';
import '../../features/map/presentation/screens/map_screen.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/booking/presentation/screens/booking_history_screen.dart';
import '../../features/owner/presentation/screens/owner_dashboard_screen.dart';
import '../../features/owner/presentation/screens/provider_setup_screen.dart';
import '../../features/owner/presentation/screens/kyc_upload_screen.dart';
import '../../features/owner/presentation/screens/availability_management_screen.dart';
import '../../features/payment/presentation/screens/wallet_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../shared/models/enums.dart';

// Route Names
class AppRoutes {
  static const String phoneInput = '/phone-input';
  static const String otpVerification = '/otp-verification';
  static const String roleSelection = '/role-selection';
  static const String ownerProfileSetup = '/owner-profile-setup';

  // User Routes
  static const String userHome = '/user/home';
  static const String booking = '/user/booking';
  static const String chargingSession = '/user/charging';

  // Owner Routes
  static const String ownerHome = '/owner/home';
  static const String providerSetup = '/owner/setup';
  static const String kycUpload = '/owner/kyc';
  static const String availabilityManagement = '/owner/availability';

  // Shared Routes
  static const String profile = '/profile';
  static const String wallet = '/wallet';
  static const String bookingHistory = '/bookings';
}

// Router Provider
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.phoneInput,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final user = authState.valueOrNull;
      final isLoading = authState.isLoading;

      // Wait for auth check to complete
      if (isLoading) {
        return null;
      }

      final isAuthenticated = user != null;
      final isOnLoginScreens = state.matchedLocation.startsWith('/phone') ||
          state.matchedLocation.startsWith('/otp');
      final isOnRoleSelection = state.matchedLocation.startsWith('/role');

      // Redirect to phone input if not authenticated
      if (!isAuthenticated && !isOnLoginScreens && !isOnRoleSelection) {
        return AppRoutes.phoneInput;
      }

      // If authenticated and on login screens (phone/otp), go to role selection
      if (isAuthenticated && isOnLoginScreens) {
        return AppRoutes.roleSelection;
      }

      // Allow role selection screen when authenticated
      if (isAuthenticated && isOnRoleSelection) {
        return null; // Let them stay on role selection
      }

      return null; // No redirect
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: AppRoutes.phoneInput,
        builder: (context, state) => const PhoneInputScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final phoneNumber = state.extra as String?;
          return OtpVerificationScreen(phoneNumber: phoneNumber ?? '');
        },
      ),
      GoRoute(
        path: AppRoutes.roleSelection,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.ownerProfileSetup,
        builder: (context, state) => const OwnerProfileSetupScreen(),
      ),

      // User Routes
      GoRoute(
        path: AppRoutes.userHome,
        builder: (context, state) => const MapScreen(),
      ),
      GoRoute(
        path: AppRoutes.booking,
        builder: (context, state) {
          final providerId = state.uri.queryParameters['providerId'] ?? '';
          return BookingScreen(providerId: providerId);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingHistory,
        builder: (context, state) => const BookingHistoryScreen(),
      ),

      // Owner Routes
      GoRoute(
        path: AppRoutes.ownerHome,
        builder: (context, state) => const OwnerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.providerSetup,
        builder: (context, state) => const ProviderSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.kycUpload,
        builder: (context, state) => const KycUploadScreen(),
      ),
      GoRoute(
        path: AppRoutes.availabilityManagement,
        builder: (context, state) => const AvailabilityManagementScreen(),
      ),

      // Shared Routes
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.wallet,
        builder: (context, state) => const WalletScreen(),
      ),
    ],
  );
});
