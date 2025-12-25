import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Glassmorphism design system constants and utilities
class GlassTheme {
  // ==================== Blur Radius Values ====================

  /// Light blur effect - subtle frosted glass
  static const double blurRadiusLight = 10.0;

  /// Medium blur effect - standard glassmorphism
  static const double blurRadiusMedium = 20.0;

  /// Heavy blur effect - strong frosted glass
  static const double blurRadiusHeavy = 30.0;

  // ==================== Opacity Values ====================

  /// Light opacity - very transparent
  static const double opacityLight = 0.1;

  /// Medium opacity - standard glass effect
  static const double opacityMedium = 0.15;

  /// Heavy opacity - more visible
  static const double opacityHeavy = 0.25;

  // ==================== Shadow Depths (Layering) ====================

  /// Low elevation shadow
  static const double shadowDepthLow = 4.0;

  /// Medium elevation shadow
  static const double shadowDepthMedium = 8.0;

  /// High elevation shadow
  static const double shadowDepthHigh = 16.0;

  /// Very high elevation shadow
  static const double shadowDepthVeryHigh = 24.0;

  // ==================== Border Opacity ====================

  /// Border opacity for glass effect
  static const double borderOpacity = 0.2;

  /// Subtle border opacity
  static const double borderOpacitySubtle = 0.1;

  // ==================== Border Radius ====================

  /// Small border radius for chips and badges
  static const double radiusSmall = 8.0;

  /// Medium border radius for buttons
  static const double radiusMedium = 12.0;

  /// Large border radius for cards
  static const double radiusLarge = 16.0;

  /// Extra large border radius for bottom sheets
  static const double radiusXLarge = 24.0;

  // ==================== Z-Index Layering System ====================

  /// Background layer
  static const double layerBackground = 1.0;

  /// Card layer
  static const double layerCard = 2.0;

  /// Popup layer
  static const double layerPopup = 3.0;

  /// Modal layer
  static const double layerModal = 4.0;

  /// Tooltip layer
  static const double layerTooltip = 5.0;

  // ==================== Gradient Overlays ====================

  /// Create a glass gradient overlay with the given base color
  static LinearGradient glassGradient(Color baseColor) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        baseColor.withOpacity(0.3),
        baseColor.withOpacity(0.1),
      ],
    );
  }

  /// Primary color glass gradient (green)
  static LinearGradient get primaryGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary.withOpacity(0.3),
        AppColors.primary.withOpacity(0.1),
      ],
    );
  }

  /// Secondary color glass gradient (blue)
  static LinearGradient get secondaryGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.secondary.withOpacity(0.3),
        AppColors.secondary.withOpacity(0.1),
      ],
    );
  }

  /// Success gradient (green)
  static LinearGradient get successGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.success.withOpacity(0.3),
        AppColors.success.withOpacity(0.1),
      ],
    );
  }

  /// Error gradient (red)
  static LinearGradient get errorGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.error.withOpacity(0.3),
        AppColors.error.withOpacity(0.1),
      ],
    );
  }

  /// Warning gradient (yellow)
  static LinearGradient get warningGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.warning.withOpacity(0.3),
        AppColors.warning.withOpacity(0.1),
      ],
    );
  }

  // ==================== Box Shadows ====================

  /// Low elevation box shadow
  static List<BoxShadow> get shadowLow {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: shadowDepthLow,
        offset: const Offset(0, 2),
      ),
    ];
  }

  /// Medium elevation box shadow
  static List<BoxShadow> get shadowMedium {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: shadowDepthMedium,
        offset: const Offset(0, 4),
      ),
    ];
  }

  /// High elevation box shadow
  static List<BoxShadow> get shadowHigh {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.12),
        blurRadius: shadowDepthHigh,
        offset: const Offset(0, 8),
      ),
    ];
  }

  /// Very high elevation box shadow
  static List<BoxShadow> get shadowVeryHigh {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: shadowDepthVeryHigh,
        offset: const Offset(0, 12),
      ),
    ];
  }

  // ==================== Glass Decoration Helpers ====================

  /// Standard glass container decoration
  static BoxDecoration glassDecoration({
    double opacity = opacityMedium,
    double borderOpacity = GlassTheme.borderOpacity,
    double borderRadius = radiusLarge,
    Gradient? gradient,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: Colors.white.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: Colors.white.withOpacity(borderOpacity),
        width: 1,
      ),
      gradient: gradient,
      boxShadow: shadows ?? shadowMedium,
    );
  }

  /// Glass container with primary color tint
  static BoxDecoration glassPrimary({
    double borderRadius = radiusLarge,
  }) {
    return BoxDecoration(
      color: AppColors.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: AppColors.primary.withOpacity(0.2),
        width: 1,
      ),
      boxShadow: shadowMedium,
    );
  }

  /// Glass container with secondary color tint
  static BoxDecoration glassSecondary({
    double borderRadius = radiusLarge,
  }) {
    return BoxDecoration(
      color: AppColors.secondary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: AppColors.secondary.withOpacity(0.2),
        width: 1,
      ),
      boxShadow: shadowMedium,
    );
  }

  // ==================== Blur Filter ====================

  /// Create a standard backdrop blur filter
  static ImageFilter get standardBlur {
    return ImageFilter.blur(
      sigmaX: blurRadiusMedium,
      sigmaY: blurRadiusMedium,
    );
  }

  /// Create a light backdrop blur filter
  static ImageFilter get lightBlur {
    return ImageFilter.blur(
      sigmaX: blurRadiusLight,
      sigmaY: blurRadiusLight,
    );
  }

  /// Create a heavy backdrop blur filter
  static ImageFilter get heavyBlur {
    return ImageFilter.blur(
      sigmaX: blurRadiusHeavy,
      sigmaY: blurRadiusHeavy,
    );
  }

  /// Create a custom backdrop blur filter
  static ImageFilter customBlur(double sigma) {
    return ImageFilter.blur(
      sigmaX: sigma,
      sigmaY: sigma,
    );
  }
}
