import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/glass_theme.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A glassmorphic button with frosted glass effect
///
/// Example usage:
/// ```dart
/// GlassButton(
///   label: 'Continue',
///   onPressed: () {},
///   variant: GlassButtonVariant.primary,
/// )
/// ```
enum GlassButtonVariant {
  primary,
  secondary,
  success,
  error,
  warning,
  outlined,
}

class GlassButton extends StatefulWidget {
  /// Button label text
  final String label;

  /// Tap handler
  final VoidCallback? onPressed;

  /// Button variant (primary, secondary, etc.)
  final GlassButtonVariant variant;

  /// Optional icon to display before the label
  final IconData? icon;

  /// Whether button is in loading state
  final bool isLoading;

  /// Button width (default: null for content width)
  final double? width;

  /// Button height (default: 48)
  final double height;

  /// Border radius (default: 12)
  final double borderRadius;

  /// Whether to enable haptic feedback on press
  final bool enableHaptic;

  const GlassButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = GlassButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.borderRadius = GlassTheme.radiusMedium,
    this.enableHaptic = true,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _scaleController.reverse();
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  void _onTap() {
    if (widget.onPressed != null && !widget.isLoading) {
      if (widget.enableHaptic) {
        HapticFeedback.lightImpact();
      }
      widget.onPressed!();
    }
  }

  Color _getBackgroundColor() {
    if (widget.onPressed == null || widget.isLoading) {
      return AppColors.disabled;
    }

    switch (widget.variant) {
      case GlassButtonVariant.primary:
        return AppColors.primary;
      case GlassButtonVariant.secondary:
        return AppColors.secondary;
      case GlassButtonVariant.success:
        return AppColors.success;
      case GlassButtonVariant.error:
        return AppColors.error;
      case GlassButtonVariant.warning:
        return AppColors.warning;
      case GlassButtonVariant.outlined:
        return Colors.transparent;
    }
  }

  Color _getBorderColor() {
    if (widget.onPressed == null || widget.isLoading) {
      return AppColors.disabled;
    }

    switch (widget.variant) {
      case GlassButtonVariant.outlined:
        return AppColors.primary;
      default:
        return Colors.white.withOpacity(0.2);
    }
  }

  Color _getTextColor() {
    if (widget.onPressed == null || widget.isLoading) {
      return AppColors.textHint;
    }

    switch (widget.variant) {
      case GlassButtonVariant.outlined:
        return AppColors.primary;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: _onTap,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: widget.variant == GlassButtonVariant.outlined
                ? _buildOutlinedButton(isDisabled)
                : _buildFilledButton(isDisabled),
          ),
        ),
      ),
    );
  }

  Widget _buildFilledButton(bool isDisabled) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: isDisabled ? 0 : GlassTheme.blurRadiusLight,
        sigmaY: isDisabled ? 0 : GlassTheme.blurRadiusLight,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(
            color: _getBorderColor(),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: isDisabled ? [] : GlassTheme.shadowLow,
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: _getTextColor(),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: AppTextStyles.buttonMedium.copyWith(
                        color: _getTextColor(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(bool isDisabled) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border.all(
          color: _getBorderColor(),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Center(
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: _getTextColor(),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: AppTextStyles.buttonMedium.copyWith(
                      color: _getTextColor(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
