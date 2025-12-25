import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF00C853); // Vibrant Green
  static const Color primaryDark = Color(0xFF009624);
  static const Color primaryLight = Color(0xFF5EFC82);

  // Secondary Colors
  static const Color secondary = Color(0xFF304FFE); // Electric Blue
  static const Color secondaryDark = Color(0xFF0026CA);
  static const Color secondaryLight = Color(0xFF7A7CFF);

  // Accent Colors
  static const Color accent = Color(0xFFFFD600); // Warning Yellow
  static const Color accentOrange = Color(0xFFFF6D00);

  // Status Colors
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFD600);
  static const Color info = Color(0xFF2196F3);

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F0);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textDisabled = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFE0E0E0); // Alias for textDisabled

  // Border & Divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Input Colors
  static const Color inputFill = Color(0xFFF8F9FA);
  static const Color inputBorder = Color(0xFFE0E0E0);

  // Chip Colors
  static const Color chipBackground = Color(0xFFE8F5E9);
  static const Color chipSelectedBackground = Color(0xFF00C853);

  // Charging Status Colors
  static const Color chargingActive = Color(0xFF00C853);
  static const Color chargingIdle = Color(0xFFFF9800);
  static const Color chargingCompleted = Color(0xFF2196F3);
  static const Color chargingCancelled = Color(0xFFD32F2F);

  // Booking Status Colors
  static const Color bookingPending = Color(0xFFFFD600);
  static const Color bookingConfirmed = Color(0xFF00C853);
  static const Color bookingActive = Color(0xFF2196F3);
  static const Color bookingCompleted = Color(0xFF9E9E9E);
  static const Color bookingCancelled = Color(0xFFD32F2F);

  // Map Marker Colors
  static const Color markerAvailable = Color(0xFF00C853);
  static const Color markerBusy = Color(0xFFFF9800);
  static const Color markerOffline = Color(0xFF757575);
  static const Color markerUserLocation = Color(0xFF304FFE);
  static const Color mapOffline = Color(0xFF757575); // Alias for markerOffline

  // Rating Colors
  static const Color ratingFilled = Color(0xFFFFD600);
  static const Color ratingEmpty = Color(0xFFE0E0E0);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00C853), Color(0xFF00E676)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF304FFE), Color(0xFF536DFE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color scrim = Color(0x4D000000);

  // Shadow Colors
  static Color shadow = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.2);
}
