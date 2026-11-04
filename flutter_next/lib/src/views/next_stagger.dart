import 'package:animation_next/animation_next.dart';
import 'package:flutter/widgets.dart';

/// Plays [motion] on each child, delayed by [step].
class NextStagger extends StatelessWidget {
  /// Creates a staggered list.
  const NextStagger({
    required this.children,
    this.motion = const NextMotion(opacityBegin: 0, opacityEnd: 1),
    this.step = const Duration(milliseconds: 60),
    super.key,
  });

  /// Children, animated in order.
  final List<Widget> children;

  /// Motion copied onto each child. The delay grows by [step].
  final NextMotion motion;

  /// Extra delay added for each index.
  final Duration step;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++)
          NextMotionView(
            motion: motion.copyWith(delay: motion.delay + step * i),
            child: children[i],
          ),
      ],
    );
  }
}
