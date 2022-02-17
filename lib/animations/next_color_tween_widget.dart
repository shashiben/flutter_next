import 'package:flutter/material.dart';

class NextColorTweenWidget extends StatefulWidget {
  const NextColorTweenWidget(
      {Key? key,
      this.controller,
      this.animationDuration = const Duration(milliseconds: 600),
      required this.beginColor,
      required this.endColor,
      required this.child})
      : super(key: key);

  final Color beginColor;
  final Color endColor;

  final Duration animationDuration;

  final Widget Function(AnimationController controller, Color? color) child;
  final AnimationController? controller;

  @override
  NextColorTweenWidgetState createState() => NextColorTweenWidgetState();
}

class NextColorTweenWidgetState extends State<NextColorTweenWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
