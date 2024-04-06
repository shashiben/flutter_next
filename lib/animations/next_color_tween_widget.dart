import 'package:flutter/material.dart';

/// A widget that animates between two colors.
///
/// The animation is controlled by an [AnimationController] and the colors are
/// specified by [beginColor] and [endColor].
class NextColorTweenWidget extends StatefulWidget {
  /// Creates a new instance of [NextColorTweenWidget].
  const NextColorTweenWidget(
      {super.key,
      this.controller,
      this.animationDuration = const Duration(milliseconds: 600),
      required this.beginColor,
      required this.endColor,
      required this.child});

  /// The color at the beginning of the animation.
  final Color beginColor;

  /// The color at the end of the animation.
  final Color endColor;

  /// The duration of the animation.
  final Duration animationDuration;

  /// A function that returns a widget that uses the current color of the animation.
  final Widget Function(AnimationController controller, Color? color) child;

  /// The controller for the animation.
  final AnimationController? controller;

  /// Creates the mutable state for this widget.
  @override
  NextColorTweenWidgetState createState() => NextColorTweenWidgetState();
}

/// The mutable state for a [NextColorTweenWidget].
class NextColorTweenWidgetState extends State<NextColorTweenWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  /// Initializes the state of the widget.
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          duration: widget.animationDuration,
          vsync: this,
        );

    _color = ColorTween(begin: widget.beginColor, end: widget.endColor)
        .animate(_controller);
  }

  /// Disposes of the resources used by the widget.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Builds the widget tree for this widget.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _color,
      builder: (BuildContext _, Widget? __) {
        return widget.child(_controller, _color.value);
      },
    );
  }
}
