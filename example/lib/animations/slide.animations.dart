import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class SlideAnimationsExample extends StatelessWidget {
  const SlideAnimationsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: NextSlideVariant.values.asMap().entries.map((entry) {
        var e = entry.value;
        return NextSlideAnimation(
          slideVariant: e,
          animationDuration: const Duration(milliseconds: 2500),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orange,
            child: const Center(
              child: Icon(
                Icons.star,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
