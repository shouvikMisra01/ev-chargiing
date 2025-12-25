import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/glass_theme.dart';

/// A glassmorphic card widget with frosted glass effect
///
/// This widget creates a modern glassmorphism effect with:
/// - Backdrop blur filter for frosted glass appearance
/// - Semi-transparent background
/// - Subtle border with opacity
/// - Customizable gradient overlays
/// - Box shadows for depth
///
/// Example usage:
/// ```dart
/// GlassCard(
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Content'),
///   ),
/// )
/// ```
class GlassCard extends StatelessWidget {
  /// The widget to display inside the glass card
  final Widget child;

  /// Blur radius for the backdrop filter (default: 20.0)
  final double blurRadius;

  /// Opacity of the card background (default: 0.15)
  final double opacity;

  /// Opacity of the border (default: 0.2)
  final double borderOpacity;

  /// Border radius of the card (default: 16.0)
  final double borderRadius;

  /// Optional gradient overlay
  final Gradient? gradient;

  /// Box shadows for depth (default: medium shadow)
  final List<BoxShadow>? shadows;

  /// Card padding (default: EdgeInsets.zero)
  final EdgeInsetsGeometry padding;

  /// Card margin (default: EdgeInsets.zero)
  final EdgeInsetsGeometry margin;

  /// Card width (default: null for full width)
  final double? width;

  /// Card height (default: null for content height)
  final double? height;

  /// Background color (default: white)
  final Color backgroundColor;

  /// Border color (default: white)
  final Color borderColor;

  /// Border width (default: 1.0)
  final double borderWidth;

  /// Whether to enable the blur effect (default: true)
  /// Set to false for better performance when blur is not needed
  final bool enableBlur;

  /// Tap handler
  final VoidCallback? onTap;

  /// Long press handler
  final VoidCallback? onLongPress;

  const GlassCard({
    super.key,
    required this.child,
    this.blurRadius = GlassTheme.blurRadiusMedium,
    this.opacity = GlassTheme.opacityMedium,
    this.borderOpacity = GlassTheme.borderOpacity,
    this.borderRadius = GlassTheme.radiusLarge,
    this.gradient,
    this.shadows,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.enableBlur = true,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(opacity),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor.withOpacity(borderOpacity),
          width: borderWidth,
        ),
        gradient: gradient,
        boxShadow: shadows ?? GlassTheme.shadowMedium,
      ),
      child: child,
    );

    final glassCard = Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: enableBlur
            ? BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurRadius,
                  sigmaY: blurRadius,
                ),
                child: cardContent,
              )
            : cardContent,
      ),
    );

    // Wrap with GestureDetector if tap handlers are provided
    if (onTap != null || onLongPress != null) {
      return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: glassCard,
      );
    }

    return glassCard;
  }
}

/// A glassmorphic card with primary color tint
class GlassPrimaryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassPrimaryCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = GlassTheme.radiusLarge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      gradient: GlassTheme.primaryGradient,
      onTap: onTap,
      child: child,
    );
  }
}

/// A glassmorphic card with secondary color tint
class GlassSecondaryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassSecondaryCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = GlassTheme.radiusLarge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      gradient: GlassTheme.secondaryGradient,
      onTap: onTap,
      child: child,
    );
  }
}

/// A glassmorphic card with success color tint
class GlassSuccessCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassSuccessCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = GlassTheme.radiusLarge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      gradient: GlassTheme.successGradient,
      onTap: onTap,
      child: child,
    );
  }
}

/// A glassmorphic card with error color tint
class GlassErrorCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassErrorCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = GlassTheme.radiusLarge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      gradient: GlassTheme.errorGradient,
      onTap: onTap,
      child: child,
    );
  }
}

/// A glassmorphic card with warning color tint
class GlassWarningCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const GlassWarningCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = GlassTheme.radiusLarge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      gradient: GlassTheme.warningGradient,
      onTap: onTap,
      child: child,
    );
  }
}
