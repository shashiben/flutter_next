import 'package:flutter/material.dart';
import '../flutter_next.dart';

class NextBounceAnimation extends StatefulWidget {
  const NextBounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.delay = Duration.zero,
    this.variant = NextBounceVariant.bounceInLeft,
    this.startAnimation = true,
    this.initialPosition = 100,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool startAnimation;
  final double initialPosition;
  final NextBounceVariant variant;

  @override
  _NextBounceAnimationState createState() => _NextBounceAnimationState();
}

class _NextBounceAnimationState extends State<NextBounceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.initialPosition,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    if (widget.startAnimation) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _getOffset(_animation.value),
          child: widget.child,
        );
      },
    );
  }

  Offset _getOffset(double animation) {
    switch (widget.variant) {
      case NextBounceVariant.bounceInTop:
        return Offset(0, -animation); // Negative for upward direction
      case NextBounceVariant.bounceInBottom:
        return Offset(0, animation); // Positive for downward direction
      case NextBounceVariant.bounceInLeft:
        return Offset(-animation, 0); // Negative for leftward direction
      case NextBounceVariant.bounceInRight:
        return Offset(animation, 0); // Positive for rightward direction
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
