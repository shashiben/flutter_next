import 'package:flutter/material.dart';
import '../enums.dart';

/// A bounce animation widget that creates a bounce effect with fade-in.
///
/// This widget animates its child with a bouncing motion from a specified
/// direction, combining position movement with opacity fade-in. The animation
/// uses a bounce curve for a natural elastic effect. The animation starts
/// automatically when the widget is built.
///
/// **Example:**
/// ```dart
/// NextBounceAnimation(
///   variant: NextBounceVariant.bounceInLeft,
///   duration: Duration(milliseconds: 600),
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
/// )
/// ```
class NextBounceAnimation extends StatefulWidget {
  /// Creates a [NextBounceAnimation].
  ///
  /// The [child] argument must not be null.
  const NextBounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.variant = NextBounceVariant.bounceInLeft,
    this.controller,
    this.autoStart = true,
    this.initialPosition = 75,
    this.curve = Curves.bounceOut,
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the bounce animation.
  ///
  /// Defaults to 1000ms for a natural bounce effect.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The direction from which the bounce animation should occur.
  final NextBounceVariant variant;

  /// Optional animation controller for manual control.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// If false, you must manually control the animation using the controller.
  final bool autoStart;

  /// The initial position offset for the bounce animation.
  ///
  /// This determines how far the widget starts from its final position.
  /// Defaults to 75 pixels.
  final double initialPosition;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.bounceOut] for a natural bounce effect.
  final Curve curve;

  @override
  State<NextBounceAnimation> createState() => _NextBounceAnimationState();
}

class _NextBounceAnimationState extends State<NextBounceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _positionAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  /// Gets the appropriate curve for the bounce variant.
  /// Bounce animations should always use elastic curves for proper bounce effect.
  Curve _getBounceCurve() {
    final isBounceIn = widget.variant == NextBounceVariant.bounceIn ||
        widget.variant == NextBounceVariant.bounceInTop ||
        widget.variant == NextBounceVariant.bounceInBottom ||
        widget.variant == NextBounceVariant.bounceInLeft ||
        widget.variant == NextBounceVariant.bounceInRight;
    return isBounceIn ? Curves.elasticOut : Curves.elasticIn;
  }

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    final isCenter = widget.variant == NextBounceVariant.bounceIn ||
        widget.variant == NextBounceVariant.bounceOut;

    // Use the bounce-specific curve instead of the passed curve
    final bounceCurve = _getBounceCurve();

    if (isCenter) {
      _scaleAnimation = _getScaleTween().animate(
        CurvedAnimation(
          parent: _controller,
          curve: bounceCurve,
        ),
      );
      _positionAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);
    } else {
      _positionAnimation = _getTween().animate(
        CurvedAnimation(
          parent: _controller,
          curve: bounceCurve,
        ),
      );
      _scaleAnimation =
          Tween<double>(begin: 1.0, end: 1.0).animate(_controller);
    }

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.65),
      ),
    );

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
    final isCenter = widget.variant == NextBounceVariant.bounceIn ||
        widget.variant == NextBounceVariant.bounceOut;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget result = widget.child;

        if (isCenter) {
          result = Transform.scale(
            scale: _scaleAnimation.value,
            child: result,
          );
        } else {
          result = Transform.translate(
            offset: _getOffset(_positionAnimation.value),
            child: result,
          );
        }

        return Opacity(
          opacity: _opacityAnimation.value,
          child: result,
        );
      },
    );
  }

  /// Gets the scale tween for center bounce animations.
  Tween<double> _getScaleTween() {
    switch (widget.variant) {
      case NextBounceVariant.bounceIn:
        return Tween<double>(begin: 0.3, end: 1.0);
      case NextBounceVariant.bounceOut:
        return Tween<double>(begin: 1.0, end: 0.3);
      default:
        return Tween<double>(begin: 1.0, end: 1.0);
    }
  }

  /// Gets the offset based on the bounce variant.
  Offset _getOffset(double animation) {
    switch (widget.variant) {
      case NextBounceVariant.bounceIn:
      case NextBounceVariant.bounceOut:
        return Offset.zero;
      case NextBounceVariant.bounceInTop:
      case NextBounceVariant.bounceOutTop:
      case NextBounceVariant.bounceInBottom:
      case NextBounceVariant.bounceOutBottom:
        return Offset(0, animation);
      case NextBounceVariant.bounceInLeft:
      case NextBounceVariant.bounceOutLeft:
      case NextBounceVariant.bounceInRight:
      case NextBounceVariant.bounceOutRight:
        return Offset(animation, 0);
    }
  }

  /// Gets the tween based on the bounce variant.
  Tween<double> _getTween() {
    switch (widget.variant) {
      case NextBounceVariant.bounceIn:
        return Tween<double>(begin: 0, end: 0);
      case NextBounceVariant.bounceOut:
        return Tween<double>(begin: 0, end: 0);
      case NextBounceVariant.bounceInTop:
        return Tween<double>(begin: -widget.initialPosition, end: 0);
      case NextBounceVariant.bounceInBottom:
        return Tween<double>(begin: widget.initialPosition, end: 0);
      case NextBounceVariant.bounceInLeft:
        return Tween<double>(begin: -widget.initialPosition, end: 0);
      case NextBounceVariant.bounceInRight:
        return Tween<double>(begin: widget.initialPosition, end: 0);
      case NextBounceVariant.bounceOutTop:
        return Tween<double>(begin: 0, end: -widget.initialPosition);
      case NextBounceVariant.bounceOutBottom:
        return Tween<double>(begin: 0, end: widget.initialPosition);
      case NextBounceVariant.bounceOutLeft:
        return Tween<double>(begin: 0, end: -widget.initialPosition);
      case NextBounceVariant.bounceOutRight:
        return Tween<double>(begin: 0, end: widget.initialPosition);
    }
  }
}
