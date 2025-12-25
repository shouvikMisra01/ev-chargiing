import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Status types for the animated indicator
enum IndicatorStatus {
  available,
  busy,
  offline,
  charging,
  idle,
}

/// An animated pulsing status indicator dot
///
/// Shows a colored dot that pulses to indicate different statuses:
/// - Green (available): Ready for booking
/// - Orange (busy): Currently in use
/// - Red (offline): Not available
/// - Blue (charging): Active charging session
///
/// Example usage:
/// ```dart
/// AnimatedStatusIndicator(
///   status: IndicatorStatus.available,
///   size: 12,
/// )
/// ```
class AnimatedStatusIndicator extends StatefulWidget {
  /// The status to display
  final IndicatorStatus status;

  /// Size of the indicator dot (default: 10)
  final double size;

  /// Duration of the pulse animation (default: 2 seconds)
  final Duration animationDuration;

  /// Whether to show the label next to the indicator
  final bool showLabel;

  /// Custom label text (default: status name)
  final String? labelText;

  /// Label text style
  final TextStyle? labelStyle;

  const AnimatedStatusIndicator({
    super.key,
    required this.status,
    this.size = 10,
    this.animationDuration = const Duration(seconds: 2),
    this.showLabel = false,
    this.labelText,
    this.labelStyle,
  });

  @override
  State<AnimatedStatusIndicator> createState() =>
      _AnimatedStatusIndicatorState();
}

class _AnimatedStatusIndicatorState extends State<AnimatedStatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Only animate for available and charging status
    if (_shouldAnimate()) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AnimatedStatusIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      if (_shouldAnimate()) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _shouldAnimate() {
    return widget.status == IndicatorStatus.available ||
        widget.status == IndicatorStatus.charging;
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case IndicatorStatus.available:
        return AppColors.success;
      case IndicatorStatus.busy:
        return AppColors.chargingIdle;
      case IndicatorStatus.offline:
        return AppColors.mapOffline;
      case IndicatorStatus.charging:
        return AppColors.chargingActive;
      case IndicatorStatus.idle:
        return AppColors.chargingIdle;
    }
  }

  String _getStatusLabel() {
    if (widget.labelText != null) {
      return widget.labelText!;
    }

    switch (widget.status) {
      case IndicatorStatus.available:
        return 'Available';
      case IndicatorStatus.busy:
        return 'Busy';
      case IndicatorStatus.offline:
        return 'Offline';
      case IndicatorStatus.charging:
        return 'Charging';
      case IndicatorStatus.idle:
        return 'Idle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();

    final indicator = SizedBox(
      width: widget.size * 2,
      height: widget.size * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated pulse ring (only for available/charging)
          if (_shouldAnimate())
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withOpacity(_opacityAnimation.value),
                    ),
                  ),
                );
              },
            ),

          // Solid center dot
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (widget.showLabel) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          const SizedBox(width: 6),
          Text(
            _getStatusLabel(),
            style: widget.labelStyle ??
                TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      );
    }

    return indicator;
  }
}

/// A simple non-animated status badge with color coding
class StatusBadge extends StatelessWidget {
  final IndicatorStatus status;
  final String? labelText;

  const StatusBadge({
    super.key,
    required this.status,
    this.labelText,
  });

  Color _getStatusColor() {
    switch (status) {
      case IndicatorStatus.available:
        return AppColors.success;
      case IndicatorStatus.busy:
        return AppColors.chargingIdle;
      case IndicatorStatus.offline:
        return AppColors.mapOffline;
      case IndicatorStatus.charging:
        return AppColors.chargingActive;
      case IndicatorStatus.idle:
        return AppColors.chargingIdle;
    }
  }

  String _getStatusLabel() {
    if (labelText != null) return labelText!;

    switch (status) {
      case IndicatorStatus.available:
        return 'Available';
      case IndicatorStatus.busy:
        return 'Busy';
      case IndicatorStatus.offline:
        return 'Offline';
      case IndicatorStatus.charging:
        return 'Charging';
      case IndicatorStatus.idle:
        return 'Idle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            _getStatusLabel(),
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
