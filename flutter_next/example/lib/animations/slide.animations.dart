import 'package:flutter/material.dart';
import 'package:next_animation/next_animation.dart';

class SlideAnimationsExample extends StatelessWidget {
  const SlideAnimationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: NextSlideVariant.values.asMap().entries.map((entry) {
        var e = entry.value;
        return NextSlideAnimation(
          variant: e,
          duration: const Duration(milliseconds: 600),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orange,
            child: const Center(
              child: Icon(Icons.star, size: 50, color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }
}
