import 'package:flutter/material.dart';

/// Animation library for consistent animations throughout the app
class AppAnimations {
  // ==================== Duration Constants ====================

  /// Fast animation duration (200ms)
  static const Duration fast = Duration(milliseconds: 200);

  /// Medium animation duration (300ms)
  static const Duration medium = Duration(milliseconds: 300);

  /// Slow animation duration (500ms)
  static const Duration slow = Duration(milliseconds: 500);

  /// Extra slow animation duration (800ms)
  static const Duration extraSlow = Duration(milliseconds: 800);

  // ==================== Curves ====================

  /// Default curve for most animations
  static const Curve defaultCurve = Curves.easeInOutCubic;

  /// Bounce curve for playful animations
  static const Curve bounceCurve = Curves.elasticOut;

  /// Fast out slow in curve
  static const Curve fastOutSlowInCurve = Curves.fastOutSlowIn;

  /// Decelerate curve
  static const Curve decelerateCurve = Curves.decelerate;

  // ==================== Stagger Delay ====================

  /// Delay between staggered list items (50ms)
  static const Duration staggerDelay = Duration(milliseconds: 50);

  // ==================== Page Transitions ====================

  /// Slide up page transition
  static Widget slideUpTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  /// Slide down page transition
  static Widget slideDownTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  /// Slide right page transition
  static Widget slideRightTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  /// Slide left page transition
  static Widget slideLeftTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  /// Fade page transition
  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Scale page transition
  static Widget scaleTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const curve = Curves.easeInOutCubic;

    final tween = Tween(begin: 0.8, end: 1.0).chain(
      CurveTween(curve: curve),
    );

    return ScaleTransition(
      scale: animation.drive(tween),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// Combined fade + slide up transition
  static Widget fadeSlideUpTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 0.3);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;

    final slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  // ==================== Widget Helpers ====================

  /// Create a staggered animation for a widget at given index
  static Widget createStaggeredAnimation({
    required int index,
    required Duration delay,
    required Widget child,
    Curve curve = defaultCurve,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: medium,
      curve: curve,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(50 * (1 - value), 0),
            child: child,
          ),
        );
      },
    );
  }
}

/// Extension on BuildContext for easier navigation with transitions
extension AnimatedNavigationExtension on BuildContext {
  /// Push a page with slide up transition
  Future<T?> pushWithSlideUp<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: AppAnimations.slideUpTransition,
        transitionDuration: AppAnimations.medium,
      ),
    );
  }

  /// Push a page with fade transition
  Future<T?> pushWithFade<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: AppAnimations.fadeTransition,
        transitionDuration: AppAnimations.medium,
      ),
    );
  }

  /// Push a page with scale transition
  Future<T?> pushWithScale<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: AppAnimations.scaleTransition,
        transitionDuration: AppAnimations.medium,
      ),
    );
  }
}

/// A widget that adds a bounce animation on tap
class BounceAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleFactor;

  const BounceAnimation({
    super.key,
    required this.child,
    this.onTap,
    this.scaleFactor = 0.95,
  });

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.fast,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: AppAnimations.defaultCurve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
