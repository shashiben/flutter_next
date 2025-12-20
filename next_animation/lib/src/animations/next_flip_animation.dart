import 'package:flutter/material.dart';
import '../enums.dart';

/// A flip animation widget that rotates its child along an axis.
///
/// This widget can flip along the X-axis (horizontal) or Y-axis (vertical),
/// creating a card-flip effect. The animation starts automatically when the
/// widget is built, providing smooth and polished transitions.
///
/// **Example:**
/// ```dart
/// NextFlipAnimation(
///   variant: NextFlipVariant.flipX,
///   duration: Duration(milliseconds: 500),
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
/// )
/// ```
class NextFlipAnimation extends StatefulWidget {
  /// Creates a [NextFlipAnimation].
  ///
  /// The [child] argument must not be null.
  const NextFlipAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.variant = NextFlipVariant.flipX,
    this.controller,
    this.autoStart = true,
    this.curve = Curves.easeInOut,
  });

  /// The widget to animate.
  final Widget child;

  /// The duration of the flip animation.
  ///
  /// Defaults to 800ms for a smooth, polished feel.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// The axis along which to flip (X for horizontal, Y for vertical).
  final NextFlipVariant variant;

  /// Optional animation controller for manual control.
  ///
  /// If provided, this controller will be used instead of creating a new one.
  final AnimationController? controller;

  /// Whether to automatically start the animation when the widget is built.
  ///
  /// If false, you must manually control the animation using the controller.
  final bool autoStart;

  /// The animation curve to use.
  ///
  /// Defaults to [Curves.easeInOut] for smooth, natural motion.
  final Curve curve;

  @override
  State<NextFlipAnimation> createState() => _NextFlipAnimationState();
}

class _NextFlipAnimationState extends State<NextFlipAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(duration: widget.duration, vsync: this);

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: widget.variant == NextFlipVariant.flipY
              ? (Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_rotationAnimation.value * 3.14159))
              : (Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_rotationAnimation.value * 3.14159)),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
