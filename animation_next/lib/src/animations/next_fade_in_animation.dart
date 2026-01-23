import 'package:flutter/material.dart';
import '../enums.dart';

/// A fade-in animation widget that smoothly fades in its child.
///
/// This widget can fade in from different directions (left, right, top, bottom)
/// or simply fade in opacity. The animation starts automatically when the widget
/// is built, providing smooth and polished transitions.
///
/// **Example:**
/// ```dart
/// NextFadeInAnimation(
///   variant: NextFadeInVariant.fadeInLeft,
///   duration: Duration(milliseconds: 500),
///   child: Text('Fading in!'),
/// )
/// ```
class NextFadeInAnimation extends StatefulWidget {
  /// Creates a [NextFadeInAnimation].
  ///
  /// The [child] argument must not be null.
  const NextFadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.variant,
    this.controller,
    this.autoStart = true,
    this.initialPosition = 100,
    this.curve = Curves.easeOut,
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the fade-in animation.
  ///
  /// Defaults to 800ms for a smooth, polished feel.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The direction from which the fade-in should occur.
  ///
  /// If null, the widget will only fade in opacity without movement.
  final NextFadeInVariant? variant;

  /// Optional animation controller for manual control.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// If false, you must manually control the animation using the controller.
  final bool autoStart;

  /// The initial position offset for directional fade-in animations.
  ///
  /// This determines how far the widget starts from its final position.
  /// Defaults to 100 pixels for a smooth effect.
  final double initialPosition;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.easeOut] for smooth, natural motion.
  final Curve curve;

  @override
  State<NextFadeInAnimation> createState() => _NextFadeInAnimationState();
}

class _NextFadeInAnimationState extends State<NextFadeInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _positionAnimation;
  late final Animation<double> _opacityAnimation;

  /// Gets the appropriate curve for fade-in animations.
  /// Fade-in animations should always use easeOut for smooth entrance.
  Curve _getFadeInCurve() {
    return Curves.easeOut;
  }

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    // Use the fade-in-specific curve instead of the passed curve
    final fadeInCurve = _getFadeInCurve();

    if (widget.variant == null) {
      _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0, 0.65),
        ),
      );
      _positionAnimation =
          _opacityAnimation; // Not used but needs to be initialized
    } else {
      _positionAnimation = _getTween().animate(
        CurvedAnimation(
          parent: _controller,
          curve: fadeInCurve,
        ),
      );
      _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0, 0.65),
        ),
      );
    }

    if (widget.autoStart) {
      if (widget.delay > Duration.zero) {
        Future<void>.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant == null) {
      return AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _getOffset(_positionAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }

  /// Gets the offset based on the fade-in variant.
  Offset _getOffset(double animation) {
    if (widget.variant == null) {
      return Offset.zero;
    }

    switch (widget.variant!) {
      case NextFadeInVariant.fadeIn:
        return Offset.zero;
      case NextFadeInVariant.fadeInTop:
      case NextFadeInVariant.fadeInUpBig:
      case NextFadeInVariant.fadeInBottom:
      case NextFadeInVariant.fadeInDownBig:
        return Offset(0, animation);
      case NextFadeInVariant.fadeInLeft:
      case NextFadeInVariant.fadeInLeftBig:
      case NextFadeInVariant.fadeInRight:
      case NextFadeInVariant.fadeInRightBig:
        return Offset(animation, 0);
      case NextFadeInVariant.fadeInTopLeft:
        return Offset(animation, animation);
      case NextFadeInVariant.fadeInTopRight:
        return Offset(-animation, animation);
      case NextFadeInVariant.fadeInBottomLeft:
        return Offset(animation, -animation);
      case NextFadeInVariant.fadeInBottomRight:
        return Offset(-animation, -animation);
    }
  }

  /// Gets the tween based on the fade-in variant.
  Tween<double> _getTween() {
    if (widget.variant == null) {
      return Tween<double>(begin: 0, end: 0);
    }

    final isBig = widget.variant.toString().contains('Big');
    final distance =
        isBig ? widget.initialPosition * 2 : widget.initialPosition;

    switch (widget.variant!) {
      case NextFadeInVariant.fadeIn:
        return Tween<double>(begin: 0, end: 0);
      case NextFadeInVariant.fadeInTop:
      case NextFadeInVariant.fadeInUpBig:
        return Tween<double>(begin: -distance, end: 0);
      case NextFadeInVariant.fadeInBottom:
      case NextFadeInVariant.fadeInDownBig:
        return Tween<double>(begin: distance, end: 0);
      case NextFadeInVariant.fadeInLeft:
      case NextFadeInVariant.fadeInLeftBig:
        return Tween<double>(begin: -distance, end: 0);
      case NextFadeInVariant.fadeInRight:
      case NextFadeInVariant.fadeInRightBig:
        return Tween<double>(begin: distance, end: 0);
      case NextFadeInVariant.fadeInTopLeft:
        return Tween<double>(begin: -distance, end: 0);
      case NextFadeInVariant.fadeInTopRight:
        return Tween<double>(begin: distance, end: 0);
      case NextFadeInVariant.fadeInBottomLeft:
        return Tween<double>(begin: -distance, end: 0);
      case NextFadeInVariant.fadeInBottomRight:
        return Tween<double>(begin: distance, end: 0);
    }
  }
}
