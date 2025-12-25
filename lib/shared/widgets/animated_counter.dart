import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// An animated counter widget that smoothly transitions between values
///
/// Example usage:
/// ```dart
/// AnimatedCounter(
///   value: 1250.00,
///   prefix: '₹',
///   duration: Duration(milliseconds: 500),
/// )
/// ```
class AnimatedCounter extends StatefulWidget {
  /// The current value to display
  final double value;

  /// Optional prefix text (e.g., '₹', '$')
  final String? prefix;

  /// Optional suffix text (e.g., 'kWh', 'km')
  final String? suffix;

  /// Number of decimal places (default: 0)
  final int decimalPlaces;

  /// Animation duration (default: 500ms)
  final Duration duration;

  /// Text style for the counter
  final TextStyle? style;

  /// Color to flash when value changes
  final Color? highlightColor;

  /// Whether to show the highlight flash effect
  final bool showHighlight;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.prefix,
    this.suffix,
    this.decimalPlaces = 0,
    this.duration = const Duration(milliseconds: 500),
    this.style,
    this.highlightColor,
    this.showHighlight = true,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _previousValue;
  bool _showFlash = false;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: _previousValue,
      end: widget.value,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;

      _animation = Tween<double>(
        begin: _previousValue,
        end: widget.value,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );

      _controller.reset();
      _controller.forward();

      // Show highlight flash
      if (widget.showHighlight) {
        setState(() => _showFlash = true);
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() => _showFlash = false);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(double value) {
    if (widget.decimalPlaces == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(widget.decimalPlaces);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = widget.style ??
        const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final displayValue = _formatValue(_animation.value);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: _showFlash
              ? BoxDecoration(
                  color: (widget.highlightColor ?? AppColors.primary)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
          child: Text.rich(
            TextSpan(
              children: [
                if (widget.prefix != null)
                  TextSpan(
                    text: widget.prefix,
                    style: defaultStyle.copyWith(
                      color: _showFlash
                          ? (widget.highlightColor ?? AppColors.primary)
                          : defaultStyle.color,
                    ),
                  ),
                TextSpan(
                  text: displayValue,
                  style: defaultStyle.copyWith(
                    color: _showFlash
                        ? (widget.highlightColor ?? AppColors.primary)
                        : defaultStyle.color,
                  ),
                ),
                if (widget.suffix != null)
                  TextSpan(
                    text: ' ${widget.suffix}',
                    style: defaultStyle.copyWith(
                      fontSize: defaultStyle.fontSize! * 0.7,
                      color: _showFlash
                          ? (widget.highlightColor ?? AppColors.primary)
                          : AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A simpler version for displaying currency with animation
class AnimatedCurrency extends StatelessWidget {
  final double amount;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCurrency({
    super.key,
    required this.amount,
    this.duration = const Duration(milliseconds: 500),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCounter(
      value: amount,
      prefix: '₹',
      decimalPlaces: 2,
      duration: duration,
      style: style,
      highlightColor: AppColors.success,
    );
  }
}

/// A percentage counter with animation
class AnimatedPercentage extends StatelessWidget {
  final double percentage;
  final Duration duration;
  final TextStyle? style;

  const AnimatedPercentage({
    super.key,
    required this.percentage,
    this.duration = const Duration(milliseconds: 500),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCounter(
      value: percentage,
      suffix: '%',
      decimalPlaces: 1,
      duration: duration,
      style: style,
    );
  }
}
